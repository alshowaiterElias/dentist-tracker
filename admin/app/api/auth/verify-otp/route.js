import { createClient } from "@supabase/supabase-js";
import crypto from "crypto";
import { NextResponse } from "next/server";

// Supabase admin client (bypasses RLS)
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// Derive a deterministic password for phone users
// This lets us use Supabase's signInWithPassword after OTP verification
function derivePassword(phone) {
  return crypto
    .createHmac("sha256", process.env.SUPABASE_SERVICE_ROLE_KEY)
    .update(phone)
    .digest("hex");
}

export async function POST(request) {
  try {
    const { phone, code, full_name } = await request.json();

    if (!phone || !code) {
      return NextResponse.json(
        { error: "Phone and code are required" },
        { status: 400 }
      );
    }

    // Find matching OTP
    const { data: otpRecord } = await supabase
      .from("otp_verifications")
      .select("*")
      .eq("phone", phone)
      .eq("code", code)
      .eq("verified", false)
      .gte("expires_at", new Date().toISOString())
      .order("created_at", { ascending: false })
      .limit(1)
      .single();

    if (!otpRecord) {
      return NextResponse.json(
        { error: "Invalid or expired code" },
        { status: 401 }
      );
    }

    // Mark OTP as verified
    await supabase
      .from("otp_verifications")
      .update({ verified: true })
      .eq("id", otpRecord.id);

    const password = derivePassword(phone);

    // Check if user exists by looking up profiles by phone
    const { data: existingProfile } = await supabase
      .from("profiles")
      .select("id")
      .eq("phone", phone)
      .limit(1)
      .single();

    if (!existingProfile) {
      // Create new user via admin API
      const { data: newUser, error: createError } = await supabase.auth.admin.createUser({
        phone,
        password,
        phone_confirm: true,
        user_metadata: { full_name: full_name || "" },
      });

      if (createError) {
        console.error("Create user error:", createError);
        return NextResponse.json(
          { error: "Failed to create account: " + createError.message },
          { status: 500 }
        );
      }
    } else {
      // Update password in case it was changed
      // Find auth user by phone
      const { data: { users } } = await supabase.auth.admin.listUsers();
      const authUser = users.find((u) => u.phone === phone);
      if (authUser) {
        await supabase.auth.admin.updateUserById(authUser.id, { password });
      }
    }

    // Sign in to get session tokens
    const { data: session, error: signInError } = await supabase.auth.signInWithPassword({
      phone,
      password,
    });

    if (signInError) {
      console.error("Sign-in error:", signInError);
      return NextResponse.json(
        { error: "Failed to sign in: " + signInError.message },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      session: {
        access_token: session.session.access_token,
        refresh_token: session.session.refresh_token,
      },
      user: {
        id: session.user.id,
        phone: session.user.phone,
        email: session.user.email,
      },
    });
  } catch (error) {
    console.error("Verify OTP error:", error);
    return NextResponse.json(
      { error: error.message || "Verification failed" },
      { status: 500 }
    );
  }
}

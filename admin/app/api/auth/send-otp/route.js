import { createClient } from "@supabase/supabase-js";
import twilio from "twilio";
import crypto from "crypto";
import { NextResponse } from "next/server";

// Supabase admin client (bypasses RLS)
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// Twilio client
const twilioClient = twilio(
  process.env.TWILIO_ACCOUNT_SID,
  process.env.TWILIO_AUTH_TOKEN
);

export async function POST(request) {
  try {
    const { phone } = await request.json();

    if (!phone || phone.length < 9) {
      return NextResponse.json(
        { error: "Valid phone number is required" },
        { status: 400 }
      );
    }

    // Generate 6-digit OTP
    const code = crypto.randomInt(100000, 999999).toString();

    // Delete any existing OTPs for this phone
    await supabase
      .from("otp_verifications")
      .delete()
      .eq("phone", phone);

    // Store OTP with 5-minute expiry
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000).toISOString();
    const { error: insertError } = await supabase
      .from("otp_verifications")
      .insert({ phone, code, expires_at: expiresAt });

    if (insertError) {
      console.error("OTP insert error:", insertError);
      return NextResponse.json(
        { error: "Failed to generate OTP" },
        { status: 500 }
      );
    }

    // Send SMS via Twilio
    await twilioClient.messages.create({
      body: `Your Dentist Tracker verification code is: ${code}`,
      from: process.env.TWILIO_PHONE_NUMBER,
      to: phone,
    });

    return NextResponse.json({ success: true, message: "OTP sent" });
  } catch (error) {
    console.error("Send OTP error:", error);
    return NextResponse.json(
      { error: error.message || "Failed to send OTP" },
      { status: 500 }
    );
  }
}

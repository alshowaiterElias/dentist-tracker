"use client";
import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "../../../lib/supabase-browser";

export default function ToggleActiveButton({ userId, isActive }) {
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  async function handleToggle() {
    const confirmMsg = isActive
      ? "Deactivate this user? They will lose access to the app."
      : "Activate this user? They will regain app access.";

    if (!confirm(confirmMsg)) return;

    setLoading(true);
    try {
      const { error } = await supabase
        .from("profiles")
        .update({ is_active: !isActive })
        .eq("id", userId);

      if (error) throw error;
      router.refresh();
    } catch (err) {
      alert("Failed to update user status: " + err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <button
      onClick={handleToggle}
      disabled={loading}
      className={`btn ${isActive ? "btn-danger" : "btn-primary"}`}
      style={{
        fontSize: "0.8125rem",
        padding: "0.375rem 0.875rem",
        opacity: loading ? 0.6 : 1,
      }}
    >
      {loading ? (
        <span className="spinner" />
      ) : isActive ? (
        "Deactivate"
      ) : (
        "Activate"
      )}
    </button>
  );
}

import { createClient } from "../../../lib/supabase-server";
import ToggleActiveButton from "./ToggleActiveButton";
import Link from "next/link";

export const dynamic = "force-dynamic";

export default async function UserDetailPage({ params }) {
  const { id } = await params;
  const supabase = await createClient();

  // Fetch user profile
  const { data: user } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", id)
    .single();

  if (!user) {
    return (
      <div style={{ textAlign: "center", padding: "4rem" }}>
        <h2 style={{ color: "var(--color-text-muted)" }}>User not found</h2>
        <Link href="/dashboard/users" className="btn btn-outline" style={{ marginTop: "1rem" }}>
          ← Back to Users
        </Link>
      </div>
    );
  }

  // Fetch user stats
  const [
    { count: patientCount },
    { count: treatmentCount },
    { count: appointmentCount },
  ] = await Promise.all([
    supabase.from("patients").select("*", { count: "exact", head: true }).eq("dentist_id", id),
    supabase.from("treatments").select("*", { count: "exact", head: true }).eq("dentist_id", id),
    supabase.from("appointments").select("*", { count: "exact", head: true }).eq("dentist_id", id),
  ]);

  // Fetch recent patients
  const { data: patients } = await supabase
    .from("patients")
    .select("id, full_name, phone, created_at")
    .eq("dentist_id", id)
    .eq("is_deleted", false)
    .order("created_at", { ascending: false })
    .limit(10);

  const stats = [
    { label: "Patients", value: patientCount ?? 0, icon: "👥", color: "#3b82f6" },
    { label: "Treatments", value: treatmentCount ?? 0, icon: "🦷", color: "#f59e0b" },
    { label: "Appointments", value: appointmentCount ?? 0, icon: "📅", color: "#22c55e" },
    { label: "Revenue %", value: `${user.revenue_percentage}%`, icon: "💰", color: "#0d9488" },
  ];

  return (
    <div>
      {/* Back Link */}
      <Link
        href="/dashboard/users"
        style={{
          color: "var(--color-text-muted)",
          textDecoration: "none",
          fontSize: "0.875rem",
          display: "inline-flex",
          alignItems: "center",
          gap: "0.25rem",
          marginBottom: "1rem",
        }}
      >
        ← Back to Users
      </Link>

      {/* User Header */}
      <div
        className="card"
        style={{
          display: "flex",
          alignItems: "center",
          gap: "1.5rem",
          marginBottom: "1.5rem",
        }}
      >
        {/* Avatar */}
        <div
          style={{
            width: 64,
            height: 64,
            borderRadius: 16,
            background: "linear-gradient(135deg, #0d9488, #14b8a6)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            flexShrink: 0,
          }}
        >
          <span style={{ fontSize: 28, color: "white", fontWeight: 700 }}>
            {(user.full_name || "?")[0].toUpperCase()}
          </span>
        </div>

        {/* Info */}
        <div style={{ flex: 1 }}>
          <h1
            style={{
              fontSize: "1.5rem",
              fontWeight: 700,
              margin: 0,
              marginBottom: "0.25rem",
            }}
          >
            {user.full_name || "Unnamed"}
          </h1>
          <div
            style={{
              display: "flex",
              gap: "1rem",
              color: "var(--color-text-secondary)",
              fontSize: "0.875rem",
            }}
          >
            {user.email && <span>📧 {user.email}</span>}
            {user.phone && <span>📱 {user.phone}</span>}
          </div>
          <div
            style={{
              fontSize: "0.75rem",
              color: "var(--color-text-muted)",
              marginTop: "0.5rem",
            }}
          >
            Joined {new Date(user.created_at).toLocaleDateString()}
            &nbsp;·&nbsp;Language: {user.preferred_language?.toUpperCase()}
          </div>
        </div>

        {/* Status + Toggle */}
        <div style={{ display: "flex", flexDirection: "column", alignItems: "flex-end", gap: "0.5rem" }}>
          <span className={`badge ${user.is_active ? "badge-active" : "badge-inactive"}`}>
            {user.is_active ? "Active" : "Inactive"}
          </span>
          <ToggleActiveButton userId={user.id} isActive={user.is_active} />
        </div>
      </div>

      {/* Stats Grid */}
      <div
        style={{
          display: "grid",
          gridTemplateColumns: "repeat(4, 1fr)",
          gap: "1rem",
          marginBottom: "1.5rem",
        }}
      >
        {stats.map((stat) => (
          <div key={stat.label} className="stat-card">
            <div className="stat-icon" style={{ background: `${stat.color}20` }}>
              <span style={{ fontSize: "1.125rem" }}>{stat.icon}</span>
            </div>
            <div className="stat-value" style={{ color: stat.color, fontSize: "1.25rem" }}>
              {typeof stat.value === "number" ? stat.value.toLocaleString() : stat.value}
            </div>
            <div className="stat-label">{stat.label}</div>
          </div>
        ))}
      </div>

      {/* Recent Patients */}
      <div className="card" style={{ padding: 0, overflow: "hidden" }}>
        <div
          style={{
            padding: "1rem 1.5rem",
            borderBottom: "1px solid var(--color-border)",
          }}
        >
          <h2 style={{ fontSize: "1rem", fontWeight: 600, margin: 0 }}>
            Recent Patients
          </h2>
        </div>
        <table className="data-table">
          <thead>
            <tr>
              <th>Name</th>
              <th>Phone</th>
              <th>Added</th>
            </tr>
          </thead>
          <tbody>
            {(patients ?? []).map((p) => (
              <tr key={p.id}>
                <td style={{ fontWeight: 500 }}>{p.full_name}</td>
                <td style={{ color: "var(--color-text-secondary)" }}>{p.phone}</td>
                <td style={{ color: "var(--color-text-muted)" }}>
                  {new Date(p.created_at).toLocaleDateString()}
                </td>
              </tr>
            ))}
            {(!patients || patients.length === 0) && (
              <tr>
                <td
                  colSpan={3}
                  style={{
                    textAlign: "center",
                    color: "var(--color-text-muted)",
                    padding: "2rem",
                  }}
                >
                  No patients yet
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

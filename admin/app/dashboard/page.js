import { createClient } from "../lib/supabase-server";

export const dynamic = "force-dynamic";

export default async function DashboardPage() {
  const supabase = await createClient();

  // Fetch stats from the database
  const [
    { count: usersCount },
    { count: patientsCount },
    { count: treatmentsCount },
    { count: appointmentsCount },
  ] = await Promise.all([
    supabase.from("profiles").select("*", { count: "exact", head: true }),
    supabase.from("patients").select("*", { count: "exact", head: true }),
    supabase.from("treatments").select("*", { count: "exact", head: true }),
    supabase.from("appointments").select("*", { count: "exact", head: true }),
  ]);

  // Recent signups
  const { data: recentUsers } = await supabase
    .from("profiles")
    .select("id, full_name, email, phone, created_at, is_active")
    .order("created_at", { ascending: false })
    .limit(5);

  const stats = [
    {
      label: "Total Dentists",
      value: usersCount ?? 0,
      icon: "👨‍⚕️",
      color: "#0d9488",
    },
    {
      label: "Total Patients",
      value: patientsCount ?? 0,
      icon: "👥",
      color: "#3b82f6",
    },
    {
      label: "Treatments",
      value: treatmentsCount ?? 0,
      icon: "🦷",
      color: "#f59e0b",
    },
    {
      label: "Appointments",
      value: appointmentsCount ?? 0,
      icon: "📅",
      color: "#22c55e",
    },
  ];

  return (
    <div>
      <h1
        style={{
          fontSize: "1.75rem",
          fontWeight: 700,
          marginBottom: "1.5rem",
        }}
      >
        Dashboard
      </h1>

      {/* Stats Grid */}
      <div
        style={{
          display: "grid",
          gridTemplateColumns: "repeat(auto-fill, minmax(220px, 1fr))",
          gap: "1rem",
          marginBottom: "2rem",
        }}
      >
        {stats.map((stat) => (
          <div key={stat.label} className="stat-card">
            <div
              className="stat-icon"
              style={{ background: `${stat.color}20` }}
            >
              <span style={{ fontSize: "1.25rem" }}>{stat.icon}</span>
            </div>
            <div className="stat-value" style={{ color: stat.color }}>
              {stat.value.toLocaleString()}
            </div>
            <div className="stat-label">{stat.label}</div>
          </div>
        ))}
      </div>

      {/* Recent Users */}
      <div className="card" style={{ padding: 0, overflow: "hidden" }}>
        <div
          style={{
            padding: "1rem 1.5rem",
            borderBottom: "1px solid var(--color-border)",
          }}
        >
          <h2 style={{ fontSize: "1rem", fontWeight: 600, margin: 0 }}>
            Recent Signups
          </h2>
        </div>
        <table className="data-table">
          <thead>
            <tr>
              <th>Name</th>
              <th>Contact</th>
              <th>Status</th>
              <th>Joined</th>
            </tr>
          </thead>
          <tbody>
            {(recentUsers ?? []).map((user) => (
              <tr key={user.id}>
                <td style={{ fontWeight: 500 }}>
                  {user.full_name || "Unnamed"}
                </td>
                <td style={{ color: "var(--color-text-secondary)" }}>
                  {user.email || user.phone || "—"}
                </td>
                <td>
                  <span
                    className={`badge ${user.is_active ? "badge-active" : "badge-inactive"}`}
                  >
                    {user.is_active ? "Active" : "Inactive"}
                  </span>
                </td>
                <td style={{ color: "var(--color-text-muted)" }}>
                  {new Date(user.created_at).toLocaleDateString()}
                </td>
              </tr>
            ))}
            {(!recentUsers || recentUsers.length === 0) && (
              <tr>
                <td
                  colSpan={4}
                  style={{
                    textAlign: "center",
                    color: "var(--color-text-muted)",
                    padding: "2rem",
                  }}
                >
                  No users yet
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

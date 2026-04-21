import Link from "next/link";
import { createClient } from "../../lib/supabase-server";

export const dynamic = "force-dynamic";

export default async function UsersPage() {
  const supabase = await createClient();

  const { data: users } = await supabase
    .from("profiles")
    .select("id, full_name, email, phone, revenue_percentage, is_active, created_at")
    .order("created_at", { ascending: false });

  return (
    <div>
      <div
        style={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
          marginBottom: "1.5rem",
        }}
      >
        <h1 style={{ fontSize: "1.75rem", fontWeight: 700, margin: 0 }}>
          Users
        </h1>
        <span
          style={{
            fontSize: "0.875rem",
            color: "var(--color-text-muted)",
          }}
        >
          {users?.length ?? 0} dentist(s)
        </span>
      </div>

      <div className="card" style={{ padding: 0, overflow: "hidden" }}>
        <table className="data-table">
          <thead>
            <tr>
              <th>Name</th>
              <th>Contact</th>
              <th>Revenue %</th>
              <th>Status</th>
              <th>Joined</th>
              <th style={{ textAlign: "right" }}>Actions</th>
            </tr>
          </thead>
          <tbody>
            {(users ?? []).map((user) => (
              <tr key={user.id}>
                <td>
                  <Link
                    href={`/dashboard/users/${user.id}`}
                    style={{
                      color: "var(--color-primary-light)",
                      textDecoration: "none",
                      fontWeight: 500,
                    }}
                  >
                    {user.full_name || "Unnamed"}
                  </Link>
                </td>
                <td style={{ color: "var(--color-text-secondary)" }}>
                  {user.email || user.phone || "—"}
                </td>
                <td style={{ color: "var(--color-accent)" }}>
                  {user.revenue_percentage}%
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
                <td style={{ textAlign: "right" }}>
                  <Link
                    href={`/dashboard/users/${user.id}`}
                    className="btn btn-outline"
                    style={{ fontSize: "0.8125rem", padding: "0.375rem 0.75rem" }}
                  >
                    View
                  </Link>
                </td>
              </tr>
            ))}
            {(!users || users.length === 0) && (
              <tr>
                <td
                  colSpan={6}
                  style={{
                    textAlign: "center",
                    color: "var(--color-text-muted)",
                    padding: "3rem",
                  }}
                >
                  No users registered yet
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

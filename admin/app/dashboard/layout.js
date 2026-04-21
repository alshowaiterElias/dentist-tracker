"use client";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { createClient } from "../lib/supabase-browser";

const navItems = [
  { href: "/dashboard", label: "Dashboard", icon: "📊" },
  { href: "/dashboard/users", label: "Users", icon: "👥" },
];

export default function DashboardLayout({ children }) {
  const pathname = usePathname();
  const router = useRouter();
  const supabase = createClient();

  async function handleLogout() {
    await supabase.auth.signOut();
    router.push("/");
  }

  return (
    <div style={{ display: "flex", minHeight: "100vh" }}>
      {/* Sidebar */}
      <aside
        style={{
          width: 260,
          background: "var(--color-surface)",
          borderRight: "1px solid var(--color-border)",
          display: "flex",
          flexDirection: "column",
          padding: "1.5rem 1rem",
          position: "fixed",
          top: 0,
          left: 0,
          bottom: 0,
          zIndex: 50,
        }}
      >
        {/* Logo */}
        <div
          style={{
            display: "flex",
            alignItems: "center",
            gap: "0.75rem",
            padding: "0 0.5rem",
            marginBottom: "2rem",
          }}
        >
          <div
            style={{
              width: 36,
              height: 36,
              borderRadius: 10,
              background: "linear-gradient(135deg, #0d9488, #14b8a6)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
            }}
          >
            <span style={{ fontSize: 18 }}>🦷</span>
          </div>
          <div>
            <div
              style={{
                fontWeight: 700,
                fontSize: "0.9375rem",
                color: "var(--color-text)",
              }}
            >
              Dentist Tracker
            </div>
            <div
              style={{
                fontSize: "0.6875rem",
                color: "var(--color-text-muted)",
              }}
            >
              Admin Panel
            </div>
          </div>
        </div>

        {/* Navigation */}
        <nav style={{ flex: 1, display: "flex", flexDirection: "column", gap: "0.25rem" }}>
          {navItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className={`sidebar-link ${pathname === item.href ? "active" : ""}`}
            >
              <span style={{ fontSize: "1.125rem" }}>{item.icon}</span>
              {item.label}
            </Link>
          ))}
        </nav>

        {/* Logout */}
        <button
          onClick={handleLogout}
          className="sidebar-link"
          style={{
            border: "none",
            background: "none",
            cursor: "pointer",
            width: "100%",
            textAlign: "left",
            color: "var(--color-error)",
          }}
        >
          <span style={{ fontSize: "1.125rem" }}>🚪</span>
          Sign Out
        </button>
      </aside>

      {/* Main Content */}
      <main
        style={{
          flex: 1,
          marginLeft: 260,
          padding: "2rem",
          minHeight: "100vh",
          background: "var(--color-bg)",
        }}
      >
        {children}
      </main>
    </div>
  );
}

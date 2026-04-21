import "./globals.css";

export const metadata = {
  title: "Dentist Tracker — Admin",
  description: "Admin panel for managing dentist accounts and system analytics",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}

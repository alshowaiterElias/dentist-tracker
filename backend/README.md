# Dentist Tracker — Backend

## Database Migrations

Run these SQL migrations **in order** in your Supabase Dashboard → SQL Editor:

| # | File | Description |
|---|------|-------------|
| 1 | `001_create_tables.sql` | Creates all 7 tables with indexes, constraints, and triggers |
| 2 | `002_rls_policies.sql` | Enables Row Level Security on all tables |
| 3 | `003_storage_bucket.sql` | Creates the `patient-files` storage bucket with RLS |
| 4 | `004_functions.sql` | Financial reporting functions and payment sync trigger |

## How to Run

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Navigate to **SQL Editor**
4. Copy and paste each migration file in order
5. Click **Run**

## Important Notes

- **Currency**: Hardcoded to Yemeni Rial (YER) — no currency column needed
- **RLS**: All tables have Row Level Security enabled. Each dentist can only access their own data
- **Storage**: Files are organized as `patient-files/{dentist_id}/{patient_id}/{filename}`
- **Auto-sync**: When a payment is inserted, the treatment's `amount_paid` is automatically recalculated
- **Profile creation**: When a user signs up via Supabase Auth, a profile row is auto-created via trigger

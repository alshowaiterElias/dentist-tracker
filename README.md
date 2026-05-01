# 🦷 Dentist Tracker

A production-grade dental practice management app built with **Flutter**, powered by **Supabase** (PostgreSQL + Auth + Storage).

> **Version:** 1.0.0+1 · **Platform:** Android · **Language:** English, Arabic (RTL)

## Overview

Dentist Tracker helps dental professionals manage their entire practice — patients, treatments, appointments, medications, files, and finances — all in one app. Built with offline-first architecture, Palmer Notation tooth charting, and secure cloud sync.

## Architecture

```
┌──────────────────────┐
│     Mobile App       │
│     (Flutter)        │
└──────────┬───────────┘
           │
   ┌───────▼───────────┐
   │     Supabase      │
   │  ┌─────────────┐  │
   │  │ PostgreSQL  │  │
   │  │ + Auth      │  │
   │  │ + Storage   │  │
   │  │ + RLS       │  │
   │  └─────────────┘  │
   │                    │
   │  ┌─────────────┐  │
   │  │ Resend SMTP │  │
   │  └─────────────┘  │
   └────────────────────┘
```

## Tech Stack

| Component | Technology |
|-----------|-----------|
| **Mobile App** | Flutter 3.9+, Dart, GetX (state management & routing) |
| **Backend** | Supabase (PostgreSQL, Auth, Storage, RPC, RLS) |
| **Auth** | Email/Password with email confirmation (Phone OTP — coming soon) |
| **Email** | Resend SMTP via custom domain (`hiretrack.ink`) |
| **Storage** | Supabase Storage (patient files, X-rays, documents) |
| **Tooth Notation** | Palmer Notation (UR/UL/LR/LL quadrants, 1-8) |
| **Offline** | SQLite via Drift, background sync queue |
| **Versioning** | Remote version check via `app_config` table |

## Features

### Core Modules
- **Patient Management** — Full CRUD with medical records, conditions, allergies, and notes
- **Treatment Tracking** — Palmer Notation tooth chart, procedure types, cost breakdown (total + technician)
- **Appointment Calendar** — Interactive calendar with day view, scheduling, and status management (scheduled/completed/cancelled/no-show)
- **Medications** — Prescriptions with dosage, frequency, start/end dates, and active status
- **File Uploads** — Camera, gallery, or document picker for X-rays, reports, and scans
- **Financial Dashboard** — Total income, paid/unpaid balances, dentist earnings with configurable revenue percentage
- **Monthly Reports** — Revenue, technician costs, appointment stats, no-show rates

### Patient Workflows
- **New Patient Visit** — Step-by-step: patient info → treatment + tooth chart → optional follow-up
- **Returning Patient Visit** — Search existing patient → add treatment → schedule follow-up

### Security & Account
- **Email Verification** — Branded confirmation emails via Resend SMTP with auto-redirect after verification
- **Delete Account Flow** — Two-step confirmation (dialog + type "DELETE"), submits deletion request, blocks future login until cancelled or processed
- **Forced App Updates** — Remote version config blocks outdated app versions from accessing the app

### Settings & Personalization
- **Profile** — Full name, email, phone, revenue percentage slider
- **Appearance** — Light / Dark / System theme
- **Language** — English / Arabic with full RTL support
- **Sync Status** — View pending operations, manual sync trigger
- **App Version** — Dynamic display from `package_info_plus`
- **About & Legal** — Privacy Policy, Terms of Service

## Project Structure

```
Dentist Tracker/
├── mobile/                    # Flutter mobile app
│   ├── lib/app/
│   │   ├── core/              # Theme, shared widgets, utils, constants
│   │   │   └── widgets/       # AppCard, AppButton, PalmerToothChart, etc.
│   │   ├── data/              # Models, repositories, providers
│   │   ├── modules/           # Feature modules (GetX pattern)
│   │   │   ├── auth/          # Login, Register, Email Verification, Deletion Pending
│   │   │   ├── dashboard/     # New/Returning patient visit flows
│   │   │   ├── patients/      # Patient list, detail, add/edit
│   │   │   ├── treatments/    # Add treatment with Palmer tooth chart
│   │   │   ├── appointments/  # Add/manage appointments
│   │   │   ├── medications/   # Prescriptions
│   │   │   ├── reports/       # Monthly financial reports
│   │   │   ├── settings/      # Profile, theme, sync, delete account
│   │   │   ├── home/          # Bottom nav container
│   │   │   └── splash/        # Splash + version check + auth gate
│   │   ├── routes/            # Route definitions (29 routes)
│   │   ├── services/          # SyncService, ConnectivityService, VersionCheckService
│   │   └── translations/      # EN/AR localization (370+ keys each)
│   ├── android/               # Android native config, signing, ProGuard
│   └── pubspec.yaml
├── backend/
│   └── migrations/            # Supabase SQL migrations (001–007)
└── README.md
```

## Getting Started

### Prerequisites
- Flutter SDK 3.9+
- Supabase project (free tier works)
- Resend account with verified domain (for auth emails)
- Android device or emulator

### 1. Database Setup

Run all SQL migrations **in order** in your Supabase SQL Editor (Dashboard → SQL Editor → New query):

```
backend/migrations/
├── 001_create_tables.sql              # Core tables: profiles, patients, treatments, etc.
├── 002_rls_policies.sql               # Row-level security policies
├── 003_storage_bucket.sql             # Storage bucket & upload policies
├── 004_functions.sql                  # Financial summary & report RPCs
├── 005_otp_table.sql                  # OTP verification table (phone auth)
├── 006_app_config.sql                 # App version config for forced updates
└── 007_account_deletion_requests.sql  # Account deletion request tracking
```

### 2. Email Setup (Resend SMTP)

Configure custom SMTP in Supabase for branded auth emails:

1. Go to **Supabase Dashboard → Authentication → SMTP Settings**
2. Toggle **Enable Custom SMTP** → ON
3. Set the fields:

| Field | Value |
|-------|-------|
| Sender email | `noreply@yourdomain.com` |
| Sender name | `Dentist Tracker` |
| SMTP Host | `smtp.resend.com` |
| Port | `465` |
| Username | `resend` |
| Password | Your Resend API key |

### 3. Mobile App

```bash
cd mobile

# Install dependencies
flutter pub get

# Run on connected device (pass environment variables securely)
flutter run \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key

# Build release AAB for Google Play
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/debug-info \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

> **Note:** Never hardcode credentials. Always pass them via `--dart-define` at build time.

### 4. App Signing

The app uses a release keystore for signing. Store your keystore config in `mobile/android/key.properties`:

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=your_key_alias
storeFile=/path/to/your-keystore.jks
```

> ⚠️ **Never commit `key.properties` or `.jks` files to version control.**

## Database Schema

| Table | Description |
|-------|-------------|
| `profiles` | Dentist profiles (name, email, phone, revenue %) |
| `patients` | Patient records (name, phone, age, gender, medical conditions) |
| `treatments` | Dental procedures (Palmer notation teeth, costs, status) |
| `payments` | Payment records linked to treatments |
| `appointments` | Scheduling with status tracking (scheduled/completed/cancelled/no-show) |
| `medications` | Prescriptions with dosage, frequency, and duration |
| `files` | Uploaded documents/images metadata |
| `app_config` | Remote app version config for forced/optional updates |
| `account_deletion_requests` | User account deletion requests with status tracking |
| `otp_codes` | Temporary OTP storage for phone auth (coming soon) |

## Security

### Build-Time Protection
- **Dart obfuscation** via `--obfuscate` flag renames all Dart symbols
- **Debug info splitting** via `--split-debug-info` strips debug symbols from release
- **R8 + ProGuard** minification enabled for Android native code
- **No hardcoded credentials** — all secrets injected via `--dart-define` at build time

### Server-Side Protection
- **Row Level Security (RLS)** on every table — users can only access their own data
- **Supabase Auth** handles all token management, session refresh, and email verification
- **Anon key is safe** — it only allows access through RLS policies (no admin access)
- **Service role key** never leaves the server / admin panel

### Account Security
- **Email verification required** before access
- **Account deletion** flow with two-step confirmation
- **Pending deletion blocks login** — users must cancel deletion to regain access

## Build & Release

### Release Build Command

```bash
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/debug-info \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

### Version Management

Update the version in `mobile/pubspec.yaml`:
```yaml
version: 1.0.0+1   # version_name+build_number
```

To enforce app updates, insert/update a row in the `app_config` table:
```sql
INSERT INTO app_config (key, value) VALUES
  ('min_version', '1.0.0'),        -- Force update below this
  ('latest_version', '1.1.0'),     -- Optional update suggestion
  ('store_url', 'https://play.google.com/store/apps/details?id=com.dentisttracker.dentist_tracker');
```

## License

Private — All rights reserved.

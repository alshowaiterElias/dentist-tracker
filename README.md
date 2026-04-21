# 🦷 Dentist Tracker

A comprehensive dental practice management system built with **Flutter** (mobile) and **Next.js** (admin panel), powered by **Supabase** backend.

## Overview

Dentist Tracker helps dental professionals manage their entire practice — patients, treatments, appointments, medications, files, and finances — all in one place.

## Architecture

```
┌──────────────────┐     ┌──────────────────┐
│   Mobile App     │     │   Admin Panel    │
│   (Flutter)      │     │   (Next.js)      │
└────────┬─────────┘     └────────┬─────────┘
         │                        │
         └──────────┬─────────────┘
                    │
            ┌───────▼───────┐
            │   Supabase    │
            │  (PostgreSQL  │
            │  + Storage    │
            │  + Auth)      │
            └───────────────┘
```

## Tech Stack

| Component | Technology |
|-----------|-----------|
| **Mobile App** | Flutter 3.9+, Dart, GetX (state management & routing) |
| **Admin Panel** | Next.js 15 (App Router), React, Tailwind CSS v4 |
| **Backend** | Supabase (PostgreSQL, Auth, Storage, RPC) |
| **Auth** | Email/Password + Phone OTP (via Twilio) |
| **Storage** | Supabase Storage (patient files, X-rays, documents) |

## Features

### Mobile App (Flutter)
- **Patient Management** — Full CRUD with medical records, conditions, and notes
- **Treatment Tracking** — Procedure types, tooth selection (dental chart), cost breakdown
- **Appointment Calendar** — Interactive calendar with day view, scheduling, and status management
- **Medications** — Prescriptions with dosage, frequency, and duration
- **File Uploads** — Camera, gallery, or document picker for X-rays, reports, and scans
- **Financial Dashboard** — Total income, paid/unpaid balances, dentist earnings with revenue percentage
- **Monthly Reports** — Revenue, technician costs, appointment stats, no-show rates
- **Settings** — Profile, revenue percentage slider, theme (light/dark/system), language (EN/AR)
- **About & Legal** — About app, Privacy Policy, Terms of Service
- **Bilingual** — Full English and Arabic translations

### Admin Panel (Next.js)
- **User Management** — View and manage registered dentists
- **Phone OTP Auth** — Twilio-powered OTP verification
- **Dashboard** — System-wide statistics

## Project Structure

```
Dentist Tracker/
├── mobile/                    # Flutter mobile app
│   ├── lib/app/
│   │   ├── core/              # Theme, widgets, utils, constants
│   │   ├── data/              # Models, repositories, providers
│   │   ├── modules/           # Feature modules (GetX pattern)
│   │   │   ├── auth/
│   │   │   ├── dashboard/
│   │   │   ├── patients/
│   │   │   ├── treatments/
│   │   │   ├── appointments/
│   │   │   ├── medications/
│   │   │   ├── reports/
│   │   │   ├── settings/
│   │   │   ├── home/
│   │   │   └── splash/
│   │   ├── routes/            # Route definitions
│   │   └── translations/      # EN/AR localization
│   └── pubspec.yaml
├── admin/                     # Next.js admin panel
│   ├── app/                   # App Router pages & API routes
│   └── package.json
├── backend/
│   └── migrations/            # Supabase SQL migrations
└── docs/                      # Documentation
```

## Getting Started

### Prerequisites
- Flutter SDK 3.9+
- Node.js 18+
- Supabase project (free tier works)
- Twilio account (for phone OTP)

### 1. Database Setup

Run the SQL migrations in order in your Supabase SQL Editor:

```bash
backend/migrations/
├── 001_initial_schema.sql     # Tables, RLS policies, RPC functions
├── 002_rls_policies.sql       # Row-level security
├── 003_storage_bucket.sql     # Storage bucket & policies
├── 004_functions.sql          # Financial summary & report RPCs
└── 005_otp_table.sql          # OTP verification table
```

### 2. Mobile App

```bash
cd mobile

# Install dependencies
flutter pub get

# Configure Supabase credentials in lib/main.dart
# Set your SUPABASE_URL and SUPABASE_ANON_KEY

# Run on device/emulator
flutter run
```

### 3. Admin Panel

```bash
cd admin

# Install dependencies
npm install

# Create .env.local with:
# NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
# NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
# SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
# TWILIO_ACCOUNT_SID=your_twilio_sid
# TWILIO_AUTH_TOKEN=your_twilio_token
# TWILIO_PHONE_NUMBER=your_twilio_number

# Run dev server
npm run dev
```

### 4. Network Testing (Physical Device)

When testing the mobile app on a physical device connected to the same network as your PC:

1. Find your PC's local IP (e.g., `192.168.x.x`)
2. Update `AppConstants.apiBaseUrl` in the mobile app to point to `http://YOUR_PC_IP:3000`
3. Ensure both devices are on the same Wi-Fi network

## Database Schema

| Table | Description |
|-------|-------------|
| `profiles` | Dentist profiles (name, email, phone, revenue %) |
| `patients` | Patient records (name, phone, age, medical status) |
| `treatments` | Dental procedures (type, teeth, costs, status) |
| `payments` | Payment records linked to treatments |
| `appointments` | Scheduling with status tracking |
| `medications` | Prescriptions with dosage details |
| `files` | Uploaded documents/images metadata |
| `otp_codes` | Temporary OTP storage for phone auth |

## License

Private — All rights reserved.

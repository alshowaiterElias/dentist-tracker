# 🔐 Required Keys & Credential Rotation Guide

## Overview

The codebase has been updated to remove all hardcoded secrets. You now need to
provide credentials via `--dart-define` build flags and environment variables.

---

## 1. Supabase Credentials (Mobile App)

### How to provide at build time

```bash
# Development
flutter run \
  --dart-define=SUPABASE_URL=https://rnvyrazifxiskhuaowhw.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key-here

# Production Release Build
flutter build appbundle \
  --dart-define=SUPABASE_URL=https://rnvyrazifxiskhuaowhw.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key-here
```

### Where to find your keys
- **Supabase Dashboard** → Settings → API
  - `Project URL` → use as `SUPABASE_URL`
  - `anon / public` key → use as `SUPABASE_ANON_KEY`

> **Note:** The anon key is designed to be public (it's client-safe), but
> injecting it via `--dart-define` decouples builds from hardcoded values
> and enables key rotation without code changes.

---

## 2. OTP Backend URL (When Phone Auth is Ready)

```bash
flutter run \
  --dart-define=API_BASE_URL=https://your-otp-backend.vercel.app
```

Phone auth is currently disabled via `AppConstants.isPhoneAuthEnabled = false`.
When your admin/OTP backend is deployed:

1. Deploy the `admin/` Next.js app to Vercel or your hosting provider
2. Set the `API_BASE_URL` dart-define to the deployed URL
3. Change `isPhoneAuthEnabled` to `true` in `app_constants.dart`

---

## 3. Admin Panel Environment Variables

The `admin/.env.local` file should **NEVER be committed to git**.
Create it locally on each dev machine and in your deployment provider's env config.

### Required Variables

| Variable | Source | Notes |
|---|---|---|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase Dashboard → API | Project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase Dashboard → API | Client-safe anon key |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase Dashboard → API → service_role | **SECRET** — bypasses RLS |
| `TWILIO_ACCOUNT_SID` | Twilio Console → Account Info | |
| `TWILIO_AUTH_TOKEN` | Twilio Console → Account Info | **SECRET** |
| `TWILIO_PHONE_NUMBER` | Twilio Console → Phone Numbers | With country code |

---

## 4. ⚠️ IMMEDIATE ACTION: Rotate Compromised Credentials

The following credentials were previously committed to the git history and
**must be rotated immediately**:

### 4a. Supabase Service Role Key
1. Go to Supabase Dashboard → Settings → API
2. Click "Regenerate service_role key"
3. Update your `.env.local` and deployment environment

### 4b. Twilio Credentials
1. Go to Twilio Console → Account → API Keys & Tokens
2. Rotate your Auth Token
3. Update your `.env.local` and deployment environment

### 4c. Android Signing Keystore
1. Generate a new keystore:
   ```bash
   keytool -genkey -v \
     -keystore dentist-tracker-release-v2.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias dentist-tracker
   ```
2. Update `android/key.properties` with new passwords
3. **Never commit** `key.properties` or `.jks` files

### 4d. Clean Git History (Recommended)
```bash
# Option A: BFG Repo Cleaner (faster)
bfg --delete-files "*.jks" --delete-files "key.properties" --delete-files ".env.local"

# Option B: git filter-branch
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch admin/.env.local android/key.properties' \
  --prune-empty -- --all
```

---

## 5. Android Signing Setup

The `android/key.properties` file is gitignored. Each developer must create it:

```properties
# android/key.properties (DO NOT COMMIT)
storePassword=YOUR_NEW_PASSWORD
keyPassword=YOUR_NEW_PASSWORD
keyAlias=dentist-tracker
storeFile=../dentist-tracker-release-v2.jks
```

---

## 6. VS Code Launch Configuration (Optional)

Add to `.vscode/launch.json` for convenient development:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dentist Tracker (Dev)",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=SUPABASE_URL=https://rnvyrazifxiskhuaowhw.supabase.co",
        "--dart-define=SUPABASE_ANON_KEY=your-key-here"
      ]
    }
  ]
}
```

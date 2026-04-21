-- ============================================================
-- Dentist Tracker — Row Level Security Policies
-- Migration 002: RLS for all tables
-- Run this in: Supabase Dashboard → SQL Editor
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- Enable RLS on all tables
-- ─────────────────────────────────────────────────────────────
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.treatments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.files ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.medications ENABLE ROW LEVEL SECURITY;

-- ─────────────────────────────────────────────────────────────
-- PROFILES: Users can read/update their own profile
-- ─────────────────────────────────────────────────────────────
CREATE POLICY "profiles_select_own" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "profiles_update_own" ON public.profiles
  FOR UPDATE USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

CREATE POLICY "profiles_insert_own" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- ─────────────────────────────────────────────────────────────
-- PATIENTS: Dentists can CRUD their own patients
-- ─────────────────────────────────────────────────────────────
CREATE POLICY "patients_select_own" ON public.patients
  FOR SELECT USING (auth.uid() = dentist_id);

CREATE POLICY "patients_insert_own" ON public.patients
  FOR INSERT WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "patients_update_own" ON public.patients
  FOR UPDATE USING (auth.uid() = dentist_id)
  WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "patients_delete_own" ON public.patients
  FOR DELETE USING (auth.uid() = dentist_id);

-- ─────────────────────────────────────────────────────────────
-- TREATMENTS: Dentists can CRUD their own treatments
-- ─────────────────────────────────────────────────────────────
CREATE POLICY "treatments_select_own" ON public.treatments
  FOR SELECT USING (auth.uid() = dentist_id);

CREATE POLICY "treatments_insert_own" ON public.treatments
  FOR INSERT WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "treatments_update_own" ON public.treatments
  FOR UPDATE USING (auth.uid() = dentist_id)
  WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "treatments_delete_own" ON public.treatments
  FOR DELETE USING (auth.uid() = dentist_id);

-- ─────────────────────────────────────────────────────────────
-- PAYMENTS: Dentists can CRUD their own payments
-- ─────────────────────────────────────────────────────────────
CREATE POLICY "payments_select_own" ON public.payments
  FOR SELECT USING (auth.uid() = dentist_id);

CREATE POLICY "payments_insert_own" ON public.payments
  FOR INSERT WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "payments_update_own" ON public.payments
  FOR UPDATE USING (auth.uid() = dentist_id)
  WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "payments_delete_own" ON public.payments
  FOR DELETE USING (auth.uid() = dentist_id);

-- ─────────────────────────────────────────────────────────────
-- APPOINTMENTS: Dentists can CRUD their own appointments
-- ─────────────────────────────────────────────────────────────
CREATE POLICY "appointments_select_own" ON public.appointments
  FOR SELECT USING (auth.uid() = dentist_id);

CREATE POLICY "appointments_insert_own" ON public.appointments
  FOR INSERT WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "appointments_update_own" ON public.appointments
  FOR UPDATE USING (auth.uid() = dentist_id)
  WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "appointments_delete_own" ON public.appointments
  FOR DELETE USING (auth.uid() = dentist_id);

-- ─────────────────────────────────────────────────────────────
-- FILES: Dentists can CRUD their own files
-- ─────────────────────────────────────────────────────────────
CREATE POLICY "files_select_own" ON public.files
  FOR SELECT USING (auth.uid() = dentist_id);

CREATE POLICY "files_insert_own" ON public.files
  FOR INSERT WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "files_update_own" ON public.files
  FOR UPDATE USING (auth.uid() = dentist_id)
  WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "files_delete_own" ON public.files
  FOR DELETE USING (auth.uid() = dentist_id);

-- ─────────────────────────────────────────────────────────────
-- MEDICATIONS: Dentists can CRUD their own medications
-- ─────────────────────────────────────────────────────────────
CREATE POLICY "medications_select_own" ON public.medications
  FOR SELECT USING (auth.uid() = dentist_id);

CREATE POLICY "medications_insert_own" ON public.medications
  FOR INSERT WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "medications_update_own" ON public.medications
  FOR UPDATE USING (auth.uid() = dentist_id)
  WITH CHECK (auth.uid() = dentist_id);

CREATE POLICY "medications_delete_own" ON public.medications
  FOR DELETE USING (auth.uid() = dentist_id);

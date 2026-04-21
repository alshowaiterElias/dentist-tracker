-- ============================================================
-- Dentist Tracker — Storage Bucket & Policies
-- Migration 003: Supabase Storage setup
-- Run this in: Supabase Dashboard → SQL Editor
-- ============================================================

-- Create the patient-files bucket (PUBLIC for image viewing)
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'patient-files',
  'patient-files',
  true,
  10485760, -- 10MB limit
  ARRAY[
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/heic',
    'application/pdf'
  ]
) ON CONFLICT (id) DO UPDATE SET public = true;

-- ─────────────────────────────────────────────────────────────
-- Storage RLS: Each dentist can only upload/read/delete
-- files in their own folder: patient-files/{dentist_id}/...
-- ─────────────────────────────────────────────────────────────

-- Allow authenticated users to upload to their own folder
CREATE POLICY IF NOT EXISTS "storage_insert_own" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'patient-files'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- Allow anyone to read files (public bucket for image viewing)
CREATE POLICY IF NOT EXISTS "storage_select_public" ON storage.objects
  FOR SELECT TO public
  USING (
    bucket_id = 'patient-files'
  );

-- Allow authenticated users to update their own files
CREATE POLICY IF NOT EXISTS "storage_update_own" ON storage.objects
  FOR UPDATE TO authenticated
  USING (
    bucket_id = 'patient-files'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- Allow authenticated users to delete their own files
CREATE POLICY IF NOT EXISTS "storage_delete_own" ON storage.objects
  FOR DELETE TO authenticated
  USING (
    bucket_id = 'patient-files'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

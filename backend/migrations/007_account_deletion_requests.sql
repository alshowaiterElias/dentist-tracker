-- ============================================================================
-- Migration 007: Account Deletion Requests
-- ============================================================================
-- Run this in Supabase SQL Editor:
--   Dashboard → SQL Editor → New query → Paste & Run

CREATE TABLE IF NOT EXISTS account_deletion_requests (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL,
  email         TEXT NOT NULL DEFAULT '',
  requested_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  status        TEXT NOT NULL DEFAULT 'pending'  -- pending, processing, completed, rejected
);

-- Any authenticated user can insert their own request
ALTER TABLE account_deletion_requests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can request their own deletion"
  ON account_deletion_requests
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Users can read their own requests
CREATE POLICY "Users can read own requests"
  ON account_deletion_requests
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Users can cancel (delete) their own pending requests
CREATE POLICY "Users can cancel own pending requests"
  ON account_deletion_requests
  FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id AND status = 'pending');

-- ─────────────────────────────────────────────────────────────
-- Migration: Palmer Notation + Support Requests
-- Run in Supabase SQL Editor
-- ─────────────────────────────────────────────────────────────

-- 1. Change tooth_numbers from INTEGER[] to TEXT[] to support Palmer notation
--    (e.g., "UR3", "LL5" instead of just numbers)
ALTER TABLE public.treatments
  ALTER COLUMN tooth_numbers TYPE TEXT[]
  USING tooth_numbers::TEXT[];

-- 2. Create support_requests table
CREATE TABLE IF NOT EXISTS public.support_requests (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  email TEXT NOT NULL DEFAULT '',
  subject TEXT NOT NULL,
  message TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'resolved', 'closed')),
  admin_notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Index for querying by user
CREATE INDEX IF NOT EXISTS idx_support_requests_user
  ON public.support_requests(user_id);

-- Index for admin dashboard filtering by status
CREATE INDEX IF NOT EXISTS idx_support_requests_status
  ON public.support_requests(status);

-- RLS: Users can insert their own requests and read their own
ALTER TABLE public.support_requests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can insert their own support requests"
  ON public.support_requests
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can read their own support requests"
  ON public.support_requests
  FOR SELECT
  USING (auth.uid() = user_id);

-- Auto-update updated_at timestamp
CREATE TRIGGER set_support_requests_updated_at
  BEFORE UPDATE ON public.support_requests
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

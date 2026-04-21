-- ============================================================
-- Dentist Tracker — OTP Verifications
-- Migration 005: Temporary OTP storage for Twilio-based auth
-- Run this in: Supabase Dashboard → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.otp_verifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  phone TEXT NOT NULL,
  code TEXT NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  verified BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_otp_phone ON public.otp_verifications(phone);

-- Clean up expired OTPs automatically (run periodically or on insert)
CREATE OR REPLACE FUNCTION public.cleanup_expired_otps()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM public.otp_verifications
  WHERE expires_at < now() OR verified = true;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cleanup_otps_on_insert
  AFTER INSERT ON public.otp_verifications
  FOR EACH STATEMENT EXECUTE FUNCTION public.cleanup_expired_otps();

-- No RLS on this table — it's accessed via service role key only
ALTER TABLE public.otp_verifications ENABLE ROW LEVEL SECURITY;
-- Service role bypasses RLS, no policies needed (anon gets nothing)

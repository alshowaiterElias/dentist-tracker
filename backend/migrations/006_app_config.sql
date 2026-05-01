-- ============================================================================
-- Migration 006: App Config (Version Control & Force Update)
-- ============================================================================
-- Run this in Supabase SQL Editor:
--   Dashboard → SQL Editor → New query → Paste & Run

-- Single-row config table for remote app version management
CREATE TABLE IF NOT EXISTS app_config (
  id            INTEGER PRIMARY KEY DEFAULT 1 CHECK (id = 1),  -- ensures single row
  min_version   TEXT NOT NULL DEFAULT '1.0.0',                 -- below this = forced update
  latest_version TEXT NOT NULL DEFAULT '1.0.0',                -- below this = optional update
  force_update  BOOLEAN NOT NULL DEFAULT false,                -- master kill switch
  store_url     TEXT NOT NULL DEFAULT '',                      -- Play Store / App Store link
  update_message TEXT NOT NULL DEFAULT '',                     -- message shown in update dialog
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Seed with initial config matching current app version
INSERT INTO app_config (id, min_version, latest_version, force_update, store_url, update_message)
VALUES (
  1,
  '1.0.0',
  '1.0.0',
  false,
  '',
  'A new version is available with improvements and bug fixes.'
)
ON CONFLICT (id) DO NOTHING;

-- Allow all authenticated users to READ the config (no RLS write — admin only via dashboard)
ALTER TABLE app_config ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read app_config"
  ON app_config
  FOR SELECT
  TO authenticated
  USING (true);

-- Auto-update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_app_config_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_app_config_updated
  BEFORE UPDATE ON app_config
  FOR EACH ROW
  EXECUTE FUNCTION update_app_config_timestamp();

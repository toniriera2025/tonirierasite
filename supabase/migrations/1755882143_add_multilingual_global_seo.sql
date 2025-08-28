-- Migration: add_multilingual_global_seo
-- Created at: 1755882143

-- Add multilingual support to global SEO settings table
-- This migration adds language-specific global SEO configurations

-- Add language column
ALTER TABLE global_seo_settings ADD COLUMN IF NOT EXISTS language VARCHAR(2) DEFAULT 'en';

-- Add multilingual setting values
ALTER TABLE global_seo_settings ADD COLUMN IF NOT EXISTS setting_value_en TEXT;
ALTER TABLE global_seo_settings ADD COLUMN IF NOT EXISTS setting_value_es TEXT;
ALTER TABLE global_seo_settings ADD COLUMN IF NOT EXISTS setting_value_ca TEXT;

-- Add translation status
ALTER TABLE global_seo_settings ADD COLUMN IF NOT EXISTS translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes
CREATE INDEX IF NOT EXISTS idx_global_seo_language ON global_seo_settings (language);
CREATE INDEX IF NOT EXISTS idx_global_seo_key_lang ON global_seo_settings (setting_key, language);

-- Update existing data: migrate current content to English columns
UPDATE global_seo_settings SET 
    setting_value_en = COALESCE(setting_value, '')
WHERE setting_value_en IS NULL OR setting_value_en = '';;
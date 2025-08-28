-- Add multilingual support to global SEO settings table
-- This migration adds language-specific global SEO configurations

-- Add language column
ALTER TABLE global_seo_settings ADD COLUMN language VARCHAR(2) DEFAULT 'en';

-- Add multilingual setting values
ALTER TABLE global_seo_settings ADD COLUMN setting_value_en TEXT;
ALTER TABLE global_seo_settings ADD COLUMN setting_value_es TEXT;
ALTER TABLE global_seo_settings ADD COLUMN setting_value_ca TEXT;

-- Add translation status
ALTER TABLE global_seo_settings ADD COLUMN translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes
CREATE INDEX IF NOT EXISTS idx_global_seo_language ON global_seo_settings (language);
CREATE INDEX IF NOT EXISTS idx_global_seo_key_lang ON global_seo_settings (setting_key, language);

-- Update existing data: migrate current content to English columns
UPDATE global_seo_settings SET 
    setting_value_en = COALESCE(setting_value, '')
WHERE setting_value_en IS NULL OR setting_value_en = '';

-- Create unique constraint to prevent duplicate key-language combinations
ALTER TABLE global_seo_settings ADD CONSTRAINT unique_setting_key_language UNIQUE (setting_key, language);

-- Add comments
COMMENT ON COLUMN global_seo_settings.language IS 'Language code (en, es, ca)';
COMMENT ON COLUMN global_seo_settings.setting_value_en IS 'Setting value in English';
COMMENT ON COLUMN global_seo_settings.setting_value_es IS 'Setting value in Spanish';
COMMENT ON COLUMN global_seo_settings.setting_value_ca IS 'Setting value in Catalan';
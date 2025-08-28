-- Migration: add_multilingual_seo_settings
-- Created at: 1755882132

-- Add multilingual support to SEO settings table
-- This migration adds language-specific SEO configurations

-- Add language column to identify which language this setting is for
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS language VARCHAR(2) DEFAULT 'en';

-- Add multilingual page titles
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS title_en TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS title_es TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS title_ca TEXT;

-- Add multilingual descriptions
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS description_en TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS description_es TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS description_ca TEXT;

-- Add multilingual keywords
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS keywords_en JSONB DEFAULT '[]'::jsonb;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS keywords_es JSONB DEFAULT '[]'::jsonb;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS keywords_ca JSONB DEFAULT '[]'::jsonb;

-- Add multilingual Open Graph data
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS og_title_en TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS og_title_es TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS og_title_ca TEXT;

ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS og_description_en TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS og_description_es TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS og_description_ca TEXT;

-- Add language-specific canonical URLs
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS canonical_url_en TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS canonical_url_es TEXT;
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS canonical_url_ca TEXT;

-- Add hreflang support
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS hreflang_links JSONB DEFAULT '{}'::jsonb;

-- Add translation status
ALTER TABLE seo_settings ADD COLUMN IF NOT EXISTS translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes
CREATE INDEX IF NOT EXISTS idx_seo_settings_language ON seo_settings (language);
CREATE INDEX IF NOT EXISTS idx_seo_settings_page_lang ON seo_settings (page_path, language);

-- Update existing data: migrate current content to English columns
UPDATE seo_settings SET 
    title_en = COALESCE(title, ''),
    description_en = COALESCE(description, ''),
    keywords_en = CASE 
        WHEN keywords IS NOT NULL THEN to_jsonb(keywords)
        ELSE '[]'::jsonb
    END,
    og_title_en = COALESCE(og_title, ''),
    og_description_en = COALESCE(og_description, ''),
    canonical_url_en = COALESCE(canonical_url, '')
WHERE title_en IS NULL OR title_en = '';;
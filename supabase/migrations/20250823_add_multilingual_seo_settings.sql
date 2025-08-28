-- Add multilingual support to SEO settings table
-- This migration adds language-specific SEO configurations

-- Add language column to identify which language this setting is for
ALTER TABLE seo_settings ADD COLUMN language VARCHAR(2) DEFAULT 'en';

-- Add multilingual page titles
ALTER TABLE seo_settings ADD COLUMN title_en TEXT;
ALTER TABLE seo_settings ADD COLUMN title_es TEXT;
ALTER TABLE seo_settings ADD COLUMN title_ca TEXT;

-- Add multilingual descriptions
ALTER TABLE seo_settings ADD COLUMN description_en TEXT;
ALTER TABLE seo_settings ADD COLUMN description_es TEXT;
ALTER TABLE seo_settings ADD COLUMN description_ca TEXT;

-- Add multilingual keywords
ALTER TABLE seo_settings ADD COLUMN keywords_en JSONB DEFAULT '[]'::jsonb;
ALTER TABLE seo_settings ADD COLUMN keywords_es JSONB DEFAULT '[]'::jsonb;
ALTER TABLE seo_settings ADD COLUMN keywords_ca JSONB DEFAULT '[]'::jsonb;

-- Add multilingual Open Graph data
ALTER TABLE seo_settings ADD COLUMN og_title_en TEXT;
ALTER TABLE seo_settings ADD COLUMN og_title_es TEXT;
ALTER TABLE seo_settings ADD COLUMN og_title_ca TEXT;

ALTER TABLE seo_settings ADD COLUMN og_description_en TEXT;
ALTER TABLE seo_settings ADD COLUMN og_description_es TEXT;
ALTER TABLE seo_settings ADD COLUMN og_description_ca TEXT;

-- Add language-specific canonical URLs
ALTER TABLE seo_settings ADD COLUMN canonical_url_en TEXT;
ALTER TABLE seo_settings ADD COLUMN canonical_url_es TEXT;
ALTER TABLE seo_settings ADD COLUMN canonical_url_ca TEXT;

-- Add hreflang support
ALTER TABLE seo_settings ADD COLUMN hreflang_links JSONB DEFAULT '{}'::jsonb;

-- Add translation status
ALTER TABLE seo_settings ADD COLUMN translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes
CREATE INDEX IF NOT EXISTS idx_seo_settings_language ON seo_settings (language);
CREATE INDEX IF NOT EXISTS idx_seo_settings_page_lang ON seo_settings (page_path, language);

-- Update existing data: migrate current content to English columns
UPDATE seo_settings SET 
    title_en = COALESCE(title, ''),
    description_en = COALESCE(description, ''),
    keywords_en = COALESCE(keywords, '[]'::jsonb),
    og_title_en = COALESCE(og_title, ''),
    og_description_en = COALESCE(og_description, ''),
    canonical_url_en = COALESCE(canonical_url, '')
WHERE title_en IS NULL OR title_en = '';

-- Create unique constraint to prevent duplicate page-language combinations
ALTER TABLE seo_settings ADD CONSTRAINT unique_page_language UNIQUE (page_path, language);

-- Add comments
COMMENT ON COLUMN seo_settings.language IS 'Language code (en, es, ca)';
COMMENT ON COLUMN seo_settings.hreflang_links IS 'JSON object containing hreflang alternate URLs';
COMMENT ON COLUMN seo_settings.translation_status IS 'Translation completion status for each language';
-- Migration: add_multilingual_projects_fixed
-- Created at: 1755881895

-- Add multilingual support to projects table
-- This migration adds language-specific columns for English, Spanish, and Catalan

-- Add multilingual title columns
ALTER TABLE projects ADD COLUMN IF NOT EXISTS title_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS title_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS title_ca TEXT;

-- Add multilingual description columns
ALTER TABLE projects ADD COLUMN IF NOT EXISTS description_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS description_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS description_ca TEXT;

-- Add multilingual SEO columns
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_title_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_title_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_title_ca TEXT;

ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_description_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_description_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_description_ca TEXT;

ALTER TABLE projects ADD COLUMN IF NOT EXISTS meta_title_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS meta_title_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS meta_title_ca TEXT;

ALTER TABLE projects ADD COLUMN IF NOT EXISTS meta_description_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS meta_description_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS meta_description_ca TEXT;

-- Add multilingual Open Graph columns
ALTER TABLE projects ADD COLUMN IF NOT EXISTS og_title_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS og_title_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS og_title_ca TEXT;

ALTER TABLE projects ADD COLUMN IF NOT EXISTS og_description_en TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS og_description_es TEXT;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS og_description_ca TEXT;

-- Add multilingual keywords columns (JSON arrays)
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_keywords_en JSONB DEFAULT '[]'::jsonb;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_keywords_es JSONB DEFAULT '[]'::jsonb;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS seo_keywords_ca JSONB DEFAULT '[]'::jsonb;

-- Add default language indicator
ALTER TABLE projects ADD COLUMN IF NOT EXISTS default_language VARCHAR(2) DEFAULT 'en';

-- Add language status tracking
ALTER TABLE projects ADD COLUMN IF NOT EXISTS translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes for performance
CREATE INDEX IF NOT EXISTS idx_projects_title_en ON projects USING GIN (to_tsvector('english', title_en));
CREATE INDEX IF NOT EXISTS idx_projects_title_es ON projects USING GIN (to_tsvector('spanish', title_es));
CREATE INDEX IF NOT EXISTS idx_projects_description_en ON projects USING GIN (to_tsvector('english', description_en));
CREATE INDEX IF NOT EXISTS idx_projects_description_es ON projects USING GIN (to_tsvector('spanish', description_es));
CREATE INDEX IF NOT EXISTS idx_projects_default_language ON projects (default_language);

-- Update existing data: migrate current single-language content to English columns
-- Handle keywords conversion from text[] to jsonb
UPDATE projects SET 
    title_en = COALESCE(title, ''),
    description_en = COALESCE(description, ''),
    seo_title_en = COALESCE(seo_title, ''),
    seo_description_en = COALESCE(seo_description, ''),
    meta_title_en = COALESCE(meta_title, ''),
    meta_description_en = COALESCE(meta_description, ''),
    og_title_en = COALESCE(og_title, ''),
    og_description_en = COALESCE(og_description, ''),
    seo_keywords_en = CASE 
        WHEN seo_keywords IS NOT NULL THEN to_jsonb(seo_keywords)
        ELSE '[]'::jsonb
    END
WHERE title_en IS NULL OR title_en = '';;
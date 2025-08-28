-- Migration: add_multilingual_content_blocks
-- Created at: 1755881919

-- Add multilingual support to content blocks table
-- This migration adds language-specific columns for dynamic content

-- Add multilingual content columns
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS content_en TEXT;
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS content_es TEXT;
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS content_ca TEXT;

-- Add section titles for each language
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS section_title_en TEXT;
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS section_title_es TEXT;
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS section_title_ca TEXT;

-- Add default language and translation status
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS default_language VARCHAR(2) DEFAULT 'en';
ALTER TABLE content_blocks ADD COLUMN IF NOT EXISTS translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes for full-text search
CREATE INDEX IF NOT EXISTS idx_content_blocks_en ON content_blocks USING GIN (to_tsvector('english', content_en));
CREATE INDEX IF NOT EXISTS idx_content_blocks_es ON content_blocks USING GIN (to_tsvector('spanish', content_es));

-- Update existing data: migrate current content to English columns
UPDATE content_blocks SET 
    content_en = COALESCE(content, ''),
    section_title_en = COALESCE(section, '')
WHERE content_en IS NULL OR content_en = '';;
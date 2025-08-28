-- Add multilingual support to content blocks table
-- This migration adds language-specific columns for dynamic content

-- Add multilingual content columns
ALTER TABLE content_blocks ADD COLUMN content_en TEXT;
ALTER TABLE content_blocks ADD COLUMN content_es TEXT;
ALTER TABLE content_blocks ADD COLUMN content_ca TEXT;

-- Add section titles for each language
ALTER TABLE content_blocks ADD COLUMN section_title_en TEXT;
ALTER TABLE content_blocks ADD COLUMN section_title_es TEXT;
ALTER TABLE content_blocks ADD COLUMN section_title_ca TEXT;

-- Add default language and translation status
ALTER TABLE content_blocks ADD COLUMN default_language VARCHAR(2) DEFAULT 'en';
ALTER TABLE content_blocks ADD COLUMN translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes for full-text search
CREATE INDEX IF NOT EXISTS idx_content_blocks_en ON content_blocks USING GIN (to_tsvector('english', content_en));
CREATE INDEX IF NOT EXISTS idx_content_blocks_es ON content_blocks USING GIN (to_tsvector('spanish', content_es));

-- Update existing data: migrate current content to English columns
UPDATE content_blocks SET 
    content_en = COALESCE(content, ''),
    section_title_en = COALESCE(section, '')
WHERE content_en IS NULL OR content_en = '';

-- Add comments
COMMENT ON COLUMN content_blocks.content_en IS 'Content block text in English';
COMMENT ON COLUMN content_blocks.content_es IS 'Content block text in Spanish';
COMMENT ON COLUMN content_blocks.content_ca IS 'Content block text in Catalan';
COMMENT ON COLUMN content_blocks.section_title_en IS 'Section title in English';
COMMENT ON COLUMN content_blocks.section_title_es IS 'Section title in Spanish';
COMMENT ON COLUMN content_blocks.section_title_ca IS 'Section title in Catalan';
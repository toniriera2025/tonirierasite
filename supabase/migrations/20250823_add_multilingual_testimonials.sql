-- Add multilingual support to testimonials table
-- This migration adds language-specific columns for testimonials

-- Add multilingual testimonial text columns
ALTER TABLE testimonials ADD COLUMN testimonial_text_en TEXT;
ALTER TABLE testimonials ADD COLUMN testimonial_text_es TEXT;
ALTER TABLE testimonials ADD COLUMN testimonial_text_ca TEXT;

-- Add multilingual client role columns
ALTER TABLE testimonials ADD COLUMN client_role_en TEXT;
ALTER TABLE testimonials ADD COLUMN client_role_es TEXT;
ALTER TABLE testimonials ADD COLUMN client_role_ca TEXT;

-- Add multilingual client company columns
ALTER TABLE testimonials ADD COLUMN client_company_en TEXT;
ALTER TABLE testimonials ADD COLUMN client_company_es TEXT;
ALTER TABLE testimonials ADD COLUMN client_company_ca TEXT;

-- Add default language and translation status
ALTER TABLE testimonials ADD COLUMN default_language VARCHAR(2) DEFAULT 'en';
ALTER TABLE testimonials ADD COLUMN translation_status JSONB DEFAULT '{"en": "complete", "es": "pending", "ca": "pending"}'::jsonb;

-- Add indexes for performance
CREATE INDEX IF NOT EXISTS idx_testimonials_text_en ON testimonials USING GIN (to_tsvector('english', testimonial_text_en));
CREATE INDEX IF NOT EXISTS idx_testimonials_text_es ON testimonials USING GIN (to_tsvector('spanish', testimonial_text_es));

-- Update existing data: migrate current content to English columns
UPDATE testimonials SET 
    testimonial_text_en = COALESCE(testimonial_text, ''),
    client_role_en = COALESCE(client_role, ''),
    client_company_en = COALESCE(client_company, '')
WHERE testimonial_text_en IS NULL OR testimonial_text_en = '';

-- Add comments
COMMENT ON COLUMN testimonials.testimonial_text_en IS 'Testimonial text in English';
COMMENT ON COLUMN testimonials.testimonial_text_es IS 'Testimonial text in Spanish';
COMMENT ON COLUMN testimonials.testimonial_text_ca IS 'Testimonial text in Catalan';
COMMENT ON COLUMN testimonials.client_role_en IS 'Client role in English';
COMMENT ON COLUMN testimonials.client_role_es IS 'Client role in Spanish';
COMMENT ON COLUMN testimonials.client_role_ca IS 'Client role in Catalan';
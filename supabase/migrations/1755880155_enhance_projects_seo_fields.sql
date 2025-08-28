-- Migration: enhance_projects_seo_fields
-- Created at: 1755880155

-- Add additional SEO fields to projects table
ALTER TABLE projects 
ADD COLUMN IF NOT EXISTS meta_title TEXT,
ADD COLUMN IF NOT EXISTS meta_description TEXT,
ADD COLUMN IF NOT EXISTS og_image_url TEXT,
ADD COLUMN IF NOT EXISTS og_title TEXT,
ADD COLUMN IF NOT EXISTS og_description TEXT,
ADD COLUMN IF NOT EXISTS twitter_card TEXT DEFAULT 'summary_large_image',
ADD COLUMN IF NOT EXISTS canonical_url TEXT,
ADD COLUMN IF NOT EXISTS focus_keyword TEXT,
ADD COLUMN IF NOT EXISTS schema_type TEXT DEFAULT 'CreativeWork',
ADD COLUMN IF NOT EXISTS seo_score INTEGER DEFAULT 0;;
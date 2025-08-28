-- Migration: create_seo_audit_table
-- Created at: 1755880167

-- Create SEO audit table for tracking optimization scores and suggestions
CREATE TABLE IF NOT EXISTS seo_audit (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    page_type TEXT NOT NULL, -- 'page', 'project'
    page_id TEXT, -- page_path for pages, project_id for projects
    audit_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    overall_score INTEGER DEFAULT 0,
    title_score INTEGER DEFAULT 0,
    description_score INTEGER DEFAULT 0,
    keywords_score INTEGER DEFAULT 0,
    images_score INTEGER DEFAULT 0,
    content_score INTEGER DEFAULT 0,
    technical_score INTEGER DEFAULT 0,
    suggestions JSON,
    issues JSON,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for performance
CREATE INDEX IF NOT EXISTS idx_seo_audit_page ON seo_audit(page_type, page_id);
CREATE INDEX IF NOT EXISTS idx_seo_audit_date ON seo_audit(audit_date DESC);;
-- Migration: create_global_seo_settings_table
-- Created at: 1755880143

-- Create global SEO settings table for site-wide configuration
CREATE TABLE IF NOT EXISTS global_seo_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    setting_key TEXT UNIQUE NOT NULL,
    setting_value TEXT,
    setting_type TEXT DEFAULT 'text', -- text, json, array, boolean
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert default global SEO settings
INSERT INTO global_seo_settings (setting_key, setting_value, setting_type, description) VALUES
('site_title', 'TONI RIERA', 'text', 'Default site title'),
('site_description', 'Creative retoucher specialized in advanced AI-driven image and video creation', 'text', 'Default site description'),
('site_keywords', '["AI image generation", "creative retouching", "visual composition", "graphic design", "AI-driven creation"]', 'json', 'Default site keywords'),
('default_og_image', '', 'text', 'Default Open Graph image URL'),
('site_author', 'Toni Riera', 'text', 'Site author name'),
('site_url', 'https://toniriera.com', 'text', 'Primary site URL'),
('twitter_handle', '@toniriera', 'text', 'Twitter handle for site'),
('facebook_app_id', '', 'text', 'Facebook App ID for Open Graph'),
('google_analytics_id', '', 'text', 'Google Analytics tracking ID'),
('google_search_console', '', 'text', 'Google Search Console verification'),
('robots_txt_rules', 'User-agent: *\nDisallow: /admin\nAllow: /', 'text', 'Robots.txt rules'),
('sitemap_enabled', 'true', 'boolean', 'Enable automatic sitemap generation'),
('schema_org_enabled', 'true', 'boolean', 'Enable Schema.org structured data')
ON CONFLICT (setting_key) DO NOTHING;;
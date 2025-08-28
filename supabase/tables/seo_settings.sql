CREATE TABLE seo_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    page_path TEXT UNIQUE NOT NULL,
    title TEXT,
    description TEXT,
    keywords TEXT[],
    og_image_url TEXT,
    og_title TEXT,
    og_description TEXT,
    twitter_card TEXT DEFAULT 'summary_large_image',
    canonical_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
-- Migration: fix_project_images_foreign_key
-- Created at: 1755675952

-- First drop the existing table structure if it exists
DROP TABLE IF EXISTS project_images;

-- Recreate the project_images table with proper foreign key constraint
CREATE TABLE project_images (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    alt_text TEXT,
    caption TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);;
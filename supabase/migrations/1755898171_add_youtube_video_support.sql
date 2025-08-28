-- Migration: add_youtube_video_support
-- Created at: 1755898171

-- Add YouTube video support to projects table
ALTER TABLE projects ADD COLUMN youtube_url TEXT;
ALTER TABLE projects ADD COLUMN youtube_video_id TEXT;
ALTER TABLE projects ADD COLUMN youtube_thumbnail_url TEXT;

-- Add comments for documentation
COMMENT ON COLUMN projects.youtube_url IS 'Full YouTube URL for the project video (optional)';
COMMENT ON COLUMN projects.youtube_video_id IS 'Extracted YouTube video ID for embed usage';
COMMENT ON COLUMN projects.youtube_thumbnail_url IS 'Auto-generated YouTube thumbnail URL';;
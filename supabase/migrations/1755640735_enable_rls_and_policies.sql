-- Migration: enable_rls_and_policies
-- Created at: 1755640735

-- Enable RLS on all tables
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE project_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE hero_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_blocks ENABLE ROW LEVEL SECURITY;
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
ALTER TABLE seo_settings ENABLE ROW LEVEL SECURITY;

-- Public read access policies
CREATE POLICY "Public can view published projects" ON projects
  FOR SELECT USING (status = 'published');

CREATE POLICY "Public can view project images" ON project_images
  FOR SELECT USING (EXISTS (
    SELECT 1 FROM projects WHERE projects.id = project_images.project_id AND projects.status = 'published'
  ));

CREATE POLICY "Public can view active hero images" ON hero_images
  FOR SELECT USING (is_active = true);

CREATE POLICY "Public can view content blocks" ON content_blocks
  FOR SELECT USING (true);

CREATE POLICY "Public can view active testimonials" ON testimonials
  FOR SELECT USING (is_active = true);

CREATE POLICY "Public can view SEO settings" ON seo_settings
  FOR SELECT USING (true);

-- Admin access policies (authenticated users have full access)
CREATE POLICY "Authenticated users have full access to projects" ON projects
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users have full access to project_images" ON project_images
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users have full access to hero_images" ON hero_images
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users have full access to content_blocks" ON content_blocks
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users have full access to testimonials" ON testimonials
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users have full access to seo_settings" ON seo_settings
  FOR ALL USING (auth.role() = 'authenticated');;
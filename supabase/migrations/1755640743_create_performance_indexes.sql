-- Migration: create_performance_indexes
-- Created at: 1755640743

-- Projects indexes
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_featured ON projects(is_featured);
CREATE INDEX idx_projects_sort_order ON projects(sort_order);
CREATE INDEX idx_projects_slug ON projects(slug);

-- Project images indexes
CREATE INDEX idx_project_images_project_id ON project_images(project_id);
CREATE INDEX idx_project_images_sort_order ON project_images(sort_order);

-- Hero images indexes
CREATE INDEX idx_hero_images_active ON hero_images(is_active);
CREATE INDEX idx_hero_images_sort_order ON hero_images(sort_order);

-- Testimonials indexes
CREATE INDEX idx_testimonials_active ON testimonials(is_active);
CREATE INDEX idx_testimonials_sort_order ON testimonials(sort_order);

-- SEO settings indexes
CREATE INDEX idx_seo_settings_page_path ON seo_settings(page_path);;
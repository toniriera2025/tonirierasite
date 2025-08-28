-- Migration: enable_rls_uploaded_images
-- Created at: 1755856511

-- Enable RLS on uploaded_images table
ALTER TABLE uploaded_images ENABLE ROW LEVEL SECURITY;

-- Policy to allow authenticated users to view all images
CREATE POLICY "Allow authenticated users to view images" ON uploaded_images
    FOR SELECT USING (auth.role() = 'authenticated');

-- Policy to allow authenticated users to insert images
CREATE POLICY "Allow authenticated users to upload images" ON uploaded_images
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Policy to allow authenticated users to update their own images
CREATE POLICY "Allow authenticated users to update images" ON uploaded_images
    FOR UPDATE USING (auth.role() = 'authenticated');

-- Policy to allow authenticated users to delete images
CREATE POLICY "Allow authenticated users to delete images" ON uploaded_images
    FOR DELETE USING (auth.role() = 'authenticated');

-- Enable RLS on upload_service_status table
ALTER TABLE upload_service_status ENABLE ROW LEVEL SECURITY;

-- Policy to allow authenticated users to read service status
CREATE POLICY "Allow authenticated users to view service status" ON upload_service_status
    FOR SELECT USING (auth.role() = 'authenticated');

-- Policy to allow authenticated users to update service status
CREATE POLICY "Allow authenticated users to update service status" ON upload_service_status
    FOR ALL USING (auth.role() = 'authenticated');;
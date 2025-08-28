-- Migration: initialize_project_sort_orders
-- Created at: 1755900163

-- Initialize sort_order values for existing projects
-- This ensures all projects have sequential sort_order values based on creation date

UPDATE projects
SET sort_order = subquery.row_number - 1
FROM (
    SELECT 
        id,
        ROW_NUMBER() OVER (ORDER BY created_at ASC) as row_number
    FROM projects
    WHERE sort_order IS NULL OR sort_order = 0
) AS subquery
WHERE projects.id = subquery.id;

-- Add index for better performance on sort_order queries
CREATE INDEX IF NOT EXISTS idx_projects_sort_order ON projects (sort_order);

-- Add comment for documentation
COMMENT ON COLUMN projects.sort_order IS 'Order for displaying projects (0-based index)';;
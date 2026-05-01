-- Add image column to announcements table
ALTER TABLE announcements
ADD COLUMN image_path VARCHAR(255) NULL COMMENT 'Path to announcement image' AFTER content;

-- Create uploads directory structure (to be created manually)
-- Create folder: system/uploads/announcements/

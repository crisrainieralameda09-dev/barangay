-- Add id_image column if it doesn't exist
ALTER TABLE users ADD COLUMN IF NOT EXISTS id_image VARCHAR(255) NULL DEFAULT NULL;

-- Add id_image_hash column if it doesn't exist
ALTER TABLE users ADD COLUMN IF NOT EXISTS id_image_hash VARCHAR(64) NULL DEFAULT NULL;

-- Index for fast duplicate check
ALTER TABLE users ADD INDEX IF NOT EXISTS idx_id_image_hash (id_image_hash);

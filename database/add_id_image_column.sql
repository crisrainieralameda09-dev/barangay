-- Add id_image column to users table for storing uploaded government ID
ALTER TABLE users ADD COLUMN IF NOT EXISTS id_image VARCHAR(255) DEFAULT NULL;

-- Add remember_token column to users table for "Remember Me" functionality
-- Run this SQL script to add the remember token functionality

-- Check and add remember_token column if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = DATABASE() 
AND table_name = 'users' 
AND column_name = 'remember_token';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE users ADD COLUMN remember_token VARCHAR(64) NULL DEFAULT NULL', 
    'SELECT "Column remember_token already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Check and add remember_token_expires column if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = DATABASE() 
AND table_name = 'users' 
AND column_name = 'remember_token_expires';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE users ADD COLUMN remember_token_expires DATETIME NULL DEFAULT NULL', 
    'SELECT "Column remember_token_expires already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add indexes if they don't exist (MySQL will ignore if they already exist)
CREATE INDEX IF NOT EXISTS idx_remember_token ON users(remember_token);
CREATE INDEX IF NOT EXISTS idx_remember_token_expires ON users(remember_token_expires);

-- Update existing users to have NULL remember_token (safe to run multiple times)
UPDATE users SET remember_token = NULL, remember_token_expires = NULL 
WHERE remember_token IS NOT NULL OR remember_token_expires IS NOT NULL;
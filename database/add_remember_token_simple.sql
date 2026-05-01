-- Simple version: Add remember_token columns for "Remember Me" functionality
-- This version handles existing columns gracefully

-- Add remember_token column (ignore error if exists)
ALTER TABLE users ADD COLUMN remember_token VARCHAR(64) NULL DEFAULT NULL;

-- Add remember_token_expires column (ignore error if exists)  
ALTER TABLE users ADD COLUMN remember_token_expires DATETIME NULL DEFAULT NULL;

-- Add indexes (ignore error if exists)
ALTER TABLE users ADD INDEX idx_remember_token (remember_token);
ALTER TABLE users ADD INDEX idx_remember_token_expires (remember_token_expires);

-- Clean up any existing tokens
UPDATE users SET remember_token = NULL, remember_token_expires = NULL;
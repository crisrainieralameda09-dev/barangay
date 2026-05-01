-- --------------------------------------------------------
-- Update census table to allow public submissions
-- Run this script to update the existing census table
-- --------------------------------------------------------

USE buegas_db;

-- Step 1: Drop the unique constraint on citizen_id
ALTER TABLE census DROP INDEX IF EXISTS unique_citizen_census;

-- Step 2: Modify citizen_id to allow NULL values
ALTER TABLE census MODIFY COLUMN citizen_id INT NULL;

-- Step 3: Add index on citizen_id if not exists
ALTER TABLE census ADD INDEX IF NOT EXISTS idx_citizen_id (citizen_id);

-- Verification query (optional - run separately to check)
-- SHOW CREATE TABLE census;

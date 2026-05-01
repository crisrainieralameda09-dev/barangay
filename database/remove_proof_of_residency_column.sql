-- Remove proof_of_residency column from document_requests table
-- This migration removes the proof of residency requirement from document requests

-- Check if column exists before dropping it
SET @column_exists = (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'document_requests'
    AND COLUMN_NAME = 'proof_of_residency'
);

-- Drop the column if it exists
SET @sql = IF(@column_exists > 0, 
    'ALTER TABLE document_requests DROP COLUMN proof_of_residency', 
    'SELECT "Column proof_of_residency does not exist" as message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Display completion message
SELECT 'Proof of residency column removal completed' as status;
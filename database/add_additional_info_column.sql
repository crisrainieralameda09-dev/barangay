-- Add additional_info column to document_requests table
-- This column stores JSON data with requester details and document-specific information

ALTER TABLE `document_requests` 
ADD COLUMN `additional_info` TEXT NULL AFTER `remarks`;

-- Update existing records to have empty JSON object
UPDATE `document_requests` 
SET `additional_info` = '{}' 
WHERE `additional_info` IS NULL;

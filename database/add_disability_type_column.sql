-- Add disability_type column to citizens table
-- This allows storing the type of disability for PWD citizens

ALTER TABLE `citizens` 
ADD COLUMN `disability_type` VARCHAR(100) DEFAULT NULL AFTER `pwd_id`;

-- Update comment
ALTER TABLE `citizens` 
MODIFY COLUMN `disability_type` VARCHAR(100) DEFAULT NULL COMMENT 'Type of disability for PWD citizens';

-- Add senior_id column to citizens table
ALTER TABLE `citizens`
    ADD COLUMN `senior_id` VARCHAR(50) DEFAULT NULL AFTER `is_senior`;

-- Add PWD and pregnancy detail columns to household_members
ALTER TABLE `household_members`
  ADD COLUMN IF NOT EXISTS `pwd_id_number`   VARCHAR(50)  DEFAULT NULL AFTER `is_pwd`,
  ADD COLUMN IF NOT EXISTS `disability_type` VARCHAR(100) DEFAULT NULL AFTER `pwd_id_number`,
  ADD COLUMN IF NOT EXISTS `expected_due_date` DATE        DEFAULT NULL AFTER `is_pregnant`;

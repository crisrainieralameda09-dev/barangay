-- Allow pregnancy_validations to reference household members (not just citizens)
ALTER TABLE `pregnancy_validations`
  ADD COLUMN IF NOT EXISTS `household_member_id` INT(11) DEFAULT NULL 
    COMMENT 'Set when request comes from a household member instead of a registered citizen'
    AFTER `citizen_id`,
  MODIFY COLUMN `citizen_id` INT(11) DEFAULT NULL COMMENT 'NULL when request is from a household member';

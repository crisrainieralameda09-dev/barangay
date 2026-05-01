-- Allow pwd_verification_requests to reference household members
ALTER TABLE `pwd_verification_requests`
  ADD COLUMN IF NOT EXISTS `household_member_id` INT(11) DEFAULT NULL
    COMMENT 'Set when request comes from a household member'
    AFTER `citizen_id`,
  MODIFY COLUMN `user_id` INT(11) DEFAULT NULL COMMENT 'NULL when request is from a household member';

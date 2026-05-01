-- Allow document_requests to reference household members
ALTER TABLE `document_requests`
  ADD COLUMN IF NOT EXISTS `household_member_id` INT(11) DEFAULT NULL
    COMMENT 'Set when request comes from a household member'
    AFTER `citizen_id`;

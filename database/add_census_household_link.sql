-- Link census records to household_members for auto-sync
ALTER TABLE `census`
  ADD COLUMN IF NOT EXISTS `household_member_id` INT(11) DEFAULT NULL COMMENT 'Links to household_members.id if auto-created from family',
  ADD COLUMN IF NOT EXISTS `source` ENUM('citizen','household','public') NOT NULL DEFAULT 'citizen' COMMENT 'Where this census record came from',
  ADD KEY IF NOT EXISTS `idx_household_member_id` (`household_member_id`);

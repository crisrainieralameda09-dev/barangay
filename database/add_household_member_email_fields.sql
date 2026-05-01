-- Add email verification columns to household_members table
ALTER TABLE `household_members` 
  ADD COLUMN IF NOT EXISTS `personal_email` VARCHAR(100) DEFAULT NULL COMMENT 'Personal email for family member' AFTER `relationship`,
  ADD COLUMN IF NOT EXISTS `email_verified` TINYINT(1) DEFAULT 0 COMMENT 'Whether personal email is verified' AFTER `personal_email`,
  ADD COLUMN IF NOT EXISTS `pending_email` VARCHAR(100) DEFAULT NULL COMMENT 'Pending email change' AFTER `email_verified`,
  ADD COLUMN IF NOT EXISTS `email_otp` VARCHAR(255) DEFAULT NULL COMMENT 'Email verification OTP hash' AFTER `pending_email`,
  ADD COLUMN IF NOT EXISTS `email_otp_expires` DATETIME DEFAULT NULL COMMENT 'When email OTP expires' AFTER `email_otp`,
  ADD COLUMN IF NOT EXISTS `contact_number` VARCHAR(20) DEFAULT NULL COMMENT 'Personal contact number' AFTER `email_otp_expires`;

-- Add indexes for email columns
ALTER TABLE `household_members`
  ADD INDEX IF NOT EXISTS `idx_personal_email` (`personal_email`),
  ADD INDEX IF NOT EXISTS `idx_pending_email` (`pending_email`),
  ADD INDEX IF NOT EXISTS `idx_email_otp_expires` (`email_otp_expires`);

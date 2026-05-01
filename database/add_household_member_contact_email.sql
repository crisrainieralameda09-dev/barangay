-- Add personal contact number, email, and OTP fields to household_members
ALTER TABLE `household_members`
  ADD COLUMN IF NOT EXISTS `contact_number`      VARCHAR(20)  DEFAULT NULL AFTER `relationship`,
  ADD COLUMN IF NOT EXISTS `personal_email`      VARCHAR(100) DEFAULT NULL COMMENT 'Member own email (optional)' AFTER `contact_number`,
  ADD COLUMN IF NOT EXISTS `email_verified`      TINYINT(1)   DEFAULT 0 AFTER `personal_email`,
  ADD COLUMN IF NOT EXISTS `pending_email`       VARCHAR(100) DEFAULT NULL AFTER `email_verified`,
  ADD COLUMN IF NOT EXISTS `email_otp`           VARCHAR(255) DEFAULT NULL AFTER `pending_email`,
  ADD COLUMN IF NOT EXISTS `email_otp_expires`   DATETIME     DEFAULT NULL AFTER `email_otp`;

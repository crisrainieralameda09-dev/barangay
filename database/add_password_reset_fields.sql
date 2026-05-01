-- Add password reset fields to users table
ALTER TABLE `users` 
ADD COLUMN `reset_token` VARCHAR(255) NULL AFTER `password_hash`,
ADD COLUMN `reset_token_expiry` DATETIME NULL AFTER `reset_token`,
ADD COLUMN `failed_login_attempts` INT DEFAULT 0 AFTER `reset_token_expiry`,
ADD COLUMN `account_locked_until` DATETIME NULL AFTER `failed_login_attempts`,
ADD COLUMN `remember_token` VARCHAR(255) NULL AFTER `account_locked_until`;

-- Add index for faster token lookups
ALTER TABLE `users` ADD INDEX `idx_reset_token` (`reset_token`);
ALTER TABLE `users` ADD INDEX `idx_remember_token` (`remember_token`);

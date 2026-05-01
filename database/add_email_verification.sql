-- Add email verification fields to users table

ALTER TABLE users 
ADD COLUMN email_verified TINYINT(1) DEFAULT 0 AFTER status,
ADD COLUMN verification_code VARCHAR(6) NULL AFTER email_verified,
ADD COLUMN verification_code_expires DATETIME NULL AFTER verification_code;

-- Add index for verification code lookup
ALTER TABLE users ADD INDEX idx_verification_code (verification_code);

-- Update existing users to be verified (optional - for existing accounts)
-- UPDATE users SET email_verified = 1 WHERE created_at < NOW();

-- PWD Verification Requests Table
-- Run this in phpMyAdmin on buegas_db

CREATE TABLE IF NOT EXISTS `pwd_verification_requests` (
  `request_id`     INT(11) NOT NULL AUTO_INCREMENT,
  `user_id`        INT(11) NOT NULL,
  `citizen_id`     INT(11) DEFAULT NULL,
  `pwd_id_number`  VARCHAR(100) NOT NULL,
  `disability_type` VARCHAR(100) NOT NULL,
  `disability_details` TEXT DEFAULT NULL,
  `pwd_id_image`   VARCHAR(255) DEFAULT NULL,
  `status`         ENUM('pending','approved','rejected','expired') NOT NULL DEFAULT 'pending',
  `admin_notes`    TEXT DEFAULT NULL,
  `expires_at`     DATETIME NOT NULL,           -- auto-reject deadline (7 days from submission)
  `created_at`     DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`     DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`request_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

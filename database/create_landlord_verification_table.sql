-- Landlord Verification Table
-- For citizens who want to rent out rooms/spaces as a boarder landlord

CREATE TABLE IF NOT EXISTS `landlord_verification` (
  `id`                    INT(11)      NOT NULL AUTO_INCREMENT,
  `user_id`               INT(11)      NOT NULL COMMENT 'The citizen requesting landlord verification',
  `house_number`          VARCHAR(50)  NOT NULL COMMENT 'The house number where boarders will stay',
  `property_details`      TEXT         DEFAULT NULL COMMENT 'Building type, number of rooms, etc.',
  `property_image`        VARCHAR(255) DEFAULT NULL COMMENT 'Photo evidence of the property',
  `verification_status`   ENUM('pending','verified','rejected','expired') NOT NULL DEFAULT 'pending',
  `verification_date`     DATETIME     DEFAULT NULL COMMENT 'Date when verified',
  `verified_by_admin_id`  INT(11)      DEFAULT NULL COMMENT 'Admin who verified the landlord',
  `admin_notes`           TEXT         DEFAULT NULL COMMENT 'Remarks from admin',
  `is_active`             TINYINT(1)   DEFAULT 1 COMMENT 'Can add boarders only if active',
  `expires_at`            DATETIME     DEFAULT NULL COMMENT 'Auto-reject deadline (30 days from submission)',
  `created_at`            DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`            DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_house_number` (`house_number`),
  KEY `idx_verification_status` (`verification_status`),
  KEY `idx_expires_at` (`expires_at`),
  CONSTRAINT `lv_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lv_ibfk_2` FOREIGN KEY (`verified_by_admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add boarders table to track people renting/staying in rooms
CREATE TABLE IF NOT EXISTS `boarders` (
  `id`                    INT(11)      NOT NULL AUTO_INCREMENT,
  `landlord_user_id`      INT(11)      NOT NULL COMMENT 'The verified landlord (citizen)',
  `house_number`          VARCHAR(50)  NOT NULL COMMENT 'Property house number',
  `first_name`            VARCHAR(50)  NOT NULL,
  `middle_name`           VARCHAR(100) DEFAULT NULL,
  `last_name`             VARCHAR(50)  NOT NULL,
  `birthdate`             DATE         NOT NULL,
  `gender`                ENUM('Male','Female','Other') NOT NULL,
  `civil_status`          ENUM('Single','Married','Divorced','Widowed') NOT NULL DEFAULT 'Single',
  `contact_number`        VARCHAR(20)  DEFAULT NULL,
  `email`                 VARCHAR(100) DEFAULT NULL,
  `room_number`           VARCHAR(50)  DEFAULT NULL COMMENT 'Room/unit number',
  `monthly_rent`          DECIMAL(10,2) DEFAULT NULL,
  `check_in_date`         DATE         NOT NULL,
  `check_out_date`        DATE         DEFAULT NULL COMMENT 'NULL if still staying',
  `status`                ENUM('active','inactive','finished') NOT NULL DEFAULT 'active',
  `is_active`             TINYINT(1)   DEFAULT 1,
  `created_at`            DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`            DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`            DATETIME     DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_landlord_user_id` (`landlord_user_id`),
  KEY `idx_house_number` (`house_number`),
  KEY `idx_status` (`status`),
  CONSTRAINT `bd_ibfk_1` FOREIGN KEY (`landlord_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

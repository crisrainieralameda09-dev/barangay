-- Add house_number to citizens table
ALTER TABLE `citizens`
  ADD COLUMN IF NOT EXISTS `house_number` VARCHAR(50) DEFAULT NULL COMMENT 'House/lot number for household grouping'
  AFTER `address`;

-- Household members table (family members under a registered citizen)
CREATE TABLE IF NOT EXISTS `household_members` (
  `id`            INT(11)      NOT NULL AUTO_INCREMENT,
  `head_user_id`  INT(11)      NOT NULL COMMENT 'The registered citizen who owns this household',
  `house_number`  VARCHAR(50)  NOT NULL COMMENT 'Shared house number',
  `first_name`    VARCHAR(50)  NOT NULL,
  `middle_name`   VARCHAR(100) DEFAULT NULL,
  `last_name`     VARCHAR(50)  NOT NULL,
  `birthdate`     DATE         NOT NULL,
  `gender`        ENUM('Male','Female','Other') NOT NULL,
  `civil_status`  ENUM('Single','Married','Divorced','Widowed') NOT NULL DEFAULT 'Single',
  `relationship`  VARCHAR(50)  NOT NULL COMMENT 'e.g. Spouse, Son, Daughter, Parent, Sibling',
  `password_hash` VARCHAR(255) DEFAULT NULL COMMENT 'Own login password for this family member',
  `is_active`     TINYINT(1)   DEFAULT 1,
  `is_senior`     TINYINT(1)   DEFAULT 0,
  `is_pwd`        TINYINT(1)   DEFAULT 0,
  `is_pregnant`   TINYINT(1)   DEFAULT 0,
  `created_at`    DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`    DATETIME     DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_head_user` (`head_user_id`),
  KEY `idx_house_number` (`house_number`),
  CONSTRAINT `hm_ibfk_1` FOREIGN KEY (`head_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

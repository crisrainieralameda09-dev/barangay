-- First Time Job Seeker (FTJS) Module Tables

-- Job seeker profiles
CREATE TABLE IF NOT EXISTS `ftjs_profiles` (
  `id`                INT(11) NOT NULL AUTO_INCREMENT,
  `user_id`           INT(11) NOT NULL,
  `highest_education` ENUM('Elementary','High School','Senior High School','Vocational/Technical','College','Post-Graduate') NOT NULL,
  `school_name`       VARCHAR(200) DEFAULT NULL,
  `year_graduated`    YEAR DEFAULT NULL,
  `course`            VARCHAR(200) DEFAULT NULL,
  `skills`            TEXT DEFAULT NULL COMMENT 'Comma-separated skills',
  `work_experience`   TEXT DEFAULT NULL COMMENT 'JSON array of work history',
  `resume_path`       VARCHAR(255) DEFAULT NULL,
  `cert_path`         VARCHAR(255) DEFAULT NULL COMMENT 'Uploaded certificates/diplomas',
  `status`            ENUM('draft','submitted','verified') DEFAULT 'draft',
  `created_at`        DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`        DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`user_id`),
  CONSTRAINT `ftjs_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- FTJS certificate requests
CREATE TABLE IF NOT EXISTS `ftjs_certificates` (
  `id`               INT(11) NOT NULL AUTO_INCREMENT,
  `reference_number` VARCHAR(30) NOT NULL UNIQUE,
  `user_id`          INT(11) NOT NULL,
  `profile_id`       INT(11) NOT NULL,
  `status`           ENUM('pending','approved','rejected','issued') DEFAULT 'pending',
  `admin_notes`      TEXT DEFAULT NULL,
  `issued_by`        INT(11) DEFAULT NULL,
  `issued_at`        DATETIME DEFAULT NULL,
  `requested_at`     DATETIME DEFAULT CURRENT_TIMESTAMP,
  `created_at`       DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `ftjs_cert_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ftjs_cert_ibfk_2` FOREIGN KEY (`profile_id`) REFERENCES `ftjs_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Job listings posted by admin
CREATE TABLE IF NOT EXISTS `ftjs_jobs` (
  `id`               INT(11) NOT NULL AUTO_INCREMENT,
  `title`            VARCHAR(200) NOT NULL,
  `company`          VARCHAR(200) DEFAULT NULL,
  `job_type`         ENUM('Full-time','Part-time','Contractual','Internship','Freelance','Government') NOT NULL DEFAULT 'Full-time',
  `category`         VARCHAR(100) DEFAULT NULL,
  `description`      TEXT NOT NULL,
  `requirements`     TEXT DEFAULT NULL,
  `salary_range`     VARCHAR(100) DEFAULT NULL,
  `location`         VARCHAR(200) DEFAULT NULL,
  `deadline`         DATE DEFAULT NULL,
  `slots`            INT(11) DEFAULT NULL,
  `status`           ENUM('active','archived') DEFAULT 'active',
  `posted_by`        INT(11) NOT NULL,
  `created_at`       DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`       DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_deadline` (`deadline`),
  CONSTRAINT `ftjs_jobs_ibfk_1` FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

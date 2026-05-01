-- ============================================================
-- BARANGAY BUEGAS MANAGEMENT SYSTEM
-- COMPLETE DATABASE SCHEMA (Consolidated)
-- Database: buegas_db | Engine: InnoDB | Charset: utf8mb4
-- ============================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS `buegas_db`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `buegas_db`;

-- ============================================================
-- TABLE: users
-- All system users: admin, healthworker, citizen
-- ============================================================
CREATE TABLE IF NOT EXISTS `users` (
  `id`                        INT(11)       NOT NULL AUTO_INCREMENT,
  `email`                     VARCHAR(100)  NOT NULL,
  `password_hash`             VARCHAR(255)  NOT NULL,
  `reset_token`               VARCHAR(255)  DEFAULT NULL,
  `reset_token_expiry`        DATETIME      DEFAULT NULL,
  `failed_login_attempts`     INT           DEFAULT 0,
  `account_locked_until`      DATETIME      DEFAULT NULL,
  `remember_token`            VARCHAR(255)  DEFAULT NULL,
  `remember_token_expires`    DATETIME      DEFAULT NULL,
  `role`                      ENUM('admin','healthworker','citizen') NOT NULL,
  `first_name`                VARCHAR(50)   NOT NULL,
  `middle_name`               VARCHAR(100)  DEFAULT NULL,
  `last_name`                 VARCHAR(50)   NOT NULL,
  `contact_number`            VARCHAR(20)   DEFAULT NULL,
  `profile_picture`           VARCHAR(255)  DEFAULT NULL,
  `id_image`                  VARCHAR(255)  DEFAULT NULL,
  `id_image_hash`             VARCHAR(64)   DEFAULT NULL,
  `status`                    ENUM('active','inactive') DEFAULT 'active',
  `email_verified`            TINYINT(1)    DEFAULT 0,
  `verification_code`         VARCHAR(6)    DEFAULT NULL,
  `verification_code_expires` DATETIME      DEFAULT NULL,
  `created_at`                DATETIME      DEFAULT CURRENT_TIMESTAMP,
  `updated_at`                DATETIME      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`                DATETIME      DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_role`                (`role`),
  KEY `idx_status`              (`status`),
  KEY `idx_verification_code`   (`verification_code`),
  KEY `idx_reset_token`         (`reset_token`),
  KEY `idx_remember_token`      (`remember_token`),
  KEY `idx_id_image_hash`       (`id_image_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: citizens
-- Citizen-specific profile (1-to-1 with users where role='citizen')
-- ============================================================
CREATE TABLE IF NOT EXISTS `citizens` (
  `citizen_id`    INT(11)  NOT NULL AUTO_INCREMENT,
  `user_id`       INT(11)  NOT NULL,
  `birthdate`     DATE     NOT NULL,
  `gender`        ENUM('Male','Female','Other') NOT NULL,
  `address`       TEXT     NOT NULL,
  `civil_status`  ENUM('Single','Married','Divorced','Widowed') NOT NULL,
  `is_senior`     TINYINT(1) DEFAULT 0,
  `is_pregnant`   TINYINT(1) DEFAULT 0,
  `is_pwd`        TINYINT(1) DEFAULT 0,
  `pwd_id`        VARCHAR(50)  DEFAULT NULL,
  `disability_type` VARCHAR(100) DEFAULT NULL COMMENT 'Type of disability for PWD citizens',
  -- Pregnancy tracking
  `pregnancy_start_date`         DATE DEFAULT NULL COMMENT 'LMP date',
  `expected_due_date`            DATE DEFAULT NULL COMMENT 'Calculated 280 days from LMP',
  `expected_barangay_visit_date` DATE DEFAULT NULL,
  `pregnancy_notes`              TEXT DEFAULT NULL,
  `created_at`    DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`    DATETIME DEFAULT NULL,
  PRIMARY KEY (`citizen_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_senior`    (`is_senior`),
  KEY `idx_pregnant`  (`is_pregnant`),
  KEY `idx_pwd`       (`is_pwd`),
  KEY `idx_pregnancy_dates` (`pregnancy_start_date`, `expected_due_date`),
  CONSTRAINT `citizens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: health_profiles
-- Extended medical info per citizen (1-to-1 with citizens)
-- ============================================================
CREATE TABLE IF NOT EXISTS `health_profiles` (
  `profile_id`        INT(11) NOT NULL AUTO_INCREMENT,
  `citizen_id`        INT(11) NOT NULL,
  `blood_type`        ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `allergies`         TEXT DEFAULT NULL,
  `chronic_diseases`  TEXT DEFAULT NULL,
  `disability_details` TEXT DEFAULT NULL,
  `created_at`        DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`        DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`        DATETIME DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `unique_citizen_profile` (`citizen_id`),
  CONSTRAINT `health_profiles_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: census
-- Census records; supports both registered citizens and public submissions
-- ============================================================
CREATE TABLE IF NOT EXISTS `census` (
  `id`               INT(11)     NOT NULL AUTO_INCREMENT,
  `census_id`        VARCHAR(50) NOT NULL,
  `citizen_id`       INT(11)     DEFAULT NULL,  -- NULL for public/unregistered submissions
  `firstname`        VARCHAR(50) NOT NULL,
  `lastname`         VARCHAR(50) NOT NULL,
  `birthdate`        DATE        NOT NULL,
  `gender`           ENUM('Male','Female','Other') NOT NULL,
  `civil_status`     ENUM('Single','Married','Divorced','Widowed') NOT NULL,
  `contact`          VARCHAR(20) NOT NULL,
  `address`          TEXT        NOT NULL,
  `occupation`       VARCHAR(100) DEFAULT NULL,
  `monthly_income`   VARCHAR(50)  DEFAULT NULL,
  `education`        VARCHAR(50)  DEFAULT NULL,
  `household_members` INT(11)    DEFAULT 0,
  `is_senior`        TINYINT(1)  DEFAULT 0,
  `is_pwd`           TINYINT(1)  DEFAULT 0,
  `is_pregnant`      TINYINT(1)  DEFAULT 0,
  `is_4ps`           TINYINT(1)  DEFAULT 0,
  `created_at`       DATETIME    DEFAULT CURRENT_TIMESTAMP,
  `updated_at`       DATETIME    DEFAULT NULL,
  `deleted_at`       DATETIME    DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `census_id` (`census_id`),
  KEY `idx_census_id`  (`census_id`),
  KEY `idx_citizen_id` (`citizen_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `census_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: document_requests
-- Barangay certificate / clearance requests by citizens
-- ============================================================
CREATE TABLE IF NOT EXISTS `document_requests` (
  `request_id`       INT(11)  NOT NULL AUTO_INCREMENT,
  `citizen_id`       INT(11)  NOT NULL,
  `document_type`    ENUM('Barangay Clearance','Certificate of Residency','Indigency','Other') NOT NULL,
  `purpose`          TEXT     DEFAULT NULL,
  `purpose_type`     VARCHAR(100) DEFAULT NULL,
  `id_type`          VARCHAR(50)  DEFAULT NULL,
  `id_number`        VARCHAR(100) DEFAULT NULL,
  `cedula_number`    VARCHAR(50)  DEFAULT NULL,
  `additional_info`  TEXT         DEFAULT NULL,
  `processing_fee`   DECIMAL(10,2) DEFAULT 0.00,
  `reference_number` VARCHAR(50)  DEFAULT NULL,
  `status`           ENUM('pending','approved','rejected','completed') DEFAULT 'pending',
  `remarks`          TEXT         DEFAULT NULL,
  `request_date`     DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `processed_by`     INT(11)      DEFAULT NULL,
  `created_at`       DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`       DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`       DATETIME     DEFAULT NULL,
  PRIMARY KEY (`request_id`),
  KEY `citizen_id`              (`citizen_id`),
  KEY `processed_by`            (`processed_by`),
  KEY `idx_status`              (`status`),
  KEY `idx_request_date`        (`request_date`),
  KEY `idx_doc_reference_number` (`reference_number`),
  CONSTRAINT `document_requests_ibfk_1` FOREIGN KEY (`citizen_id`)   REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `document_requests_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users`    (`id`)         ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: summons_reports
-- Incident reports, complaints, and dispute resolution
-- Follows Philippine Barangay Justice System (Katarungang Pambarangay)
-- ============================================================
CREATE TABLE IF NOT EXISTS `summons_reports` (
  `report_id`            INT(11)      NOT NULL AUTO_INCREMENT,
  `reference_number`     VARCHAR(50)  DEFAULT NULL,
  `barangay_case_number` VARCHAR(50)  DEFAULT NULL,
  `criminal_case_number` VARCHAR(100) DEFAULT NULL,
  -- Complainant info
  `citizen_id`           INT(11)      NOT NULL,
  `complainant_name`     VARCHAR(255) DEFAULT NULL,
  `complainant_address`  TEXT         DEFAULT NULL,
  `complainant_contact`  VARCHAR(100) DEFAULT NULL,
  -- Respondent info
  `respondent_name`      VARCHAR(255) DEFAULT NULL,
  `respondent_address`   TEXT         DEFAULT NULL,
  `respondent_contact`   VARCHAR(100) DEFAULT NULL,
  -- Complaint details
  `report_type`          ENUM(
    'Summon','Mediation Request','Settlement Follow-up','Incident',
    'Noise Complaint','Property Dispute','Debt Collection','Physical Injury',
    'Oral Defamation','Threat','Trespassing','Damage to Property',
    'Harassment','Family Dispute','Neighbor Dispute','Business Dispute','Other Concern'
  ) NOT NULL,
  `complaint_type`        VARCHAR(255) DEFAULT NULL,
  `description`           TEXT         NOT NULL,
  `complaint_description` TEXT         DEFAULT NULL,
  `requested_relief`      TEXT         DEFAULT NULL,
  `incident_date`         DATE         NOT NULL,
  `date_made`             DATE         DEFAULT NULL,
  `date_filed`            DATE         DEFAULT NULL,
  `urgency`               ENUM('low','medium','high','critical') DEFAULT 'medium',
  -- Official / hearing info
  `barangay_official`    VARCHAR(255) DEFAULT 'ASAHEL P. GAYATIN',
  `official_position`    VARCHAR(100) DEFAULT 'Punong Barangay / Lupon Chairman',
  `lupon_members`        TEXT         DEFAULT NULL,
  `hearing_date`         DATETIME     DEFAULT NULL,
  `hearing_location`     VARCHAR(255) DEFAULT 'Barangay Hall',
  -- Settlement
  `settlement_amount`    DECIMAL(10,2) DEFAULT NULL,
  `settlement_terms`     TEXT          DEFAULT NULL,
  `case_notes`           TEXT          DEFAULT NULL,
  `processed_by`         INT(11)       DEFAULT NULL,
  -- Status
  `status`               ENUM(
    'new','for_mediation','summons_issued','mediation_scheduled','hearing_scheduled',
    'under_mediation','settled','no_settlement','certificate_issued',
    'investigating','resolved','dismissed','referred_to_court','closed'
  ) DEFAULT 'new',
  -- NLP analysis
  `nlp_confidence`       DECIMAL(3,2) DEFAULT NULL,
  `nlp_reasoning`        TEXT         DEFAULT NULL,
  `nlp_analysis_date`    DATETIME     DEFAULT NULL,
  `created_at`           DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`           DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`           DATETIME     DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `citizen_id`              (`citizen_id`),
  KEY `idx_status`              (`status`),
  KEY `idx_urgency`             (`urgency`),
  KEY `idx_reference_number`    (`reference_number`),
  KEY `idx_barangay_case_number` (`barangay_case_number`),
  KEY `idx_criminal_case_number` (`criminal_case_number`),
  KEY `idx_complainant_name`    (`complainant_name`),
  KEY `idx_hearing_date`        (`hearing_date`),
  KEY `idx_date_filed`          (`date_filed`),
  KEY `idx_nlp_confidence`      (`nlp_confidence`),
  KEY `idx_nlp_analysis_date`   (`nlp_analysis_date`),
  CONSTRAINT `summons_reports_ibfk_1`      FOREIGN KEY (`citizen_id`)   REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_summons_processed_by`     FOREIGN KEY (`processed_by`) REFERENCES `users`    (`id`)         ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: announcements
-- Public announcements posted by admin
-- ============================================================
CREATE TABLE IF NOT EXISTS `announcements` (
  `announcement_id` INT(11)      NOT NULL AUTO_INCREMENT,
  `title`           VARCHAR(200) NOT NULL,
  `content`         TEXT         NOT NULL,
  `posted_by`       INT(11)      NOT NULL,
  `target_audience` ENUM('all','citizens','healthworkers') DEFAULT 'all',
  `category`        ENUM('general','aid_distribution','calamity','health','event','urgent') DEFAULT 'general',
  `image_path`      VARCHAR(255) DEFAULT NULL,
  `posted_at`       DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `expires_at`      DATETIME     DEFAULT NULL,
  `created_at`      DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`      DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`      DATETIME     DEFAULT NULL,
  PRIMARY KEY (`announcement_id`),
  KEY `posted_by`      (`posted_by`),
  KEY `idx_audience`   (`target_audience`),
  KEY `idx_posted_at`  (`posted_at`),
  CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: appointments
-- Health appointments; supports admin-scheduled and citizen-requested
-- ============================================================
CREATE TABLE IF NOT EXISTS `appointments` (
  `appointment_id`   INT(11)      NOT NULL AUTO_INCREMENT,
  `citizen_id`       INT(11)      NOT NULL,
  `requested_by`     INT(11)      DEFAULT NULL,
  `healthworker_id`  INT(11)      DEFAULT NULL,
  `appointment_type` ENUM('check-up','vaccination','follow-up') NOT NULL,
  `scheduled_date`   DATETIME     NOT NULL,
  `status`           ENUM('pending','approved','scheduled','completed','cancelled','rejected') DEFAULT 'pending',
  `reminder_sent`    TINYINT(1)   DEFAULT 0,
  `notes`            TEXT         DEFAULT NULL,
  `contact_number`   VARCHAR(20)  DEFAULT NULL,
  `email`            VARCHAR(100) DEFAULT NULL,
  `id_type`          VARCHAR(50)  DEFAULT NULL,
  `id_number`        VARCHAR(100) DEFAULT NULL,
  `reference_number` VARCHAR(50)  DEFAULT NULL,
  `created_at`       DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`       DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`       DATETIME     DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `citizen_id`          (`citizen_id`),
  KEY `healthworker_id`     (`healthworker_id`),
  KEY `requested_by`        (`requested_by`),
  KEY `idx_scheduled_date`  (`scheduled_date`),
  KEY `idx_status`          (`status`),
  KEY `idx_reference_number` (`reference_number`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`citizen_id`)      REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`healthworker_id`) REFERENCES `users`    (`id`)         ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`requested_by`)    REFERENCES `users`    (`id`)         ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: aid_distribution
-- Tracks medicine, food, financial, or other aid given to citizens
-- ============================================================
CREATE TABLE IF NOT EXISTS `aid_distribution` (
  `distribution_id` INT(11)     NOT NULL AUTO_INCREMENT,
  `citizen_id`      INT(11)     NOT NULL,
  `aid_type`        ENUM('medicine','food','financial','other') NOT NULL,
  `quantity`        VARCHAR(50) DEFAULT NULL,
  `date_distributed` DATE       NOT NULL,
  `distributed_by`  INT(11)     NOT NULL,
  `notes`           TEXT        DEFAULT NULL,
  `created_at`      DATETIME    DEFAULT CURRENT_TIMESTAMP,
  `updated_at`      DATETIME    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`      DATETIME    DEFAULT NULL,
  PRIMARY KEY (`distribution_id`),
  KEY `citizen_id`           (`citizen_id`),
  KEY `distributed_by`       (`distributed_by`),
  KEY `idx_date_distributed` (`date_distributed`),
  CONSTRAINT `aid_distribution_ibfk_1` FOREIGN KEY (`citizen_id`)    REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `aid_distribution_ibfk_2` FOREIGN KEY (`distributed_by`) REFERENCES `users`   (`id`)         ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: notifications
-- In-app notifications for all user roles
-- ============================================================
CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` INT(11)      NOT NULL AUTO_INCREMENT,
  `user_id`         INT(11)      NOT NULL,
  `type`            VARCHAR(50)  NOT NULL,
  `message`         TEXT         NOT NULL,
  `is_read`         TINYINT(1)   DEFAULT 0,
  `link`            VARCHAR(255) DEFAULT NULL,
  `created_at`      DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `idx_user_read` (`user_id`, `is_read`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: reports
-- Generated report files (PDFs / data snapshots)
-- ============================================================
CREATE TABLE IF NOT EXISTS `reports` (
  `report_id`    INT(11)      NOT NULL AUTO_INCREMENT,
  `report_type`  VARCHAR(100) NOT NULL,
  `generated_by` INT(11)      NOT NULL,
  `file_path`    VARCHAR(255) NOT NULL,
  `parameters`   LONGTEXT     CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
                 CHECK (json_valid(`parameters`)),
  `generated_at` DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`),
  KEY `generated_by`      (`generated_by`),
  KEY `idx_type`          (`report_type`),
  KEY `idx_generated_at`  (`generated_at`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: barangay_officials
-- Elected and appointed barangay officials displayed on the landing page
-- ============================================================
CREATE TABLE IF NOT EXISTS `barangay_officials` (
  `id`            INT(11)      NOT NULL AUTO_INCREMENT,
  `name`          VARCHAR(255) NOT NULL,
  `position`      VARCHAR(255) NOT NULL,
  `committee`     VARCHAR(255) DEFAULT NULL,
  `phone`         VARCHAR(50)  DEFAULT NULL,
  `email`         VARCHAR(255) DEFAULT NULL,
  `photo_path`    VARCHAR(255) DEFAULT NULL,
  `display_order` INT(11)      DEFAULT 0,
  `official_type` ENUM('captain','sk_chairman','kagawad','secretary','treasurer','other') DEFAULT 'kagawad',
  `is_active`     TINYINT(1)   DEFAULT 1,
  `created_at`    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at`    TIMESTAMP    NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE: pwd_verification_requests
-- PWD ID verification requests submitted by citizens
-- ============================================================
CREATE TABLE IF NOT EXISTS `pwd_verification_requests` (
  `request_id`         INT(11)      NOT NULL AUTO_INCREMENT,
  `user_id`            INT(11)      NOT NULL,
  `citizen_id`         INT(11)      DEFAULT NULL,
  `pwd_id_number`      VARCHAR(100) NOT NULL,
  `disability_type`    VARCHAR(100) NOT NULL,
  `disability_details` TEXT         DEFAULT NULL,
  `pwd_id_image`       VARCHAR(255) DEFAULT NULL,
  `status`             ENUM('pending','approved','rejected','expired') NOT NULL DEFAULT 'pending',
  `admin_notes`        TEXT         DEFAULT NULL,
  `expires_at`         DATETIME     NOT NULL,
  `created_at`         DATETIME     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`         DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`request_id`),
  KEY `idx_user_id`    (`user_id`),
  KEY `idx_status`     (`status`),
  KEY `idx_expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE: pregnancy_validations
-- Pregnancy status change requests requiring healthworker approval
-- ============================================================
CREATE TABLE IF NOT EXISTS `pregnancy_validations` (
  `validation_id`               INT(11)  NOT NULL AUTO_INCREMENT,
  `citizen_id`                  INT(11)  NOT NULL,
  `request_type`                ENUM('new_pregnancy','update_pregnancy','clear_pregnancy') NOT NULL DEFAULT 'new_pregnancy',
  `pregnancy_start_date`        DATE     DEFAULT NULL COMMENT 'Proposed LMP date',
  `expected_due_date`           DATE     DEFAULT NULL,
  `expected_barangay_visit_date` DATE    DEFAULT NULL,
  `pregnancy_notes`             TEXT     DEFAULT NULL,
  `status`                      ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `requested_at`                DATETIME DEFAULT CURRENT_TIMESTAMP,
  `validated_at`                DATETIME DEFAULT NULL,
  `validated_by`                INT(11)  DEFAULT NULL,
  `validation_notes`            TEXT     DEFAULT NULL,
  `rejection_reason`            TEXT     DEFAULT NULL,
  `created_at`                  DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`                  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`validation_id`),
  KEY `citizen_id`       (`citizen_id`),
  KEY `validated_by`     (`validated_by`),
  KEY `idx_status`       (`status`),
  KEY `idx_requested_at` (`requested_at`),
  KEY `idx_pregnancy_validation_status` (`status`, `citizen_id`),
  CONSTRAINT `pregnancy_validations_ibfk_1` FOREIGN KEY (`citizen_id`)   REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `pregnancy_validations_ibfk_2` FOREIGN KEY (`validated_by`) REFERENCES `users`    (`id`)         ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: activity_logs
-- Audit trail of user actions across the system
-- ============================================================
CREATE TABLE IF NOT EXISTS `activity_logs` (
  `id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `user_id`     INT(11)      NOT NULL,
  `action`      VARCHAR(100) NOT NULL,
  `description` TEXT         DEFAULT NULL,
  `ip_address`  VARCHAR(45)  DEFAULT NULL,
  `created_at`  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id`    (`user_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;

-- ============================================================
-- SCHEMA SUMMARY
-- ============================================================
-- Tables (13 total):
--
--  Core Auth & Profiles
--   1. users                    - All accounts (admin / healthworker / citizen)
--   2. citizens                 - Citizen demographic + pregnancy + PWD info
--   3. health_profiles          - Blood type, allergies, chronic diseases
--   4. activity_logs            - Audit trail
--
--  Citizen Services
--   5. census                   - Census records (registered + public)
--   6. document_requests        - Barangay clearance / certificate requests
--   7. appointments             - Health appointments
--   8. aid_distribution         - Aid given to citizens
--
--  Dispute Resolution
--   9. summons_reports          - Complaints, summons, mediation (KP system)
--
--  Announcements & Notifications
--  10. announcements            - Admin-posted announcements
--  11. notifications            - In-app notifications
--
--  Verification Workflows
--  12. pwd_verification_requests  - PWD ID verification queue
--  13. pregnancy_validations      - Pregnancy status approval queue
--
--  Reference Data
--  14. barangay_officials        - Officials shown on landing page
--  15. reports                   - Generated report file references
-- ============================================================

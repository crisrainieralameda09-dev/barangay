-- ========================================================================
-- PREGNANCY VALIDATION REQUESTS TABLE
-- ========================================================================
-- This table stores pregnancy status change requests that require
-- healthcare worker validation before being applied to the citizen's record
-- ========================================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

USE buegas_db;

-- ========================================================================
-- TABLE: pregnancy_validations
-- Stores pregnancy validation requests from citizens
-- ========================================================================

CREATE TABLE IF NOT EXISTS `pregnancy_validations` (
  `validation_id` int(11) NOT NULL AUTO_INCREMENT,
  `citizen_id` int(11) NOT NULL,
  `request_type` enum('new_pregnancy','update_pregnancy','clear_pregnancy') NOT NULL DEFAULT 'new_pregnancy',
  `pregnancy_start_date` date DEFAULT NULL COMMENT 'Proposed pregnancy start date (LMP)',
  `expected_due_date` date DEFAULT NULL COMMENT 'Proposed expected due date',
  `expected_barangay_visit_date` date DEFAULT NULL COMMENT 'Expected date for barangay health center visit',
  `pregnancy_notes` text DEFAULT NULL COMMENT 'Notes provided by citizen',
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `requested_at` datetime DEFAULT current_timestamp(),
  `validated_at` datetime DEFAULT NULL,
  `validated_by` int(11) DEFAULT NULL COMMENT 'Health worker who validated the request',
  `validation_notes` text DEFAULT NULL COMMENT 'Notes from health worker during validation',
  `rejection_reason` text DEFAULT NULL COMMENT 'Reason if request was rejected',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`validation_id`),
  KEY `citizen_id` (`citizen_id`),
  KEY `validated_by` (`validated_by`),
  KEY `idx_status` (`status`),
  KEY `idx_requested_at` (`requested_at`),
  CONSTRAINT `pregnancy_validations_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `pregnancy_validations_ibfk_2` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add index for efficient queries
CREATE INDEX idx_pregnancy_validation_status ON pregnancy_validations(status, citizen_id);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- ========================================================================
-- TABLE CREATION COMPLETE
-- ========================================================================

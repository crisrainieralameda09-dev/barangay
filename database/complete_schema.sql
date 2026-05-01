-- ========================================================================
-- BARANGAY BUEGAS MANAGEMENT SYSTEM - COMPLETE DATABASE SCHEMA
-- ========================================================================
-- This file contains the complete consolidated database schema
-- including all tables, indexes, constraints, and sample data
-- ========================================================================

-- phpMyAdmin SQL Dump
-- Database: buegas_db
-- Generated: Consolidated Schema
-- ========================================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- ========================================================================
-- DATABASE CREATION
-- ========================================================================

CREATE DATABASE IF NOT EXISTS buegas_db
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE buegas_db;

-- ========================================================================
-- TABLE: users
-- Holds login credentials and basic info for all roles
-- Roles: 'admin', 'healthworker', 'citizen'
-- ========================================================================

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','healthworker','citizen') NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `email_verified` tinyint(1) DEFAULT 0,
  `verification_code` varchar(6) DEFAULT NULL,
  `verification_code_expires` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_role` (`role`),
  KEY `idx_status` (`status`),
  KEY `idx_verification_code` (`verification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: citizens
-- Citizen-specific details (linked to users with role='citizen')
-- ========================================================================

CREATE TABLE IF NOT EXISTS `citizens` (
  `citizen_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `birthdate` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `address` text NOT NULL,
  `civil_status` enum('Single','Married','Divorced','Widowed') NOT NULL,
  `is_senior` tinyint(1) DEFAULT 0,
  `is_pregnant` tinyint(1) DEFAULT 0,
  `is_pwd` tinyint(1) DEFAULT 0,
  `pwd_id` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`citizen_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_senior` (`is_senior`),
  KEY `idx_pregnant` (`is_pregnant`),
  KEY `idx_pwd` (`is_pwd`),
  CONSTRAINT `citizens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: health_profiles
-- Extended medical information for citizens
-- ========================================================================

CREATE TABLE IF NOT EXISTS `health_profiles` (
  `profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `citizen_id` int(11) NOT NULL,
  `blood_type` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `allergies` text DEFAULT NULL,
  `chronic_diseases` text DEFAULT NULL,
  `disability_details` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `unique_citizen_profile` (`citizen_id`),
  CONSTRAINT `health_profiles_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: census
-- Stores census information for citizens with QR code access
-- Supports both registered citizens and public submissions
-- ========================================================================

CREATE TABLE IF NOT EXISTS `census` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `census_id` varchar(50) NOT NULL,
  `citizen_id` int(11) DEFAULT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `birthdate` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `civil_status` enum('Single','Married','Divorced','Widowed') NOT NULL,
  `contact` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `monthly_income` varchar(50) DEFAULT NULL,
  `education` varchar(50) DEFAULT NULL,
  `household_members` int(11) DEFAULT 0,
  `is_senior` tinyint(1) DEFAULT 0,
  `is_pwd` tinyint(1) DEFAULT 0,
  `is_pregnant` tinyint(1) DEFAULT 0,
  `is_4ps` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `census_id` (`census_id`),
  KEY `idx_census_id` (`census_id`),
  KEY `idx_citizen_id` (`citizen_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `census_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: document_requests
-- Citizen requests for barangay certificates / clearances
-- ========================================================================

CREATE TABLE IF NOT EXISTS `document_requests` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `citizen_id` int(11) NOT NULL,
  `document_type` enum('Barangay Clearance','Certificate of Residency','Indigency','Other') NOT NULL,
  `purpose` text DEFAULT NULL,
  `purpose_type` varchar(100) DEFAULT NULL,
  `id_type` varchar(50) DEFAULT NULL,
  `id_number` varchar(100) DEFAULT NULL,
  `proof_of_residency` varchar(100) DEFAULT NULL,
  `cedula_number` varchar(50) DEFAULT NULL,
  `additional_info` text DEFAULT NULL,
  `processing_fee` decimal(10,2) DEFAULT 0.00,
  `reference_number` varchar(50) DEFAULT NULL,
  `status` enum('pending','approved','rejected','completed') DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `request_date` datetime DEFAULT current_timestamp(),
  `processed_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`request_id`),
  KEY `citizen_id` (`citizen_id`),
  KEY `processed_by` (`processed_by`),
  KEY `idx_status` (`status`),
  KEY `idx_request_date` (`request_date`),
  KEY `idx_doc_reference_number` (`reference_number`),
  CONSTRAINT `document_requests_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `document_requests_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: summons_reports
-- Incident reports / community concerns / dispute resolution
-- Includes Philippine Barangay dispute resolution system
-- ========================================================================

CREATE TABLE IF NOT EXISTS `summons_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `reference_number` varchar(50) DEFAULT NULL,
  `citizen_id` int(11) NOT NULL,
  `report_type` enum('Summon','Mediation Request','Settlement Follow-up','Incident','Noise Complaint','Property Dispute','Other Concern') NOT NULL,
  `description` text NOT NULL,
  `respondent_name` varchar(255) DEFAULT NULL,
  `respondent_address` text DEFAULT NULL,
  `respondent_contact` varchar(100) DEFAULT NULL,
  `incident_date` date NOT NULL,
  `urgency` enum('low','medium','high','critical') DEFAULT 'medium',
  `status` enum('new','for_mediation','mediation_scheduled','settled','no_settlement','investigating','resolved','closed') DEFAULT 'new',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `citizen_id` (`citizen_id`),
  KEY `idx_status` (`status`),
  KEY `idx_urgency` (`urgency`),
  KEY `idx_reference_number` (`reference_number`),
  CONSTRAINT `summons_reports_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: announcements
-- Public announcements posted by admin
-- ========================================================================

CREATE TABLE IF NOT EXISTS `announcements` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `posted_by` int(11) NOT NULL,
  `target_audience` enum('all','citizens','healthworkers') DEFAULT 'all',
  `category` enum('general','aid_distribution','calamity','health','event','urgent') DEFAULT 'general',
  `posted_at` datetime DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`announcement_id`),
  KEY `posted_by` (`posted_by`),
  KEY `idx_audience` (`target_audience`),
  KEY `idx_posted_at` (`posted_at`),
  CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: appointments
-- Health check-ups / vaccination appointments
-- Supports both admin-scheduled and citizen-requested appointments
-- ========================================================================

CREATE TABLE IF NOT EXISTS `appointments` (
  `appointment_id` int(11) NOT NULL AUTO_INCREMENT,
  `citizen_id` int(11) NOT NULL,
  `requested_by` int(11) DEFAULT NULL,
  `healthworker_id` int(11) DEFAULT NULL,
  `appointment_type` enum('check‑up','vaccination','follow‑up') NOT NULL,
  `scheduled_date` datetime NOT NULL,
  `status` enum('pending','approved','scheduled','completed','cancelled','rejected') DEFAULT 'pending',
  `reminder_sent` tinyint(1) DEFAULT 0,
  `notes` text DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_type` varchar(50) DEFAULT NULL,
  `id_number` varchar(100) DEFAULT NULL,
  `reference_number` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `citizen_id` (`citizen_id`),
  KEY `healthworker_id` (`healthworker_id`),
  KEY `requested_by` (`requested_by`),
  KEY `idx_scheduled_date` (`scheduled_date`),
  KEY `idx_status` (`status`),
  KEY `idx_reference_number` (`reference_number`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`healthworker_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`requested_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: aid_distribution
-- Tracks distribution of medicine, food, or other aid to citizens
-- ========================================================================

CREATE TABLE IF NOT EXISTS `aid_distribution` (
  `distribution_id` int(11) NOT NULL AUTO_INCREMENT,
  `citizen_id` int(11) NOT NULL,
  `aid_type` enum('medicine','food','financial','other') NOT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `date_distributed` date NOT NULL,
  `distributed_by` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`distribution_id`),
  KEY `citizen_id` (`citizen_id`),
  KEY `distributed_by` (`distributed_by`),
  KEY `idx_date_distributed` (`date_distributed`),
  CONSTRAINT `aid_distribution_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  CONSTRAINT `aid_distribution_ibfk_2` FOREIGN KEY (`distributed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: notifications
-- In-app notifications for users
-- ========================================================================

CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `link` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`notification_id`),
  KEY `idx_user_read` (`user_id`,`is_read`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- TABLE: reports
-- Stores generated reports (PDFs or data snapshots)
-- ========================================================================

CREATE TABLE IF NOT EXISTS `reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_type` varchar(100) NOT NULL,
  `generated_by` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`parameters`)),
  `generated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`report_id`),
  KEY `generated_by` (`generated_by`),
  KEY `idx_type` (`report_type`),
  KEY `idx_generated_at` (`generated_at`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================================================
-- SAMPLE DATA - DEFAULT ADMIN ACCOUNT
-- ========================================================================

-- Default Admin Account
-- Email: admin@buegas.local
-- Password: admin123
INSERT INTO `users` (`id`, `email`, `password_hash`, `role`, `first_name`, `last_name`, `contact_number`, `status`, `email_verified`, `created_at`, `updated_at`) VALUES
(1, 'admin@buegas.local', '$2y$10$Xh7zXup8UJCWOr9ELAaY3uOoMAJ5YuieizfYXycjfWc4dqhJ.ZzAO', 'admin', 'Admin', 'User', 'N/A', 'active', 1, NOW(), NOW());

-- ========================================================================
-- SAMPLE DATA - HEALTH WORKER ACCOUNTS
-- ========================================================================

-- Health Worker 1: Maria Santos
-- Email: healthworker@buegas.com
-- Password: healthworker123
INSERT INTO `users` (`email`, `password_hash`, `role`, `first_name`, `last_name`, `contact_number`, `status`, `email_verified`, `created_at`, `updated_at`) VALUES
('healthworker@buegas.com', '$2y$10$ioIX5AOlL8eYIcgjCHwV2.64dEOP7johR1WPfAzF0kakDaPCbgZe2', 'healthworker', 'Maria', 'Santos', '09123456789', 'active', 1, NOW(), NOW());

-- Health Worker 2: Juan Dela Cruz
-- Email: juan.delacruz@buegas.com
-- Password: healthworker123
INSERT INTO `users` (`email`, `password_hash`, `role`, `first_name`, `last_name`, `contact_number`, `status`, `email_verified`, `created_at`, `updated_at`) VALUES
('juan.delacruz@buegas.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'healthworker', 'Juan', 'Dela Cruz', '09234567890', 'active', 1, NOW(), NOW());

-- Health Worker 3: Ana Reyes
-- Email: ana.reyes@buegas.com
-- Password: healthworker123
INSERT INTO `users` (`email`, `password_hash`, `role`, `first_name`, `last_name`, `contact_number`, `status`, `email_verified`, `created_at`, `updated_at`) VALUES
('ana.reyes@buegas.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'healthworker', 'Ana', 'Reyes', '09345678901', 'active', 1, NOW(), NOW());

-- ========================================================================
-- SAMPLE DATA - CITIZEN ACCOUNT
-- ========================================================================

-- Sample Citizen Account
-- Email: citizen@buegas.com
-- Password: citizen123
INSERT INTO `users` (`email`, `password_hash`, `role`, `first_name`, `last_name`, `contact_number`, `status`, `email_verified`, `created_at`, `updated_at`) VALUES
('citizen@buegas.com', '$2y$10$6eNL70Ve/4g11O2Z2ZhCJu1lxIt5ktvtW5MjVSrgJCpLG1SIsIUXi', 'citizen', 'Juan', 'Dela Cruz', '09987654321', 'active', 1, NOW(), NOW());

-- Get the citizen user_id for the citizens table
SET @citizen_user_id = LAST_INSERT_ID();

-- Insert citizen details
INSERT INTO `citizens` (`user_id`, `birthdate`, `gender`, `address`, `civil_status`, `is_senior`, `is_pregnant`, `is_pwd`, `created_at`, `updated_at`) VALUES
(@citizen_user_id, '1990-05-15', 'Male', 'Purok 1, Barangay Buegas, City, Province', 'Single', 0, 0, 0, NOW(), NOW());

-- ========================================================================
-- COMPLETION MESSAGE
-- ========================================================================

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- ========================================================================
-- DATABASE SCHEMA INSTALLATION COMPLETE
-- ========================================================================
-- 
-- DEFAULT LOGIN CREDENTIALS:
-- 
-- ADMIN ACCOUNT:
--   Email: admin@buegas.local
--   Password: admin123
-- 
-- HEALTH WORKER ACCOUNTS:
--   1. Email: healthworker@buegas.com | Password: healthworker123
--   2. Email: juan.delacruz@buegas.com | Password: healthworker123
--   3. Email: ana.reyes@buegas.com | Password: healthworker123
-- 
-- CITIZEN ACCOUNT:
--   Email: citizen@buegas.com
--   Password: citizen123
-- 
-- ========================================================================
-- TABLES CREATED:
-- ========================================================================
-- 1. users - User accounts (admin, healthworker, citizen)
-- 2. citizens - Citizen-specific information
-- 3. health_profiles - Medical records for citizens
-- 4. census - Census data with QR code support
-- 5. document_requests - Barangay document requests
-- 6. summons_reports - Incident reports and dispute resolution
-- 7. announcements - Public announcements
-- 8. appointments - Health appointments
-- 9. aid_distribution - Aid distribution tracking
-- 10. notifications - In-app notifications
-- 11. reports - Generated reports storage
-- ========================================================================

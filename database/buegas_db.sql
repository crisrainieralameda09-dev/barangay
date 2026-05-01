-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 25, 2026 at 07:38 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `buegas_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `aid_distribution`
--

CREATE TABLE `aid_distribution` (
  `distribution_id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `aid_type` enum('medicine','food','financial','other') NOT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `date_distributed` date NOT NULL,
  `distributed_by` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `aid_distribution`
--

INSERT INTO `aid_distribution` (`distribution_id`, `citizen_id`, `aid_type`, `quantity`, `date_distributed`, `distributed_by`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 'financial', '1', '0000-00-00', 1, 'asdas', '2026-02-20 12:21:10', '2026-02-20 12:21:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `announcement_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `posted_by` int(11) NOT NULL,
  `target_audience` enum('all','citizens','healthworkers') DEFAULT 'all',
  `category` enum('general','aid_distribution','calamity','health','event','urgent') DEFAULT 'general',
  `posted_at` datetime DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`announcement_id`, `title`, `content`, `posted_by`, `target_audience`, `category`, `posted_at`, `expires_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'dsd', 'dsdsa', 1, 'all', 'general', '2026-02-15 22:01:29', '2206-09-09 00:00:00', '2026-02-15 22:01:29', '2026-02-15 22:01:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
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
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `citizen_id`, `requested_by`, `healthworker_id`, `appointment_type`, `scheduled_date`, `status`, `reminder_sent`, `notes`, `contact_number`, `email`, `id_type`, `id_number`, `reference_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 5, 2, '', '2026-02-11 13:12:00', 'scheduled', 0, 'i have a fever', NULL, NULL, NULL, NULL, NULL, '2026-02-15 22:13:11', '2026-02-15 22:13:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `census`
--

CREATE TABLE `census` (
  `id` int(11) NOT NULL,
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
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `census`
--

INSERT INTO `census` (`id`, `census_id`, `citizen_id`, `firstname`, `lastname`, `birthdate`, `gender`, `civil_status`, `contact`, `address`, `occupation`, `monthly_income`, `education`, `household_members`, `is_senior`, `is_pwd`, `is_pregnant`, `is_4ps`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'CEN-2026-PUB-922534', NULL, 'CRIS', 'ALAMEDA', '2004-09-01', 'Male', 'Single', '09562109987', 'prk capahuan\r\nprk capahuan', 'house wife', 'Below 5000', 'Elementary', 45, 0, 0, 0, 0, '2026-02-14 22:39:14', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `citizens`
--

CREATE TABLE `citizens` (
  `citizen_id` int(11) NOT NULL,
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
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `citizens`
--

INSERT INTO `citizens` (`citizen_id`, `user_id`, `birthdate`, `gender`, `address`, `civil_status`, `is_senior`, `is_pregnant`, `is_pwd`, `pwd_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, '1990-05-15', 'Male', 'Purok 1, Barangay Buegas, City, Province', 'Single', 0, 0, 0, NULL, '2026-02-14 20:07:50', '2026-02-14 20:07:50', NULL),
(3, 5, '2004-09-09', 'Male', 'prk capahuan\r\nprk capahuan', 'Single', 0, 0, 0, '', '2026-02-14 20:55:34', '2026-02-14 20:55:34', NULL),
(4, 6, '2004-09-09', 'Male', 'prk capahuan\r\nprk capahuan', 'Single', 1, 0, 0, '', '2026-02-14 21:28:51', '2026-02-14 21:28:51', NULL),
(5, 7, '2004-09-09', 'Male', 'prk capahuan\r\nprk capahuan', 'Single', 0, 0, 0, '', '2026-02-14 21:30:55', '2026-02-14 21:30:55', NULL),
(13, 17, '2004-09-09', 'Male', 'prk capahuan\r\nprk capahuan', 'Single', 0, 0, 0, '', '2026-02-20 21:12:14', '2026-02-20 21:12:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `document_requests`
--

CREATE TABLE `document_requests` (
  `request_id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `document_type` enum('Barangay Clearance','Certificate of Residency','Indigency','Other') NOT NULL,
  `purpose` text DEFAULT NULL,
  `status` enum('pending','approved','rejected','completed') DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `request_date` datetime DEFAULT current_timestamp(),
  `processed_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `document_requests`
--

INSERT INTO `document_requests` (`request_id`, `citizen_id`, `document_type`, `purpose`, `status`, `remarks`, `request_date`, `processed_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 'Certificate of Residency', 'dsds', 'pending', 'dsdsdas', '2026-02-15 21:56:23', 1, '2026-02-15 21:56:23', '2026-02-15 21:56:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `health_profiles`
--

CREATE TABLE `health_profiles` (
  `profile_id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `blood_type` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `allergies` text DEFAULT NULL,
  `chronic_diseases` text DEFAULT NULL,
  `disability_details` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `health_profiles`
--

INSERT INTO `health_profiles` (`profile_id`, `citizen_id`, `blood_type`, `allergies`, `chronic_diseases`, `disability_details`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 'A+', 'none ', 'none ', 'none', '2026-02-20 12:37:50', '2026-02-20 12:37:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `link` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `type`, `message`, `is_read`, `link`, `created_at`) VALUES
(2, 5, 'welcome', 'Welcome to Barangay Buegas Management System! Your account has been successfully created.', 0, NULL, '2026-02-14 20:55:34'),
(3, 6, 'welcome', 'Welcome to Barangay Buegas Management System! Your account has been successfully created.', 0, NULL, '2026-02-14 21:28:51'),
(4, 7, 'welcome', 'Welcome to Barangay Buegas Management System! Your account has been successfully created.', 0, NULL, '2026-02-14 21:30:55'),
(5, 5, 'document_request', 'Your document request for Certificate of Residency has been updated to: pending', 0, NULL, '2026-02-15 21:56:48'),
(6, 1, 'appointment_request', 'New appointment request for check-up', 0, NULL, '2026-02-15 22:13:11'),
(7, 5, 'appointment_update', 'Your appointment request for  has been updated to: approved', 0, NULL, '2026-02-15 22:13:39'),
(8, 5, 'appointment_update', 'Your appointment request for  has been updated to: scheduled', 0, NULL, '2026-02-15 22:13:43'),
(13, 17, 'welcome', 'Welcome to Barangay Buegas Management System! Your account has been successfully verified.', 0, NULL, '2026-02-20 21:12:53');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `report_type` varchar(100) NOT NULL,
  `generated_by` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`parameters`)),
  `generated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `summons_reports`
--

CREATE TABLE `summons_reports` (
  `report_id` int(11) NOT NULL,
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
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `summons_reports`
--

INSERT INTO `summons_reports` (`report_id`, `reference_number`, `citizen_id`, `report_type`, `description`, `respondent_name`, `respondent_address`, `respondent_contact`, `incident_date`, `urgency`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 3, 'Summon', 'dsadsa', NULL, NULL, NULL, '2026-02-20', 'medium', 'new', '2026-02-20 12:13:36', '2026-02-20 12:13:36', NULL),
(2, NULL, 3, 'Summon', 'sdasfasdasd', NULL, NULL, NULL, '2026-02-20', 'medium', 'new', '2026-02-20 12:14:01', '2026-02-20 12:14:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','healthworker','citizen') NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `email_verified` tinyint(1) DEFAULT 0,
  `verification_code` varchar(6) DEFAULT NULL,
  `verification_code_expires` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `role`, `first_name`, `last_name`, `contact_number`, `status`, `email_verified`, `verification_code`, `verification_code_expires`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin@buegas.local', '$2y$10$Xh7zXup8UJCWOr9ELAaY3uOoMAJ5YuieizfYXycjfWc4dqhJ.ZzAO', 'admin', 'Admin', 'User', 'N/A', 'active', 1, NULL, NULL, '2026-02-14 19:11:50', '2026-02-20 20:26:35', NULL),
(2, 'healthworker@buegas.com', '$2y$10$ioIX5AOlL8eYIcgjCHwV2.64dEOP7johR1WPfAzF0kakDaPCbgZe2', 'healthworker', 'Maria', 'Santos', '09123456789', 'active', 1, NULL, NULL, '2026-02-14 20:00:23', '2026-02-20 20:26:54', NULL),
(3, 'citizen@buegas.com', '$2y$10$6eNL70Ve/4g11O2Z2ZhCJu1lxIt5ktvtW5MjVSrgJCpLG1SIsIUXi', 'citizen', 'Juan', 'Dela Cruz', '09987654321', 'active', 0, NULL, NULL, '2026-02-14 20:07:50', '2026-02-14 20:07:50', NULL),
(5, 'crisalameda@gmail.com', '$2y$10$/xFK33whmXj.mOqBAxwNFuzx2GXxoUZFOWtBs6w1p03geXExI0bkG', 'citizen', 'alameda', 'alameda', '09562109987', 'active', 0, NULL, NULL, '2026-02-14 20:55:34', '2026-02-14 20:55:34', NULL),
(6, 'crisrainieralameda023@gmail.com', '$2y$10$MhusPU9.xVNr6CKQJLdNZOl3eIJHlYp29mJVQpJdHBBg8f6lNj1PK', 'citizen', 'CRIS', 'ALAMEDA', '09562109987', 'active', 0, NULL, NULL, '2026-02-14 21:28:51', '2026-02-14 21:28:51', NULL),
(7, 'crisrainieralameda0912@gmail.com', '$2y$10$Wy7E4WtrDFoWshfPkmiFu.xiINKflLLL33WQmFINXOefgccjTwpKO', 'citizen', 'CRIS', 'ALAMEDA', '09562109987', 'active', 0, NULL, NULL, '2026-02-14 21:30:55', '2026-02-14 21:30:55', NULL),
(17, 'crisrainieralameda09@gmail.com', '$2y$10$Z4YljIXp/YQeIUCXNHAdjuw4f9ogxawEH/tHyGMCGB8W9bIqmOaGG', 'citizen', 'CRIS', 'ALAMEDA', '09562109987', 'active', 1, NULL, NULL, '2026-02-20 21:12:14', '2026-02-20 21:12:53', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aid_distribution`
--
ALTER TABLE `aid_distribution`
  ADD PRIMARY KEY (`distribution_id`),
  ADD KEY `citizen_id` (`citizen_id`),
  ADD KEY `distributed_by` (`distributed_by`),
  ADD KEY `idx_date_distributed` (`date_distributed`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`announcement_id`),
  ADD KEY `posted_by` (`posted_by`),
  ADD KEY `idx_audience` (`target_audience`),
  ADD KEY `idx_posted_at` (`posted_at`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `citizen_id` (`citizen_id`),
  ADD KEY `healthworker_id` (`healthworker_id`),
  ADD KEY `idx_scheduled_date` (`scheduled_date`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `requested_by` (`requested_by`),
  ADD KEY `idx_reference_number` (`reference_number`);

--
-- Indexes for table `census`
--
ALTER TABLE `census`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `census_id` (`census_id`),
  ADD KEY `idx_census_id` (`census_id`),
  ADD KEY `idx_citizen_id` (`citizen_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `citizens`
--
ALTER TABLE `citizens`
  ADD PRIMARY KEY (`citizen_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `idx_senior` (`is_senior`),
  ADD KEY `idx_pregnant` (`is_pregnant`),
  ADD KEY `idx_pwd` (`is_pwd`);

--
-- Indexes for table `document_requests`
--
ALTER TABLE `document_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `citizen_id` (`citizen_id`),
  ADD KEY `processed_by` (`processed_by`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_request_date` (`request_date`);

--
-- Indexes for table `health_profiles`
--
ALTER TABLE `health_profiles`
  ADD PRIMARY KEY (`profile_id`),
  ADD UNIQUE KEY `unique_citizen_profile` (`citizen_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_user_read` (`user_id`,`is_read`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `generated_by` (`generated_by`),
  ADD KEY `idx_type` (`report_type`),
  ADD KEY `idx_generated_at` (`generated_at`);

--
-- Indexes for table `summons_reports`
--
ALTER TABLE `summons_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `citizen_id` (`citizen_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_urgency` (`urgency`),
  ADD KEY `idx_reference_number` (`reference_number`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_verification_code` (`verification_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aid_distribution`
--
ALTER TABLE `aid_distribution`
  MODIFY `distribution_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `census`
--
ALTER TABLE `census`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `citizens`
--
ALTER TABLE `citizens`
  MODIFY `citizen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `document_requests`
--
ALTER TABLE `document_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `health_profiles`
--
ALTER TABLE `health_profiles`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `summons_reports`
--
ALTER TABLE `summons_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aid_distribution`
--
ALTER TABLE `aid_distribution`
  ADD CONSTRAINT `aid_distribution_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `aid_distribution_ibfk_2` FOREIGN KEY (`distributed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`healthworker_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`requested_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `census`
--
ALTER TABLE `census`
  ADD CONSTRAINT `census_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE;

--
-- Constraints for table `citizens`
--
ALTER TABLE `citizens`
  ADD CONSTRAINT `citizens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `document_requests`
--
ALTER TABLE `document_requests`
  ADD CONSTRAINT `document_requests_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `document_requests_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `health_profiles`
--
ALTER TABLE `health_profiles`
  ADD CONSTRAINT `health_profiles_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `summons_reports`
--
ALTER TABLE `summons_reports`
  ADD CONSTRAINT `summons_reports_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`citizen_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

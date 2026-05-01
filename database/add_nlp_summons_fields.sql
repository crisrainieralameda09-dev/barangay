-- ========================================================================
-- ADD NLP AND COMPREHENSIVE FIELDS TO SUMMONS REPORTS TABLE
-- ========================================================================
-- This script adds new fields for NLP analysis and comprehensive complaint
-- management without modifying existing data
-- Split into smaller ALTER TABLE statements to avoid MySQL limitations
-- ========================================================================

USE buegas_db;

-- Batch 1: Basic complaint information fields
ALTER TABLE `summons_reports` 
ADD COLUMN `barangay_case_number` VARCHAR(50) DEFAULT NULL AFTER `reference_number`,
ADD COLUMN `criminal_case_number` VARCHAR(100) DEFAULT NULL AFTER `barangay_case_number`,
ADD COLUMN `complainant_name` VARCHAR(255) DEFAULT NULL AFTER `criminal_case_number`,
ADD COLUMN `complainant_address` TEXT DEFAULT NULL AFTER `complainant_name`,
ADD COLUMN `complainant_contact` VARCHAR(100) DEFAULT NULL AFTER `complainant_address`;

-- Batch 2: Complaint details and relief fields
ALTER TABLE `summons_reports` 
ADD COLUMN `complaint_type` VARCHAR(255) DEFAULT NULL AFTER `report_type`,
ADD COLUMN `complaint_description` TEXT DEFAULT NULL AFTER `description`,
ADD COLUMN `requested_relief` TEXT DEFAULT NULL AFTER `complaint_description`,
ADD COLUMN `date_made` DATE DEFAULT NULL AFTER `incident_date`,
ADD COLUMN `date_filed` DATE DEFAULT NULL AFTER `date_made`;

-- Batch 3: Official and hearing information fields
ALTER TABLE `summons_reports` 
ADD COLUMN `barangay_official` VARCHAR(255) DEFAULT 'ASAHEL P. GAYATIN' AFTER `date_filed`,
ADD COLUMN `official_position` VARCHAR(100) DEFAULT 'Punong Barangay / Lupon Chairman' AFTER `barangay_official`,
ADD COLUMN `lupon_members` TEXT DEFAULT NULL AFTER `official_position`,
ADD COLUMN `hearing_date` DATETIME DEFAULT NULL AFTER `lupon_members`,
ADD COLUMN `hearing_location` VARCHAR(255) DEFAULT 'Barangay Hall' AFTER `hearing_date`;

-- Batch 4: Settlement and case management fields
ALTER TABLE `summons_reports` 
ADD COLUMN `settlement_amount` DECIMAL(10,2) DEFAULT NULL AFTER `hearing_location`,
ADD COLUMN `settlement_terms` TEXT DEFAULT NULL AFTER `settlement_amount`,
ADD COLUMN `case_notes` TEXT DEFAULT NULL AFTER `settlement_terms`,
ADD COLUMN `processed_by` INT(11) DEFAULT NULL AFTER `case_notes`;

-- Batch 5: NLP analysis fields
ALTER TABLE `summons_reports` 
ADD COLUMN `nlp_confidence` DECIMAL(3,2) DEFAULT NULL AFTER `processed_by`,
ADD COLUMN `nlp_reasoning` TEXT DEFAULT NULL AFTER `nlp_confidence`,
ADD COLUMN `nlp_analysis_date` DATETIME DEFAULT NULL AFTER `nlp_reasoning`;

-- Update the report_type enum to include more specific complaint types
ALTER TABLE `summons_reports` 
MODIFY COLUMN `report_type` ENUM(
  'Summon',
  'Mediation Request', 
  'Settlement Follow-up',
  'Incident',
  'Noise Complaint',
  'Property Dispute',
  'Debt Collection',
  'Physical Injury',
  'Oral Defamation',
  'Threat',
  'Trespassing',
  'Damage to Property',
  'Harassment',
  'Family Dispute',
  'Neighbor Dispute',
  'Business Dispute',
  'Other Concern'
) NOT NULL;

-- Update the status enum to include more barangay justice system statuses
ALTER TABLE `summons_reports` 
MODIFY COLUMN `status` ENUM(
  'new',
  'for_mediation',
  'summons_issued',
  'mediation_scheduled',
  'hearing_scheduled',
  'under_mediation',
  'settled',
  'no_settlement',
  'certificate_issued',
  'investigating',
  'resolved',
  'dismissed',
  'referred_to_court',
  'closed'
) DEFAULT 'new';

-- Add foreign key constraint for processed_by
ALTER TABLE `summons_reports` 
ADD CONSTRAINT `fk_summons_processed_by` 
FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

-- Add indexes for better performance
CREATE INDEX `idx_barangay_case_number` ON `summons_reports` (`barangay_case_number`);
CREATE INDEX `idx_criminal_case_number` ON `summons_reports` (`criminal_case_number`);
CREATE INDEX `idx_complainant_name` ON `summons_reports` (`complainant_name`);
CREATE INDEX `idx_hearing_date` ON `summons_reports` (`hearing_date`);
CREATE INDEX `idx_date_filed` ON `summons_reports` (`date_filed`);
CREATE INDEX `idx_nlp_confidence` ON `summons_reports` (`nlp_confidence`);
CREATE INDEX `idx_nlp_analysis_date` ON `summons_reports` (`nlp_analysis_date`);

-- ========================================================================
-- VERIFICATION QUERY
-- ========================================================================

-- Check the updated table structure
-- DESCRIBE summons_reports;

COMMIT;
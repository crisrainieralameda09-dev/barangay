-- ========================================================================
-- SAFELY ADD MISSING NLP AND COMPREHENSIVE FIELDS TO SUMMONS REPORTS TABLE
-- ========================================================================
-- This script checks for existing columns before adding new ones
-- to avoid "Duplicate column name" errors
-- ========================================================================

USE buegas_db;

-- Check and add columns that don't exist yet
-- Note: Run each section separately if needed

-- Add barangay_case_number if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'barangay_case_number';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `barangay_case_number` VARCHAR(50) DEFAULT NULL AFTER `reference_number`', 
    'SELECT "Column barangay_case_number already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add criminal_case_number if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'criminal_case_number';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `criminal_case_number` VARCHAR(100) DEFAULT NULL AFTER `barangay_case_number`', 
    'SELECT "Column criminal_case_number already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add complainant_name if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'complainant_name';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `complainant_name` VARCHAR(255) DEFAULT NULL AFTER `criminal_case_number`', 
    'SELECT "Column complainant_name already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add complainant_address if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'complainant_address';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `complainant_address` TEXT DEFAULT NULL AFTER `complainant_name`', 
    'SELECT "Column complainant_address already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add complainant_contact if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'complainant_contact';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `complainant_contact` VARCHAR(100) DEFAULT NULL AFTER `complainant_address`', 
    'SELECT "Column complainant_contact already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add complaint_type if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'complaint_type';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `complaint_type` VARCHAR(255) DEFAULT NULL AFTER `report_type`', 
    'SELECT "Column complaint_type already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add complaint_description if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'complaint_description';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `complaint_description` TEXT DEFAULT NULL AFTER `description`', 
    'SELECT "Column complaint_description already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add requested_relief if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'requested_relief';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `requested_relief` TEXT DEFAULT NULL AFTER `complaint_description`', 
    'SELECT "Column requested_relief already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add date_made if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'date_made';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `date_made` DATE DEFAULT NULL AFTER `incident_date`', 
    'SELECT "Column date_made already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add date_filed if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'date_filed';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `date_filed` DATE DEFAULT NULL AFTER `date_made`', 
    'SELECT "Column date_filed already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add nlp_confidence if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'nlp_confidence';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `nlp_confidence` DECIMAL(3,2) DEFAULT NULL', 
    'SELECT "Column nlp_confidence already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add nlp_reasoning if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'nlp_reasoning';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `nlp_reasoning` TEXT DEFAULT NULL', 
    'SELECT "Column nlp_reasoning already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add nlp_analysis_date if it doesn't exist
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.columns 
WHERE table_schema = 'buegas_db' 
AND table_name = 'summons_reports' 
AND column_name = 'nlp_analysis_date';

SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `summons_reports` ADD COLUMN `nlp_analysis_date` DATETIME DEFAULT NULL', 
    'SELECT "Column nlp_analysis_date already exists" as message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

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

-- Show final table structure
DESCRIBE summons_reports;

COMMIT;
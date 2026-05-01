-- --------------------------------------------------------
-- Table: census
-- Stores census information for citizens with QR code access
-- --------------------------------------------------------

USE buegas_db;

CREATE TABLE IF NOT EXISTS census (
    id INT AUTO_INCREMENT PRIMARY KEY,
    census_id VARCHAR(50) NOT NULL UNIQUE,              -- e.g., 'CEN-2026-000001'
    citizen_id INT NULL,                                 -- NULL for public submissions
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    civil_status ENUM('Single', 'Married', 'Divorced', 'Widowed') NOT NULL,
    contact VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    occupation VARCHAR(100) NULL,
    monthly_income VARCHAR(50) NULL,
    education VARCHAR(50) NULL,
    household_members INT DEFAULT 0,
    is_senior BOOLEAN DEFAULT FALSE,
    is_pwd BOOLEAN DEFAULT FALSE,
    is_pregnant BOOLEAN DEFAULT FALSE,
    is_4ps BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id) ON DELETE CASCADE,
    INDEX idx_census_id (census_id),
    INDEX idx_citizen_id (citizen_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB;

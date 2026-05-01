-- --------------------------------------------------------
-- Database: buegas_db
-- --------------------------------------------------------
CREATE DATABASE IF NOT EXISTS buegas_db
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE buegas_db;

-- --------------------------------------------------------
-- Table: users
-- Holds login credentials and basic info for all roles.
-- Roles: 'admin', 'healthworker', 'citizen'
-- --------------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'healthworker', 'citizen') NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    contact_number VARCHAR(20),
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,                       -- soft delete
    INDEX idx_role (role),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: citizens
-- Citizen‑specific details (linked to users with role='citizen')
-- --------------------------------------------------------
CREATE TABLE citizens (
    citizen_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,                     -- one‑to‑one with users
    birthdate DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    address TEXT NOT NULL,
    civil_status ENUM('Single', 'Married', 'Divorced', 'Widowed') NOT NULL,
    is_senior BOOLEAN DEFAULT FALSE,
    is_pregnant BOOLEAN DEFAULT FALSE,
    is_pwd BOOLEAN DEFAULT FALSE,
    pwd_id VARCHAR(50) NULL,                          -- if applicable
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_senior (is_senior),
    INDEX idx_pregnant (is_pregnant),
    INDEX idx_pwd (is_pwd)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: health_profiles
-- Extended medical information for citizens
-- --------------------------------------------------------
CREATE TABLE health_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NULL,
    allergies TEXT NULL,
    chronic_diseases TEXT NULL,
    disability_details TEXT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id) ON DELETE CASCADE,
    UNIQUE KEY unique_citizen_profile (citizen_id)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: document_requests
-- Citizen requests for barangay certificates / clearances
-- --------------------------------------------------------
CREATE TABLE document_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    document_type ENUM('Barangay Clearance', 'Certificate of Residency', 'Indigency', 'Other') NOT NULL,
    purpose TEXT,
    status ENUM('pending', 'approved', 'rejected', 'completed') DEFAULT 'pending',
    remarks TEXT NULL,
    request_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    processed_by INT NULL,                             -- admin who handled it
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id) ON DELETE CASCADE,
    FOREIGN KEY (processed_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_request_date (request_date)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: summons_reports
-- Incident reports / community concerns filed by citizens
-- --------------------------------------------------------
CREATE TABLE summons_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    report_type ENUM('Summon', 'Incident', 'Concern') NOT NULL,
    description TEXT NOT NULL,
    incident_date DATE NOT NULL,
    urgency ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium',
    status ENUM('new', 'investigating', 'resolved', 'closed') DEFAULT 'new',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_urgency (urgency)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: announcements
-- Public announcements posted by admin
-- --------------------------------------------------------
CREATE TABLE announcements (
    announcement_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    posted_by INT NOT NULL,                            -- admin user id
    target_audience ENUM('all', 'citizens', 'healthworkers') DEFAULT 'all',
    posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (posted_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_audience (target_audience),
    INDEX idx_posted_at (posted_at)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: appointments
-- Health check‑ups / vaccination appointments scheduled by healthworkers
-- --------------------------------------------------------
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    healthworker_id INT NOT NULL,                       -- user with role 'healthworker'
    appointment_type ENUM('check‑up', 'vaccination', 'follow‑up') NOT NULL,
    scheduled_date DATETIME NOT NULL,
    status ENUM('scheduled', 'completed', 'cancelled') DEFAULT 'scheduled',
    reminder_sent BOOLEAN DEFAULT FALSE,
    notes TEXT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id) ON DELETE CASCADE,
    FOREIGN KEY (healthworker_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_scheduled_date (scheduled_date),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: aid_distribution
-- Tracks distribution of medicine, food, or other aid to citizens
-- --------------------------------------------------------
CREATE TABLE aid_distribution (
    distribution_id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    aid_type ENUM('medicine', 'food', 'financial', 'other') NOT NULL,
    quantity VARCHAR(50),                               -- e.g., "2 boxes", "5 kg"
    date_distributed DATE NOT NULL,
    distributed_by INT NOT NULL,                        -- healthworker user id
    notes TEXT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id) ON DELETE CASCADE,
    FOREIGN KEY (distributed_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_date_distributed (date_distributed)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: notifications
-- In‑app notifications for users
-- --------------------------------------------------------
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,                          -- e.g., 'appointment_reminder', 'request_update'
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    link VARCHAR(255) NULL,                              -- deep link to relevant page
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_read (user_id, is_read)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Table: reports
-- Stores generated reports (PDFs or data snapshots)
-- --------------------------------------------------------
CREATE TABLE reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    report_type VARCHAR(100) NOT NULL,                   -- e.g., 'monthly_requests', 'health_trends'
    generated_by INT NOT NULL,                            -- user id of admin/healthworker
    file_path VARCHAR(255) NOT NULL,                      -- path to stored PDF
    parameters JSON NULL,                                  -- query parameters used
    generated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (generated_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_type (report_type),
    INDEX idx_generated_at (generated_at)
) ENGINE=InnoDB;
-- Add additional fields to appointments table for Philippine Barangay Health Center standards
ALTER TABLE appointments 
ADD COLUMN contact_number VARCHAR(20) AFTER notes,
ADD COLUMN email VARCHAR(100) AFTER contact_number,
ADD COLUMN id_type VARCHAR(50) AFTER email,
ADD COLUMN id_number VARCHAR(100) AFTER id_type,
ADD COLUMN reference_number VARCHAR(50) AFTER id_number;

-- Add index for reference number
ALTER TABLE appointments ADD INDEX idx_reference_number (reference_number);

-- Update appointments table to support citizen requests
-- Run this SQL in your database

ALTER TABLE appointments 
MODIFY COLUMN status ENUM('pending', 'approved', 'scheduled', 'completed', 'cancelled', 'rejected') DEFAULT 'pending';

ALTER TABLE appointments 
MODIFY COLUMN healthworker_id INT NULL;

-- Add requested_by column to track who created the appointment
ALTER TABLE appointments 
ADD COLUMN requested_by INT NULL AFTER citizen_id,
ADD FOREIGN KEY (requested_by) REFERENCES users(id) ON DELETE SET NULL;

-- Add pregnancy tracking fields to citizens table
-- This allows tracking pregnancy start date and expected due date for female citizens

ALTER TABLE citizens
ADD COLUMN pregnancy_start_date DATE NULL COMMENT 'Date when pregnancy started (LMP - Last Menstrual Period)',
ADD COLUMN expected_due_date DATE NULL COMMENT 'Expected delivery/labor date (calculated as 280 days from LMP)',
ADD COLUMN expected_barangay_visit_date DATE NULL COMMENT 'Expected date for barangay health center visit',
ADD COLUMN pregnancy_notes TEXT NULL COMMENT 'Additional notes about pregnancy';

-- Add index for pregnancy tracking queries
CREATE INDEX idx_pregnancy_dates ON citizens(pregnancy_start_date, expected_due_date);

-- Update is_pregnant flag based on pregnancy dates
-- Automatically set is_pregnant to 1 if pregnancy dates are set and due date is in the future
UPDATE citizens 
SET is_pregnant = 1 
WHERE pregnancy_start_date IS NOT NULL 
  AND expected_due_date IS NOT NULL 
  AND expected_due_date >= CURDATE()
  AND gender = 'Female';

-- Set is_pregnant to 0 if due date has passed
UPDATE citizens 
SET is_pregnant = 0 
WHERE expected_due_date < CURDATE()
  AND gender = 'Female';

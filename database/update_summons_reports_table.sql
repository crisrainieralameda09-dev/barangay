-- --------------------------------------------------------
-- Update summons_reports table for Philippine Dispute Resolution System
-- Add respondent information and reference number fields
-- --------------------------------------------------------

-- Add new columns for respondent information
ALTER TABLE summons_reports
ADD COLUMN respondent_name VARCHAR(255) NULL AFTER description,
ADD COLUMN respondent_address TEXT NULL AFTER respondent_name,
ADD COLUMN respondent_contact VARCHAR(100) NULL AFTER respondent_address,
ADD COLUMN reference_number VARCHAR(50) NULL AFTER report_id,
ADD INDEX idx_reference_number (reference_number);

-- Update report_type ENUM to include new Philippine dispute resolution types
ALTER TABLE summons_reports
MODIFY COLUMN report_type ENUM(
    'Summon',
    'Mediation Request',
    'Settlement Follow-up',
    'Incident',
    'Noise Complaint',
    'Property Dispute',
    'Other Concern'
) NOT NULL;

-- Update status ENUM to include Philippine-specific statuses
ALTER TABLE summons_reports
MODIFY COLUMN status ENUM(
    'new',
    'for_mediation',
    'mediation_scheduled',
    'settled',
    'no_settlement',
    'investigating',
    'resolved',
    'closed'
) DEFAULT 'new';

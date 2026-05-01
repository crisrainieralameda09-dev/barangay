-- Add additional fields to document_requests table for Philippine Barangay standards
ALTER TABLE document_requests 
ADD COLUMN purpose_type VARCHAR(100) AFTER purpose,
ADD COLUMN id_type VARCHAR(50) AFTER purpose_type,
ADD COLUMN id_number VARCHAR(100) AFTER id_type,
ADD COLUMN proof_of_residency VARCHAR(100) AFTER id_number,
ADD COLUMN cedula_number VARCHAR(50) AFTER proof_of_residency,
ADD COLUMN additional_info TEXT AFTER cedula_number,
ADD COLUMN processing_fee DECIMAL(10,2) DEFAULT 0.00 AFTER additional_info,
ADD COLUMN reference_number VARCHAR(50) AFTER processing_fee;

-- Add index for reference number
ALTER TABLE document_requests ADD INDEX idx_doc_reference_number (reference_number);

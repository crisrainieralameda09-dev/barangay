-- Add category column to announcements table
ALTER TABLE announcements 
ADD COLUMN category ENUM('general', 'aid_distribution', 'calamity', 'health', 'event', 'urgent') 
DEFAULT 'general' 
AFTER target_audience;

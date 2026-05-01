-- Create Health Worker Account
-- Email: healthworker@buegas.com
-- Password: healthworker123

USE buegas_db;

-- Insert health worker user
-- Password hash for 'healthworker123' using PHP password_hash()
INSERT INTO users (email, password_hash, role, first_name, last_name, contact_number, status, created_at, updated_at)
VALUES (
    'healthworker@buegas.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', -- password: healthworker123
    'healthworker',
    'Maria',
    'Santos',
    '09123456789',
    'active',
    NOW(),
    NOW()
);

-- Get the inserted user ID
SET @healthworker_id = LAST_INSERT_ID();

-- Display the created account details
SELECT 
    id,
    email,
    role,
    CONCAT(first_name, ' ', last_name) as full_name,
    contact_number,
    status,
    created_at
FROM users 
WHERE id = @healthworker_id;

-- Success message
SELECT 'Health Worker account created successfully!' as message,
       'Email: healthworker@buegas.com' as login_email,
       'Password: healthworker123' as login_password;

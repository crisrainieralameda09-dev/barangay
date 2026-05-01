-- Sample Health Worker Accounts
-- Use these accounts for testing the health worker platform

USE buegas_db;

-- Health Worker 1: Maria Santos
-- Email: healthworker@buegas.com
-- Password: healthworker123
INSERT INTO users (email, password_hash, role, first_name, last_name, contact_number, status, created_at, updated_at)
VALUES (
    'healthworker@buegas.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'healthworker',
    'Maria',
    'Santos',
    '09123456789',
    'active',
    NOW(),
    NOW()
);

-- Health Worker 2: Juan Dela Cruz
-- Email: juan.delacruz@buegas.com
-- Password: healthworker123
INSERT INTO users (email, password_hash, role, first_name, last_name, contact_number, status, created_at, updated_at)
VALUES (
    'juan.delacruz@buegas.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'healthworker',
    'Juan',
    'Dela Cruz',
    '09234567890',
    'active',
    NOW(),
    NOW()
);

-- Health Worker 3: Ana Reyes
-- Email: ana.reyes@buegas.com
-- Password: healthworker123
INSERT INTO users (email, password_hash, role, first_name, last_name, contact_number, status, created_at, updated_at)
VALUES (
    'ana.reyes@buegas.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'healthworker',
    'Ana',
    'Reyes',
    '09345678901',
    'active',
    NOW(),
    NOW()
);

-- Display all created health worker accounts
SELECT 
    id,
    email,
    role,
    CONCAT(first_name, ' ', last_name) as full_name,
    contact_number,
    status,
    created_at
FROM users 
WHERE role = 'healthworker'
ORDER BY id DESC;

-- Login credentials summary
SELECT 'Health Worker Accounts Created!' as message;
SELECT '================================' as separator;
SELECT 'Account 1:' as account, 'healthworker@buegas.com' as email, 'healthworker123' as password;
SELECT 'Account 2:' as account, 'juan.delacruz@buegas.com' as email, 'healthworker123' as password;
SELECT 'Account 3:' as account, 'ana.reyes@buegas.com' as email, 'healthworker123' as password;
SELECT '================================' as separator;
SELECT 'All passwords are: healthworker123' as note;

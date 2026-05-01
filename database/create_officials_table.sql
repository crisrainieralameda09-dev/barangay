    -- Create barangay_officials table
    CREATE TABLE IF NOT EXISTS barangay_officials (
        id INT(11) AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        position VARCHAR(255) NOT NULL,
        committee VARCHAR(255) DEFAULT NULL,
        phone VARCHAR(50) DEFAULT NULL,
        email VARCHAR(255) DEFAULT NULL,
        photo_path VARCHAR(255) DEFAULT NULL,
        display_order INT(11) DEFAULT 0,
        official_type ENUM('captain', 'sk_chairman', 'kagawad', 'secretary', 'treasurer', 'other') DEFAULT 'kagawad',
        is_active TINYINT(1) DEFAULT 1,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        deleted_at TIMESTAMP NULL DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

    -- Insert default officials data
    INSERT INTO barangay_officials (name, position, committee, phone, email, photo_path, display_order, official_type) VALUES
    ('Hon. ASAHEL P. GAYATIN', 'Barangay Captain', NULL, '(123) 456-7890', 'captain@buegas.gov.ph', 'images/Captain.jpeg', 1, 'captain'),
    ('Hon. JULIANAE V. LAVADIA', 'SK Chairman', NULL, '(123) 456-7898', 'sk@buegas.gov.ph', 'images/skchairman.jpg', 2, 'sk_chairman'),
    ('Hon. RODEL P. PONDALES', 'Barangay Kagawad', 'Committee on Livelihood and Cooperative', '(123) 456-7891', NULL, 'images/kagawad1.jpeg', 3, 'kagawad'),
    ('Hon. ALEX B. PEÑAFLOR', 'Barangay Kagawad', 'Committee on Peace and Order and Environmental Protection', '(123) 456-7892', NULL, 'images/kagawad2.jpeg', 4, 'kagawad'),
    ('Hon. MA.JIJI E. BALBOA', 'Barangay Kagawad', 'Committee on Education and Culture', '(123) 456-7893', NULL, 'images/kagawad3.jpeg', 5, 'kagawad'),
    ('Hon. RAMON A. BARAYOGA', 'Barangay Kagawad', 'Committee on Health and Nutrition', '(123) 456-7894', NULL, 'images/kagawad5.jpeg', 6, 'kagawad'),
    ('Hon. NELSON P. DAVID, JR.', 'Barangay Kagawad', 'Committee on Budget and Finance and Infrastructure', '(123) 456-7895', NULL, 'images/kagawad6.jpeg', 7, 'kagawad'),
    ('Hon. RICHARD B. TAPARANO', 'Barangay Kagawad', 'Committee on Ways and Means and Tourism Affairs', '(123) 456-7896', NULL, 'images/kagawad4.jpeg', 8, 'kagawad'),
    ('Hon. AMALIA A. MAQUILING', 'Barangay Kagawad', 'Committee on Women and Family', '(123) 456-7897', NULL, 'images/kagawad7.jpeg', 9, 'kagawad'),
    ('PRECIOUS GIL L. BINABAE', 'Barangay Secretary', NULL, '(123) 456-7899', NULL, 'images/secretary.jpeg', 10, 'secretary'),
    ('SANTIAGO M. DEGALA, JR.', 'Barangay Treasurer', NULL, '(123) 456-7800', NULL, 'images/treasurer.jpeg', 11, 'treasurer');
    
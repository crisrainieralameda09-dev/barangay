# Barangay Buegas Management System - Complete Guide

## System Overview

A comprehensive barangay management system with three user roles:
- **Admin** - Full system management
- **Health Worker** - Healthcare and aid distribution
- **Citizen** - Access services and information

## Quick Start

### 1. Create All Accounts

Visit these URLs to create accounts automatically:

```
http://localhost/system/create_healthworker.php
http://localhost/system/create_citizen.php
```

### 2. Login

Go to: `http://localhost/system/index.php`

Use credentials from `QUICK_LOGIN_CREDENTIALS.txt`

### 3. Explore

Each role will be redirected to their respective dashboard.

## System Architecture

### Three-Tier Role System

```
┌─────────────────────────────────────────────────────────────┐
│                         ADMIN                               │
│  - Full system access                                       │
│  - Manage all users                                         │
│  - Process document requests                                │
│  - Handle incident reports                                  │
│  - Post announcements                                       │
│  - Generate reports                                         │
│  - View analytics                                           │
│  - System settings                                          │
└─────────────────────────────────────────────────────────────┘
                              │
                ┌─────────────┴─────────────┐
                │                           │
┌───────────────▼──────────────┐  ┌────────▼──────────────────┐
│      HEALTH WORKER           │  │        CITIZEN            │
│  - Manage appointments       │  │  - View profile           │
│  - Update health profiles    │  │  - Request documents      │
│  - Distribute aid            │  │  - View appointments      │
│  - View citizen records      │  │  - View aid received      │
│  - Generate reports          │  │  - Report incidents       │
│  - View announcements        │  │  - View announcements     │
│  - Receive notifications     │  │  - Receive notifications  │
└──────────────────────────────┘  └───────────────────────────┘
```

## Database Structure

### Core Tables

1. **users** - All user accounts (admin, healthworker, citizen)
2. **citizens** - Citizen-specific information
3. **health_profiles** - Medical information
4. **document_requests** - Certificate/clearance requests
5. **summons_reports** - Incident reports
6. **announcements** - Public announcements
7. **appointments** - Health checkups/vaccinations
8. **aid_distribution** - Medicine/food/financial aid
9. **notifications** - In-app notifications
10. **reports** - Generated reports

## Features by Role

### Admin Features

**Dashboard**
- System statistics
- Pending requests count
- Upcoming appointments
- New incident reports

**Citizen Management**
- Add/edit/delete citizens
- Manage health profiles
- View vulnerable sectors (seniors, PWD, pregnant)

**Document Requests**
- Process clearance requests
- Approve/reject requests
- Add remarks
- Track status

**Summons & Reports**
- View incident reports
- Update investigation status
- Set urgency levels
- Close cases

**Announcements**
- Create announcements
- Target specific audiences
- Set expiration dates
- Edit/delete posts

**Healthcare & Social Services**
- Manage appointments
- Track aid distribution
- View health statistics

**Reports & Analytics**
- Generate various reports
- View charts and graphs
- Export data
- Track trends

**User Management**
- Add health workers
- Manage user accounts
- Set permissions
- Deactivate users

**System Settings**
- Configure barangay info
- Change password
- System preferences
- Database maintenance

### Health Worker Features

**Dashboard**
- Personal statistics
- Today's appointments
- Aid distributed
- Quick actions

**My Appointments**
- Create appointments
- View schedule
- Mark as completed
- Add notes

**Citizen Health Records**
- View citizen list (read-only)
- Update health profiles
- Add medical information
- View vulnerable sectors

**Aid Distribution**
- Record aid given
- Track medicine distribution
- Log food assistance
- Record financial aid

**Announcements**
- View all announcements
- Read targeted messages

**Notifications**
- Appointment reminders
- System notifications

**Reports & Statistics**
- Generate personal reports
- View performance metrics
- Track monthly statistics
- View charts

**Profile & Settings**
- Update personal info
- Change password
- Configure preferences

### Citizen Features

**Dashboard**
- Personal statistics
- Quick actions
- Recent announcements
- Personal information

**My Profile**
- Update information
- Change password
- Modify contact details

**My Health Record**
- View health profile
- See appointment history
- Track medical records

**Document Requests**
- Request documents
- Track request status
- View history

**My Appointments**
- View all appointments
- See schedule
- Check status

**Aid Received**
- View aid history
- Track distributions

**Report Incident**
- File reports
- Submit concerns
- Track status

**Announcements**
- View public notices
- Read updates

**Notifications**
- Receive alerts
- Read messages

**Settings**
- Configure preferences
- View account info

## Setup Instructions

### Prerequisites

- PHP 7.4 or higher
- MySQL 5.7 or higher
- Apache/Nginx web server
- Web browser

### Installation Steps

1. **Database Setup**
   ```sql
   - Import database/Buegas.sql
   - Database name: buegas_db
   ```

2. **Configure Connection**
   ```php
   - Edit system/includes/conn.php
   - Set database credentials
   ```

3. **Create Accounts**
   ```
   - Visit create_healthworker.php
   - Visit create_citizen.php
   - Or run SQL scripts
   ```

4. **Login**
   ```
   - Go to system/index.php
   - Use credentials from guide
   ```

5. **Security**
   ```
   - Change default passwords
   - Delete create_*.php files
   - Set proper file permissions
   ```

## Default Credentials

### Admin
- Email: admin@buegas.com
- Password: admin123

### Health Worker
- Email: healthworker@buegas.com
- Password: healthworker123

### Citizen
- Email: citizen@buegas.com
- Password: citizen123

## File Organization

```
basic_crud/
├── database/
│   ├── Buegas.sql
│   ├── create_healthworker_account.sql
│   └── sample_healthworkers.sql
├── system/
│   ├── includes/
│   │   ├── conn.php
│   │   ├── session.php
│   │   ├── session_healthworker.php
│   │   ├── session_citizen.php
│   │   ├── header.php
│   │   ├── footer.php
│   │   ├── navbar.php
│   │   ├── sidebar.php
│   │   ├── sidebar_healthworker.php
│   │   ├── sidebar_citizen.php
│   │   └── *_modal.php files
│   ├── Admin files (home.php, citizen.php, etc.)
│   ├── Health Worker files (healthworker_*.php)
│   ├── Citizen files (citizen_*.php)
│   ├── create_healthworker.php
│   ├── create_citizen.php
│   ├── login.php
│   └── index.php
├── QUICK_LOGIN_CREDENTIALS.txt
├── HEALTHWORKER_SETUP.md
├── CITIZEN_SETUP.md
└── COMPLETE_SYSTEM_GUIDE.md (this file)
```

## Security Best Practices

1. **Change Default Passwords**
   - All default passwords are for testing only
   - Use strong passwords in production

2. **Delete Setup Files**
   - Remove create_*.php after setup
   - Delete check_*.php files

3. **Database Security**
   - Use strong database passwords
   - Limit database user permissions
   - Regular backups

4. **File Permissions**
   - Set proper file permissions
   - Protect sensitive files
   - Secure uploads directory

5. **SSL/HTTPS**
   - Use HTTPS in production
   - Secure cookie settings
   - Enable secure headers

## Troubleshooting

### Common Issues

**Can't Login**
- Check database connection
- Verify account exists
- Check password hash
- Clear browser cache

**Wrong Redirect**
- Check user role in database
- Verify login.php logic
- Clear session data

**Missing Features**
- Check file uploads
- Verify database tables
- Check file permissions

**Database Errors**
- Check connection settings
- Verify table structure
- Check SQL syntax

### Error Logs

Check these locations:
- PHP error log
- Apache/Nginx error log
- Browser console
- Database logs

## Support & Documentation

- **Quick Reference:** QUICK_LOGIN_CREDENTIALS.txt
- **Health Worker Guide:** HEALTHWORKER_SETUP.md
- **Citizen Guide:** CITIZEN_SETUP.md
- **This Guide:** COMPLETE_SYSTEM_GUIDE.md

## Future Enhancements

Potential features to add:
- SMS integration
- Email notifications
- PDF generation for documents
- Online payment
- Mobile app
- QR code scanning
- Biometric authentication
- Advanced analytics
- Export to Excel
- Backup automation

## License & Credits

**System:** Barangay Buegas Management System
**Version:** 1.0
**Created:** February 2026
**Purpose:** Barangay service management and citizen engagement

---

**For technical support, contact your system administrator.**

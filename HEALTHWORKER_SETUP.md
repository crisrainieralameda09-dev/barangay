# Health Worker Account Setup Guide

## Quick Setup (Recommended)

### Option 1: Using PHP Script (Easiest)

1. Open your browser and navigate to:
   ```
   http://localhost/system/create_healthworker.php
   ```
   OR
   ```
   http://localhost/basic_crud/system/create_healthworker.php
   ```

2. The script will automatically create a health worker account

3. You'll see the login credentials on the success page

4. Click "Go to Login Page" and log in with the provided credentials

### Option 2: Using SQL Script

1. Open phpMyAdmin or your MySQL client

2. Select the `buegas_db` database

3. Run one of these SQL files:
   - `database/create_healthworker_account.sql` - Creates 1 account
   - `database/sample_healthworkers.sql` - Creates 3 accounts

4. Go to the login page and use the credentials below

## Default Health Worker Accounts

### Account 1 (Primary)
- **Email:** healthworker@buegas.com
- **Password:** healthworker123
- **Name:** Maria Santos
- **Contact:** 09123456789

### Account 2 (Optional)
- **Email:** juan.delacruz@buegas.com
- **Password:** healthworker123
- **Name:** Juan Dela Cruz
- **Contact:** 09234567890

### Account 3 (Optional)
- **Email:** ana.reyes@buegas.com
- **Password:** healthworker123
- **Name:** Ana Reyes
- **Contact:** 09345678901

## Login Instructions

1. Go to: `http://localhost/system/index.php`

2. Enter the email and password from above

3. Click "Sign In"

4. You will be automatically redirected to the Health Worker Dashboard

## Health Worker Platform Features

Once logged in, you'll have access to:

### Dashboard
- View scheduled appointments
- See completed appointments today
- Track aid distributed this month
- Monitor vulnerable sector citizens
- Quick action buttons

### My Appointments
- Create new appointments
- View all your appointments
- Edit appointment details
- Mark appointments as completed
- Cancel appointments

### Citizen Health Records
- View all citizen records (read-only)
- Access health profiles
- Update health information
- View vulnerable sectors (seniors, PWD, pregnant)

### Aid Distribution
- Record new aid distribution
- Track medicine distribution
- Log food assistance
- Record financial aid
- View distribution history

### Announcements
- View all announcements
- Read announcements targeted to health workers
- Stay updated with barangay news

### Notifications
- Receive appointment reminders
- Get system notifications
- Mark notifications as read

### Reports & Statistics
- Generate personal reports
- View appointment statistics
- Track aid distribution metrics
- Monitor monthly performance
- View charts and analytics

### Profile & Settings
- Update personal information
- Change password
- Configure notification preferences
- Set appointment reminders

## Security Notes

⚠️ **Important:**
1. Change the default password after first login
2. Delete `create_healthworker.php` after creating accounts
3. Use strong passwords in production
4. Keep your credentials secure

## Troubleshooting

### Can't log in?
- Make sure you ran the SQL script or PHP script
- Check that the database `buegas_db` exists
- Verify the email and password are correct
- Ensure the account status is 'active'

### Redirected to wrong page?
- Clear browser cache and cookies
- Check the `login.php` file for role-based redirection
- Verify the user role is set to 'healthworker'

### Missing features?
- Make sure all health worker files are uploaded
- Check that `includes/sidebar_healthworker.php` exists
- Verify `includes/session_healthworker.php` is present

## File Structure

```
system/
├── healthworker_home.php              # Dashboard
├── healthworker_appointments.php      # Appointments
├── healthworker_citizens.php          # Citizen records
├── healthworker_health_profiles.php   # Health profiles
├── healthworker_vulnerable_sectors.php # Vulnerable sectors
├── healthworker_aid_distribution.php  # Aid distribution
├── healthworker_announcements.php     # Announcements
├── healthworker_notifications.php     # Notifications
├── healthworker_reports.php           # Reports
├── healthworker_statistics.php        # Statistics
├── healthworker_profile.php           # Profile
├── healthworker_settings.php          # Settings
└── includes/
    ├── session_healthworker.php       # Auth
    ├── sidebar_healthworker.php       # Menu
    ├── healthworker_appointments_modal.php
    ├── healthworker_aid_distribution_modal.php
    └── healthworker_notifications_modal.php
```

## Support

If you encounter any issues:
1. Check the browser console for JavaScript errors
2. Check PHP error logs
3. Verify database connection in `includes/conn.php`
4. Ensure all files are uploaded correctly

## Next Steps

After logging in:
1. Update your profile information
2. Change your password
3. Explore the dashboard
4. Create a test appointment
5. Record a test aid distribution
6. Generate a sample report

---

**Created:** February 2026
**System:** Barangay Buegas Management System
**Version:** 1.0

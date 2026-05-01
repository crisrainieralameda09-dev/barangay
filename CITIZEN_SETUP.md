# Citizen Portal Setup Guide

## Quick Setup (Recommended)

### Option 1: Using PHP Script (Easiest)

1. Open your browser and navigate to:
   ```
   http://localhost/system/create_citizen.php
   ```

2. The script will automatically create a citizen account with profile

3. You'll see the login credentials on the success page

4. Click "Go to Login Page" and log in

### Option 2: Using SQL Script

1. Open phpMyAdmin or your MySQL client

2. Select the `buegas_db` database

3. Run the SQL file: `database/sample_citizens.sql`

4. Go to the login page and use the credentials below

## Default Citizen Account

### Primary Account
- **Email:** citizen@buegas.com
- **Password:** citizen123
- **Name:** Juan Dela Cruz
- **Contact:** 09987654321
- **Birthdate:** May 15, 1990
- **Gender:** Male
- **Civil Status:** Single

## Login Instructions

1. Go to: `http://localhost/system/index.php`

2. Enter the email and password

3. Click "Sign In"

4. You will be automatically redirected to the Citizen Portal

## Citizen Portal Features

### Dashboard
- View pending document requests
- See upcoming appointments
- Track aid received
- View incident reports
- Quick action buttons
- Recent announcements
- Personal information summary

### My Profile
- Update personal information
- Change password
- Update contact details
- Modify address

### My Health Record
- View health profile (blood type, allergies, etc.)
- View appointment history
- Track health checkups
- View vaccination records

### Document Requests
- **Request Document**
  - Barangay Clearance
  - Certificate of Residency
  - Certificate of Indigency
  - Other documents
- **My Requests**
  - Track request status
  - View pending requests
  - See completed requests
  - Check remarks from admin

### My Appointments
- View all appointments
- See scheduled appointments
- Check appointment history
- View health worker assigned
- Read appointment notes

### Aid Received
- View aid distribution history
- Track medicine received
- See food assistance
- View financial aid
- Check distribution dates

### Report Incident
- File incident reports
- Submit concerns
- Report summons
- Set urgency level
- Track report status

### Announcements
- View barangay announcements
- Read public notices
- Stay updated with community news
- See targeted announcements

### Notifications
- Receive appointment reminders
- Get request updates
- View system notifications
- Mark as read/unread

### Settings
- Configure notification preferences
- Enable/disable email notifications
- Set SMS preferences
- View account information

## Security Notes

⚠️ **Important:**
1. Change the default password after first login
2. Delete `create_citizen.php` after creating accounts
3. Use strong passwords in production
4. Keep your credentials secure
5. Don't share your account with others

## Troubleshooting

### Can't log in?
- Make sure you ran the SQL script or PHP script
- Check that the database `buegas_db` exists
- Verify the email and password are correct
- Ensure the account status is 'active'
- Check that citizen profile was created

### Redirected to wrong page?
- Clear browser cache and cookies
- Check the `login.php` file for role-based redirection
- Verify the user role is set to 'citizen'

### Missing features?
- Make sure all citizen files are uploaded
- Check that `includes/sidebar_citizen.php` exists
- Verify `includes/session_citizen.php` is present
- Ensure citizen record exists in database

### No citizen profile found?
- Check if citizen record exists in `citizens` table
- Verify `user_id` matches in both tables
- Run the create script again
- Contact administrator

## File Structure

```
system/
├── citizen_portal.php              # Dashboard
├── citizen_profile.php             # Profile management
├── citizen_health_record.php       # Health records
├── citizen_request_document.php    # Request documents
├── citizen_my_requests.php         # Track requests
├── citizen_appointments.php        # View appointments
├── citizen_aid_received.php        # Aid history
├── citizen_report_incident.php     # Report incidents
├── citizen_announcements.php       # View announcements
├── citizen_notifications.php       # Notifications
├── citizen_settings.php            # Settings
└── includes/
    ├── session_citizen.php         # Auth
    └── sidebar_citizen.php         # Menu
```

## Citizen Workflow Examples

### Requesting a Document

1. Login to citizen portal
2. Click "Request Document" or use quick action
3. Select document type (e.g., Barangay Clearance)
4. Enter purpose
5. Submit request
6. Track status in "My Requests"
7. Receive notification when processed

### Reporting an Incident

1. Go to "Report Incident"
2. Select report type (Summon/Incident/Concern)
3. Describe the incident in detail
4. Set incident date
5. Choose urgency level
6. Submit report
7. Barangay office will review and respond

### Viewing Health Records

1. Click "My Health Record"
2. View health profile information
3. Check appointment history
4. See health worker notes
5. Track medical history

## Support

If you encounter any issues:
1. Check the browser console for JavaScript errors
2. Check PHP error logs
3. Verify database connection in `includes/conn.php`
4. Ensure all files are uploaded correctly
5. Contact barangay administrator

## Next Steps

After logging in:
1. Update your profile information
2. Change your password
3. Explore the dashboard
4. Request a test document
5. View announcements
6. Check your health record

## Privacy & Data Protection

- Your personal information is protected
- Only authorized personnel can access your data
- Health records are confidential
- Document requests are secure
- Report your concerns safely

---

**Created:** February 2026
**System:** Barangay Buegas Management System
**Version:** 1.0

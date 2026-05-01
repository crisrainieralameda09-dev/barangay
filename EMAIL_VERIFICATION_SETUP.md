# Email Verification System - Setup Guide

## Overview
The registration system now includes email verification using PHPMailer with SMTP. Users must verify their email address before they can log in to the system.

## Features Implemented

### 1. Email Verification Flow
- User registers with email and password
- System generates 6-digit verification code
- Verification code sent to user's email via SMTP
- User enters code on verification page
- Account activated upon successful verification
- Unverified users cannot log in

### 2. Security Features
- Verification codes expire after 30 minutes
- Codes are randomly generated (6 digits)
- Account status set to 'pending' until verified
- Email verification status tracked in database
- Resend code functionality with 60-second cooldown

### 3. User Management (Admin)
- Add new users (auto-verified)
- Edit user information
- Delete users (soft delete)
- View all users with status
- Prevent self-deletion

## Database Changes Required

Run this SQL file to add email verification fields:
```sql
database/add_email_verification.sql
```

This adds:
- `email_verified` TINYINT(1) - Verification status (0 or 1)
- `verification_code` VARCHAR(6) - 6-digit code
- `verification_code_expires` DATETIME - Expiration timestamp

## PHPMailer Setup

### Step 1: Install PHPMailer

**Option A: Using Composer (Recommended)**
```bash
cd /path/to/your/project
composer require phpmailer/phpmailer
```

**Option B: Manual Installation**
1. Download PHPMailer from: https://github.com/PHPMailer/PHPMailer/releases
2. Extract to `system/includes/PHPMailer/`
3. Ensure these files exist:
   - `system/includes/PHPMailer/PHPMailer.php`
   - `system/includes/PHPMailer/SMTP.php`
   - `system/includes/PHPMailer/Exception.php`

### Step 2: Configure SMTP Settings

Edit `system/includes/phpmailer_config.php`:

```php
define('SMTP_HOST', 'smtp.gmail.com');
define('SMTP_PORT', 587);
define('SMTP_USERNAME', 'your-email@gmail.com');
define('SMTP_PASSWORD', 'your-app-password');
define('SMTP_FROM_EMAIL', 'your-email@gmail.com');
define('SMTP_FROM_NAME', 'Barangay Buegas');
```

### Step 3: Gmail Setup (If using Gmail)

1. Enable 2-Factor Authentication:
   - Go to Google Account settings
   - Security → 2-Step Verification → Turn On

2. Generate App Password:
   - Go to: https://myaccount.google.com/apppasswords
   - Select app: Mail
   - Select device: Other (Custom name)
   - Enter: "Barangay Buegas System"
   - Click Generate
   - Copy the 16-character password
   - Use this as `SMTP_PASSWORD` in config

3. Allow Less Secure Apps (if needed):
   - Go to: https://myaccount.google.com/lesssecureapps
   - Turn ON (not recommended, use App Password instead)

### Step 4: Other Email Providers

**Outlook/Hotmail:**
```php
define('SMTP_HOST', 'smtp.office365.com');
define('SMTP_PORT', 587);
```

**Yahoo:**
```php
define('SMTP_HOST', 'smtp.mail.yahoo.com');
define('SMTP_PORT', 587);
```

**Custom Domain/cPanel:**
- Check with your hosting provider for SMTP settings
- Usually: `mail.yourdomain.com` or `smtp.yourdomain.com`
- Port: 587 (TLS) or 465 (SSL)

## Files Created/Modified

### New Files:
1. **system/includes/phpmailer_config.php** - SMTP configuration
2. **system/includes/send_email.php** - Email sending functions
3. **system/verify_email.php** - Verification page with code input
4. **system/verify_email_process.php** - Processes verification code
5. **system/resend_verification.php** - Resends verification code
6. **system/users_row.php** - Fetches user data for modals
7. **system/users_add.php** - Adds new user
8. **system/users_edit.php** - Edits user information
9. **system/users_delete.php** - Soft deletes user
10. **database/add_email_verification.sql** - Database migration

### Modified Files:
1. **system/register_process.php** - Generates code and sends email
2. **system/login.php** - Checks email verification status
3. **system/users.php** - Added delete button functionality
4. **system/includes/users_modal.php** - Enhanced delete modal

## How It Works

### Registration Flow:
1. User fills registration form
2. System validates input
3. Creates user account with `status='pending'` and `email_verified=0`
4. Generates 6-digit verification code
5. Sets expiration time (30 minutes)
6. Sends email with verification code
7. Redirects to verification page
8. User enters 6-digit code
9. System validates code and expiration
10. Updates `email_verified=1` and `status='active'`
11. User can now log in

### Login Flow:
1. User enters email and password
2. System checks if account exists
3. Verifies password
4. **Checks if email is verified**
5. If not verified, shows error message
6. If verified, allows login

### Resend Code Flow:
1. User clicks "Resend Code" button
2. 60-second cooldown timer starts
3. System generates new code
4. Updates database with new code and expiration
5. Sends new email
6. User can enter new code

## User Management Features

### Add User (Admin):
- Admin can create users directly
- Users created by admin are auto-verified
- No email verification required
- Can set role: Admin, Health Worker, or Citizen
- Can set status: Active or Inactive

### Edit User (Admin):
- Update user information
- Change role
- Change status
- Email uniqueness validated
- If role changed to citizen, creates citizen profile

### Delete User (Admin):
- Soft delete (sets `deleted_at` timestamp)
- Cannot delete own account
- Shows confirmation with user details
- Deactivates account
- If citizen, also soft deletes citizen profile
- Creates notification for record keeping

## Testing Checklist

### Email Verification:
- [ ] Run database migration SQL
- [ ] Configure SMTP settings in phpmailer_config.php
- [ ] Install PHPMailer (Composer or manual)
- [ ] Register new account
- [ ] Check email inbox for verification code
- [ ] Enter code on verification page
- [ ] Verify account is activated
- [ ] Try logging in with verified account
- [ ] Try logging in with unverified account (should fail)
- [ ] Test resend code functionality
- [ ] Test expired code (wait 30+ minutes)

### User Management:
- [ ] Admin can add new user
- [ ] Admin can edit user
- [ ] Admin can delete user
- [ ] Cannot delete own account
- [ ] Deleted users cannot log in
- [ ] User list shows correct information

## Troubleshooting

### Email Not Sending:

**Check 1: PHPMailer Installation**
```php
// Add to verify_email_process.php temporarily
if (file_exists(__DIR__ . '/vendor/autoload.php')) {
    echo "PHPMailer found via Composer";
} elseif (file_exists(__DIR__ . '/includes/PHPMailer/PHPMailer.php')) {
    echo "PHPMailer found manually";
} else {
    echo "PHPMailer NOT FOUND!";
}
```

**Check 2: SMTP Credentials**
- Verify email and password are correct
- For Gmail, use App Password, not regular password
- Check if 2FA is enabled

**Check 3: Firewall/Port**
- Ensure port 587 (TLS) or 465 (SSL) is open
- Check with hosting provider

**Check 4: Error Logs**
- Check PHP error logs
- Enable error display temporarily:
```php
ini_set('display_errors', 1);
error_reporting(E_ALL);
```

### Verification Code Not Working:

**Check 1: Code Expiration**
- Codes expire after 30 minutes
- Use resend code feature

**Check 2: Database**
- Verify code is stored in database
- Check expiration timestamp

**Check 3: Session**
- Ensure session variables are set
- Check `$_SESSION['pending_verification_user_id']`

### Login Issues:

**Check 1: Email Verified**
- Check database: `email_verified` should be 1
- Check status: should be 'active'

**Check 2: Account Status**
- Verify account is not deleted (`deleted_at` is NULL)
- Verify status is 'active'

## Security Considerations

1. **SMTP Credentials**: Never commit phpmailer_config.php to version control
2. **App Passwords**: Use Gmail App Passwords, not regular passwords
3. **Code Expiration**: Codes expire after 30 minutes
4. **Rate Limiting**: Consider adding rate limiting for resend code
5. **Soft Delete**: Users are soft deleted, not permanently removed
6. **Password Hashing**: All passwords are hashed with bcrypt

## Future Enhancements

Potential improvements:
- Email verification link instead of code
- SMS verification option
- Two-factor authentication (2FA)
- Password reset via email
- Email notifications for account changes
- Bulk user import
- User activity logs
- Account recovery options

## Support

For issues or questions:
1. Check error logs
2. Verify SMTP configuration
3. Test with different email provider
4. Check database structure
5. Review session variables

## Configuration Example

Complete working example for Gmail:

```php
// system/includes/phpmailer_config.php
define('SMTP_HOST', 'smtp.gmail.com');
define('SMTP_PORT', 587);
define('SMTP_USERNAME', 'barangaybuegas@gmail.com');
define('SMTP_PASSWORD', 'abcd efgh ijkl mnop'); // 16-char App Password
define('SMTP_FROM_EMAIL', 'barangaybuegas@gmail.com');
define('SMTP_FROM_NAME', 'Barangay Buegas');
```

## Important Notes

1. **First Time Setup**: May take 5-10 minutes for Gmail to activate App Password
2. **Testing**: Use real email addresses for testing
3. **Spam Folder**: Check spam/junk folder if email not received
4. **Production**: Use professional email service for production (SendGrid, Mailgun, etc.)
5. **Backup**: Always backup database before running migrations

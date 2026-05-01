# Email Notification System Guide

## Overview
A new email notification system has been implemented to automatically send approval notifications to users' registered email addresses when their account requests are approved by administrators.

## Implementation Details

### 📧 New Function: `sendApprovalNotificationEmail()`

**Location:** `system/includes/send_email.php`

**Parameters:**
```php
sendApprovalNotificationEmail(
    $to_email,           // User's registered email address
    $to_name,            // User's full name
    $request_type,       // Type of request (document, pwd_verification, account, appointment, etc.)
    $request_details     // Array with approval details
)
```

**Request Details Array Options:**
```php
[
    'document_type'   => 'Barangay Clearance',           // For document requests
    'pwd_id'          => 'PWD-2024-00123',               // For PWD verification
    'appointment_date' => 'April 15, 2024 at 2:00 PM',  // For appointments
    'approval_date'   => date('F j, Y'),                // Approval date (auto-generated)
    'approved_by'     => 'Admin Name',                  // Name of approving admin (auto-generated)
    'remarks'         => 'Additional notes/remarks'      // Optional: approval message
]
```

**Return Value:**
```php
[
    'success' => true/false,
    'message' => 'Success or error message'
]
```

## Supported Request Types

### 1. **Document Requests**
When a citizen's document request is approved or completed:
```php
sendApprovalNotificationEmail(
    $citizen_email,
    $citizen_name,
    'document_request',
    [
        'document_type' => 'Birth Certificate',
        'approval_date' => date('F j, Y'),
        'approved_by' => $_SESSION['name'],
        'remarks' => 'Document is ready for pickup'
    ]
);
```

### 2. **PWD Verification Requests**
When a PWD verification request is approved:
```php
sendApprovalNotificationEmail(
    $user_email,
    $user_name,
    'pwd_verification',
    [
        'pwd_id' => 'PWD-2026-00456',
        'approval_date' => date('F j, Y'),
        'approved_by' => $_SESSION['name'],
        'remarks' => 'Your disability verification has been confirmed'
    ]
);
```

### 3. **Account Requests**
When a new account request is approved:
```php
sendApprovalNotificationEmail(
    $user_email,
    $user_name,
    'account_request',
    [
        'approval_date' => date('F j, Y'),
        'approved_by' => 'System Administrator'
    ]
);
```

### 4. **Appointment Requests**
When an appointment is approved:
```php
sendApprovalNotificationEmail(
    $user_email,
    $user_name,
    'appointment_request',
    [
        'appointment_date' => 'May 1, 2024 at 10:00 AM',
        'approval_date' => date('F j, Y'),
        'approved_by' => 'Health Worker'
    ]
);
```

## Current Implementation

### ✅ Already Integrated

#### 1. **PWD Verification Module** (`system/pwd_verification_action.php`)
- Sends approval email when admin approves PWD verification request
- Includes PWD ID in email
- Adds in-app notification
- Sends rejection email with reason

#### 2. **Document Requests Module** (`system/document_requests_edit.php`)
- Sends approval/completion email when document status is updated
- Includes document type in email
- Adds in-app notification
- Sends rejection email for rejected requests

## Email Features

### Professional Email Design
- Modern, responsive HTML template
- Barangay Buegas branding with logo
- Green gradient header for approvals
- Red gradient header for rejections
- Clear status indicators with checkmarks/crosses
- Mobile-responsive layout

### Email Sections
1. **Header** - Logo and request title
2. **Success Message** - Highlighted approval status
3. **Action Details** - Next steps and requirements
4. **Remarks Section** - Additional information from admin
5. **Approval Details** - Status, date, and approver
6. **Next Steps Section** - What user should do
7. **Help Section** - Contact information
8. **Footer** - System info and copyright

## Integration Steps

### Step 1: Include the Function
At the top of your approval action file:
```php
<?php
include 'includes/session_admin.php';
include 'includes/conn.php';
include 'includes/send_email.php';  // ← Add this line
```

### Step 2: Get User Details
Before sending email, retrieve the user's email and name:
```php
$user_data = $conn->query("SELECT u.email, u.first_name, u.last_name 
                          FROM users u 
                          WHERE u.id = $user_id LIMIT 1")->fetch_assoc();
```

### Step 3: Call the Function
When approval status is set:
```php
if($new_status === 'approved'){
    $email_result = sendApprovalNotificationEmail(
        $user_data['email'],
        $user_data['first_name'] . ' ' . $user_data['last_name'],
        'document_request',
        [
            'document_type' => $document_type,
            'approval_date' => date('F j, Y'),
            'approved_by' => $_SESSION['name'],
            'remarks' => $admin_remarks
        ]
    );
    
    // Check if email was sent successfully
    if($email_result['success']){
        // Email sent successfully
    } else {
        // Log error: $email_result['message']
    }
}
```

## Testing the System

### Test Without Email Sending (Recommended First)
1. Add debug logging to see if function is called correctly
2. Check that user emails are being retrieved properly
3. Verify database updates happen before email send

### Test Email Sending
1. Ensure SMTP credentials in `system/includes/phpmailer_config.php` are correct
2. Check inbox and spam folder for test emails
3. Verify email content matches request type

### Example Test Case
```php
// For Document Requests
1. Admin opens document_requests.php
2. Admin clicks "Edit" on a pending document request
3. Admin changes status from "pending" to "approved"
4. Admin enters remarks (or leaves empty for default)
5. Admin clicks "Update Request"
6. User should receive approval email within 2-3 seconds

// Check for:
- Email arrives in user's inbox/spam
- Email subject shows "Document Request Approved - Barangay Buegas"
- Email contains document type and remarks
- Email is professionally formatted
```

## Error Handling

### Common Issues

**Issue: Email not sending**
- Solution: Check SMTP credentials in phpmailer_config.php
- Check if user email exists in database
- Check server error logs

**Issue: Email sent but looks plain**
- Solution: Make sure recipient email supports HTML
- Check PHPMailer is properly installed
- Verify email service isn't stripping HTML

**Issue: Email goes to spam**
- Solution: Check SPF/DKIM records
- Verify "From" email matches SMTP configuration
- Add organization name to emails

### Debugging
Enable error logging in `send_email.php`:
```php
// Add this after any sendApprovalNotificationEmail call
if(!$email_result['success']){
    error_log('Email Error: ' . $email_result['message']);
    $_SESSION['email_error'] = $email_result['message'];
}
```

## Rejection Notification

### Automatic Rejection Emails
When a request is rejected, the system automatically sends a rejection email with:
- Clear rejection message
- Reason provided by admin
- Instructions for resubmission
- Contact information

### PWD Verification Rejection Example
Currently implemented in `pwd_verification_action.php`:
```php
// Sends rejection email with admin notes as reason
sendEmail($user_email, $user_name, 'PWD Verification Request - Not Approved', $rejection_body);
```

## Database Schema
The system uses these tables:
- `users` - Contains email addresses
- `document_requests` - Document request workflows
- `pwd_verification_requests` - PWD verification workflows
- `notifications` - In-app notification logs

No new tables are required - the system integrates with existing tables.

## Customization

### Change Email Template
Edit the HTML template in `sendApprovalNotificationEmail()` function in `send_email.php`:
- Modify colors (currently: #228b22 and #008080)
- Change header text
- Add/remove sections
- Customize footer

### Add New Request Type
Add new `case` in the `switch` statement:
```php
case 'your_request_type':
    $request_title = 'Your Request Type Approved';
    $request_message = 'Your request message...';
    $action_text = 'What user should do next...';
    break;
```

### Change Default Approval Message
Modify the default message in `sendApprovalNotificationEmail()`:
```php
default:
    $request_title = 'Request Approved';
    $request_message = "Your request has been <strong>APPROVED</strong>.";
    $action_text = 'Custom action text here...';
```

## Security Considerations

✅ **Already Implemented:**
- Email addresses escaped before database operations
- Names HTML-escaped in email output
- Session validation to ensure only admins can approve
- Error messages don't expose sensitive data

⚠️ **Best Practices:**
1. Always validate user input before processing
2. Never log emails in plain text error messages
3. Use HTTPS for all forms
4. Regularly audit email logs
5. Keep SMTP password secure in config file

## Performance Impact

- Email sending is **synchronous** (waits for response)
- Average email send time: **2-5 seconds**
- Recommended: Add async queue for high-volume systems

### Optimization for Future
```php
// Consider using Mailtrap, SendInBlue, or queue system
// for better performance with large user bases
```

## Troubleshooting Checklist

- [ ] SMTP credentials are correct
- [ ] User email exists in database
- [ ] Include statement for send_email.php is present
- [ ] Request type parameter is correct
- [ ] Email address format is valid
- [ ] PHPMailer is properly installed
- [ ] Server has internet connection
- [ ] No firewall blocking SMTP port 587

## Support & Maintenance

### Log Email Activity
To track sent emails, add logging:
```php
// In send_email.php or where function is called
$email_log = fopen(__DIR__ . '/../../logs/email.log', 'a');
fwrite($email_log, date('Y-m-d H:i:s') . " - Sent to: $to_email - Type: $request_type\n");
fclose($email_log);
```

### Monitor Email Bounces
Check your email provider's delivery reports regularly to identify:
- Invalid email addresses
- Bounced emails
- Spam complaints

## Future Enhancements

Possible additions:
1. **Email Templates UI** - Admin can customize email templates
2. **Email Queue** - Queue emails for async sending
3. **Email History** - Track all sent approval emails
4. **Multi-language Support** - Send emails in different languages
5. **Partial Approvals** - Different email for partial vs full approval
6. **SMS Notifications** - Send SMS in addition to email
7. **Calendar Integration** - Add appointment to user's calendar

## Summary

The email notification system is now fully integrated and ready to use:
- ✅ PWD verification module sends emails
- ✅ Document requests module sends emails
- ✅ Professional HTML email templates included
- ✅ Rejection emails with reasons
- ✅ In-app notifications alongside emails
- ✅ Easy to extend to other modules

For questions or issues, contact your system administrator.

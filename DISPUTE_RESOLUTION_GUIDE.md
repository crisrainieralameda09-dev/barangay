# Barangay Dispute Resolution System - Complete Guide

## Overview
The Barangay Dispute Resolution System follows Philippine Katarungang Pambarangay standards for handling disputes, summons, and community concerns at the barangay level.

---

## Database Update Required

Before using the updated system, you MUST run the SQL update file:

```sql
-- Run this file in your database
database/update_summons_reports_table.sql
```

This will:
- Add `respondent_name`, `respondent_address`, `respondent_contact` columns
- Add `reference_number` column with index
- Update `report_type` ENUM with new Philippine dispute types
- Update `status` ENUM with mediation-specific statuses

---

## Features

### 1. Philippine-Standard Request Types

**Dispute Resolution:**
- Request for Summons (Dispute with Neighbor/Resident)
- Request for Mediation/Conciliation
- Follow-up on Settlement Agreement

**Community Concerns:**
- Report Incident/Disturbance
- Noise Complaint
- Property Boundary Dispute
- Other Community Concern

### 2. Unique Reference Number System

Every request automatically generates a unique reference number:
- Format: `BDR-YYYYMMDD-XXXX`
- Example: `BDR-20260220-1234`
- BDR = Barangay Dispute Resolution
- Automatically checked for uniqueness

### 3. Respondent Information (Optional)

For summons and mediation requests, citizens can provide:
- Respondent Name (other party's name)
- Respondent Address (within barangay)
- Respondent Contact (phone or email)

These fields appear automatically when selecting "Summon" or "Mediation Request" types.

### 4. Urgency Levels

- **Low** - Can wait for regular schedule
- **Medium** - Needs attention soon (default)
- **High** - Urgent matter
- **Critical** - Immediate attention required

### 5. Philippine-Standard Status Tracking

**For Citizens:**
- New - Pending Review
- For Mediation
- Mediation Scheduled
- Settled/Resolved
- No Settlement Reached
- Under Investigation
- Resolved
- Closed

**Status Badges:**
- New: Blue (Primary)
- For Mediation: Light Blue (Info)
- Mediation Scheduled: Yellow (Warning)
- Settled: Green (Success)
- No Settlement: Red (Danger)
- Investigating: Yellow (Warning)
- Resolved: Green (Success)
- Closed: Gray (Default)

---

## Citizen Features

### Filing a Request

1. Navigate to "Request Summons" in sidebar
2. Read the information about Katarungang Pambarangay
3. Fill out the form:
   - Select request type
   - Choose urgency level
   - Enter incident/dispute date (cannot be future date)
   - Provide detailed description
   - If summons/mediation: Add respondent information
4. Review important reminders
5. Submit request

### After Submission

- Success message shows your unique reference number
- Save this reference number for tracking
- View your request in "My Previous Requests" table
- Check status updates from barangay officials

### Previous Requests Table

Shows your last 10 requests with:
- Reference number
- Request type
- Description preview
- Date filed
- Current status with color-coded badge

---

## Admin Features

### Viewing Requests

The admin dashboard shows all requests with:
- Reference number (bold, prominent)
- Citizen name
- Request type
- Respondent name (if applicable)
- Incident date
- Urgency level badge
- Status badge
- Action buttons (View, Edit)

### View Modal

Detailed view includes:
- Reference number (large, prominent)
- Status badge
- Complainant information
- Request type
- Incident date
- Urgency level
- Respondent information section (if applicable):
  - Name
  - Address
  - Contact
- Full description
- Date filed
- Last updated timestamp

### Edit Modal

Admins can update:
- Citizen (reassign if needed)
- Request type
- Description
- Respondent information (all fields)
- Incident date
- Urgency level
- Status (with all Philippine-standard options)

Reference number is read-only (cannot be changed).

---

## Important Reminders

### For Citizens

1. All information must be truthful and accurate
2. False reports may result in legal consequences
3. You may be required to attend mediation hearings
4. Bring evidence or witnesses to support your case
5. Barangay will attempt amicable settlement first
6. Processing is FREE - no fees required

### For Administrators

1. Reference numbers are unique and auto-generated
2. Cannot modify reference numbers after creation
3. Update status as case progresses through mediation
4. Respondent information is optional but recommended for summons
5. Use appropriate status for each stage of resolution

---

## Status Workflow

### Typical Dispute Resolution Flow:

1. **New** - Request received, pending review
2. **For Mediation** - Assigned to mediation process
3. **Mediation Scheduled** - Hearing date set
4. **Settled** - Parties reached agreement
   OR
5. **No Settlement** - Mediation failed, may proceed to court
6. **Closed** - Case concluded

### Typical Incident Report Flow:

1. **New** - Report received
2. **Investigating** - Under review
3. **Resolved** - Issue addressed
4. **Closed** - Case concluded

---

## Technical Details

### Files Modified

**Citizen Side:**
- `system/citizen_report_incident.php` - Request form with Philippine standards
- `system/citizen_report_incident_submit.php` - Handles submission with reference number generation

**Admin Side:**
- `system/summons_reports.php` - Admin dashboard with updated table
- `system/summons_reports_edit.php` - Edit handler with respondent fields
- `system/summons_reports_row.php` - AJAX endpoint for fetching data
- `system/includes/summons_reports_modal.php` - Updated modals with all fields

**Database:**
- `database/update_summons_reports_table.sql` - Schema updates

### Database Schema Changes

```sql
-- New columns added
respondent_name VARCHAR(255) NULL
respondent_address TEXT NULL
respondent_contact VARCHAR(100) NULL
reference_number VARCHAR(50) NULL

-- Updated ENUMs
report_type: Added 7 Philippine-standard types
status: Added 8 mediation-specific statuses
```

---

## Testing Checklist

### Citizen Side
- [ ] Can file summons request with respondent info
- [ ] Can file mediation request with respondent info
- [ ] Can file incident report without respondent info
- [ ] Respondent fields show/hide based on request type
- [ ] Reference number appears in success message
- [ ] Previous requests table shows reference numbers
- [ ] Status badges display correctly

### Admin Side
- [ ] Table shows reference numbers prominently
- [ ] Respondent column shows names or "N/A"
- [ ] View modal displays all information correctly
- [ ] Respondent section hides when no respondent
- [ ] Edit modal loads all fields correctly
- [ ] Can update respondent information
- [ ] Status dropdown shows all Philippine options
- [ ] Changes save successfully

---

## Troubleshooting

### "Column not found" errors
- Run `database/update_summons_reports_table.sql`
- Verify all new columns exist in database

### Reference number not showing
- Check if `reference_number` column exists
- Verify submit handler is generating numbers

### Respondent fields not appearing
- Check JavaScript in `citizen_report_incident.php`
- Verify report_type dropdown values match script

### Status not displaying correctly
- Verify status ENUM updated in database
- Check status badge switch statements in PHP

---

## Future Enhancements

Potential additions:
- Email notifications to respondents
- SMS notifications for hearing schedules
- Document upload for evidence
- Digital signature for settlement agreements
- Certificate to File Action generation
- Hearing schedule calendar
- Mediation notes/minutes

---

## Support

For issues or questions:
1. Check this guide first
2. Verify database updates are applied
3. Check browser console for JavaScript errors
4. Review PHP error logs for server-side issues

---

**Last Updated:** February 20, 2026
**Version:** 1.0
**Status:** Production Ready

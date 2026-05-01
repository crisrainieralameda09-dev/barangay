# Census Module Guide

## Overview
The Census Module allows citizens to fill out demographic and socio-economic information that can be accessed via QR code without requiring login. This enables quick verification by barangay officials.

## Database Setup

### Step 1: Create Census Table
Run the SQL script to create the census table:

```bash
mysql -u root -p buegas_db < database/create_census_table.sql
```

Or manually execute the SQL in phpMyAdmin/MySQL Workbench:
- Open `database/create_census_table.sql`
- Execute the SQL commands

### Table Structure
The `census` table includes:
- **census_id**: Unique identifier (format: CEN-YYYY-XXXXXX)
- **citizen_id**: Foreign key to citizens table
- **Personal Info**: firstname, lastname, birthdate, gender, civil_status, contact, address
- **Socio-Economic**: occupation, monthly_income, education, household_members
- **Special Categories**: is_senior, is_pwd, is_pregnant, is_4ps
- **Timestamps**: created_at, updated_at, deleted_at

## Features

### 1. Census Form (citizen_census.php)
- Pre-filled with user's basic information from their account
- Collects demographic and socio-economic data
- Special categories checkboxes (Senior, PWD, Pregnant, 4Ps)
- Submit button saves data and redirects to QR code view
- Link to view existing QR code

### 2. Census Save (citizen_census_save.php)
- Processes form submission
- Generates unique census ID: `CEN-{YEAR}-{CITIZEN_ID_PADDED}`
- Updates existing record or inserts new one
- Redirects to QR code view page

### 3. QR Code View (citizen_census_view.php)
- Displays census information in table format
- Generates QR code using qrcodejs library
- QR code contains URL to public census page
- Features:
  - Download QR code as PNG
  - Print QR code with census details
  - Update census form link
  - Public link for sharing

### 4. Public Census Page (census_public.php)
- Accessible without login via QR code or direct link
- Modern dark theme matching landing page
- Displays verified badge and all census information
- Organized sections:
  - Personal Information
  - Socio-Economic Information (if provided)
  - Special Categories (badges)
- Print functionality
- Back to Home link

## User Flow

### For Citizens:
1. Login to citizen portal
2. Navigate to Census → Fill Census Form
3. Fill out the form (some fields pre-filled)
4. Submit the form
5. View generated QR code
6. Download or print QR code
7. Show QR code to barangay officials when needed

### For Barangay Officials:
1. Scan citizen's QR code using any QR scanner
2. Opens public census page in browser
3. View verified census information
4. No login required

## Navigation

### Citizen Sidebar Menu
The Census menu is located between "Aid Received" and "Report Incident":
- **Census** (dropdown)
  - Fill Census Form
  - View QR Code

## Technical Details

### QR Code Generation
- Uses qrcodejs library (CDN: https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js)
- QR code size: 256x256 pixels
- Error correction level: High (H)
- Contains full URL to public census page

### Public URL Format
```
http://yourdomain.com/system/census_public.php?id=CEN-2026-000001
```

### Security Considerations
- Public page only displays census information (no sensitive data)
- Census ID is required to access public page
- Invalid census IDs redirect to landing page
- No authentication required for public access (by design)

## Styling

### Census Form
- Uses AdminLTE theme (matching other citizen pages)
- Two-column layout: Form (left) + Info box (right)
- Responsive design

### Public Census Page
- Modern dark theme with gradient background
- Green/teal color scheme (#228b22, #008080)
- Inter font family
- Card-based layout with rounded corners
- Verified badge with checkmark icon
- Print-friendly styling

## Files Involved

1. **system/citizen_census.php** - Census form page
2. **system/citizen_census_save.php** - Form processing
3. **system/citizen_census_view.php** - QR code generation and display
4. **system/census_public.php** - Public census view (no login)
5. **system/includes/sidebar_citizen.php** - Navigation menu
6. **database/create_census_table.sql** - Database schema

## Testing

### Test the Census Module:
1. Login as a citizen
2. Go to Census → Fill Census Form
3. Fill out all fields and submit
4. Verify QR code is generated
5. Download QR code
6. Scan QR code with phone or use the public link
7. Verify public page displays correctly
8. Test print functionality
9. Update census form and verify changes

### Test Cases:
- [ ] Form submission with all fields
- [ ] Form submission with only required fields
- [ ] Update existing census record
- [ ] QR code generation
- [ ] QR code download
- [ ] QR code print
- [ ] Public page access via QR code
- [ ] Public page access via direct link
- [ ] Invalid census ID handling
- [ ] Print functionality on public page

## Troubleshooting

### QR Code Not Generating
- Check if qrcodejs library is loading (check browser console)
- Verify census record exists in database
- Check if census_url variable is set correctly

### Public Page Not Loading
- Verify census_id parameter in URL
- Check database connection in census_public.php
- Ensure census record exists with that ID

### Form Not Submitting
- Check database connection
- Verify census table exists
- Check for SQL errors in citizen_census_save.php
- Ensure citizen_id is in session

## Future Enhancements

Potential improvements:
- Bulk census data export for admin
- Census statistics dashboard
- QR code expiration dates
- Multiple QR code formats (PDF, SVG)
- SMS notification with census link
- Census verification status by officials
- Census data analytics

# PWD Disability Type Feature - Database Update

## Overview
Added a "Type of Disability" field to the PWD (Person with Disability) registration section.

## Database Migration Required

### Step 1: Run SQL Migration
Execute the following SQL file in your database:
```
database/add_disability_type_column.sql
```

This will add the `disability_type` column to the `citizens` table.

### Step 2: Verify Column Added
Run this query to verify:
```sql
DESCRIBE citizens;
```

You should see a new column `disability_type` of type VARCHAR(100).

## Features Added

### 1. Registration Form (system/register.php)
- When user checks "Person with Disability (PWD)" checkbox
- Two fields now appear:
  - **PWD ID Number** (text input)
  - **Type of Disability** (dropdown select)

### 2. Disability Type Options
- Visual Impairment
- Hearing Impairment
- Speech Impairment
- Physical Disability
- Intellectual Disability
- Mental/Psychosocial Disability
- Multiple Disabilities
- Other

### 3. Backend Processing (system/register_process.php)
- Updated to capture and store `disability_type` value
- Stored in `citizens` table alongside `pwd_id`

## Files Modified

1. **system/register.php**
   - Changed `pwd_id_group` to `pwd_details_group`
   - Added disability type dropdown field
   - Updated JavaScript to clear both fields when PWD is unchecked

2. **system/register_process.php**
   - Added `$disability_type` variable
   - Updated INSERT query to include `disability_type` column
   - Updated bind_param to handle the new field

3. **database/add_disability_type_column.sql** (NEW)
   - Migration script to add the column

## Testing

1. Go to registration page
2. Check "Person with Disability (PWD)"
3. Verify both "PWD ID Number" and "Type of Disability" fields appear
4. Select a disability type from dropdown
5. Complete registration
6. Check database to verify both `pwd_id` and `disability_type` are saved

## Notes

- The `disability_type` field is optional (can be NULL)
- Only appears when PWD checkbox is checked
- Both fields are cleared when PWD checkbox is unchecked
- Follows the same styling as other form fields

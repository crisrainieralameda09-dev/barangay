# Barangay Officials Management Module

## Overview
Complete CRUD (Create, Read, Update, Delete) module for managing barangay officials with photo upload functionality.

## Features Implemented

### 1. Database Table
- **File**: `database/create_officials_table.sql`
- **Table**: `barangay_officials`
- **Columns**:
  - id (Primary Key)
  - name
  - position
  - committee (for Kagawads)
  - phone
  - email
  - photo_path
  - display_order (for sorting)
  - official_type (captain, sk_chairman, kagawad, secretary, treasurer, other)
  - is_active (status)
  - created_at, updated_at, deleted_at (timestamps)
- **Pre-populated** with existing officials data

### 2. Admin Management Page
- **File**: `system/barangay_officials.php`
- **Features**:
  - View all officials in a table
  - Photo thumbnails
  - Status indicators (Active/Inactive)
  - Type labels (Captain, SK Chairman, Kagawad, etc.)
  - Contact information display
  - Display order column
  - Edit and Delete buttons

### 3. Modal Forms
- **File**: `system/includes/barangay_officials_modal.php`
- **Add Official Modal**:
  - Name (required)
  - Position (required)
  - Official Type dropdown (required)
  - Committee (optional, for Kagawads)
  - Phone (optional)
  - Email (optional)
  - Photo upload with preview
  - Display order
  - Active/Inactive checkbox
  
- **Edit Official Modal**:
  - All fields from Add modal
  - Current photo preview
  - Option to change photo
  - Option to remove photo
  - Auto-deletes old photo when replaced
  
- **Delete Official Modal**:
  - Confirmation dialog
  - Soft delete (sets deleted_at timestamp)

### 4. Backend Processing Files

#### Add Official (`barangay_officials_add.php`)
- Validates input data
- Handles photo upload
- Validates file type (JPG, PNG, GIF)
- Validates file size (max 5MB)
- Generates unique filename
- Stores in `uploads/officials/` directory
- Inserts record into database

#### Edit Official (`barangay_officials_edit.php`)
- Updates official information
- Handles photo replacement
- Deletes old photo when new one uploaded
- Handles photo removal
- Updates database record

#### Delete Official (`barangay_officials_delete.php`)
- Soft delete (sets deleted_at timestamp)
- Preserves data for audit trail

#### Get Official Row (`barangay_officials_row.php`)
- AJAX endpoint
- Returns official data as JSON
- Used for populating edit modal

### 5. Photo Upload Features
- File type validation (JPG, PNG, GIF only)
- File size validation (max 5MB)
- Real-time image preview before upload
- Unique filename generation (prevents conflicts)
- Automatic directory creation
- Old photo deletion on replacement
- Photo removal option

### 6. Admin Sidebar Menu
- Added "Barangay Officials" menu item
- Located under "SYSTEM ADMINISTRATION" section
- Icon: fa-user-circle

## Usage Instructions

### Step 1: Create Database Table
Run the SQL file to create the table and populate with existing data:
```sql
-- Run this in phpMyAdmin or MySQL command line
source database/create_officials_table.sql;
```

### Step 2: Access Admin Panel
1. Login as admin
2. Navigate to "Barangay Officials" in the sidebar
3. You'll see all existing officials

### Step 3: Add New Official
1. Click "Add Official" button
2. Fill in the form:
   - Name (required)
   - Position (required)
   - Select Official Type
   - Add Committee (if Kagawad)
   - Add contact info (optional)
   - Upload photo (optional)
   - Set display order
   - Set status (Active/Inactive)
3. Click "Save"

### Step 4: Edit Official
1. Click "Edit" button on any official
2. Modal opens with current data
3. Modify any fields
4. Upload new photo or remove existing
5. Click "Update"

### Step 5: Delete Official
1. Click "Delete" button
2. Confirm deletion
3. Official is soft-deleted (hidden but not removed from database)

## File Structure
```
database/
  └── create_officials_table.sql

system/
  ├── barangay_officials.php (main admin page)
  ├── barangay_officials_add.php (add processing)
  ├── barangay_officials_edit.php (edit processing)
  ├── barangay_officials_delete.php (delete processing)
  ├── barangay_officials_row.php (AJAX endpoint)
  ├── includes/
  │   ├── barangay_officials_modal.php (modals)
  │   └── sidebar.php (updated with menu item)
  └── uploads/
      └── officials/ (photo storage directory)
```

## Security Features
- SQL injection prevention (mysqli_real_escape_string)
- File type whitelist
- File size limit
- Secure file upload handling
- Soft delete (preserves data)
- Session-based authentication

## Display Features
- Photo thumbnails in table
- Status badges (Active/Inactive)
- Type labels with colors
- Contact information formatting
- Sortable by display order
- Responsive design

## Next Steps (Optional Enhancements)
1. Update `officials.php` public page to pull from database
2. Add drag-and-drop reordering
3. Add bulk operations
4. Add photo cropping/editing
5. Add export to PDF
6. Add activity logs

## Status: ✅ COMPLETE
The Barangay Officials Management Module is fully functional and ready to use!

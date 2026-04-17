# Active Directory PowerShell Scripts

A collection of PowerShell scripts built in a Windows Server 2019 home lab environment to automate Active Directory user management.

## Scripts

### 1_CREATE_USERS.ps1
- Bulk creates AD users from a names list
- Distributes users across department OUs (HR, IT, Finance, Sales, Support)
- Sets temporary password with forced change on first login
- Assigns users to department security groups

### 2_OFFBOARD_USER.ps1
- Disables the specified user account
- Removes user from all security groups
- Moves user to a Disabled OU for record keeping

### 3_USER_REPORT.ps1
- Exports all active AD users to a CSV file
- Includes First Name, Last Name, Username and Department columns
- Used for auditing and reporting purposes

## Technologies Used
- PowerShell
- Active Directory
- Windows Server 2019

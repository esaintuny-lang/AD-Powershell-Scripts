# ----- Offboarding Script ----- #
# This script disables a user, moves them to a Disabled OU, and removes group memberships

$username = Read-Host "Enter the username to offboard"

# Check if user exists
$user = Get-ADUser -Filter "SamAccountName -eq '$username'" -Properties MemberOf
if ($null -eq $user) {
    Write-Host "User $username not found!" -BackgroundColor Black -ForegroundColor Red
    exit
}

# Disable the account
Disable-ADAccount -Identity $username
Write-Host "Disabled account: $username" -BackgroundColor Black -ForegroundColor Yellow

# Remove from all groups
foreach ($group in $user.MemberOf) {
    Remove-ADGroupMember -Identity $group -Members $username -Confirm:$false
    Write-Host "Removed $username from $group" -BackgroundColor Black -ForegroundColor Yellow
}

# Create Disabled OU if it doesn't exist
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Disabled'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Disabled" -Path "DC=mydomain,DC=com" -ProtectedFromAccidentalDeletion $false
    Write-Host "Created Disabled OU" -BackgroundColor Black -ForegroundColor Green
}

# Move user to Disabled OU
Move-ADObject -Identity $user.DistinguishedName -TargetPath "OU=Disabled,DC=mydomain,DC=com"
Write-Host "Moved $username to Disabled OU" -BackgroundColor Black -ForegroundColor Yellow

Write-Host "Offboarding complete for $username" -BackgroundColor Black -ForegroundColor Green

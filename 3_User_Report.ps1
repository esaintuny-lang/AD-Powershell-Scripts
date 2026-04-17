# ----- User Report Script ----- #
# This script exports all active AD users to a CSV file

$reportPath = "C:\Users\a-esaintuny\Desktop\AD_PS-master\UserReport.csv"

Get-ADUser -Filter {Enabled -eq $true} -SearchBase "OU=_USERS,DC=mydomain,DC=com" -SearchScope Subtree -Properties GivenName, Surname, SamAccountName, EmailAddress, DistinguishedName |
    Select-Object `
        @{Name="First Name"; Expression={$_.GivenName}}, `
        @{Name="Last Name"; Expression={$_.Surname}}, `
        @{Name="Username"; Expression={$_.SamAccountName}}, `
        @{Name="Email"; Expression={$_.EmailAddress}}, `
        @{Name="Department"; Expression={
            $dn = $_.DistinguishedName
            if ($dn -match "OU=(\w+),OU=_USERS") { $matches[1] } else { "Unknown" }
        }} |
    Export-Csv -Path $reportPath -NoTypeInformation

Write-Host "Report exported to $reportPath" -BackgroundColor Black -ForegroundColor Green
Write-Host "Total active users:" -BackgroundColor Black -ForegroundColor White
Import-Csv $reportPath | Measure-Object | Select-Object Count

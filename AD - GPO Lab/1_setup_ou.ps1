# 1_setup_ou.ps1
# Run on AD01-jacob via remote PS session from MGMT01-jacob
# Deliverable 1: Creates Software Deploy OU, moves WKS01 and named account, deletes Test OU

Import-Module ActiveDirectory

$domain = "DC=jacob,DC=local"
$namedAccount = "jacob.greeley"

# Create Software Deploy OU
New-ADOrganizationalUnit -Name "Software Deploy" -Path $domain
Write-Host "[+] Created 'Software Deploy' OU"

# Move WKS01 computer object
$wks01 = Get-ADComputer -Identity "wks01-jacob"
Move-ADObject -Identity $wks01.DistinguishedName `
  -TargetPath "OU=Software Deploy,$domain"
Write-Host "[+] Moved wks01-jacob to Software Deploy"

# Move named account
$user = Get-ADUser -Identity $namedAccount
Move-ADObject -Identity $user.DistinguishedName `
  -TargetPath "OU=Software Deploy,$domain"
Write-Host "[+] Moved $namedAccount to Software Deploy"

# Remove accidental deletion protection then delete Test OU
Set-ADOrganizationalUnit -Identity "OU=Test OU,$domain" `
  -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=Test OU,$domain" -Confirm:$false
Write-Host "[+] Deleted Test OU"

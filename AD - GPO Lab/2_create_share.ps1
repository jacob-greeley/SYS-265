# 2_create_share.ps1
# Run on MGMT01-jacob
# Creates the Software share for GPO deployment

$sharePath = "C:\Software"
$shareName = "Software"

New-Item -ItemType Directory -Path $sharePath -Force

New-SmbShare -Name $shareName -Path $sharePath `
  -ReadAccess "Domain Users" -FullAccess "Administrators"

Write-Host "[+] Share \\mgmt01-jacob\$shareName created"
Write-Host "    Place PuTTY .msi in $sharePath before proceeding with GPO"

# 2_create_share.ps1
# Run on MGMT01-jacob
# Creates the Software share for GPO deployment

$sharePath = "C:\Software"
$shareName = "Software"

New-Item -ItemType Directory -Path $sharePath -Force

New-SmbShare -Name $shareName -Path $sharePath `
  -ReadAccess "Domain Users" -FullAccess "Administrators"

# Grant Everyone read access so computer accounts can access during GPO install
Grant-SmbShareAccess -Name $shareName -AccountName "Everyone" -AccessRight Read -Force

# Set NTFS permissions to allow Everyone read access
icacls $sharePath /grant "Everyone:(OI)(CI)R" /T

Write-Host "[+] Share \\mgmt01-jacob\$shareName created"
Write-Host "[+] Permissions set for Everyone (required for GPO computer account installs)"
Write-Host "    Place PuTTY .msi in $sharePath before proceeding with GPO"

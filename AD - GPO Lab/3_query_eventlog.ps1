# 3_query_eventlog.ps1
# Run on WKS01-jacob AFTER gpupdate /force and reboot
# Deliverable 3: Queries System log for PuTTY GPO install confirmation

Get-WinEvent -LogName System | Where-Object {
    $_.ProviderName -eq "Application Management Group Policy" -and
    $_.Message -like "*PuTTY*Deploy SW*succeeded*"
} | Select-Object TimeCreated, Id, LevelDisplayName, Message |
Format-List

# SYS-255 AD GPO + Software Deployment Lab

## Environment
- Domain: jacob.local
- AD01: ad01-jacob
- MGMT01: mgmt01-jacob
- WKS01: wks01-jacob
- Named Account: jacob.greeley

## Usage

### Step 1 - Setup OUs (Deliverable 1)
Run on AD01-jacob via remote PS session from MGMT01-jacob:
```powershell
git clone https://github.com/jacob-greeley/SYS-265/tree/main/AD%20-%20GPO%20Lab
.\1_setup_ou.ps1
```
Screenshot the output for Deliverable 1.

### Step 2 - Create Software Share (Deliverable 2)
Run on MGMT01-jacob:
```powershell
.\2_create_share.ps1
```
Then manually place PuTTY x64 .msi into C:\Software.
Log into WKS01-jacob as jacob.greeley and browse to \\mgmt01-jacob\Software — screenshot for Deliverable 2.

### Step 3 - Configure GPO (Manual - GUI Required)
1. Open Group Policy Management on MGMT01-jacob
2. Create new GPO named "Deploy SW" linked to "Software Deploy" OU
3. Edit GPO → Computer Configuration → Software Settings → Software Installation
4. New Package → point to \\mgmt01-jacob\Software\putty.msi → Assigned

### Step 4 - Apply GPO
On WKS01-jacob:
```powershell
gpupdate /force
```
Allow the reboot when prompted.

### Step 5 - Validate (Deliverable 3)
After reboot, log in as jacob.greeley and run:
```powershell
.\3_query_eventlog.ps1
```
Screenshot the output. Also grab a GUI screenshot from Event Viewer.

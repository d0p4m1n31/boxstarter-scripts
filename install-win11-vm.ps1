
# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
    Invoke-Expression ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

# Check PowerShell version to make sure it's a minimum of 5.0.0 
Write-Host "[+] Checking if PowerShell version is compatible..."
$psVersion = $PSVersionTable.PSVersion
if ($psVersion -lt [System.Version]"5.0.0") {
    Write-Host "`t[!] You are using PowerShell version $psVersion. This is an old version and it is not supported" -ForegroundColor Red
    Read-Host "Press any key to exit..."
    exit 1
}
else {
    Write-Host "`t[+] Installing with PowerShell version $psVersion" -ForegroundColor Green
}

# Check for spaces in the username, exit if identified
Write-Host "[+] Checking for spaces in the username..."
$currentUsername = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$extractedUsername = $currentUsername -replace '^.*\\'
if ($extractedUsername -match '\s') {
    Write-Host "`t[!] Username '$extractedUsername' contains a space and will break installation." -ForegroundColor Red
    Write-Host "`t[!] Exiting..." -ForegroundColor Red
    Start-Sleep 3
    exit 1
}
else {
    Write-Host "`t[+] Username '$extractedUsername' does not contain any spaces." -ForegroundColor Green
}

# Check if host has enough disk space
Write-Host "[+] Checking if host has enough disk space..."
$disk = Get-PSDrive (Get-Location).Drive.Name
Start-Sleep -Seconds 1
if (-Not (($disk.used + $disk.free) / 1GB -gt 58.8)) {
    Write-Host "`t[!] A minimum of 60 GB hard drive space is preferred. Please increase hard drive space of the VM, reboot, and retry install" -ForegroundColor Red
    Write-Host "[-] Do you still wish to proceed? (Y/N): " -ForegroundColor Yellow -NoNewline
    $response = Read-Host
    if ($response -notin @("y", "Y")) {
        exit 1
    }
}
else {
    Write-Host "`t[+] Disk is larger than 60 GB" -ForegroundColor Green
}

# Set Boxstarter options
$Boxstarter.RebootOk = (-not $noReboots.IsPresent)
$Boxstarter.NoPassword = $noPassword.IsPresent
$Boxstarter.AutoLogin = $true
$Boxstarter.SuppressLogging = $false
$global:VerbosePreference = "SilentlyContinue"
Set-BoxstarterConfig -NugetSources "$desktopPath;.;https://www.myget.org/F/vm-packages/api/v2;https://myget.org/F/vm-packages/api/v2;https://chocolatey.org/api/v2"

#Set default Windows enviroment settings
executeScript "set-def-win11settings.ps1";

#Remove default installed Windows apps
executeScript "remove-def-win11apps.ps1";

#Remove default installed Windows Configuration parameters
executeScript "remove-def-win11config.ps1";

#Remove default installed Windows Scheduled Tasks and Services
executeScript "remove-def-win11schtasksservices.ps1";

# Install default applications using Chocolatey
executeScript "install-defapps.ps1";

#Re-enable UAC and Microsoft Update. Install updates when ready
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
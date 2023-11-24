$installExtraApps = $true;
#if $installExtraApps is set to $true, make sure to add the filename for the extra apps script you place in the scripts folder here.
$extraAppScriptFileName = "devApplications.ps1";

# List of Built-in aspplications to remove
$appsToRemove = @(
    "Microsoft.549981C3F5F10",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.Office.OneNote",
    "Microsoft.3DBuilder"
)

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
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

# Check PowerShell version
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
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar


# Set power options to prevent installs from timing out
powercfg -change -monitor-timeout-ac 0 | Out-Null
powercfg -change -monitor-timeout-dc 0 | Out-Null
powercfg -change -disk-timeout-ac 0 | Out-Null
powercfg -change -disk-timeout-dc 0 | Out-Null
powercfg -change -standby-timeout-ac 0 | Out-Null
powercfg -change -standby-timeout-dc 0 | Out-Null
powercfg -change -hibernate-timeout-ac 0 | Out-Null
powercfg -change -hibernate-timeout-dc 0 | Out-Null


# Attempt to disable unwanted services
Write-Host "[+] Attempting to disable unwanted services..."
try {
    Get-Service -Name "MapsBroker", "WbioSrvc", "WMPNetworkSvc", "WSearch" | Stop-Service -Force -ErrorAction Stop | Out-Null
    Get-Service -Name "MapsBroker", "WbioSrvc", "WMPNetworkSvc", "WSearch" | Set-Service -StartupType Disabled -ErrorAction Stop | Out-Null  
    Write-Host "`t[+] Finished trying to disable unwanted services" -ForegroundColor Green  
}
catch {
    Write-Host "`t[!] Failed to disable unwanted services" -ForegroundColor Yellow
}

# Attempt to disable unwanted scheduled tasks
Write-Host "[+] Attempting to disable unwanted scheduled tasks..."
try {
    Get-ScheduledTask -TaskPath "\Microsoft\Windows\*" | Disable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null     
    Write-Host "`t[+] Finished disabling unwanted scheduled tasks" -ForegroundColor Green       
}
catch {
    Write-Host "`t[!] Failed to disable unwanted scheduled tasks" -ForegroundColor Yellow
}


# Attempt to remove unwanted apps
Write-Host "[+] Attempting to remove default selected apps..."
try {
    foreach ($app in $appsToRemove) {
        Get-AppxPackage -AllUsers | Where-Object { $_.Name -eq $app } | Remove-AppxPackage -AllUsers -ErrorAction Stop | Out-Null 
        Write-Host "`t[+] Removed (or not found) unwanted default installed app: "$app -ForegroundColor Green  
    }
}
catch {
    Write-Host "`t[!] Failed to remove all the unwanted default apps" -ForegroundColor Yellow
}

# Install default applications using Chocolatey
try {
    executeScript "DefaultApplications.ps1";
    executeScript "DevApplications.ps1";
    Write-Host "`t[+] Installed the default applications with Chocolatey" -ForegroundColor Green    
}
catch{
    Write-Host "`t[!] Failed to install (some) default applications" -ForegroundColor Yellow
}

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
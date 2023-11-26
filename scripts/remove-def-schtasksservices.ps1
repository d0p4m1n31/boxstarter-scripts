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
    #Disables scheduled tasks that are considered unnecessary 
    Write-Output "Disabling scheduled tasks"
    Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask  
    Write-Host "`t[+] Finished disabling unwanted scheduled tasks" -ForegroundColor Green       
}
catch {
    Write-Host "`t[!] Failed to disable unwanted scheduled tasks" -ForegroundColor Yellow
}
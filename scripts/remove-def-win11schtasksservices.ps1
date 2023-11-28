# Attempt to disable unwanted scheduled tasks and services

Write-Host "Disabling default services..."
try {
    Get-Service -Name "MapsBroker", "WbioSrvc", "WMPNetworkSvc", "WSearch" | Stop-Service -Force -ErrorAction Stop | Out-Null
    Get-Service -Name "MapsBroker", "WbioSrvc", "WMPNetworkSvc", "WSearch" | Set-Service -StartupType Disabled -ErrorAction Stop | Out-Null  
    Write-Host "`t[+] Stopped and disabled unwanted services" -ForegroundColor Green  
}
catch {
    Write-Host "`t[!] Failed to stop and disable unwanted services" -ForegroundColor Yellow
}

# Attempt to disable unwanted scheduled tasks
Write-Host "Disabling default scheduled tasks..."
try {
    #Disables scheduled tasks that are considered unnecessary 
    #Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask //Does not seem to exist anymore
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask  
    Write-Host "`t[+] Disabled default unwanted scheduled tasks" -ForegroundColor Green       
}
catch {
    Write-Host "`t[!] Failed to disable unwanted scheduled tasks" -ForegroundColor Yellow
}
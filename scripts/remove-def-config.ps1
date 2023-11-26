# Attempt to disable unwanted features
Write-Host "[+] Attempting to disable unwanted features..."

#Disabling Windows Error Reporting
Disable-WindowsErrorReporting -ErrorAction SilentlyContinue | Out-Null     
//Write-Host "`t[+] Finished disabling unwanted features" -ForegroundColor Green       

#Disables Windows Feedback Experience
Write-Host "Disabling Windows Feedback Experience program"
$Advertising = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
If (Test-Path $Advertising) {
    Set-ItemProperty $Advertising Enabled -Value 0
}

#Disables live tiles
Write-Host "Disabling live tiles"
$Live = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'    
If (!(Test-Path $Live)) {
    mkdir $Live  
    New-ItemProperty $Live NoTileApplicationNotification -Value 1
}    

#Disables Bing Search from Taskbar
Write-Host "Disabling Bing Search when using Search via the Start Menu"
$BingSearch = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
If (Test-Path $BingSearch) {
    Set-ItemProperty $BingSearch DisableSearchBoxSuggestions -Value 1
}

#Turns off Data Collection via the Allow Telemetry key by changing it to 0
Write-Output "Turning off Data Collection"
$DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
$DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
If (Test-Path $DataCollection1) {
    Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection2) {
    Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection3) {
    Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
}   


#Disabling Windows Error Reporting
Disable-WindowsErrorReporting -ErrorAction SilentlyContinue | Out-Null     
Write-Host "`t[+] Finished disabling unwanted features" -ForegroundColor Green       

#Disables Windows Feedback Experience
Write-Host "Disabling Windows Feedback Experience program"
$Advertising = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
If (Test-Path $Advertising) {
    Set-ItemProperty $Advertising Enabled -Value 0
}
#Disables live tiles
Write-Host "Disabling live tiles"
$Live = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'    
If (!(Test-Path $Live)) {
    mkdir $Live  
    New-ItemProperty $Live NoTileApplicationNotification -Value 1
}    
#Disables Bing Search from Taskbar
Write-Host "Disabling Bing Search when using Search via the Start Menu"
$BingSearch = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
If (Test-Path $BingSearch) {
    Set-ItemProperty $BingSearch DisableSearchBoxSuggestions -Value 1
}
#Turns off Data Collection via the Allow Telemetry key by changing it to 0
Write-Output "Turning off Data Collection"
$DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
$DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
If (Test-Path $DataCollection1) {
    Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection2) {
    Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection3) {
    Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
}
 

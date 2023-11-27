
Write-Host "Removing/disabling unwanted default configuration settings"
try {    
    try {
        #Disable Windows Error Reporting
        Disable-WindowsErrorReporting -ErrorAction SilentlyContinue | Out-Null     
        Write-Host "`t[+] Disabled Windows Error Reporting" -ForegroundColor Green       
    }
    catch {
        Write-Host "`t[!] Failed to disable Windows Error Reporting" -ForegroundColor Yellow
    }

    try {
        #Disable Windows Feedback Experience
        $Advertising = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
        If (Test-Path $Advertising) {
            Set-ItemProperty $Advertising Enabled -Value 0
            Write-Host "`t[+] Disabled Windows Feedback Experience program" -ForegroundColor Green 
        }
        else {
            Write-Host "`t[ ] Windows Feedback Experience program option not found" -ForegroundColor Green  
        }
    }
    catch {
        Write-Host "`t[!] Failed to disable Windows Feedback Experience" -ForegroundColor Yellow
    }
    try {
        #Disables live tiles
        $Live = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'    
        If (!(Test-Path $Live)) {
            mkdir $Live  
            New-ItemProperty $Live NoTileApplicationNotification -Value 1
            Write-Host "`t[+] Disabled Live tiles" -ForegroundColor Green 
        }    
        else {
            Write-Host "`t[ ] Live tiles option not found" -ForegroundColor Green    
        }        
    }
    catch {
        Write-Host "`t[!] Failed to disable Live tiles" -ForegroundColor Yellow
    }

    try {
        #Disables Bing Search from Taskbar
        $BingSearch = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
        If (Test-Path $BingSearch) {
            Set-ItemProperty $BingSearch DisableSearchBoxSuggestions -Value 1
            Write-Host "`t[+] Disabled Bing Search when using Search via the Start Menu" -ForegroundColor Green     
        }
        else {
            Write-Host "`t[ ] Bing Search when using Search via Start Mneu option not found" -ForegroundColor Green 
        }
    }
    catch {
        Write-Host "`t[!] Failed to disable Bing Search from taskbar" -ForegroundColor Yellow
    }

    try {
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
        Write-Host "[+] Disabled Data Collection via Allow Telemetry key" -ForegroundColor Green   
    }
    catch {
        Write-Host "`t[!] Failed to disable Data collection via the allow telemetry key" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "[!] Failed to removing/disable unwanted default configuration settings" -ForegroundColor Yellow
}

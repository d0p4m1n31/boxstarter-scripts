#Set Windows settings using Boxstarter builtin functions

Write-Host "Set default Windows environment settings..."
try {
    try {
        #Set Windows Explorer Look and Feel
        Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
        Write-Host "`t[+] Set Windows Explorer options" -ForegroundColor Green       
    }
    catch{
        Write-Host "`t[!] Failed to set Windows Explorer look and feel" -ForegroundColor Yellow       
    }
    try{
        #Set PowerOptions to best performance
        powercfg -change -monitor-timeout-ac 0 | Out-Null
        powercfg -change -monitor-timeout-dc 0 | Out-Null
        powercfg -change -disk-timeout-ac 0 | Out-Null
        powercfg -change -disk-timeout-dc 0 | Out-Null
        powercfg -change -standby-timeout-ac 0 | Out-Null
        powercfg -change -standby-timeout-dc 0 | Out-Null
        powercfg -change -hibernate-timeout-ac 0 | Out-Null
        powercfg -change -hibernate-timeout-dc 0 | Out-Null
        Write-Host "`t[+] Set Windows PowerOptions to best performance" -ForegroundColor Green    
    }
    catch{
        Write-Host "`t[!] Failed to set Windows PowerOptions to best performance" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "[!] Failed setting default Windows environment settings" -ForegroundColor Yellow
}

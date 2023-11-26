#Set Windows settings using Boxstarter builtin function
try {
    #Set Windows Explorer Look and Feel
    Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar

    #Set PowerOptions to best performance
    powercfg -change -monitor-timeout-ac 0 | Out-Null
    powercfg -change -monitor-timeout-dc 0 | Out-Null
    powercfg -change -disk-timeout-ac 0 | Out-Null
    powercfg -change -disk-timeout-dc 0 | Out-Null
    powercfg -change -standby-timeout-ac 0 | Out-Null
    powercfg -change -standby-timeout-dc 0 | Out-Null
    powercfg -change -hibernate-timeout-ac 0 | Out-Null
    powercfg -change -hibernate-timeout-dc 0 | Out-Null
    Write-Host "`t[+] Configured Windows environment settings" -ForegroundColor Green    
}
catch {
    Write-Host "`t[!] Failed setting Windows environment settings" -ForegroundColor Yellow
}

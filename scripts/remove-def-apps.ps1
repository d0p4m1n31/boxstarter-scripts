#remove unwanted applications

#List of Built-in aspplications to remove
$appsToRemove = @(
    "Microsoft.549981C3F5F10",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.Office.OneNote",
    "Microsoft.3DBuilder"
)
try {
    foreach ($app in $appsToRemove) {
        Get-AppxPackage -AllUsers | Where-Object { $_.Name -eq $app } | Remove-AppxPackage -AllUsers -ErrorAction Stop | Out-Null 
        Write-Host "`t[+] Removed (or not found) unwanted default installed app: "$app -ForegroundColor Green  
    }    
    Write-Host "[+] Removed unwanted default Windows applications" -ForegroundColor Green    
}
catch {
    Write-Host "[!] Failed to remove unwanted default Windows applications" -ForegroundColor Yellow
}
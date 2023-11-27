#Remove default installed applications from Microsoft Windows 

#List of applications to remove from the system
$appsToRemove = @(
    "Microsoft.549981C3F5F10",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.Office.OneNote",
    "Microsoft.3DBuilder"
)

Write-Host "Removing default installed applications"
try {
    foreach ($app in $appsToRemove) {
        Get-AppxPackage -AllUsers | Where-Object { $_.Name -eq $app } | Remove-AppxPackage -AllUsers -ErrorAction Stop | Out-Null 
        Write-Host "`t[+] Removed (or not found) application: "$app -ForegroundColor Green  
    }    
    Write-Host "[+] Removed default installed applications" -ForegroundColor Green    
}
catch {
    Write-Host "[!] Failed to remove unwanted default Windows applications" -ForegroundColor Yellow
}
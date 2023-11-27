#Development applications to install on your machine. You can find supported packages on https://community.chocolatey.org/packages

Write-Host "Installing Development applications"
try{    
    choco install -y vscode
    choco install -y hXd
    Write-Host "`t[+] Installed the Development applications with Chocolatey" -ForegroundColor Green    
}
catch {
    Write-Host "`t[!] Failed to install (some) Development applications" -ForegroundColor Yellow
}

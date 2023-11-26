# Default tools to install on every machine
try{    
    choco install -y vscode
    choco install -y hXd
    Write-Host "[+] Installed the Development applications with Chocolatey" -ForegroundColor Green    
}
catch {
    Write-Host "[!] Failed to install (some) Development applications" -ForegroundColor Yellow
}

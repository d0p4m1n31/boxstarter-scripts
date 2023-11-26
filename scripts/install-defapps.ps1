# Default tools to install on every machine
try{
    choco install -y notepadplusplus
    choco install -y 7zip.install
    Write-Host "[+] Installed the default applications with Chocolatey" -ForegroundColor Green    
}
catch {
    Write-Host "[!] Failed to install (some) default applications" -ForegroundColor Yellow
}

#Default applications to install on your machine. You can find supported packages on https://community.chocolatey.org/packages

Write-Host "Installing Development applications"
try{
    choco install -y notepadplusplus
    choco install -y 7zip.install
    Write-Host "[+] Installed the default applications with Chocolatey" -ForegroundColor Green    
}
catch {
    Write-Host "[!] Failed to install (some) default applications" -ForegroundColor Yellow
}

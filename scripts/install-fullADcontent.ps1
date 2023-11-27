#Install full Active Directory Domain with users, objects and groups.

Write-Host "Installing full Active Directory environment"
try{
    choco install -y git
    New-Item -ItemType Directory -Path C:\InstallFIles
    # clone the repo
    git clone https://github.com/davidprowe/badblood.git "c:\InstallFiles"
    
    #Run Invoke-badblood.ps1
    Import-Module ActiveDirectory
    c:\InstallFiles\badblood\invoke-badblood.ps1
    Write-Host "[+] Installed the default applications with Chocolatey" -ForegroundColor Green    
}
catch {
    Write-Host "[!] Failed to install (some) default applications" -ForegroundColor Yellow
}



#Install full Active Directory Domain with users, objects and groups.

Write-Host "Installing full Active Directory environment"
try{
    #Create install folder and clone the BadBlood repo
    New-Item -ItemType Directory -Path C:\InstallFIles
    git clone https://github.com/davidprowe/badblood.git "c:\InstallFiles"
    
    #Run Invoke-badblood.ps1
    Import-Module ActiveDirectory
    c:\InstallFiles\badblood\ Invoke-BadBlood.ps1 -UserCount 100 -GroupCount 50 -ComputerCount 150  -SkipLapsInstall -NonInteractive
    
    Write-Host "[+] Installed the Full Lab Active Directory" -ForegroundColor Green    
}
catch {
    Write-Host "[!] Failed to install the Full Lab Active Directory" -ForegroundColor Yellow
}



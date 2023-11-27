#Install specific apps for Digital Forensics and Incident Response VM (DFIR). You can find supported packages on https://community.chocolatey.org/packages

Write-Host "Installing Development applications"
try{
    choco install -y powertoys 
    choco install -y vscode 
    choco install -y putty 
    choco install -y notepadplusplus 
    choco install -y python wireshark 
    choco install -y vlc 
    choco install -y firefox 
    choco install -y paint.net 
    choco install -y git 
    choco install -y ericzimmermantools 
    choco install -y autopsy 
    choco install -y agentransack 
    choco install -y autoruns 
    choco install -y veeam-backup-and-replication-extract 
    choco install -y volatility3 
    choco install -y hxd
    Write-Host "`t[+] Installed the DFIR applications with Chocolatey" -ForegroundColor Green    
}
catch {
    Write-Host "`t[!] Failed to install (some) DFIR applications" -ForegroundColor Yellow
}
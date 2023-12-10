#Install the machine as a Domain Controller
$domainName="cybertron.local";
$domainNBName="cybertron";

#Set Local Administrator Password
$LocalAdminPassword = Read-Host "Enter the password for the local administrator account" -AsSecureString
$UserAccount = Get-LocalUser -Name "Administrator"
$UserAccount | Set-LocalUser -Password $LocalAdminPassword

#Get the SafeModeAdministrator password for the ADDSForest installation
$SafeModePassword = Read-Host "Enter the Safe Mode Administrator password" -AsSecureString

Write-Host "Install required roles and features and promote Domain Controller..."
try {
    try {
        #Install ActiveDirectory Domain Services (AD-DS)
        Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
        Write-Host "`t[+] Installed Active Direcotry Domain Services (AD-DS)" -ForegroundColor Green       
    }
    catch{
        Write-Host "`t[!] Failed to installed Active Direcotry Domain Services (AD-DS)" -ForegroundColor Yellow       
    }
    try{
        #Promote server to Domain Controller in new forest
        Install-ADDSForest -DomainName $domainName -DomainNetBIOSName $domainNBName -InstallDNS -SafeModeAdministratorPassword $SafeModePassword
    }
    catch{
        Write-Host "`t[!] Failed to promote the server to a Domain Controller in a new Forest" -ForegroundColor Yellow       
    }
}
catch{
    Write-Host "[!] Failed to install required roles and features and promote Domain Controller"
}

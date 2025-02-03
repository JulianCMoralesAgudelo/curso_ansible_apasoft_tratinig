# Establecer configuracion de seguridad
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Remove the auto logon.
$reg_winlogon_path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $reg_winlogon_path -Name AutoAdminLogon -Value 0
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultUserName -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultPassword -ErrorAction SilentlyContinue

# To install the hotfix:
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Install-WMF3Hotfix.ps1"
$file = "$env:temp\Install-WMF3Hotfix.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file -Verbose

# Verificar e Instalar PowerShell 3.0 o superior
$PSVersionTable.PSVersion

# Verificar e Instalar .NET Framework 4.0 o superior
(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Version

# Configurar WinRM (Auto) HTTP y HTPPS:
winrm quickconfig
winrm quickconfig -transport:https

# Configurar WinRM (modo básico y sin cifrado)
winrm quickconfig -q
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Habilitar un listener en el puerto 5985 (HTTP)
winrm create winrm/config/listener?Address=*+Transport=HTTP @{Port="5985"}

# Crear certificado htpss
New-SelfSignedCertificate -DnsName "tu-servidor.tudominio.com" -CertStoreLocation Cert:\LocalMachine\My

# Ejecuta este comando para obtener el thumbprint real de tu certificado:
Get-ChildItem -Path Cert:\LocalMachine\My | Format-List Subject, Thumbprint

# Salida del comando anterior
Subject    : CN=tu-servidor.tudominio.com
Thumbprint : 9AB4004808ABE26F8273A47A99B31F35F38DD066

# Ahora, crea el listener HTTPS con el siguiente comando:
New-Item -Path WSMan:\Localhost\Listener\ -Transport HTTPS -Address * -CertificateThumbprint "9AB4004808ABE26F8273A47A99B31F35F38DD066" -Port 5986
New-NetFirewallRule -Name winrm-https -DisplayName "Windows Remote Management (HTTPS)" -Enabled True -Protocol TCP -Action Allow -LocalPort 5986

# Reiniciar el servicio para aplicar los cambios
Restart-Service WinRM

# Verificar listener
winrm enumerate winrm/config/listener

# Verificar listener
Get-Service -Name WinRM

# Iniciar servicio 
Start-Service WinRM
Set-Service -Name WinRM -StartupType Automatic

# Detener servicio
Stop-Service -Name winrm

# Habilitar en el firewall
netsh advfirewall firewall add rule name="WinRM HTTP" dir=in action=allow protocol=TCP localport=5985

# Verificar desde otra maquina
Test-WsMan <IP_DEL_SERVIDOR>

# Script de fabrica 
# https://docs.ansible.com/ansible/7/os_guide/windows_setup.html

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Upgrade-PowerShell.ps1"
$file = "$env:temp\Upgrade-PowerShell.ps1"
$username = "Administrator"
$password = "Password"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

&$file -Version 5.1 -Username $username -Password $password -Verbose

############################################################################## 
# Crear el usuario ansible
New-LocalUser -Name "ansible" -Password (ConvertTo-SecureString "4Ns1bl3Us3r*" -AsPlainText -Force) -FullName "Ansible User" -Description "Usuario para administración remota con Ansible"

# Grupos
Add-LocalGroupMember -Group "Remote Management Users" -Member "ansible"
Add-LocalGroupMember -Group "Administrators" -Member "ansible"

# Permisos WinRM
(Get-PSSessionConfiguration -Name Microsoft.PowerShell).SecurityDescriptorSddl | Out-String

# Reiniciar WinRM
Restart-Service winrm




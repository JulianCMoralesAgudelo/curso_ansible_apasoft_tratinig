# Ejecutar el playbook YAML
ansible-playbook -i inventory.ini copy.yaml

# Comando de prueba de conexion con windows
ansible all -i inventory.ini -m win_ping

# Comando de prueba de usuario
ansible all -i inventory.ini -m win_command -a "whoami"

# Version del java
ansible all -i inventory.ini -m win_command -a "java -version"

# Comandos CMD listar directorio
ansible all -i inventory.ini -m win_command -a "cmd.exe /c dir"

# Comandos CMD listar ip
ansible all -i inventory.ini -m win_command -a "cmd.exe /c ipconfig"

# Crear directorio
ansible all -i inventory.ini -m win_command -a "cmd.exe /c ipconfig"

# Comandos SHELL mayor petencia de scripting
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c ls"

# Listar los archivos de un directorio específico
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c Get-ChildItem C:\Windows"

# Crear un archivo de texto en el sistema Windows
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c echo 'Hello, World!' > C:\temp\example.txt"

#  Ejecutar un script PowerShell completo
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c C:\path\to\your_script.ps1"

#  Instalar una aplicación utilizando PowerShell
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c choco install 7zip -y"

# Verificar el estado de un servicio
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c Get-Service wuauserv | Select-Object Status"

# Reiniciar una máquina remota
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c shutdown /r /f /t 0"

# Verificar el espacio libre en un disco
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c Get-PSDrive C"

#  Obtener información sobre los procesos en ejecución
ansible all -i inventory.ini -m win_shell -a "powershell.exe /c Get-Process"
# Ejecutar el proceso de instalación del parche SQL Server
$patchPath = "C:\Users\admindb\Documents\parches\sqlserver2019-kb5049235-x64_a17df28b9f89ec829ef865add26d75b4958ec802.exe"
$arguments = "/q /action=patch /allinstances /IAcceptSQLServerLicenseTerms"

try {
    Start-Process $patchPath -ArgumentList $arguments -Wait
    Write-Host "Parche instalado correctamente."
}
catch {
    Write-Error "Error al ejecutar la instalación del parche: $_"
}

# Ejecutar el script PowerShell con runas
try {
    runas /user:Administrator "powershell.exe -ExecutionPolicy Bypass -File C:\Users\admindb\Documents\parches\sql_server_patch.ps1"
}
catch {
    Write-Error "Error al ejecutar runas: $_"
}

# Usar PsExec para ejecutar el script
try {
    PsExec.exe -u Administrator -p "Password" powershell.exe -ExecutionPolicy Bypass -File C:\Users\admindb\Documents\parches\sql_server_patch.ps1
}
catch {
    Write-Error "Error al ejecutar PsExec: $_"
}

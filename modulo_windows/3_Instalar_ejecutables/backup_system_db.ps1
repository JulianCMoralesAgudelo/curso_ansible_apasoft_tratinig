#region Información de Acceso a la base de datos
$ServerInstance = "localhost\SQL_SERVER_DEV"  # Reemplaza con tu instancia real
$Username = "ansible"  # Reemplaza con tu usuario
$Password = "4Ns1bl3Us3r*"  # Reemplaza con tu contraseña
$BackupDir = "C:\Users\admindb\Documents\parches\backups"  # Directorio para almacenar los backups
#endregion

#region Ruta del archivo de registro con fecha
$Date = Get-Date -Format "dd_MM_yyyy"
$LogFile = "C:\Users\admindb\Documents\parches\log_system_backup_$Date.log"
#endregion

#region Función para escribir en el archivo de registro en UTF-8
function Write-Log {
    param(
        [string]$Message
    )
    $Time = Get-Date -Format "HH:mm:ss"
    $LogEntry = "$Date $Time - $Message"
    try {
        # Usamos Out-File con codificación UTF-8 para asegurarnos de que la salida sea en UTF-8
        $LogEntry | Out-File -FilePath $LogFile -Append -Encoding utf8
    }
    catch {
        Write-Warning "No se pudo escribir en el archivo de registro: $_"
    }
}
#endregion

#region Respaldo de bases de datos
try {
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection -ArgumentList "Server=$ServerInstance;User ID=$Username;Password=$Password;"
    $SqlConnection.Open()

    Write-Log "Acceso a la base de datos establecida."

    # Bases de datos a respaldar
    $Databases = @("master", "model", "msdb")

    foreach ($DatabaseName in $Databases) {
        $BackupFile = "$BackupDir\$DatabaseName-$Date.bak"
        $BackupQuery = "BACKUP DATABASE [$DatabaseName] TO DISK = N'$BackupFile' WITH INIT, FORMAT, SKIP, NOREWIND, NOUNLOAD"

        # Ejecutar el respaldo
        $SqlCommand = New-Object System.Data.SqlClient.SqlCommand -ArgumentList $BackupQuery, $SqlConnection
        $SqlCommand.ExecuteNonQuery()

        Write-Log "Backup de la base de datos $DatabaseName completado. Archivo: $BackupFile"
    }

    $SqlConnection.Close()
    Write-Log "Acceso a la base de datos cerrada."
}
catch {
    Write-Log "Error al conectar o realizar el respaldo: $_"
}
#endregion

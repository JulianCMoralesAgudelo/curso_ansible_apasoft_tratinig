USE [master]
GO

-- Crear el login para el usuario ansible con la contraseña especificada
CREATE LOGIN [ansible] WITH PASSWORD=N'4Ns1bl3Us3r*', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

-- Agregar el usuario ansible al rol sysadmin para otorgarle permisos administrativos
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ansible]
GO

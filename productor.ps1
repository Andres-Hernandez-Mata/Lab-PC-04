#Autor: Andres Hernandez Mata
#Fecha: 24/03/2021
#Version: 1.0

#Nos movemos al directorio home del usuario
Set-Location $HOME

#Preguntar al usuario su nombre
$nombre = Read-Host "¿Cual es su nombre? "

#Preguntar al usuario su apellido
$apellido = Read-Host "¿Cual es su primer apellido? "

Write-Host "Hola $nombre $apellido" -ForegroundColor Yellow

Write-Host "*** Directorio actual ***"
Get-Location


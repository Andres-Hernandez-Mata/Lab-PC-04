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

Write-Host "*** Directorio actual ***" -ForegroundColor Red
Get-Location

Write-Host "*** Probando la conectividad con un ping a la computadora local 127.0.0.1 ***" -ForegroundColor Red
Test-Connection 127.0.0.1 > ping.txt | Format-Table -AutoSize
Write-Host "Se genero el archivo ping.txt con el resultado" -ForegroundColor Red

Write-Host "*** Consultado el tamaño del directorio home del usuario ***"
Get-ChildItem -Path $HOME -File -Recurse | Measure-Object -Property Length -Sum > size.txt
Write-Host "Se genero el archivo size.txt con el resultado esperado"

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
Write-Host "Se genero el archivo ping.txt con el resultado" -ForegroundColor Green

Write-Host "*** Consultado el tamaño del directorio home del usuario ***" -ForegroundColor Red
Get-ChildItem -Path $HOME -File -Recurse | Measure-Object -Property Length -Sum > size.txt
Write-Host "Se genero el archivo size.txt con el resultado esperado" -ForegroundColor Green

Write-Host "*** Creando 3 archivos .txt ***" -ForegroundColor Red
1..3 | ForEach-Object { New-Item -ItemType File -Name lab$_.txt }
Write-Host "Se generaron lab{1..3}.txt en el directorio actual $HOME" -ForegroundColor Green

Write-Host "*** Nuevo directorio ***" -ForegroundColor Red
$directorio = Read-Host "Ingresar el nombre del directorio"
New-Item -ItemType Directory -Name $directorio
Write-Host "Se genero un nuevo directorio en la ubicacion de $HOME\$directorio" -ForegroundColor Green

Write-Host "*** Copiando los tres archivos generados anteriomente ***" -ForegroundColor Red
1..3 | ForEach-Object { Copy-Item -Path $HOME\lab$_.txt -Destination $HOME\$directorio }
Write-Host "Se copiaron los archivo lab{1..3}.txt en la siguiente ubicacion $HOME\$directorio" -ForegroundColor Green









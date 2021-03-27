<#
    Autor: Andres Hernandez Mata
    Fecha: 24/03/2021
    Version: 2.2
#>

Clear

Set-Location $HOME

function Write-Progress-Bar{
    
    $total = 5
    $i = 0

    for ($i=0; $i -lt $total; $i++) {

        $porcentaje = ($i / $total) * 100
        Write-Progress -Activity 'Espere un momento' -Status "$i %" -PercentComplete $porcentaje
        Sleep 1

    }
}

function Start-Informacion{
    
    $flag = $true

    do {        
        
        $nombre = Read-Host "Ingrese su nombre"
        $apellido = Read-Host "Ingrese sus apellidos"
        if( [string]::IsNullOrEmpty($nombre) -or  [string]::IsNullOrEmpty($apellido) ){
            Clear
            Write-Host 'Favor de verificar los datos ingresados...' -ForegroundColor Red
        } else {
            $flag = $false
            Write-Host "Hola $nombre $apellido" -ForegroundColor Yellow                  
        }
        
    } while ($flag)   
                    
}
#Start-Informacion

function Get-Directorio{
    Write-Host "*** Directorio actual ***" -ForegroundColor Red        
    Get-Location | Format-Table -AutoSize
}
#Get-Directorio

function Ping-Local{
    try{

        Write-Host "*** Probando la conectividad con un ping a la computadora local 127.0.0.1 ***" -ForegroundColor Red
        Test-Connection 127.0.0.1 > ping.txt -ErrorAction Stop | Format-Table -AutoSize | Write-Progress-Bar       
        Write-Host "Se genero un archivo en $HOME\ping.txt con el resultado obtenido" -ForegroundColor Green

    } catch {
        $_.Exception.Message
    }
}
#Ping-Local

function Get-Size{
    Write-Host "*** Consultado el tamaño del directorio home del usuario ***" -ForegroundColor Red
    Get-ChildItem -Path $HOME -File -Recurse | Measure-Object -Property Length -Sum > size.txt
    Write-Host "Se genero un archivo en $HOME\size.txt con el resultado obtenido" -ForegroundColor Green    
}
#Get-Size

function New-File{    
    try {
        Write-Host "*** Creando 3 archivos .txt ***" -ForegroundColor Red    
        1..3 | ForEach-Object { Remove-Item lab$_.txt -ErrorAction Stop }        
        1..3 | ForEach-Object { New-Item -ItemType File -Name lab$_.txt -ErrorAction Stop }                 
        Write-Host "Se generaron lab{1..3}.txt en el directorio actual $HOME" -ForegroundColor Green
    } catch {
        $_.Exception.Message
    }
}
New-File

function New-Directorio{
    Write-Host "*** Nuevo directorio ***" -ForegroundColor Red
    $directorio = Read-Host "Ingresar el nombre del directorio"
    New-Item -ItemType Directory -Name $directorio
    Write-Host "Se genero un nuevo directorio en la ubicacion de $HOME\$directorio" -ForegroundColor Green
}

function Copy-New-File{
    Write-Host "*** Copiando los tres archivos generados anteriomente ***" -ForegroundColor Red
    1..3 | ForEach-Object { Copy-Item -Path $HOME\lab$_.txt -Destination $HOME\$directorio }
    Write-Host "Se copiaron los archivo lab{1..3}.txt en la siguiente ubicacion $HOME\$directorio" -ForegroundColor Green
}

function Copy-File{
    Write-Host "*** Copiando los archivos ping.txt y size.txt en el nuevo directorio ***" -ForegroundColor Red
    Copy-Item -Path $HOME\ping.txt -Destination $HOME\$directorio
    Copy-Item -Path $HOME\size.txt -Destination $HOME\$directorio
    Write-Host "Se copiaron los archivos ping.txt y size.txt en $HOME\$directorio" -ForegroundColor Green
}

function Read-Directorio{
    Write-Host "*** Listando el contenido del nuevo directorio ***" -ForegroundColor Red
    Get-ChildItem $HOME\$directorio
}

function Open-Script{
    Write-Host "*** Llamando al script consumidor.ps1 y enviando parametros ***" -ForegroundColor Red
    D:\Scripts\Lab-PC-04\consumidor.ps1 $nombre $apellido
}


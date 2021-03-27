<#
    Autor: Andres Hernandez Mata
    Fecha: 24/03/2021
    Version: 3.0
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
   
$flag = $true

do {        
    
    $nombre = Read-Host "Ingrese su nombre"
    $apellido = Read-Host "Ingrese sus apellidos"    
    if( [string]::IsNullOrEmpty($nombre) -or  [string]::IsNullOrEmpty($apellido) ){
        Clear
        Write-Host 'Favor de verificar los datos ingresados...' -ForegroundColor Red
    } else {
        $flag = $false
        Write-Host "Hola $nombre $apellido" -ForegroundColor Green
        Get-Directorio
     }
        
} while ($flag)

function Get-Directorio{
    Write-Host "*** Directorio actual ***" -ForegroundColor Red        
    Get-Location | Format-Table -AutoSize
    Ping-Local
}

function Ping-Local{
    try{

        Write-Host "*** Probando la conectividad con un ping a la computadora local 127.0.0.1 ***" -ForegroundColor Red
        Test-Connection 127.0.0.1 > ping.txt -ErrorAction SilentlyContinue | Format-Table -AutoSize 
        Write-Host "Se genero un archivo en $HOME\ping.txt con el resultado obtenido" -ForegroundColor Green
        Get-Size

    } catch {
        $_.Exception.Message
    }
}

function Get-Size{
    Write-Host "*** Consultado el tamaño del directorio home del usuario ***" -ForegroundColor Red
    Get-ChildItem -Path $HOME -File -Recurse | Measure-Object -Property Length -Sum > size.txt
    Write-Host "Se genero un archivo en $HOME\size.txt con el resultado obtenido" -ForegroundColor Green    
    New-File
}


function New-File{    
    try {

        Write-Host "*** Creando 3 archivos .txt ***" -ForegroundColor Red                        
        
        1..3 | ForEach-Object { 
            if(Test-Path lab$_.txt){
               Write-Host "Archivo lab$_.txt ya existe en $HOME\lab$_.txt" -ForegroundColor Green
            } else {
                New-Item -ItemType File -Name lab$_.txt -ErrorAction SilentlyContinue
            }
        }
                                           
        Write-Host "Los archivos lab{1..3}.txt estan en el directorio actual $HOME" -ForegroundColor Green
        New-Directorio

    } catch {
        $_.Exception.Message
    }
}

function New-Directorio{
    
    $flag = $true

    try {

        do {

            Write-Host "*** Nuevo directorio ***" -ForegroundColor Red
            $directorio = Read-Host "Ingresar el nombre del directorio"
            if( [string]::IsNullOrEmpty($directorio) ){
                Clear
                Write-Host 'Favor de verificar los datos ingresados...' -ForegroundColor Red
            } else {
                if(Test-Path $HOME\$directorio){
                    Clear
                    Write-Host "Ya existe un elemento con el nombre especificado: $HOME\$directorio" -ForegroundColor Red                  
                } else {
                    New-Item -ItemType Directory -Name $directorio -ErrorAction SilentlyContinue         
                    Write-Host "Se genero un nuevo directorio en la ubicacion de $HOME\$directorio" -ForegroundColor Green
                    Copy-New-File($directorio)
                    $flag = $false
                }                             
            }                       

        } while($flag)

    } catch {
        $_.Exception.Message        
    }
    
}

function Copy-New-File($directorio){
    try {

        Write-Host "*** Copiando los tres archivos generados anteriomente ***" -ForegroundColor Red
        1..3 | ForEach-Object { Copy-Item -Path $HOME\lab$_.txt -Destination $HOME\$directorio -ErrorAction SilentlyContinue }
        Write-Host "Se copiaron los archivo lab{1..3}.txt en la siguiente ubicacion $HOME\$directorio" -ForegroundColor Green
        Copy-File($directorio)

    } catch {
        $_.Exception.Message
    }
}

function Copy-File($directorio){
    try {

        Write-Host "*** Copiando los archivos ping.txt y size.txt en el nuevo directorio ***" -ForegroundColor Red
        Copy-Item -Path $HOME\ping.txt -Destination $HOME\$directorio -ErrorAction SilentlyContinue
        Copy-Item -Path $HOME\size.txt -Destination $HOME\$directorio -ErrorAction SilentlyContinue
        Write-Host "Se copiaron los archivos ping.txt y size.txt en $HOME\$directorio" -ForegroundColor Green
        Read-Directorio($directorio)

    } catch {
        $_.Exception.Message
    }
}

function Read-Directorio($directorio){
    try {

        Write-Host "*** Listando el contenido del nuevo directorio ***" -ForegroundColor Red
        Get-ChildItem $HOME\$directorio | Format-Table -AutoSize      

    } catch {
        $_.Exception.Message
    }
}


try {
    Write-Host "*** Llamando al script consumidor.ps1 y enviando parametros ***" -ForegroundColor Red
    $consumidor = "D:\Scripts\Lab-PC-04\consumidor.ps1 $nombre $apellido"
    Invoke-Expression $consumidor
} catch {
    $_.Exception.Message
}


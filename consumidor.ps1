<#
    Autor: Andres Hernandez Mata
    Fecha: 24/03/2021
    Version: 2.1
#>

param(    
    [string]$nombre,
    [string]$apellido
)

$archivo = $false
$directorio = $false

clear

Write-Host "*** Borrar archivo o directorio ***" -ForegroundColor Red
$ruta = Read-Host "Ingresar la ruta del directoio o archivo que quiere borrar"

Write-Host "*** Verificando si la ruta ingresada existe ***" -ForegroundColor Red

try{
    
    $file = Get-Item $ruta -ErrorAction Ignore
        
    if(Test-Path $ruta){
        Write-Host "La ruta si exite en $ruta" -ForegroundColor Green
        
        Write-Host "*** Verificando si es un directorio o archivo ***" -ForegroundColor Red       
        if(!$file.PSisContainer){
            Write-Host "La ubicacion $ruta indica que es un archivo" -ForegroundColor Green
            $archivo = $true
            $elemento = 'archivo'
        } elseif ($file.PSisContainer){
            Write-Host "La ubicacion $ruta indica que es un directorio" -ForegroundColor Green
            $directorio = $true
            $elemento = 'directorio'
        }

         Write-Host "*** Comprobando si tiene permisos de lectura y/o escritura ***" -ForegroundColor Red
         if($file.IsReadOnly){
            Write-Host "Usted tiene permisos de lectura en $ruta" -ForegroundColor Green
         } elseif (!$file.IsReadOnly){
            Write-Host "Usted tiene permisos de lectura y escritura en $ruta" -ForegroundColor Green
         }

         $flag = $true
         
         do {
            
            $delete = Read-Host "Desea borrar el $elemento ingresado (true/false)"
            
            if ($delete -eq "true"){
                Remove-Item $ruta
                Write-Host "Se borro correctamente" -ForegroundColor Green
                $flag = $false
            } elseif ($delete -eq "false"){                               
                $flag = $false
            } else {
                Clear
                $flag = $true
            }

         } while($flag)
         
         Write-Host "Adios $nombre $apellido"   
    
    } else {
        Write-Host "La ruta no exite en $ruta" -ForegroundColor Red
        return
    }   

} catch {
    $_.Exception.Message            
    Write-Host 'Favor de verificar los datos ingresados...' -ForegroundColor Red
}


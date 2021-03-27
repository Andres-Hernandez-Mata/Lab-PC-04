#!/usr/bin/bash

<<COMMENT
    Autor: Andres Hernandez Mata
    Fecha: 24/03/2021
    Version: 2.0
COMMENT

#Funcion para simular un progress bar con movimiento
function progress_bar(){
    echo -ne '\e[92m#####                     (33%)\e[0m\r'
    sleep 1
    echo -ne '\e[92m#############             (66%)\e[0m\r'
    sleep 1
    echo -ne '\e[92m#######################   (100%)\e[0m\r'
    echo -ne '\n'
}

clear

cd $HOME

flag=true

while $flag
do
    echo -e "\e[92m¿Cual es su nombre?\e[0m"
    read nombre
    echo -e "\e[92m¿Cual es su primer apellido?\e[0m"
    read apellido
    
    if [[ -z "$nombre" || -z "$apellido" ]];
    then
        clear
        echo -e "\e[91mFavor de verificar los datos ingresados...\e[0m"
    else
        echo -e "\e[92mHola $nombre $apellido\e[0m"
        flag=false
    fi
    
done

#Funcion para obtener el directorio actual donde estamos ubicados
function get_directorio(){
    echo -e "\e[91m*** Directorio actual ***\e[0m"
    progress_bar
    pwd
}
get_directorio

#Funcion para probar la conectividad a la computadora local 127.0.0.1
function ping_local(){
    echo -e "\e[91m*** Probando la conectividad con un ping a la computadora local 127.0.0.1 ***\e[0m"
    ping -c 4 127.0.0.1 > ping.txt
    progress_bar
    echo -e "\e[92mSe genero un archivo en $HOME/ping.txt con el resultado obtenido\e[0m"
}
ping_local

#Funcion para obtener el tamaño del directorio solicitado
function get_size(){
    echo -e "\e[91m*** Consultado el tamaño del directorio home del usuario ***\e[0m"
    du -sh $HOME > size.txt
    progress_bar
    echo -e "\e[92mSe genero un archivo en $HOME/size.txt con el resultado obtenido\e[0m"
}
get_size

#Funcion para crear algunos archivos .txt
function new_files(){
    echo -e "\e[91m*** Creando 3 archivos .txt ***\e[0m"
    touch lab{1..3}.txt
    progress_bar
    echo -e "\e[92mLos archivos lab{1..3}.txt estan en el directorio actual $HOME\e[0m"
}
new_file

#Funcion para crear un nuevo directorio solicitando primero el nombre y 
#verificar que no exista ya en el directorio home
function new_directorio(){
    flag=true
    while $flag
    do
        echo -e "\e[91m*** Nuevo directorio ***\e[0m"
        echo -e "\e[92mIngresar el nombre del directorio\e[0m"
        read directorio
        
        if [[ -z "$directorio" ]];
        then
            clear
            echo -e "\e[91mFavor de verificar los datos ingresados...\e[0m"
        else
            if [[ -e $HOME/$directorio ]];
            then
                clear
                echo -e "\e[91mYa existe un elemento con el nombre especificado: $HOME/$directorio\e[0m"
            else
                mkdir $directorio
                progress_bar
                echo -e "\e[92mSe genero un nuevo directorio en la ubicacion de $HOME/$directorio\e[0m"
                flag=false
            fi            
        fi

    done            
}
new_directorio

#Funcion para copiar los archivos .txt en el nuevo directorio
function copy_new_files(){
    echo -e "\e[91m*** Copiando los tres archivos generados anteriomente ***\e[0m"
    cp lab{1..3}.txt $HOME/$directorio
    progress_bar
    echo -e "\e[92mSe copiaron los archivo lab{1..3}.txt en la siguiente ubicacion $HOME/$directorio\e[0m"
}
copy_new_files

#Funcion para copiar los archivos generado en el nuevo directorio creado
function copy_files(){
    echo -e "\e[91m*** Copiando los archivos ping.txt y size.txt en el nuevo directorio ***\e[0m"
    cp ping.txt size.txt $HOME/$directorio
    progress_bar
    echo -e "\e[92mSe copiaron los archivos ping.txt y size.txt en $HOME/$directorio\e[0m"
}
copy_files

#Funcion para obtener el contenido del nuevo directorio
function read_directorio(){
    echo -e "\e[91m*** Listando el contenido del nuevo directorio ***\e[0m"
    progress_bar
    tree -a $HOME/$directorio
}
read_directorio

#Llamar al script consumidor.sh y enviar parametros
echo -e "\e[91m*** Llamando al script consumidor.sh y enviando parametros ***\e[0m"
progress_bar
sh ./consumidor.sh $nombre $apellido

exit 0

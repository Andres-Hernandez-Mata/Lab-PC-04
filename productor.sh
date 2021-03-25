#!/usr/bin/bash

#Funcion para simular un progress bar con movimiento
function progress_bar(){
    echo -ne '\e[42m#####                     (33%)\e[0m\r'
    sleep 1
    echo -ne '\e[42m#############             (66%)\e[0m\r'
    sleep 1
    echo -ne '\e[42m#######################   (100%)\e[0m\r'
    echo -ne '\n'
}

cd $HOME

echo -e "\e[93m¿Cual es su nombre?\e[0m"
read nombre

echo -e "\e[93m¿Cual es su primer apellido?\e[0m"
read apellido

echo -e "\e[104mHola $nombre $apellido\e[0m"

echo -e "\e[91m*** Directorio actual ***\e[0m"
progress_bar
pwd

echo -e "\e[91m*** Probando la conectividad con un ping a la computadora local 127.0.0.1 ***\e[0m"
ping -c 4 127.0.0.1 > ping.txt
progress_bar
echo -e "\e[92mSe genero el archivo ping.txt con el resultado\e[0m"

echo -e "\e[91m*** Consultado el tamaño del directorio home del usuario ***\e[0m"
du -sh $HOME > size.txt
progress_bar
echo -e "\e[92mSe genero el archivo size.txt con el resultado esperado\e[0m"

echo -e "\e[91m*** Creando 3 archivos .txt ***\e[0m"
touch lab{1..3}.txt
progress_bar
echo -e "\e[92mSe generaron lab{1..3}.txt en el directorio actual $HOME\e[0m"

echo -e "\e[91m*** Nuevo directorio ***\e[0m"
echo -e "\e[93mIngresar el nombre del directorio\e[0m"
read directorio

mkdir $directorio
progress_bar
echo -e "\e[92mSe genero un nuevo directorio en la ubicacion de $HOME/$directorio\e[0m"

echo -e "\e[91m*** Copiando los tres archivos generados anteriomente ***\e[0m"
cp lab{1..3}.txt $HOME/$directorio
progress_bar
echo -e "\e[92mSe copiaron los archivo lab{1..3}.txt en la siguiente ubicacion $HOME/$directorio\e[0m"

echo -e "\e[91m*** Copiando los archivos ping.txt y size.txt en el nuevo directorio ***\e[0m"
cp ping.txt size.txt $HOME/$directorio
progress_bar
echo -e "\e[92mSe copiaron los archivos ping.txt y size.txt en $HOME/$directorio\e[0m"

echo -e "\e[91m*** Listando el contenido del nuevo directorio ***\e[0m"
progress_bar
tree -a $HOME/$directorio

echo -e "\e[91m*** Llamando al script consumidor.sh y enviando parametros ***\e[0m"
progress_bar
sh ./consumidor.sh $nombre $apellido

exit 0


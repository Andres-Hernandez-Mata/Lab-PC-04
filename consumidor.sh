#!/usr/bin/bash

<<COMMENT
    Autor: Andres Hernandez Mata
    Fecha: 24/03/2021
    Version: 2.0
COMMENT

nombre=$1
apellido=$2

flag=true

echo "\e[91m*** Borrar archivo o directorio ***\e[0m"
echo "\e[92mIngresar la ruta del directoio o archivo que quiere borrar\e[0m"
read ruta

echo "\e[91m*** Verificando si la ruta ingresada existe ***\e[0m"
if [ -e "$ruta" ];
then 
	
	echo "\e[92mLa ruta si exite en $ruta\e[0m"

	echo "\e[91m*** Verificando si es un directorio o archivo ***\e[0m"
	if [ -f "$ruta" ]
	then
		echo "\e[92mLa ubicacion $ruta indica que es un archivo\e[0m"
		elemento="archivo"
	elif [ -d "$ruta" ]
	then
		echo "\e[92mLa ubicacion $ruta indica que es un directorio\e[0m"
		elemento="directorio"
	fi

	echo "\e[91m*** Comprobando si tiene permisos de lectura y/o escritura ***\e[0m"
	if [ -r "$ruta" ] 
	then 
		echo "\e[92mUsted tiene permisos de lectura en $ruta\e[0m"
	elif [ -w "$ruta" ]
	then
		echo "\e[92mUsted tiene permisos de lectura y escritura en $ruta\e[0m"
	fi
	
	flag=true
	while $flag
	do
		echo "\e[92mDesea borrar el $elemento ingresado (si/no)\e[0m"
		read delete
		if [ "$delete" = "si" ]
		then
			if [ "$elemento" = "directorio" ]
			then
				rm -r $ruta
			else 
				rm $ruta			
			fi
			flag=false
			echo "\e[92mSe borro correctamente\e[0m"
		elif [ "$delete" = "no" ]
		then
			flag=false
		else 
			clear		
		fi
	done
	
	echo "\e[92mAdios $1 $2\e[0m"

else 
   	echo "\e[91mLa ruta no exite en $ruta\e[0m"
	echo "\e[104mAdios $1 $2\e[0m"
	exit 1
fi

exit 0

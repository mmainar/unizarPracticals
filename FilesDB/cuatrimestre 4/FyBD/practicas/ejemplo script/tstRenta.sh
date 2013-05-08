#!/bin/ksh 
#
############################################################
# ejemplo de script
############################################################
#
#set -x
echo
echo Ejemplo de sencillo script que pondria en ejecucion un programa llamado renta, 
echo pasandole un fichero de entrada y un fichero de salida...
echo
# El programa implementado, renta, solicita el fichero con
# la tabla de la renta (por defecto "RENTA.DAT") y
# el nombre del fichero de texto a generar (por
# defecto "tabla.txt"). Para la ejecución automatica
# se habran introducido los nombres de dichos ficheros (de 
# entrada y de salida) en el fichero de texto "datPrueba.txt", 
# uno en cada linea.
#
echo
echo "compilación del programa (depende del lenguaje)"
echo ". . . . . ."
#
# ........ depende del lenguaje utilizado
#
echo
echo ejecución del programa con los datos:
# ejecución del programa de la renta con los datos:
#
cat datPrueba.txt
#
echo
# Ejecutamos redirigiendo la salida estandar a un fichero, 
# y la salida de error a otro.
# $$ es el identificador de proceso, para que sea mas dificil
# sobreescribir ningun fichero previo

renta < datPrueba.txt 2> /tmp/$$.error >/tmp/$$.salida
#
# test del resultado de la ejecución
#
#
error=$?
if [ $error -eq 0 ]
then
  echo se ha ejecutado sin problemas
  echo
# visualización del fichero de texto obtenido
#
  echo "desea ver el fichero obtenido (S/N) ?\c"
  read resp
  if [[ $resp = "S" ]]
  then
    cat nwTabla.txt
  fi
else
  echo "desea ver la salida del programa?"
  read resp
  if [[ $resp = "S" ]]
  then
	cat /tmp/$$.salida
  fi
  echo "desea ver la salida de error del programa?"
  read resp
  if [[ $resp = "S" ]]
  then
	cat /tmp/$$.error
  fi
fi
#
# comparación del resultado obtenido con el patrón
# (las diferencias apareceran en pantalla)
if [ $error -eq 0 ]
then
  echo
  echo comparacion con el fichero patron "tabla.txt":
#
diff nwTabla.txt tabla.txt
#
	if [ $? -eq 0 ]
	then
	  echo la solución es correcta
	  echo y se elimina el fichero de texto
	  echo
	  rm nwTabla.txt
	else
	  echo la solución NO ES CORRECTA
	fi
fi
echo

# Limpieza....
/bin/rm /tmp/$$.salida /tmp/$$.error

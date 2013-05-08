# Ejecutamos redirigiendo la salida estandar a un fichero.
# $$ es el identificador de proceso, para que sea mas dificil
# sobreescribir ningun fichero previo

cp /users2/FYBD/P2005/P1/DOW_10_4Q05.dat .
pmenu1 < prueba_menu > $$.salida

# test del resultado de la ejecucion
error=$?
if [ $error -eq 0 ]
then
  echo se ha ejecutado sin problemas
  echo
# visualización del fichero de salida
fi
  echo "desea ver la salida del programa?(S/Otra tecla)"
  read resp
  if [[ $resp = "S" ]]
  then
        more $$.salida
  else
      echo "La salida no se mostrara"
  fi

rm DOW_10_4Q05.dat
  # Limpieza...
  echo "desea borrar el fichero de salida del programa?(S/Otra tecla)"
  read resp
  if [[ $resp = "S" ]]
  then
    /bin/rm $$.salida
  else
    echo "El fichero no ha sido borrado"
  fi

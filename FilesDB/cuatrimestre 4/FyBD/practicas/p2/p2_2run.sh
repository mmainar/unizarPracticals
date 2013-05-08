# Ejecutamos redirigiendo la salida estandar a un fichero.
# $$ es el identificador de proceso, para que sea mas dificil
# sobreescribir ningun fichero previo

cp /users2/FYBD/P2005/P2/DOW_10_4Q05.dat .
ordenar < prueba_ordenacion > $$.salida

# test del resultado de la ejecucion
error=$?
if [ $error -eq 0 ]
then
  echo se ha ejecutado sin problemas
  echo
# visualización del fichero de salida
fi
  echo "desea ver la salida del programa?(S/N)"
  read resp
  if [[ $resp = "S" ]]
  then
        more $$.salida
  fi

  # Limpieza...
  echo "desea borrar el fichero de salida del programa?(S/N)"
  read resp
  if [[ $resp = "S" ]]
  then
    /bin/rm $$.salida
  fi

rm DOW_10_4Q05.dat
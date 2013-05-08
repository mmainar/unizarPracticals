# Ejecutamos redirigiendo la salida estandar a un fichero.
# $$ es el identificador de proceso, para que sea mas dificil
# sobreescribir ningun fichero previo

cp /users2/FYBD/P2005/P3/DOW_10_4Q05.dat .
gnatmake p3_3sai
gnatmake pmenu
p3_3sai < entrada_sai > $$.salidaSai
pmenu < prueba_menu > $$.salida

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

# Limpieza....
echo "desea borrar el fichero de salida del programa?(S/N)"
  read resp
  if [[ $resp = "S" ]]
  then
        /bin/rm $$.salida
  fi

rm DOW_10_4Q05.dat DOW_10_4Q05.dir DOW_10_4Q05.idx
count=39
while [ $count -ge 1 ]
do
  comando="$HOME/COMPII/practica4/maquinap $HOME/COMPII/practica4/bateriaDePruebas/prueba$count"
  echo prueba$count
  eval $comando
  count=`expr $count - 1`
  echo "Pulse cualquier tecla para pasar al siguiente programa de prueba"
  read resp 
done

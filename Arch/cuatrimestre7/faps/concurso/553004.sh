#Compilamos las librerias necesarias
./compilarLibs.sh presum
ar r libpresum.a presum.o

#Compilamos el Secuencial
./compilarSec.sh 553004_s 4

#Compilamos el Paralelo
./compilarPar.sh 553004_p

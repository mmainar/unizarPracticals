###########################################
## Makefile para compilar los utiles
## en GNU/Linux pot I~naki Ra~no' (Ir - 2007)
## [probado en Debian Sarge]
## Si tienes algun problema, mail to: irano@unizar.es

SRC = geometria.adb graficas.adb listas.adb textos.adb vectores.adb
OBJ := $(SRC:.adb=.o)
## Este es el include que indica donde estan
## los fichero ada-plotuil, sustituyelo con el
## path correspondiente
CFLAGS = -I/home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/ada-plotutil
LFLAGS = -L/home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/plotutils-2.3/libplot
 

%: %.o

%.o: %.adb
	gnat compile $(CFLAGS) $<

%.o: %.ads
	gnat compile $(CFLAGS) $<

all: gnu.o $(OBJ) configuracion.o prueba_utiles

prueba_utiles: prueba_utiles.adb
	gnat compile $(CFLAGS) $<
	gnat bind $(CFLAGS) $@
	gnat link $(CFLAGS) $@

configuracion.o: configuracion.ads
gnu.o: gnu.ads

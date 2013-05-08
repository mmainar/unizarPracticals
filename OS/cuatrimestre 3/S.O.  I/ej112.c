/*ej112.c con open(O_APPEND)*/
#include <fcntl.h>
#include <stdio.h>

main() {
	int fd;
	close(1); /*Cierro el descriptor de la TDF correspondiente a la salida estándar, stdout*/
	fd=open("quien_hay",O_WRONLY|O_APPEND);
	if (fd == 1)
		fprintf(stderr, "Salida Redireccionada\n");
	else{
		fprintf(stderr,"Virus\n");
		exit(1);
	}
	execl("/bin/date","date",0); /* date >> quien_hay */
}
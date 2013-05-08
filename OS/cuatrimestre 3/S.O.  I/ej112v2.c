/*ej112.c con lseek*/
#include <fcntl.h>
#include <stdio.h>

main() {
	int fd, where;
	close(1); /*Cierro el descriptor de la TDF correspondiente a la salida estándar, stdout*/
	fd=open("quien_hay",O_WRONLY,O_CREAT);
	where=lseek(fd,1,2);/*Nos posicionamos al final del fichero quien_hay*/
	if (fd == 1)
		fprintf(stderr, "Salida Redireccionada\n");
	else{
		fprintf(stderr,"Virus\n");
		exit(1);
	}
	execl("/bin/date","date",0); /* date >> quien_hay */
}
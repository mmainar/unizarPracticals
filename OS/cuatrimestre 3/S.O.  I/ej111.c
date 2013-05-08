/*ej111.c */
#include <fcntl.h>
#include <stdio.h>

main() {
	int fdin,fdout;
	close(0); /*Cierro el descriptor de la TDF correspondiente a la entrada estándar, stdin*/
	if ( (fdin= open("quien_hay.tmp",O_RDONLY)) == 0)
		fprintf(stderr,"Entrada estandar redireccionada\n");
	else{
		fprintf(stderr,"Ha ocurrido algún tipo de error\n");
	        exit(1);
	}
	close(1); /*Cierro el descriptor de la TDF correspondiente a la salida estándar, stdout*/
	if ( (fdout=creat("quien_hay",0640)) == 1)
		fprintf(stderr,"Salida estandar redireccionada\n");
	else{
		fprintf(stderr,"Ha ocurrido algun tipo de error\n");
		exit(1);
	}
	execlp("sort","sort",0);
}
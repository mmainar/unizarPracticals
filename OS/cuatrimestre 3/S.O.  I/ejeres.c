#include <stdio.h>
#include <sys/types.h>
#include <string.h>
main( ) {
	int id, estado,fd;
	
	
	printf("linea de texto n 1\n");
	if ((id=fork( )) == 0) {
		close(1);
		fd=creat("salida.dat",0777);
		write(fd,"linea de texto n 2\n",19);
		exit(1);
	}
	else{
		while(wait(&estado) !=id);
		write(1,"linea de texto n 3\n",19);
		exit(0);
	}
 }

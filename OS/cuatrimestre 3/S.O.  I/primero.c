/*primero.c*/

#include <stdio.h>

main()
{
	int id, estado;
	
	
	close(1);
	creat("salida.dat",0777);
	write(1,"linea\n",6);
	if ( ( id = fork() ) == 0 ) {
		execl("/home/marcos/so/segundo","segundo",0);
		exit(1);
	}
	else {
		while (wait(&estado)!=id);
		write(1,"linea\n",6);
		exit(0);
	}
}
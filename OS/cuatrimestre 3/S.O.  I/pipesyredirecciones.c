#include <stdio.h>
main( ) 
{
	int fd[2];
	
	
	pipe(fd);
	switch( fork() ) {
		case 0: /*hijo: productor de la tubería, el que escribe en ella*/
			close(fd[0]); /*Cerramos el extremo de lectura por limpieza*/
		        close( 1 );
			dup(fd[1]);
			close(fd[1]);
			execlp("who","who",0);
		default: /*padre: consumidor de la tubería, el que lee de ella*/
			close(fd[1]); /*Cerramos el extremo de escritura de la tubería para no quedarnos bloqueados, no lo necesitamos*/
			close(0);
			dup(fd[0]);
			close(fd[0]);
			execlp("sort","sort",0);
	}
}
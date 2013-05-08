/* ej70.c */
#include <sys/types.h>
#include <stdio.h>
main()
{
         pid_t getpid();
	 int pidh;
	 printf("Inicio prueba\n");
	 if ( (pidh=fork())== 0 ) {
	           fprintf( stderr, "\n\tSoy el hijo: %d\n", getpid() );
		   fprintf( stdout, "\n\tFork me devuelve: %d\n", pidh );
		   exit(0);
	 }
	 fprintf( stderr, "Antes de sleep\n");
	 wait(NULL);
	 fprintf( stdout, "\n\tSoy el padre: %d\n", getpid() );
	 fprintf( stdout, "\n\tFork me devuelve: %d\n", pidh );
}

/*ej901.c*/
#include <stdio.h>
#include <signal.h>
#define MAL (void (*) () ) -1

void trap( );

main( ) {
	if ( signal(SIGALRM,trap) == MAL)
		fprintf(stderr,"error signal\n");
	alarm(2);
	getchar( );
	pause( );
	puts("Aqui seguiria el programa...\n");
}

void trap ( ) { };
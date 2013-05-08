/*ej90.c*/
#include <signal.h>
#include <stdio.h>

main( ) {
	void newhandler( );
	unsigned seg;
	void (* syshandler) ( );
	char *s;
	
	syshandler = signal(SIGALRM,newhandler);
	seg = alarm(5); /*Aquí podemos ahorrarnos el seg */
	s = "Me bloqueo esperando la alarma\n";
	printf("%s",s);
	pause( );
	s = "Ya me he despertado\n";
	printf("%s",s);
	exit(0);
}

void newhandler( ) {
	char *s;
	
	s="En la rutina de servicio\n";
	printf("%s",s);
	return;
}
/* duerme.c */
/* Programa que mantiene bloqueado al proceso
  que lo llama durante el numero de segundos
  pasado como parametro                 */


#include "error.h"
#include <stdio.h>
#include <string.h>
#include <signal.h>


void captura(n) {
 printf("En la funcion de captura...\n");
}


main(argc,argv)
int argc; char *argv[];
{
 int tiempo;

 signal(SIGALRM,captura);
 tiempo= (int)*argv[1] - (int)('0');
 alarm(tiempo);
 pause();
 printf("Fin bloqueo\n");
}/*main*/

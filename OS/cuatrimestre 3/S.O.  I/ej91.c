/* ej91.c */
/* Programa que lanza un mensaje a pantalla
  cada X segundos durante Y segundos.
  Para ello, ejecuta un fork y el proceso
  hijo lanza mensajes indefinidamente cada X
  segundos. Pasados Y segundos el proceso padre
  suspende la ejecución del proceso hijo
  X e Y se pasan como parametros al programa */


#include "error.h"
#include <stdio.h>
#include <string.h>
#include <signal.h>


void capturaHijo(n) {
 signal(SIGALRM,capturaHijo);
 printf("Mensaje del hijo \n");
}

void capturaPadre(n) {
 printf("Fin del programa\n");
}

main(argc,argv)
int argc; char *argv[];
{
 int tiempoHijo,tiempoPadre,pid;
 switch (pid=fork() )  {
   case -1:   /*error*/
     fprintf(stderr,"\n No se puede crear proceso nuevo\n");
     syserr("fork");
   case 0:   /*hijo*/
     signal(SIGALRM,capturaHijo);
     while (1) { /*Lanza mensajes a pantalla indefinidamente cada X segundos*/
       tiempoHijo=(int)*argv[1]-(int)('0');
       alarm(tiempoHijo);
       pause();
       }
   default: /*padre*/
       signal(SIGALRM,capturaPadre);
       tiempoPadre=(int)*argv[2]-(int)('0');
       alarm(tiempoPadre); /* Espera Y segundos antes de suspender la ejecución
                             del proceso hijo. */
       pause();
       kill(pid,SIGKILL); /* Mandamos señal 9 para matar al hijo pasados los
                             Y segundos */
 } /*switch*/
} /*main*/


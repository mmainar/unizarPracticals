/* shpar.c */
/* Programa que ejecuta 2 aplicaciones en paralelo
  cuyos nombres recibe en la línea de comandos.
  Las aplicaciones a ejecutar podran tener parametros
  y entre la especificacion de la primera aplicacion
  y la segunda habra un simbolo +                  */


#include "error.h"
#include <stdio.h>
#include <string.h>


main(argc,argv)
int argc; char *argv[];
{
 int i, separador;

 for (i=1; (strcmp(argv[i],"+")!=0); i++);
 separador = i; argv[separador] = NULL; i++;
 /* Nos quedaremos apuntando a la posicion del "+" */
 switch ( fork() ) {
   case -1:       /*error*/
     fprintf(stderr,"\nNo se puede crear proceso nuevo\n");
     syserr( "fork" );
   case 0:        /*hijo*/ /*ejecuta la primera aplicacion que se pasa en la linea de comandos*/
     execvp(argv[1],&argv[1]);
     fprintf(stderr,"\nNo se puede ejecutar %s\n",argv[1]);
     syserr( "execvp" );
   default:       /*padre*/
     sleep(2); /*para verlo*/
     execvp(argv[separador+1],&argv[separador+1]); /*ejecuta la segunda aplicacion que se pasa en la linea de comandos*/
     /*no espera al hijo por lo que este quedara zombie*/
     fprintf(stderr,"\nNo se puede ejecutar %s\n",argv[separador+1]);
     syserr( "execvp" );

 }/*switch*/
}/*main*/

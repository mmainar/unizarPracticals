/* ej1001.c
   * Shell elemental con bucle de lectura de comandos con
     parametros
   * Uso: [arre|soo] [comando] [lista parametros]
*/
#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <string.h>
#include "error.h"

#define BUFSIZE 1024
#define TRUE 1
#define FALSE 0

int pid, esperar_hijo;


void fcaptura() {
  signal(sigchld,fcaptura);
  if (pid == wait(NULL) )
    esperar_hijo= FALSE;
}


main()
{
  static char s[BUFSIZE];
  char *argt[BUFSIZE];
  int i, parate, pid;

  signal(sigchld,fcaptura);
  
  while(1) {
    fprintf(stderr, "\n_$ " );
    gets( s );
    argt[0] = strtok( s, " " );
    if ( 0 == strcmp( argt[0], "quit" )) {
      printf("logout\n");
      exit(0);
    }
    
    for( i = 1; (argt[i] = strtok( NULL, " \t" )) != NULL; i++ );
    
    if ( 0 == strcmp( argt[0], "soo" ) )
      parate = TRUE;
    else
      if( 0 == strcmp( argt[0], "arre") )
        parate = FALSE;
      else{
        printf( "\n Mande?" ); continue;
      }
    
    switch ( pid=fork() ) {
      case -1:       /* error */
        fprintf(stderr,"\n No se puede crear proceso nuevo\n");
      case 0:        /* hijo */
        if(!parate) sleep(3); /*para que se note mas */
	execvp( argt[1], &argt[1]);
	fprintf(stderr,"\nNo se puede ejecutar %s\n", argt[1] );
      default:       /* padre */   
        if(parate) {
          esperar_hijo = TRUE;
	  while (esperar_hijo)
	    pause();
        } /*if*/ 
   }/*switch*/
  }/*while*/
}/*main*/  
      

     

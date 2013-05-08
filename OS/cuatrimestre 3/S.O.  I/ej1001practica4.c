/* ej1001.c
        * Shell elemental con bucle de lectura de comandos con par'ametros.
        * Uso: [arre|soo] [comando][lista parametros]
        */
#include <stdio.h>
#include <string.h>
#include "error.h"
#include <signal.h>

#define BUFSIZE 1024
#define TRUE 1
#define FALSE 0


void captura1(n) {
 signal(SIGINT,captura1);
}


void captura2(n) {
 signal(SIGQUIT,captura2);
}

main( )
{
       static char s[BUFSIZE];
       char *argt[BUFSIZE];
       int i, parate, pid;


       while(1){
               fprintf( stderr, "\n_$ " );
               gets( s );
               argt[0] = strtok( s, " " );

               if( 0 == strcmp( argt[0], "quit" )){
                       write( 2, "logout\n", 7);
                       exit( 0 );
                       }

               for( i = 1;
                    (argt[i] = strtok( NULL, " \t" )) != NULL;
                    i++ );

               if( 0 == strcmp( argt[0], "soo" ) )
                       parate = TRUE;
               else
                       if( 0 == strcmp( argt[0], "arre" ) )
                               parate = FALSE;
                       else{
                               printf( "\n Mande?" ); continue;
                            }

               switch ( pid=fork() )
               {
                 case -1:      /* error */
                       write(2,"\nNo se puede crear proceso nuevo\n",33 );
                       syserr( "fork" );

                 case 0:       /* hijo */
                       if(!parate) sleep(3);/*para que se note mas*/
                       execvp( argt[1], &argt[1]);
                       fprintf(stderr,"\nNo se puede ejecutar %s\n", argt[1] );
                       syserr( "execvp" );

                 default:      /* padre */
                               signal(SIGINT,captura1);
                               signal(SIGQUIT,captura2);
                               if( parate)
                                       while( pid != wait( NULL))
                                          if( pid == -1 ){
                                            write(2,"\nMuy raro. Bye\n",15);
                                            exit( 1 );}
               }/*switch*/
       }/*for*/
}/*main*/

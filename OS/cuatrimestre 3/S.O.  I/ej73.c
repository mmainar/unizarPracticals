/* ej73.c
        * Shell elemental con bucle de lectura de comandos con parametros.
        */
#include <stdio.h>
#include <string.h>

#define BUFSIZE 1024

main( )
{
       static char s[BUFSIZE];
       char *argt[BUFSIZE];
       int i;


       for(;;){
               fprintf( stderr, "\n_$ " );
               if(gets(s)==NULL) {printf("logout\n"); exit(0);}
               argt[0] = strtok( s, " " );

               if( 0 == strcmp( argt[0], "quit" )){
                       printf("logout\n");
                       exit( 0 );
                       }

               for( i = 1; (argt[i] = strtok( NULL, " \t" )) != NULL; i++ );

               switch ( fork() )
               {
                 case -1:      /* error */
                       fprintf(stderr, "\nNo se puede crear proceso nuevo\n");
                       /*syserr( "fork" );*/

                 case 0:       /* hijo */
                       execvp( argt[0], &argt[0]);
                       fprintf(stderr,"\nNo se puede ejecutar %s\n", argt[1] );
                      /*syserr( "execvp" );*/

                 default:      /* padre */
                      wait( NULL);
               }/*switch*/
       }/*for*/
}/*main*/
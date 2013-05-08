/* ej71.c
        * Curso Unix
        * Mayo 1990
        * Shell elemental sin parametros.
        */
#include <stdio.h>
/*#include "error.h"*/

main( argc, argv )
int argc; char *argv[];
{
       switch ( fork() )
       {
         case -1:      /* error */
           fprintf( stderr, "no se puede crear proceso nuevo\n" );
           /*syserr( "fork" );*/

         case 0:       /* hijo */
           execlp(argv[1], argv[1], 0);
           printf( "No se puede ejecutar %s\n", argv[1]);
           fflush( stdout );
           /*syserr( "execlp" );*/

       default:        /* padre */
           wait( NULL );
             /*syserr( "wait" ); /* trat. erroneo? */
           printf( "Ejecutado %s \n", argv[1] );
           fflush( stdout );
           exit( 0 );
       }
}
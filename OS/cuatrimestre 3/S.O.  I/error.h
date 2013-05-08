/* error.h
                                * En este fichero se define la funcion
                                * syserr()
                                * Incluir "error.h" detras de todos
                                * los demas includes
                                */
#include <errno.h>
#include<stdio.h>
void syserr( men )
char *men;
{
       extern int errno, sys_nerr;
       extern char *sys_errlist[];

       fprintf( stderr, "Error %s (%d", men, errno );

       if (errno > 0 && errno < sys_nerr )
               fprintf( stderr, "; %s)\n", sys_errlist[errno] );
       else
               fprintf( stderr, ")\n" );

       exit( 1 );
}


void error( men )
char *men;
{
       extern int errno, sys_nerr;
       extern char *sys_errlist[];

       fprintf( stderr, "Error %s (%d", men, errno );

       if (errno > 0 && errno < sys_nerr )
               fprintf( stderr, "; %s)\n", sys_errlist[errno] );
       else
               fprintf( stderr, ")\n" );
}

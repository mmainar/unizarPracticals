/* ej100.c      con modo[5] funciona.... */
#include <stdio.h>
#include "error.h"
#define TRUE 1
#define FALSE 0

main()
{
       char com[10], modo[4];
       int parate, pid;

       while (1)
       {
               write(2, "\n?? ", 4);
               fflush(stdin);
               scanf( "%s%s", com, modo);
               if( 0 == strcmp( modo, "soo" ) )
                       parate = TRUE;
               else
                       if( 0 == strcmp( modo, "arre" ) )
                               parate = FALSE;
                       else{
                               printf( "\n Mande?" );
                               fflush(stdin);
                               continue;
                            }
               switch( pid = fork() ){
                       case -1:
                               syserr( "fork" );
                       case 0:
                               write( 2, "Hijo\n", 5);
                               write( 2, com, strlen(com));
                               fflush(stdin);
                               execlp(com,com,0);
                               syserr( "execlp" );

                       default:
                               write( 2, "Padre\n", 6);
                               if( parate)
                                       while( pid != wait( NULL))
                                          if( pid == -1 ){
                                            printf( "\nMuy raro. Bye\n" );
                                            exit( 1 );
                                               }
               }
       }
}

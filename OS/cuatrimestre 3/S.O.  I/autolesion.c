    /* Autolesion Violenta. SisOpsPostInfo 92.
           * Cfr. Bach p 24?
           */

#include <signal.h>
#include <stdio.h>
#define MAL (int (*)()) -1

main()
{
 int i, *ip;
 void func(), captura();

 ip = (int *) func;
 for( i= 1; i <20; i++ )
     if( i != 9 )   /* no podemos proteger la SIGKILL (9) */
       if( signal( i, captura ) == MAL )
              fprintf(stderr, "signal error\n" );

 *ip = 1;
 printf( "Asignado ip\n" );
 func();
}

void func(){}

void captura( n )
int n;
{
 printf( "Capturada %d\n", n );
 exit( 1 );
}

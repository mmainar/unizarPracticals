     /* ej221.c
        * Curso UNIX. Victor Vinyals.
        * Mayo 1990.
        * Lanza dos procesos que se ejecutan de forma concurrente.
        *   A diferencia de ej22.c, son lanzados directamente por el
        *   mismo padre, que luego hace dos wait(), de forma que
        *   ninguno de los dos queda zombie.
        *   Los printf() de cada proceso evidencian el "interleaving".
        *
#include <stdio.h>

main( argc, argv )
int argc; char *argv[];
{
       int i, maxveces;

       maxveces = atoi( argv[1] );
       if ( fork()==0  ){
               for( i = 0; i < maxveces; i++ )
                       fprintf(stderr, "**" );

       /* Preciso utilizar salida sin buffer (vgr. stderr, o usar
        *   write()), ya que en otro caso el interleaving visto
        *   en pantalla no seria el real, sino el producto
        *   de la escritura de buffers. Para verlo, basta hacer
        *   este programa usando printf.
        */
               printf( "\tsoy ** y me muero\n" );
               exit( 0 );
       }

       if ( fork()==0  ){
               for( i = 0; i < maxveces; i++ )
                       fprintf(stderr, "--" );
               printf( "\tsoy -- y me muero\n" );
               exit( 0 );
       }

       wait(NULL);
       wait(NULL);
}
/* ej64.c
        * Curso UNIX
        * Mayo 1990
        * Pr'actica de salidas con/ sin 'buffer'.
        *      Ejecutar el programa; ejecutar luego ej64 > fich y ver
        *      la salida en fich: el mensaje de printf no aparece,
        *      ya que es una salida con buffer. Usar setbuf(),
        *      fflush(), o fprintf( stderr,..) (la salida stderr
        *      se realiza sin buffer). fprintf, printf, scanf... son
        *      I/O con buffer de caracteres. Read, write... son I/O
        *      con buffer de bloques. Cfr. los progrs.
        *      anteriores del curso y Darnell & Margolis pp. 343-344,
        *      y 359.
        */
#include <stdio.h>
#include "error.h"

main()
{
       printf( "\n\tSi estais aburridos hacedlo notar\n" );
/*      fflush( stdout );  */
       execl( "/bin/echo", "echo", "\tcon", "una", "leve", "sonrisa\n");
       syserr( "execl" );
}

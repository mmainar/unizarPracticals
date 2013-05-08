 /* filtro.c
        * Mayo 1990.
        * Copia la entrada en la salida. <fcntl.h> contiene
        *   O_RDONLY. "error.h" contiene syserr (cfr. Rochkind. M.J
        *   (1985).- Advanced UNIX Programming. Prentice Hall.)
        */

#define BUFSIZE 2048

main()
{
       int cuenta;
       char buf[BUFSIZE];

       while ( (cuenta = read( 0, buf, sizeof( buf ) )) > 0 )
               write( 1, buf, cuenta );
}
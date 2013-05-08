/* ex#4.0.c
 * padre de ex#4.1.c
 * Ejercicio 1 Examen 6/6/94, 4 Telecos
 * He puesto algunos mensajes que facilitan el seguimiento de la
 * ejecucion desde una terminal, y que no puse en el funte del examen
 * para no complicarlo.
 */
#include<stdio.h>
#include<signal.h>
#include<errno.h>

char s[] = "El suenyo de la razon produce monstruos";
char m2[] = "Y el de la conciencia dictaduras";
int fd1, fd2, p, out;
FILE *fd;
main()
{
       int tubo[2];
       int n;
       void foo();
       void quux();
       char buf[BUFSIZ];

       out = open("/dev/tty", 1 );
       fd = fdopen( out, "w+" );
       setbuf( fd, NULL);

       signal( SIGTERM, quux);
       signal( SIGALRM, foo);
       setbuf( stdout, NULL );
       setbuf(stderr, NULL);

       mknod( "fifo1", 010666, 0);
       mknod( "fifo2", 010666, 0);
       fd1 = open("fifo1", 2);
       fd2 = open("fifo2", 2);
       p = getpid();
       printf( "pid1 %d\n", getpid());
       fork();
       pipe(tubo);
       switch(fork()) {
       case -1 : exit( 1 );
       case 0 :
         if( getppid() != p ){
           close( 0 );
           dup( tubo[0] );
           close( tubo[1] );
           close( 1 );
           dup( fd2 );
           close( fd2 );
           close( fd1 );
           pause();
           execl( "ex#4.1", "ex#4.1", 0 );
         }
         else {
           close( 0 );
           dup( fd2 );
           close( fd2 );
           close( 1 );
           dup( tubo[1] );
           close( tubo[1] );
           close( tubo[0] );
           close( fd1 );
           pause();
           execl( "ex#4.1", "ex#4.1", 0 );
         }
       default:
         break;
       }

       if( getpid() == p ){
         close( 0 );
         close( 1 );
         close( fd2 );
         close( tubo[1] );
         dup( tubo[0] );
         dup( fd1 );
         close( tubo[0] );
         close( fd1 );
         alarm( 2 );
         pause();
         kill( 0, SIGALRM );
         execl( "ex#4.1", "ex#4.1", 0 );
       }
       else {
         close( tubo[0] );
         close( 1 );
         close( 0 );
         close( fd2 );
         dup( fd1 );
         close( fd1 );
         dup( tubo[1] );
         close( tubo[1] );
         write( 1, s, sizeof(s) );
         pause();
         while(1){
           n = read( 0, buf, sizeof(buf));
           write( 1, buf, n);
           write( 2, buf, n);
           fprintf( stderr, "(%d)\n", getpid());
           fflush(stderr);
         }
       }
}

void foo(){
 signal( SIGALRM, foo );
}

void quux()
{

 signal( SIGTERM, quux );

 write( 2, m2, sizeof( m2 ) );
 fprintf( stderr, "(%d)\n", getpid());
 fflush( stderr);

/*  unlink( "fifo1" );
 unlink( "fifo2" );
 kill( 0, SIGKILL );
 write( out, s, sizeof(s) );
*/
}

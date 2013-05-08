/* ex#4.1.c
 * hijo de ex#4.0.c.
 */
#include<stdio.h>
#include<signal.h>
#include<string.h>

void quux(n)
int n;
{
 signal( n, quux);
 fprintf( stderr, "SIG: %d\n", n);
}

void fubar(n)
int n;
{
 signal(n, fubar );
 kill( getppid(), SIGTERM );
}

main()
{
       int n, i;
       char buf[BUFSIZ];
       char *s;

       for( i =0; i<20;i++){
         if( i != 9 )
           if( i == 16 )
             signal(i, fubar);
           else
             signal( i, quux );
       }

       while( 1){
         if( (n = read( 0, buf, sizeof(buf)))!= 0 ){
           write( 1, buf, n);
           write( 2, buf, n);
           fprintf( stderr, "(%d)\n", getpid());
           fflush(stderr);
         }
       }
}
/* forkfiles.c
          * IntroUnix Enero 1993
          * Padre e hijo acceden a los mismos ficheros a traves del
          * cursor.
          */
#include<fcntl.h>
#include<stdio.h>

int sfd, tfd;
char c;

main(argc, argv)
int argc; char **argv;
{
 if( argc != 3 )
   exit( 1 );

 sfd = open( argv[1], O_RDONLY );
 tfd = creat( argv[2], 0777 );
 fork();

 copy();
 exit( 0 );
}

copy()
{
 for(;;){
   if( read( sfd, &c, 1) != 1)
     return;
   write( tfd, &c, 1 );
 }
}
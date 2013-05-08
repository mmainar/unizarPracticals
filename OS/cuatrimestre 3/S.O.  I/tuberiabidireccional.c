#include <string.h>

char string[] = "Hello world";

main()
{
       int count, i;
       int to_par[2], to_chil[2];
       char buf[256];

       pipe(to_par);/*Creamos la tubería del padre*/
       pipe(to_chil);/*Creamos la tubería del hijo*/
       if( fork() == 0 ) /*hijo*/
       {
               close(0);
               dup(to_chil[0]);
               close(1);
               dup(to_par[1]);
               close(to_par[1]);
               close(to_chil[0]);
               close(to_par[0]);
               close(to_chil[1]);
               for(;;)
               {
                       if((count = read(0,buf,sizeof(buf))) == 0)
                               exit(1);
                       write(1,buf,count);
               }
       } /*Padre*/
       close(1);
       dup(to_chil[1]);
       close(0);
       dup(to_par[0]);
       close(to_chil[1]);
       close(to_par[0]);
       close(to_chil[0]);
       close(to_par[1]);
       for( i = 0; i<15; i++ )
       {
               write(1,string,strlen(string));
               read(0,buf,sizeof(buf));
       }

}
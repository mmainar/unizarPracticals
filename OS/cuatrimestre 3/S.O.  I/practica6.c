#include <stdio.h>
#include <string.h>
#include <fcntl.h>

#define sizebuff 10

main(argc,argv)
 char *argv[]; int argc;
{
 int leido, error, fd;
 char buff[sizebuff];

 if (argv[1]!=NULL) {
   if((fd=open(argv[1],O_WRONLY)) == -1)
     fd= creat(argv[1],0666);
   else
     lseek(fd,1,2); }
 while(1){
   leido=read(0,buff,sizeof(buff));
   switch (leido) {
     default:
       if (argv[1]!=NULL)  
         error=write(fd,buff,leido);
       else
         error=write(1,buff,leido);
   }
 }
}

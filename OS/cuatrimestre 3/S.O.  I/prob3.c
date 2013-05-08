 /* prob3.c
              */
#include<stdio.h>
#include<signal.h>

main()
{
 char c = 'c';
 void foo();
 int fd0, fd1, fd2, pid0, pid1, pid2, term;

 pid0 = pid1 = pid2 = 0; /* para evitar warnings molestos */

 fd0 = creat("f0", 0666);
 fd1 = creat("f1", 0666);
 fd2 = creat("f2", 0666);
 close(fd0); close(fd1);close(fd2);

 fd0 = open("f0", 2);
 fd1 = open("f1", 2);
 fd2 = open("f2", 2);

 term = open("/dev/tty", 1); /* solo para ver la traza del programa...*/

 signal(SIGUSR1, foo );

 if((pid0 = fork()) == 0)
   while(1)
     {
       pause();
       read(fd0, &c, 1);
       lseek(fd0, 0L, 0);
       write(fd1, &c, 1);
       lseek(fd1, 0L, 0);
       write(term,"uno\n", 4);
       kill(getppid(), SIGUSR1);
     }
 if((pid1 = fork()) == 0)
   while(1)
     {
       pause();
       read(fd1, &c, 1);
       lseek(fd1, 0L, 0);
       write(fd2, &c, 1);
       lseek(fd2, 0L, 0);
       write(term,"dos\n", 4);
       kill(getppid(), SIGUSR1);
     }
 if((pid2 = fork()) == 0)
   while(1)
     {
       pause();
       read(fd2, &c, 1);
       lseek(fd2, 0L, 0);
       write(fd0, &c, 1);
       lseek(fd0, 0L, 0);
       write(term,"tres\n", 5);
       kill(getppid(), SIGUSR1);
     }

     write(fd0, &c, 1);
     lseek(fd0, 0L, 0);

 while(1)
   {
     kill(pid0, SIGUSR1);
     pause();
     kill(pid1, SIGUSR1);
     pause();
     kill(pid2, SIGUSR1);
     pause();
   }

}

void foo(){ signal(SIGUSR1, foo); }

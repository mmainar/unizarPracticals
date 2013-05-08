#include <errno.h>
#include <stdio.h>
main() {
  int pid;
  switch(fork())  {
  case -1:perror("fork"); exit(1);
  case 0 :
     pid=getppid();
     printf("pid padre antes = %d\n",pid);
     sleep(4); /* Damos tiempo a que muera el padre. */
     pid=getppid();
     printf("pid padre despues = %d\n",pid);
     exit(15);
  default:
     sleep(2);
     exit(0);
  }
}

/*      ej81.c  */


main()
{
int pid;
switch(fork()) {
       case 0 :
               pid=getppid();
               printf("pid padre antes = %d\n",pid);
               sleep(10);
               pid=getppid();
               printf("pid padre despues = %d\n",pid);
               exit(15);
       default:
               sleep(20);
               exit(0);
       }
}
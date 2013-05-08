#include <signal.h>
#include <stdio.h>

void f(){
       signal(SIGUSR1,f);
       fprintf(stderr,"-");
}

main(){
int pid;

       signal(SIGUSR1,f);

       if((pid=fork())==0){
               pid=getppid();
               while(1){
                       fprintf(stderr,"h");
                       kill(pid,SIGUSR1);
                       pause();
               }
       }
       else{
               pause();
               while(1){
                       fprintf(stderr,"p");
                       kill(pid,SIGUSR1);
                       pause();
               }
       }
}

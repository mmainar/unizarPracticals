#include <signal.h>
#include <stdio.h>

void f(){
        signal(SIGUSR1,f);
        fprintf(stderr,"-");
}

main(){
int pid;
sigset_t x,y;

        sigemptyset(&x);
        sigemptyset(&y);
        sigaddset(&x,SIGUSR1);
        sigprocmask(SIG_BLOCK,&x,&y);

        signal(SIGUSR1,f);


        if((pid=fork())==0){
                pid=getppid();
                while(1){
                        fprintf(stderr,"h");
                        kill(pid,SIGUSR1);
                        sigsuspend(&y);

                }
        }
        else{
                /*sigsuspend(&y);*/
                while(1){
                        fprintf(stderr,"p");
                        kill(pid,SIGUSR1);
                        sigsuspend(&y);
                }
        }
}



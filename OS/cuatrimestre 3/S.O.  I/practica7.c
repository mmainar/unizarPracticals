#include <stdio.h>
#include <signal.h>

int pelota, fd[2];

void captura1(n)
int n;
{
	signal(SIGUSR1,captura1);
	pelota=0;
	write(fd[1],&pelota,sizeof(int));
}

void captura2(n)
int n;
{
	signal(SIGUSR2,captura1);
	pelota=0;	
}



main() {
	int pid, padre, id;
	
	pipe(fd);
	signal(SIGUSR1,captura1);
	signal(SIGUSR2,captura2);
	if ( (id=fork()) == 0) /*hijo*/
	{
		pid=getpid(); padre=getppid();
		pelota=0;
		write(fd[1],&pelota,sizeof(int));
		while (1){
			read(fd[0],&pelota,sizeof(int));
			fprintf(stdout,"Proceso %d, pelota = %d\n",pid,pelota);
			sleep(1);
			if (pelota==5) kill(padre,SIGUSR1);
			if (pelota==10){ kill(padre,SIGKILL); exit(0) ; }
			pelota++;
			write(fd[1],&pelota,sizeof(int));
		}/*while*/
	}
	else /*Padre*/ {
		pid=getpid();
		pelota=0;
		write(fd[1],&pelota,sizeof(int));
		while (1){
			read(fd[0],&pelota,sizeof(int));
			fprintf(stdout,"Proceso %d, pelota = %d\n",pid,pelota);
			sleep(1);
			if (pelota==5) { kill(id,SIGKILL); exit(0);}
			pelota++;
			write(fd[1],&pelota,sizeof(int));
		}/*while*/
	}
}

		
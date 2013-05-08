* alarmas.c
    * Mayo 94, SisOps Teleco
    * El padre se proteje de SIGALRM.
    * El hijo no hereda la senyal, pero se proteje de
    * SIGTERM. El padre se bloquea en pause, es desbloqueado
    * por su alarma, y envia una SIGTERM al hijo, que de
    * otra forma quedaria bloqueado en un pause.
    *
    * PROBAD EL EJERCICIO COMPILANDO CON EL SIGNAL DEL HIJO
    * COMENTADO, Y LUEGO QUITANDO EL COMENTARIO!!!!!!!
    */

#include<stdio.h>
#include<signal.h>
#include<sys/wait.h>

main()
{
 void rut_serv();
 void rut_hijo();
 int pid;
 int estado;

 signal(SIGALRM, rut_serv);
 alarm(20);
 if( (pid = fork()) == 0){
   /* signal( SIGTERM, rut_hijo);*/
   pause();
   exit(0);
 }
 pause();
 kill( pid, SIGTERM );
 wait(&estado);
 if(WIFSIGNALED(estado))
       printf("%d murio por la senyal %d\n", pid, WTERMSIG(estado));
 exit(0);
}

void rut_serv(n)
int n;
{
 printf( "Alarma %d\n", n);
}
void rut_hijo(n)
int n;
{
 printf( "Acabar %d\n", n);
}
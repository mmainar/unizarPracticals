/*ej2.c*/
#include <stdio.h>

main()
{
	int pid, pid1,estado;
	
	if ( ( pid = fork( ) ) < 0 ) printf("error fork\n");
	else   if (pid == 0) {
		
		   if ( ( pid = fork( ) ) < 0 ) printf("error fork\n");
	           else  if ( pid ) 
		               {
				       /*exit(0);*/
				       fprintf(stderr,"El PID de P3 es = %d\n",pid);
			       }
		   sleep( 2 );
		   fprintf(stderr, "Mi padre tiene PID = %d, pid vale = %d\n",getppid(), pid);
		   exit(0);
		       }
	while ( ( pid1 = wait (&estado ) ) > 0 )
	{
		fprintf(stderr, "Wait devuelve %d\n", pid1);
	}
	exit(0);
}
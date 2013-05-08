/*replicar.c*/

#include <fcntl.h>
#include <stdio.h>


main(argc,argv)
int argc; char *argv[];
{
	char *error="Codigo de error de valor 2\n";
	int fd1,fd2,fd3;
	void copia();
	void copiaYEscribePant();
	if (argc<2) { write(2,error,27); exit(0); }
	else {
		
		if (argc==2){
			fd1=creat(argv[1],0777);
			copiaYEscribePant(0,fd1);
		}
		else{
			fd1=open(argv[3],0777);
			fd2=creat(argv[1],0777);
			fd3=creat(argv[5],0777);
			copia(fd1,fd2);
			copia(fd1,fd3);
		}
	}
}

void copiaYEscribePant(fnt,dst)
int fnt,dst;
{
	int cuenta;
	char buf[BUFSIZ];
	
	while ( ( cuenta = read (fnt,buf,sizeof(buf) ) ) > 0 ) {
		write(dst,buf,cuenta);
		write(1,buf,cuenta);
	}
}


void copia(fnt,dst)
int fnt,dst;
{
	int cuenta;
	char buf[BUFSIZ];
	
	while ( ( cuenta = read (fnt,buf,sizeof(buf) ) ) > 0 ) 
		write(dst,buf,cuenta);
}
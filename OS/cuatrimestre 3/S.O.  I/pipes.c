#include <stdio.h>
main(argc, argv) 
int argc; char *argv[ ];
{
	int fpipe[2], file, n; char buf[512];

	
        pipe(fpipe); /*Creamos la tubería*/
	switch(fork() ) {
		case 0:  /*hijo -> es el productor*/
			close(fpipe[0]); /* Esta linea no sería necesaria pero la ponemos por limpieza, el hijo no necesita el extremo de lectura de la tubería, es el productor*/
			file = open(argv[1],0); 
		        while ((n=read(file,buf,sizeof(buf)))!=0)
				write(fpipe[1],buf,n); /*Al morir, el hijo cierra el extremo de escritura*/
			printf("Fichero leido\n");
			break;
		default: /*padre -> es el consumidor*/
			close(fpipe[1]); /*Sin esta línea, nos quedamos bloqueados porque el padre aun tiene el extremo de escritura abierto*/
			file=creat(argv[2],0600);
		        while ((n=read(fpipe[0],buf,sizeof(buf)))!=0)
				write(file,buf,n);
			printf("Fichero copiado\n");
	}
	exit(0);
}
	
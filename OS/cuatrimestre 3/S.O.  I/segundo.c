/*segundo.c*/

#include <stdio.h>
#include <sys/file.h>

main()
{
	int idf, id;
	
	idf = open("salida.dat",O_WRONLY);
	write(idf,"linea\n",6);
	id = dup(1);
	lseek(id,0,SEEK_SET);
	write(id,"linea\n",6);
	write(idf,"linea\n",6);
	close(idf);
	close(id);
	close(1);
	exit(0);
}
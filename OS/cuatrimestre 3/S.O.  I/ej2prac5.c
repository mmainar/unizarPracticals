#include <stdio.h>
#include <strings.h>


int parser(origen,destino)
   char *origen; char *destino[ ];
{
	int i; int numPalabras;
	
	i=0; destino[0]=*origen; numPalabras=1;
	
	while( (origen+i) != NULL) {
	        if( (strcmp(*(origen+i)," ") !=0) || strcmp(*(origen+i),"\t") !=0 ) {
			*(origen+i)='/0'; destino[i]=*(origen+i); numPalabras++; }
	        i++;
	}
	
	
}
   


main() {
	char origen; char destino[500];
	origen="esto es muy  util";
	parser(&origen,&destino);
	printf("%s\n",origen);
	
	
	
}
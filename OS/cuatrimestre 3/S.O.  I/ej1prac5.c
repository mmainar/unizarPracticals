#include <stdio.h>
#include <strings.h>

char almacen[100]; 


int itoa(i,buff)
  int i; char *buff;
{
   int contador=0;
   int longitud,num;
	
   num=i;	
   while(num != 0) {
	   almacen[contador]='0'+(num%10);
	   num=num/10;
	   contador++;
   }
   buff=almacen;
   return contador;
}

int invertir(buff, longitud)
  char *buff; int longitud;
{
  char temporal;  
  int posicion, i;
	
  posicion=0; i=0;
  while(posicion<=(longitud/2) ){
	  temporal= almacen[i];
	  almacen[i]=almacen[longitud-i-1];
	  almacen[longitud-i-1]=temporal;
	  posicion++;i++;
  }
  return 0;	
}


main(){
	char *buff;
	int longitud;	
	char cadena[100]; 
	
	printf("Probando la funcion para el numero 4999998\n");
	longitud=itoa(4999998,&buff);
	printf("La longitud del numero es: %d\n",longitud);
	printf("La cadena sin invertir es: %s\n",almacen);
	invertir(almacen,longitud);
	printf("La cadena es: %s\n",almacen);
	
}

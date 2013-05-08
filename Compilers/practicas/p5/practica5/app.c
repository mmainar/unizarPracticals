/**********************************************************************
 * fichero: app.c
 *          Aplicacion con menu interactivo en modo texto que encadena
 *          todas las practicas de la asignatura Compiladores II.
 *
 * realizado por: Marcos Mainar Lalmolda
 *
 * fecha ultima modificacion: 3 de junio de 2009
 *
 *
 **********************************************************************/



#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int mostrar_menu()
/* Muestra por pantalla el menu en modo texto de la aplicacion */
{
  int opcion = -1;
  
  while (!(opcion >= 0 && opcion <= 5))
  {
    printf("-----------------------------------------\n");
    printf("0. Salir\n");
    printf("1. Compilacion\n");
    printf("2. Generacion de codigo intermedio\n");
    printf("3. Ensamblar codigo intermedio\n");
    printf("4. Interpretacion\n");
    printf("5. Cambiar el fichero de trabajo\n");
    printf("-----------------------------------------\n");
    printf("Introduce una opcion: ");
    scanf("%d", &opcion); 
  }
  
  return opcion;
}


int main(int argc, char **argv)
{ 
  int opcion, salir = 0;
  char fich[100], namein[100], comando[100], resp[5];
  FILE *f;
  
  printf("Introduzca el nombre del fichero fuente Pascual con el que desea trabajar (sin extension .pc): ");
  scanf("%s", &fich);
  strcpy (namein, fich);
  strcat (namein, ".pc");
  f = fopen (namein, "r");
  
  if (f == NULL) {
    fprintf (stderr, "Fichero %s no existe\n", namein);
    exit (-1);
  }
  
  while ( !salir )
  {
    opcion = mostrar_menu();
    
    switch (opcion)
    {
      case 0: salir = 1; 
              break;

      case 1: printf("Desea compilar el programa paso a paso (S/N)?: ");
              scanf("%s", resp);
	      if (strcmp(resp, "S") == 0)
	        sprintf(comando, "pascual1 %s -w", fich);
              else if (strcmp(resp, "N") == 0)
	        sprintf(comando, "pascual1 %s", fich);	
	      else {
	        printf("Error en la respuesta, no se mostraran warnings\n");	 
		sprintf(comando, "pascual1 %s", fich);
	      }	
              printf("Compilando el fichero...\n"); 
              
              system(comando);
              break;

      case 2: printf("Generando codigo intermedio...\n"); 
              sprintf(comando, "pascual %s", fich);
              system(comando);
	      break; 
	      
      case 3: printf("Ensamblando codigo intermedio...\n");	      
              sprintf(comando, "ensamblador %s", fich);
	      system(comando);
	      break;

      case 4: printf("Desea interpretar el programa paso a paso (S/N)?: ");
              scanf("%s", resp);
	      if (strcmp(resp, "S") == 0)
	        sprintf(comando, "maquinap %s -t", fich);
              else if (strcmp(resp, "N") == 0)
	        sprintf(comando, "maquinap %s", fich);	
	      else printf("Error en la respuesta, se interpretara el programa de una vez\n");		
              printf("Interpretando el fichero...\n"); 
                
              system(comando);
              break;	  
	      
      case 5: fclose(f);
              printf("Introduzca el nombre del fichero fuente Pascual con el que desea trabajar (sin extension .pc): ");
              scanf("%s", &fich);
              strcpy (namein, fich);
              strcat (namein, ".pc");
              f = fopen (namein, "r");     
	      break; 

    }    
  }
  
  fclose(f);  
}

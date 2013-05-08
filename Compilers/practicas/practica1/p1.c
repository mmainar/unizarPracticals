/**********************************************************************
* Practicas de Compiladores II, 2008/2009
* Fichero: p1.c
*          Funciones del analizador sintactico y semantico de codigo P
* autor: Marcos Mainar Lalmolda
* fecha: 19-MAR-09
***********************************************************************/

#include <stdio.h>
#include <stdarg.h>
#include <limits.h> /* Para el rango de short int */
#include "etiquetas.h"
#include "codigop.h"

extern int lineno, linepos;
extern FILE* yyout;
int instno = -1; /* Para saber el numero de instruccion en que nos encontramos para
   	            poner las referencias adecuadas en las etiquetas.
		    -1 porque incrementamos antes de generar. */
int numPasada = 1; /* Para saber el numero de pasada en la que nos encontramos.
		      En la primera pasada rellenamos la tabla de etiquetas y
		      en la segunda pasada generamos el codigo binario. */
		      
int error = 0;  /* Flag que indica si ha habido error semantico */
int numInst = 0; /* Para controlar saltos mas alla del final del programa */

/**********************************************************************/

void tratar_instruccion_sin_argumentos (int instruccion)
{ 
  instno++;
  if (numPasada == 2) generar(yyout, instruccion);
}


void tratar_instruccion_con_1_argumento (int instruccion, int arg1)
{    
  instno++;  
  if (numPasada == 2) 
  { 
    generar(yyout, instruccion, arg1);
  
    /* Tratamiento de errores */  
    switch (instruccion)
    {
      case STC:  if ((arg1 < SHRT_MIN) || (arg1 > SHRT_MAX))
                 {
		   printf("ERROR SEMANTICO! (%d, %d): La instruccion STC tiene un argumento fuera del rango permitido para el mismo.\n",
		           lineno, linepos);
		   printf("El rango permitido es [%d, %d]\n", SHRT_MIN, SHRT_MAX);
	  	   error = 1;	
		 }  
                 break;
      case ENP: if (arg1 == instno)
                 {
		   printf("ERROR SEMANTICO! (%d, %d): La instruccion ENP no puede saltar a si misma\n",
		           lineno, linepos);
	  	   error = 1;	
		 }
		 if (arg1 <= 0) 
                 {
	           printf("ERROR SEMANTICO! (%d, %d): La instruccion ENP tiene el argumento erroneo\n", 
		           lineno, linepos);
	  	   error = 1;	
	         }
		 if (arg1 > numInst)
		 {		 
		   printf("ERROR SEMANTICO! (%d, %d): La instruccion ENP no puede saltar a una instruccion mas alla del final del programa\n", 
		           lineno, linepos);
	  	   error = 1;	
		 }
		 break;
      case JMP:  if (arg1 == instno)
                 {
		   printf("ERROR SEMANTICO! (%d, %d): La instruccion JMP no puede saltar a si misma\n", 
		           lineno, linepos);
	  	   error = 1;	
		 }
		 if (arg1 <= 0) 
                 {
	           printf("ERROR SEMANTICO! (%d, %d): La instruccion JMP tiene el argumento erroneo\n", 
		           lineno, linepos);
	  	   error = 1;	
	         }
		 if (arg1 > numInst)
		 {		 
		   printf("ERROR SEMANTICO! (%d, %d): La instruccion JMP no puede saltar a una instruccion mas alla del final del programa\n", 
		           lineno, linepos);
	  	   error = 1;	
		 }
		 break;
      case JMF:
      case JMT:  if (arg1 <= 0) 
                 {
	           printf("ERROR SEMANTICO! (%d, %d): La instruccion tiene el argumento erroneo\n", 
		           lineno, linepos);
	  	   error = 1;	
	         }
		 if (arg1 > numInst)
		 {		 
		   printf("ERROR SEMANTICO! (%d, %d): no se puede saltar a una instruccion mas alla del final del programa\n", 
		           lineno, linepos);
	  	   error = 1;	
		 }
		 break;
      case RD:
      case WRT: if ((arg1 != 0) && (arg1 != 1)) 
                {
	          printf("ERROR SEMANTICO! (%d, %d): La instruccion no puede tener un argumento distinto de 0 o 1\n", 
		          lineno, linepos);
	    	  error = 1;	
	        }
		break;
      default : ;
     }	      
  }
}


void tratar_instruccion_con_2_argumentos (int instruccion, int arg1, int arg2)
{    
  instno++;  
  if (numPasada == 2) 
  {  
    generar(yyout, instruccion, arg1, arg2);
  
    /* Tratamiento de errores de los argumentos de SRF */
    if ((arg1 < 0) || (arg2 <= 0))
    {
      printf("ERROR SEMANTICO! (%d, %d): La instruccion SRF tiene algun argumento erroneo\n", 
	      lineno, linepos);
      error = 1;		
    }
  }
}


void tratar_instruccion_con_3_argumentos (int instruccion, int arg1, int arg2, int arg3)
{    
  instno++;  
  if (numPasada == 2) 
  {
    generar(yyout, instruccion, arg1, arg2, arg3);
  
    /* Tratamiento de errores en los argumentos de OSF  */ 
    if ((arg3 <= 0) || (arg2 < 0) || (arg1 <= 0))
    {
      printf("ERROR SEMANTICO! (%d, %d): La instruccion OSF tiene algun argumento erroneo\n", 
 	      lineno, linepos);
      error = 1;			 
    }
  }
}


void agregar_etiqueta (char *etiqueta)
{ 
  if (numPasada == 1) 
  {
    if (buscar_etiqueta(etiqueta) == NULO) anadir_etiqueta(etiqueta, instno+1);
    else 
    {
      printf("ERROR SEMANTICO! (%d, %d): la etiqueta %s ya ha sido declarada.\n",
              lineno, linepos, etiqueta);
      error = 1;       
    }	      
  }
} 


int referencia (char *etiqueta)
{ 
  int r;
  
  if (numPasada == 2)
  {
    if ((r = buscar_etiqueta(etiqueta)) == NULO)
    {
      printf("ERROR SEMANTICO! (%d, %d): la etiqueta %s no ha sido declarada.\n",
              lineno, linepos, etiqueta);
      error = 1;
      return r;		  
    }		 
    else return r;
  }
  else return NULO; 
}



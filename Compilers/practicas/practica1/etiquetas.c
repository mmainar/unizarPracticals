/**********************************************************************
* Practicas de Compiladores II, 2008/2009
* fichero: etiquetas.c 
*          manejo de etiquetas para el ensamblador de codigo P
***********************************************************************/

/**********************************************************************/
/*                  F I C H E R O S  I N C L U I D O S                */
/**********************************************************************/

#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include "etiquetas.h"

/**********************************************************************/
/*                V A R I A B L E S   E S T A T I C A S               */
/**********************************************************************/

ETIQ etiquetas[MAXETIQ];
int netiqueta = 0;

/**********************************************************************/
void anadir_etiqueta (char *etiqueta, int instr)
/**********************************************************************/
{
   if (netiqueta == MAXETIQ)
   {
	  fprintf(stderr, "(etiquetas): Vector de etiquetas agotado.");
	  exit (1);
   }
   else 
   {
	  etiquetas[netiqueta].nombre = strdup (etiqueta);
	  etiquetas[netiqueta].instr = instr;
	  etiquetas[netiqueta].referenciada = FALSE;
	  ++netiqueta;
   }
}

/**********************************************************************/
int buscar_etiqueta (char *etiqueta)
/**********************************************************************/
{
   int i, encontrada;
   
   i = 0;
   encontrada = FALSE;
   while ((!encontrada) && (i < netiqueta))
   {
		 if (!strcmp(etiquetas[i].nombre, etiqueta))
		 {
			encontrada = TRUE;
	        etiquetas[i].referenciada = TRUE;
		 }
         else
			++i;
   }

   return (encontrada ? etiquetas[i].instr : NULO);
}

/**********************************************************************/
void mostrar_etiquetas ()
/**********************************************************************/
{
   int i;
   
   i = 0;
   fprintf(stderr, "Etiquetas: %d\n\n", netiqueta);
   while (i < netiqueta)
   {
		 fprintf(stderr, "%d: id: %s, instr: %d, ref: %d\n", i, 
				 etiquetas[i].nombre, etiquetas[i].instr, 
				 etiquetas[i].referenciada);
		 ++i;
   }
}

/**********************************************************************/
void mostrar_etiquetas_no_referenciadas ()
/**********************************************************************/
{
   int i;
   
   i = 0;
   while (i < netiqueta)
   {
		 if (!etiquetas[i].referenciada)
		    fprintf(stderr, "Etiqueta no referenciada: %s, instruccion: %d\n", 
		   		    etiquetas[i].nombre, etiquetas[i].instr);
		 ++i;
   }
}


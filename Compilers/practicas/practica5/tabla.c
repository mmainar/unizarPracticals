 /*
 *
 *
 * fichero: tabla.c
 *          funciones para manipular una tabla de simbolos
 *
 * modificado por: Marcos Mainar Lalmolda
 * modificaciones realizadas:  - Permitir el tipo vector de una dimension 
 *                               con indices enteros y las componentes
 *                               pueden ser booleanos, enteros o caracteres.
 *                             - A�adir un campo referenciada en la T.S.
 *			         para indicar si una variable ha sido o no
 *				 referenciada. Cuando una variable se a�ade
 *				 a la T.S. se pone como no referenciada.
 *				 Procedimiento que muestra las variables no
 *				 referenciada.
 *				 				 
 * fecha modificacion: 13 de mayo de 2009
 *
 *
 */
 

/**********************************************************************/
/*                  F I C H E R O S  I N C L U I D O S                */
/**********************************************************************/

#include "listas.h"
#include "tabla.h"
#include <stdio.h>
#include <string.h>
#include <assert.h>

extern int lineno, linepos; /* Para mostrar variables no referenciadas */

/**********************************************************************/
void inicializar_tabla (TABLA_SIMBOLOS tabla)
/**********************************************************************/
{
   int i;

   for (i = 0; i < TAMANO_TABLA; ++i)
	   crear_vacia (&(tabla[i]));
}

/**********************************************************************/
void mostrar_simbolo (SIMBOLO simbolo)
/**********************************************************************/
{
   fprintf (stderr, "%s", simbolo.nombre);
   switch (simbolo.tipo)
   {
		  case PROGRAMA: fprintf (stderr, ":prog"); break;
		  case VARIABLE: fprintf (stderr, ":var"); break;
		  case PARAMETRO: fprintf (stderr, ":par"); break;
		  case ACCION: fprintf (stderr, ":acc"); break;
   }
   if (!simbolo.visible)
	  fprintf (stderr, "(INV!)");
   if ((simbolo.tipo == VARIABLE) || (simbolo.tipo == PARAMETRO))
   {
      switch (simbolo.variable)
      {
		     case ENTERO: fprintf (stderr, ":int"); break;
		     case BOOLEANO: fprintf (stderr, ":bool"); break;
		     case CHAR: fprintf (stderr, ":chr"); break;
		     case VECTOR: { fprintf (stderr, ":vector of "); 
		                    switch (simbolo.tipo_componentes)
				    {
				      case ENTERO: fprintf (stderr, "int"); break;
				      case BOOLEANO: fprintf (stderr, "bool"); break;
				      case CHAR: fprintf (stderr, "char"); break;
				    }
		                    fprintf (stderr, ":%d:%d", 
				             simbolo.indiceInf, simbolo.indiceSup);
				    break;
				  }
      }
      if (simbolo.tipo == PARAMETRO)
         switch (simbolo.parametro)
         {
		        case VAL: fprintf (stderr, ":val"); break;
		        case REF: fprintf (stderr, ":ref"); break;
         }
	  else fprintf (stderr, ":--");
   }
   else fprintf (stderr, ":--:--");
   fprintf (stderr, ":%d", simbolo.nivel); 
   fprintf (stderr, ":%d ", simbolo.dir); 
}

/**********************************************************************/
void mostrar_parametros (LISTA lista)
/**********************************************************************/
{
   int i, n = longitud_lista (lista);
   SIMBOLO *simbolo;

   fprintf (stderr, "[[ ");
   for (i = 1; i <= n; ++i)
   {
	   simbolo = (SIMBOLO*) observar (lista, i);
	   mostrar_simbolo (*simbolo);
   }
   fprintf (stderr, "]] ");
}

/**********************************************************************/
void mostrar_lista_colisiones (int i, LISTA lista)
/**********************************************************************/
{
   int n = longitud_lista (lista);
   SIMBOLO *simbolo;

   fprintf (stderr, "%d: ", i);

   for (i = 1; i <= n; ++i)
   {
	   simbolo = (SIMBOLO*) observar (lista, i);
	   mostrar_simbolo (*simbolo);
	   if ((*simbolo).tipo == ACCION) 
	      mostrar_parametros ((*simbolo).parametros);
   }
   fprintf (stderr, "\n");
}

/**********************************************************************/
void mostrar_tabla (TABLA_SIMBOLOS tabla)
/**********************************************************************/
{
   int i;

   fprintf (stderr, "Tabla de simbolos.\n");
   fprintf (stderr, "----- -- --------.  id:tipo:var:parametro:nivel:dir\n");
   for (i = 0; i < TAMANO_TABLA; ++i)
	   mostrar_lista_colisiones (i, tabla[i]);
}

/**********************************************************************/
int hash (char *nombre)
/**********************************************************************/
{
   int r = 0;

   for ( ; *nombre; ++nombre)
	   r += *nombre;

	return (r % TAMANO_TABLA);
}

/**********************************************************************/
SIMBOLO *buscar_simbolo (TABLA_SIMBOLOS tabla, char *nombre)
/**********************************************************************/
{
   int sitio = hash (nombre);
   SIMBOLO *simbolo = NULL;
   int i = 1, 
	   encontrado = FALSE;

   while (!encontrado && (i <= longitud_lista (tabla[sitio])))
   {
           simbolo = (SIMBOLO *) observar (tabla[sitio], i);

           if ((*simbolo).visible && !strcmp (nombre, (*simbolo).nombre))
			  encontrado = TRUE;
		   else
		      ++i;
   }

   return (encontrado ? simbolo : NULL);
}

/**********************************************************************/
SIMBOLO *tsim_int_programa (TABLA_SIMBOLOS tabla, char *nombre, char* etiq)
/**********************************************************************/
{
   int sitio = hash (nombre);
   SIMBOLO simbolo;

   simbolo.tipo = PROGRAMA;
   simbolo.nombre = strdup (nombre);
   simbolo.nivel = 0;
   strcpy (simbolo.etiq, etiq);
   simbolo.visible = TRUE;
   crear_vacia(&(simbolo.parametros)); /* A�adido PB FIB */

   anadir_izquierda_copiando (&simbolo, &tabla[sitio], sizeof (simbolo));

   return (SIMBOLO *) observar_izquierda (tabla[sitio]);
}
/**********************************************************************/
SIMBOLO *introducir_programa (TABLA_SIMBOLOS tabla, char *nombre, char* etiq)
/**********************************************************************/
{
  return tsim_int_programa (tabla, nombre, etiq);
}

/**********************************************************************/
SIMBOLO *tsim_int_variable (TABLA_SIMBOLOS tabla, char *nombre, TIPO_VARIABLE variable, int nivel, int dir)
/**********************************************************************/
{
   int sitio = hash (nombre);
   SIMBOLO simbolo;

   simbolo.tipo = VARIABLE;
   simbolo.nombre = strdup(nombre);
   simbolo.variable = variable;
   simbolo.nivel = nivel;
   simbolo.dir = dir;
   simbolo.visible = TRUE;

   anadir_izquierda_copiando (&simbolo, &tabla[sitio], sizeof (simbolo));

   return (SIMBOLO *) observar_izquierda (tabla[sitio]);
}

/**********************************************************************/
SIMBOLO *tsim_int_accion (TABLA_SIMBOLOS tabla, char *nombre, int nivel, char *etiq)
/**********************************************************************/
{
   int sitio = hash (nombre);
   SIMBOLO simbolo;

   simbolo.tipo = ACCION;
   simbolo.nombre = strdup(nombre);
   simbolo.nivel = nivel;
   strcpy (simbolo.etiq, etiq);
   simbolo.visible = TRUE;
   crear_vacia (&(simbolo.parametros));

   anadir_izquierda_copiando (&simbolo, &tabla[sitio], sizeof (simbolo));

   return (SIMBOLO *) observar_izquierda (tabla[sitio]);
}

/**********************************************************************/
SIMBOLO *tsim_int_parametro (TABLA_SIMBOLOS tabla, char *nombre, TIPO_VARIABLE variable, CLASE_PARAMETRO parametro,int nivel, int dir)
/**********************************************************************/
{
   int sitio = hash (nombre);
   SIMBOLO simbolo;

   simbolo.tipo = PARAMETRO;
   simbolo.nombre = strdup(nombre);
   simbolo.variable = variable;
   simbolo.nivel = nivel;
   simbolo.dir = dir;
   simbolo.parametro = parametro;
   simbolo.visible = TRUE;
   crear_vacia(&(simbolo.parametros)); /* A�adido PB FIB */

   anadir_izquierda_copiando (&simbolo, &tabla[sitio], sizeof (simbolo));

   return (SIMBOLO *) observar_izquierda (tabla[sitio]);
}

/**********************************************************************/
void eliminar_programa (TABLA_SIMBOLOS tabla)
/**********************************************************************/
{
   int i, j;

   for (i = 0; i < TAMANO_TABLA; ++i)
   {
       j = 1;
       while (j <= longitud_lista (tabla[i]))
       {
           SIMBOLO *simbolo = (SIMBOLO*) observar (tabla[i], j);

           if (((*simbolo).tipo == PROGRAMA) && ((*simbolo).nivel == 0))
			  borrar (&tabla[i], j);
		   else
		      ++j;
       }
   }
}

/**********************************************************************/
void eliminar_variables (TABLA_SIMBOLOS tabla, int nivel)
/**********************************************************************/
{
   int i, j;

   for (i = 0; i < TAMANO_TABLA; ++i)
   {
       j = 1;
       while (j <= longitud_lista (tabla[i]))
       {
           SIMBOLO *simbolo = (SIMBOLO*) observar (tabla[i], j);

           if (((*simbolo).tipo == VARIABLE) && ((*simbolo).nivel == nivel))
			  borrar (&tabla[i], j);
		   else
		      ++j;
       }
   }
}

/**********************************************************************/
SIMBOLO *introducir_variable (TABLA_SIMBOLOS tabla, char *nombre, TIPO_VARIABLE variable, int nivel, int dir)
/**********************************************************************/
{
   SIMBOLO *simbolo = buscar_simbolo (tabla, nombre);

   if (simbolo == NULL)
      simbolo = tsim_int_variable (tabla, nombre, variable, nivel, dir);
   else if ((*simbolo).nivel != nivel)
           simbolo = tsim_int_variable (tabla, nombre, variable, nivel, dir);
   else
	  simbolo = NULL;

   return simbolo;
}

/**********************************************************************/
SIMBOLO *introducir_accion (TABLA_SIMBOLOS tabla, char *nombre, int nivel, char* etiq)
/**********************************************************************/
{
   SIMBOLO *simbolo = buscar_simbolo (tabla, nombre);

   if (simbolo == NULL)
      simbolo = tsim_int_accion (tabla, nombre, nivel, etiq);
   else if ((*simbolo).nivel != nivel)
           simbolo = tsim_int_accion (tabla, nombre, nivel, etiq);
   else
	  simbolo = NULL;

   return simbolo;
}

/**********************************************************************/
SIMBOLO *introducir_parametro (TABLA_SIMBOLOS tabla, char *nombre, TIPO_VARIABLE variable, CLASE_PARAMETRO parametro, int nivel, int dir)
/**********************************************************************/
{
   SIMBOLO *simbolo = buscar_simbolo (tabla, nombre);

   if (simbolo == NULL)
      simbolo = tsim_int_parametro (tabla, nombre, variable, parametro, nivel, dir);
   else if ((*simbolo).nivel != nivel)
           simbolo = tsim_int_parametro (tabla, nombre, variable, parametro, nivel, dir);
   else
	  simbolo = NULL;

   return simbolo;
}

/**********************************************************************/
void ocultar_parametros (TABLA_SIMBOLOS tabla, int nivel)
/**********************************************************************/
{
   int i, j;

   for (i = 0; i < TAMANO_TABLA; ++i)
       for (j = 1; j <= longitud_lista (tabla[i]); ++j)
       {
           SIMBOLO *simbolo = (SIMBOLO*) observar (tabla[i], j);

           if (ES_PARAMETRO(*simbolo) && ((*simbolo).nivel == nivel))
			  (*simbolo).visible = FALSE;
       }
}

/**********************************************************************/
void eliminar_parametros_ocultos (TABLA_SIMBOLOS tabla, int nivel)
/**********************************************************************/
{
   int i, j;

   for (i = 0; i < TAMANO_TABLA; ++i)
   {
       j = 1;
       while (j <= longitud_lista (tabla[i]))
       {
           SIMBOLO *simbolo = (SIMBOLO*) observar (tabla[i], j);

           if (((*simbolo).tipo == PARAMETRO) && (!(*simbolo).visible) && ((*simbolo).nivel == nivel))
			  borrar (&tabla[i], j);
		   else
		      ++j;
       }
   }
}

/**********************************************************************/
void eliminar_acciones (TABLA_SIMBOLOS tabla, int nivel)
/**********************************************************************/
{
   int i, j;

   for (i = 0; i < TAMANO_TABLA; ++i)
   {
       j = 1;
       while (j <= longitud_lista (tabla[i]))
       {
           SIMBOLO *simbolo = (SIMBOLO*) observar (tabla[i], j);

           if (ES_ACCION(*simbolo) && ((*simbolo).nivel == nivel))
		   {
			  liberar (&((*simbolo).parametros));
			  borrar (&tabla[i], j);
		   }
		   else
		      ++j;
       }
   }
}


/* Funciones a�adidas para los vectores */


/**********************************************************************/
SIMBOLO *tsim_int_variable_vector (TABLA_SIMBOLOS tabla, char *nombre, int nivel, int dir, 
                                   TIPO_VARIABLE tipo_componentes, int indiceInf, int indiceSup, 
				   int dimension)
/**********************************************************************/
{
   int sitio = hash (nombre);
   SIMBOLO simbolo;

   simbolo.tipo = VARIABLE;
   simbolo.nombre = strdup(nombre);
   simbolo.variable = VECTOR;
   simbolo.nivel = nivel;
   simbolo.dir = dir;
   simbolo.visible = TRUE;
   simbolo.tipo_componentes = tipo_componentes;
   simbolo.indiceInf = indiceInf;
   simbolo.indiceSup = indiceSup;
   simbolo.dimension = dimension;

   anadir_izquierda_copiando (&simbolo, &tabla[sitio], sizeof (simbolo));

   return (SIMBOLO *) observar_izquierda (tabla[sitio]);
}


/**********************************************************************/
SIMBOLO *introducir_variable_vector (TABLA_SIMBOLOS tabla, char *nombre, 
                                     int nivel, int dir, TIPO_VARIABLE 
				     tipo_componentes, int indiceInf, 
				     int indiceSup, int dimension)
/**********************************************************************/
{
   SIMBOLO *simbolo = buscar_simbolo (tabla, nombre);

   if (simbolo == NULL)
      simbolo = tsim_int_variable_vector (tabla, nombre, nivel, dir,
                                          tipo_componentes, indiceInf, indiceSup, dimension);
   else if ((*simbolo).nivel != nivel)
           simbolo = tsim_int_variable_vector (tabla, nombre, nivel, dir,
	                                       tipo_componentes, indiceInf, indiceSup, dimension);
   else
	  simbolo = NULL;

   return simbolo;
}


/**********************************************************************/
void mostrar_variables_no_referenciadas (TABLA_SIMBOLOS tabla, int nivel)
/**********************************************************************/
{
   int i, n, j;
   SIMBOLO *simbolo;
   int hay = FALSE; /* Hay o no hay variables no referenciadas en este nivel */
   
   for (i = 0; i < TAMANO_TABLA; ++i)	 
   {	
     n = longitud_lista (tabla[i]); 
     for (j = 1; j <= n; ++j)
     {
	   simbolo = (SIMBOLO*) observar (tabla[i], j);	   
	   if (((*simbolo).tipo == VARIABLE) && ((*simbolo).referenciada == FALSE)
	       && ((*simbolo).nivel == nivel)) 
	   {  if (hay == FALSE) 
	      { 
	        fprintf (stderr, "AVISO! (%d, %d): Variables no referenciadas en el bloque recien cerrado:\n", lineno, linepos);
	        fprintf (stderr, "%s\n", (*simbolo).nombre); 
		hay = TRUE;
	      }	
	      else fprintf (stderr, "%s\n", (*simbolo).nombre); hay = TRUE;	      
	   }
     }
   }
}

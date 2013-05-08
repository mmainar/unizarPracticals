 /*
 *
 *
 * fichero: xml.c
 *          funciones para generar un fichero xml con la estructura
 *          de un programa pascual en compilacion.
 *
 * creado por: Marcos Mainar Lalmolda.
 * fecha ultima modificacion: 8 de abril de 2009
 *
 *
 */
 

/**********************************************************************/
/*                  F I C H E R O S  I N C L U I D O S                */
/**********************************************************************/

#include "xml.h"
#include <stdio.h>
#include <string.h>
#include <assert.h>


extern FILE *yyout;

/**********************************************************************/
void generar_inicio_programa(char *nombre)
/**********************************************************************/
{
  fprintf(yyout, "<Programa name=\"%s\">\n", nombre);
}

/**********************************************************************/
void generar_cierre_programa(char *nombre)
/**********************************************************************/
{
  fprintf(yyout, "</Programa>\n");
}

/**********************************************************************/
void generar_dec_var(int nivel)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "<declaracion_variables>\n");
}

/**********************************************************************/
void generar_cierre_dec_var(int nivel, char *nombre)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "</declaracion_variables>\n");
}

/**********************************************************************/
void generar_dec_acc(int nivel)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "<declaracion_acciones>\n");
}

/**********************************************************************/
void generar_cierre_dec_acc(int nivel)
/**********************************************************************/
{  
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "</declaracion_acciones>\n");
}

/**********************************************************************/
void generar_nueva_var_simple(int nivel, char *nombre, TIPO_VARIABLE tipo)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "<var nombre=\"%s\" tipo=\"", nombre);
  switch (tipo)
  {
    case ENTERO: fprintf (yyout, "entero\" />\n"); break;
    case BOOLEANO: fprintf (yyout, "booleano\" />\n"); break;
    case CHAR: fprintf (yyout, "caracter\" />\n"); break;
    default: ;
  }
}

/**********************************************************************/
void generar_nueva_acc(int nivel, char *nombre)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "<accion nombre=\"%s\">\n", nombre);
}

/**********************************************************************/
void generar_nuevo_par(int nivel, char *nombre, TIPO_VARIABLE tipo, 
                       CLASE_PARAMETRO clase)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "<parametro nombre=\"%s\" tipo=\"", nombre);
  switch (tipo)
  {
    case ENTERO: fprintf (yyout, "entero\""); break;
    case BOOLEANO: fprintf (yyout, "booleano\""); break;
    case CHAR: fprintf (yyout, "caracter\""); break;
    default: ;
  }
  fprintf(yyout, " paso=\"");
  switch (clase)
  {
    case VAL: fprintf(yyout, "val\" />\n"); break;
    case REF: fprintf(yyout, "ref\" />\n"); break;
  } 
}

/**********************************************************************/
void generar_cierre_acc(int nivel)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "</accion>\n");
}

/**********************************************************************/
void generar_nueva_var_vector(int nivel, char *nombre, 
                              TIPO_VARIABLE tipo_componentes, int indiceInf,
			      int indiceSup)
/**********************************************************************/
{
  int i;
  for (i = 0; i < nivel; i++) fprintf(yyout, "\t");
  fprintf(yyout, "<var nombre=\"%s\" tipo=\"vector\" tipo_componentes=\"", 
                 nombre);		 
  switch (tipo_componentes)
  {
    case ENTERO: fprintf (yyout, "entero\""); break;
    case BOOLEANO: fprintf (yyout, "booleano\""); break;
    case CHAR: fprintf (yyout, "caracter\""); break;
    default: ;
  }
  fprintf(yyout, " indice inferior=\"%d\" indice superior =\"%d\" />\n", indiceInf, indiceSup);
}

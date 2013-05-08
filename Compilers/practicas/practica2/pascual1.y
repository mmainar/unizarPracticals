%{
/**********************************************************************
 * fichero: pascual1.y
 *          Analizador semantico de Pascual
 *
 * modificado por: Marcos Mainar Lalmolda
 * modificaciones realizadas:
 *   - Modificada la gramatica para eliminar conflictos shift/reduce
 *   - Añadidas las acciones para realizar el Analisis Semantico
 *   - Añadidas las funciones para generar un fichero XML
 *
 * fecha ultima modificacion: 7 de mayo de 2009
 *
 *
 **********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "errores.h"
#include "listas.h"
#include "tabla.h"


TABLA_SIMBOLOS tabsim; /* Tabla de simbolos para el analisis semantico */
int nivel = 0; /* Bloque, ambito o nivel actual en el que nos encontramos */
int ident = 0; /* Sangrado para el fichero XML de salida */
extern lineno, linepos; /* para depuracion, definidas en pascual1.l */
int error = 0; /* Flag que indica si ha habido algun error semantico en yyparse. 
                  Para borrar el fichero de salida XML si hay error en yyparse */
FILE *yyin, *yyout; /* Fichero fuente Pascual de entrada y fichero de salida XML con la estructura
                       del programa en compilacion */
char namein[100], nameout[100]; /* Nombres de los ficheros de entrada y salida */
int warnings = 0; /* Flag que indica si se ha seleccionado la opcion -w */
char errorBuf[100]; /* Buffer para escribir los mensajes de error semantico por pantalla */

extern char yytext[];


void abrir_bloque ()
/* Abre un nuevo bloque actualizando la variable global nivel */
{
  nivel++;
}

void cerrar_bloque ()
/* Cierra el bloque actual realizando las acciones necesarias sobre 
   la TS */
{
  /* Si esta el modo warning, muestro las variables no utilizadas o referenciadas
     al cerrar cada bloque */
  if (warnings == 1) { mostrar_variables_no_referenciadas(tabsim, nivel); }
  eliminar_variables (tabsim, nivel); 
  /* Eliminamos los parametros ocultos del nivel cerrado anteriormente
    ya que ya no se va a invocar mas a las acciones a las que pertenecen. */
  eliminar_parametros_ocultos (tabsim, nivel+1); 
  ocultar_parametros (tabsim, nivel);  
  eliminar_acciones (tabsim, nivel);  
  nivel--;
}

%}

%token tPROGRAMA tACCION
%token tCONSTENTERA tCONSTCHAR tCONSTCAD tTRUE tFALSE tENTACAR tCARAENT
%token tIDENTIFICADOR tENTERO tCARACTER tBOOLEANO
%token tESCRIBIR tLEER tOPAS tPRINCIPIO tFIN tNULA
%token tVECTOR tDE 
%token tAND tOR tNOT
%token tMQ tFMQ
%token tMEI tMAI tNI tMOD tDIV
%token tSI tENT tSI_NO tFSI
%token tVAL tREF
%left tAND tOR
%left tMEI tMAI tNI '=' '>' '<'
%left '+' '-'
%left '*' tDIV tMOD
%left tNOT
%nonassoc MENOSU



%type <paraID> tIDENTIFICADOR
%type <paraExp> expresion expresion_simple termino factor 
%type <tipo> tipo_variables
%type <constante> lista_escribibles lista_asignables operador_aditivo operador_multiplicativo 
%type <constante> lista_expresiones tCONSTENTERA argumentos operador_relacional
%type <lista> parametros_formales parametros lista_parametros declaracion_parametros listaIDs_parametros
%type <clase> clase_parametros
%type <paraVector> tipo_variable_vector
%type <constante> tCONSTCHAR

%union {
 int constante;
 char *cadena;
 struct{
   SIMBOLO *simbolo; /* Puntero a la posicion en la TS */
   char *nombre;
 }paraID;
 TIPO_VARIABLE tipo;
 struct{
  TIPO_VARIABLE tipo; /* El tipo original */
  int esVariable; /* Para comprobar parametros por REF */
  int esParametroRef; /* Para comprobar parametros por REF */
  SIMBOLO *simbolo; /* Para la asignacion directa de vectores */
  int esConstEntera;  /* Para comprobar expresiones constantes al indexar un vector */
  int valorConstEntera; /* Calculo el valor constante para ver si esta dentro de los indices del vector */
  int esConstChar; /* Para comprobar constantes devueltas por caraent y entacar al indexar un vector */
  char valorConstChar; 
 }paraExp; /* Para todos los no terminales relacionados con expresiones */
 int ok;      /* Para varias acciones intermedias */
 LISTA lista; /* Para almacenar los parametros */
 CLASE_PARAMETRO clase; 
 SIMBOLO *simbolo;
 struct{
  TIPO_VARIABLE tipo;
  int indiceInf, indiceSup;
  int dimension;
  TIPO_VARIABLE tipo_componentes;
 }paraVector;
}

%start programa
%%

programa:
  tPROGRAMA tIDENTIFICADOR ';'
  {
    nivel = 0;
    ident = 0; /* XML */
    introducir_programa (tabsim, $2.nombre, 0); /* XML */
    generar_inicio_programa($2.nombre); /* XML */
    ident++; /* XML */
    generar_dec_var(ident); /* XML */
    ident++; /* XML */
  }
  declaracion_variables
  declaracion_acciones2
  bloque_instrucciones
  {
    eliminar_programa (tabsim); 
    cerrar_bloque();
    generar_cierre_programa($2.nombre); /* XML */
  }
;

declaracion_acciones2:
    {
      /* XML */
      ident--;
      if (ident == 1) generar_cierre_dec_acc(ident);
    }
|   declaracion_acciones
    {
      /* XML */
      ident--;
      if (ident == 1) generar_cierre_dec_acc(ident);
    }
;

declaracion_variables:
   {
     /* XML */
     ident--;
     generar_cierre_dec_var(ident);
     if (ident == 1)  
     { 
       generar_dec_acc(ident); 
       ident++; 
     }
     else ident--;
   }
|  lista_declaraciones ';'
   {
     /* XML */
     ident--;
     generar_cierre_dec_var(ident);
     if (ident == 1)  
     { 
       generar_dec_acc(ident); 
       ident++; 
     }
     else ident--;
   }

;

lista_declaraciones:
   lista_declaraciones ';' declaracion
|  declaracion
;

declaracion:
   tipo_variables identificadores { ; }
|
   tipo_variable_vector identificadores_vector { ; }
;

tipo_variables:
    tENTERO    { $$ = ENTERO;   }
|   tCARACTER  { $$ = CHAR;     }
|   tBOOLEANO  { $$ = BOOLEANO; }
;

tipo_variable_vector:
       tVECTOR '[' tCONSTENTERA '.''.' tCONSTENTERA ']' tDE tipo_variables
       {
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         $$.tipo = VECTOR;
         $$.indiceInf = $3;
         $$.indiceSup = $6;
         $$.dimension = $$.indiceSup - $$.indiceInf + 1;
         $$.tipo_componentes = $9;
       }
       |  tVECTOR '[' '-' tCONSTENTERA '.''.' tCONSTENTERA ']' tDE tipo_variables
       {
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         $$.tipo = VECTOR;
         $$.indiceInf = -($4);
         $$.indiceSup = $7;
         $$.dimension = $$.indiceSup - $$.indiceInf + 1;
         $$.tipo_componentes = $10;
       }
       |  tVECTOR '['  tCONSTENTERA '.''.' '-' tCONSTENTERA ']' tDE tipo_variables
       {
         /* En este caso, los indices del vector son incorrectos, ya que el inferior
	    es >= 0 y el superior es < 0. Daremos el error semantico mas tarde  */
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         $$.tipo = VECTOR;
         $$.indiceInf = $3;
         $$.indiceSup = -($7);
         $$.dimension = $$.indiceSup - $$.indiceInf + 1;
         $$.tipo_componentes = $10;
       }
       |  tVECTOR '['  '-' tCONSTENTERA '.''.' '-' tCONSTENTERA ']' tDE tipo_variables
       {
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         $$.tipo = VECTOR;
         $$.indiceInf = -($4);
         $$.indiceSup = -($8);
         $$.dimension = $$.indiceSup - $$.indiceInf + 1;
         $$.tipo_componentes = $11;
       }
;


identificadores:
   tIDENTIFICADOR
   {
     if (($1.simbolo == NULL) || ($1.simbolo->nivel != nivel))
     {
       introducir_variable(tabsim, $1.nombre, $<tipo>0, nivel, 0); 
       generar_nueva_var_simple(ident, $1.nombre, $<tipo>0); /* XML */ 
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch ($1.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", $1.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", $1.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", $1.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", $1.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   }
|  identificadores ',' tIDENTIFICADOR
   {
     if (($3.simbolo == NULL) || ($3.simbolo->nivel != nivel))
     {
       introducir_variable(tabsim, $3.nombre, $<tipo>0, nivel, 0);
       generar_nueva_var_simple(ident, $3.nombre, $<tipo>0); /* XML */
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch ($3.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", $3.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", $3.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", $3.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", $3.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   }
;

identificadores_vector:
   tIDENTIFICADOR
   {
     if ($<paraVector>0.indiceInf > $<paraVector>0.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son incorrectos", $1.nombre);
       error_semantico(errorBuf);
     }
     else if ($<paraVector>0.indiceInf == $<paraVector>0.indiceSup)
     {
       if (warnings == 1) 
       { 
         sprintf(errorBuf, "Los indices del vector %s son iguales", $1.nombre);
         warning(errorBuf);
       }
     }
     else if (($1.simbolo == NULL) || ($1.simbolo->nivel != nivel))
     {
       introducir_variable_vector (tabsim, $1.nombre, nivel, 0, $<paraVector>0.tipo_componentes,
                                   $<paraVector>0.indiceInf, $<paraVector>0.indiceSup,
                                   $<paraVector>0.dimension);
       generar_nueva_var_vector(ident+1, $1.nombre, $<paraVector>0.tipo_componentes,
                                $<paraVector>0.indiceInf, $<paraVector>0.indiceSup); /* XML */
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch ($1.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", $1.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", $1.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", $1.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", $1.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   }
|  identificadores_vector ',' tIDENTIFICADOR
   {
     if ($<paraVector>0.indiceInf > $<paraVector>0.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son incorrectos", $3.nombre);
       error_semantico(errorBuf);
     }
     else if ($<paraVector>0.indiceInf == $<paraVector>0.indiceSup)
     {
       if (warnings == 1) 
       {
         sprintf(errorBuf, "Los indices del vector %s son iguales", $3.nombre);
         warning(errorBuf);
       }
       introducir_variable_vector (tabsim, $3.nombre, nivel, 0, $<paraVector>0.tipo_componentes,
                                   $<paraVector>0.indiceInf, $<paraVector>0.indiceSup,
                                   $<paraVector>0.dimension);
				   
       generar_nueva_var_vector(ident+1, $3.nombre, $<paraVector>0.tipo_componentes,
                                $<paraVector>0.indiceInf, $<paraVector>0.indiceSup); /* XML */
     }
     else if (($3.simbolo == NULL) || ($3.simbolo->nivel != nivel))
     {
       introducir_variable_vector (tabsim, $3.nombre, nivel, 0, $<paraVector>0.tipo_componentes,
                                   $<paraVector>0.indiceInf, $<paraVector>0.indiceSup,
                                   $<paraVector>0.dimension);
       generar_nueva_var_vector(ident+1, $3.nombre, $<paraVector>0.tipo_componentes,
                                $<paraVector>0.indiceInf, $<paraVector>0.indiceSup); /* XML */
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch ($3.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", $3.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", $3.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", $3.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", $3.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   }

declaracion_acciones:
    declaracion_accion
|   declaracion_acciones  declaracion_accion
;

declaracion_accion:
   cabecera_accion ';'
   { ident++; /* XML */}
   declaracion_variables
   { ident++; /* XML */}
   declaracion_acciones2
   bloque_instrucciones
   {
     generar_cierre_acc(ident); /* XML */
     cerrar_bloque();
   }
;

cabecera_accion:
   tACCION tIDENTIFICADOR
   {
     $<simbolo>$ = NULL;
     if (($2.simbolo == NULL) || ($2.simbolo->nivel != nivel))
     {
       $<simbolo>$ = introducir_accion (tabsim, $2.nombre, nivel, 0);
       generar_nueva_acc(ident, $2.nombre); /* XML */
     }
     else 
     {    
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch ($2.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Accion %s en conflicto con programa principal", $2.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Accion %s en conflicto con otra accion", $2.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Accion %s en conflicto con variable", $2.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Accion %s en conflicto con parametro", $2.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }

     /* Despues de procesar el identificador y antes de los parametros formales,
        abrimos nuevo bloque */
     abrir_bloque();
     ident++; /* XML */
   }
   parametros_formales
   {
     if ($<simbolo>3 != NULL)
     {
       /* Almacenamos los parametros de la accion en la TS */
       $<simbolo>3->parametros = $4; 
     }
   }

;

parametros_formales: 
     { 
       crear_vacia(&($$)); /* No hay parametros formales en la accion */
       generar_dec_var(ident); /* XML */
     }
|    '(' lista_parametros ')'  
     { 
       $$ = $2; 
       generar_dec_var(ident);  /* XML */
     }
;

lista_parametros:
   lista_parametros ';' parametros
   {
     concatenar(&($1), $3);
     $$ = $1;
   }
|  parametros { $$ = $1; }
;

parametros:
   clase_parametros declaracion_parametros
   { $$ = $2; }
;

declaracion_parametros:
      tipo_variables listaIDs_parametros
      { $$ = $2; }
;

listaIDs_parametros:
     tIDENTIFICADOR
     {
       if (($1.simbolo == NULL) || ($1.simbolo->nivel != nivel))
       {
         crear_unitaria(&($$), (introducir_parametro (tabsim, $1.nombre, $<tipo>0, $<clase>-1, nivel, 0)));
         generar_nuevo_par(ident, $1.nombre, $<tipo>0, $<clase>-1); /* XML */
       }
       else 
       { 
         sprintf(errorBuf, "Parametro %s duplicado", $1.nombre);
         error_semantico(errorBuf);
       }
     }
|     listaIDs_parametros ',' tIDENTIFICADOR
     {
       if (($3.simbolo == NULL) || ($3.simbolo->nivel != nivel))
       {
         crear_unitaria(&($<lista>$), (introducir_parametro (tabsim, $3.nombre, $<tipo>0, $<clase>-1, nivel, 0)));
         concatenar(&($1), $<lista>$);
         /* Las 2 formas funcionan (son equivalentes) */
         /* anadir_derecha(introducir_parametro (tabsim, $3.nombre, $<tipo>0, $<clase>-1, nivel, 0) , &($1)); */
         generar_nuevo_par(ident, $3.nombre, $<tipo>0, $<clase>-1); /* XML */
         $$ = $1;
       }
       else 
       { 
         sprintf(errorBuf, "Parametro %s duplicado", $3.nombre);
         error_semantico(errorBuf);
       }
     }

clase_parametros:
    tVAL  { $$ = VAL; }
|   tREF  { $$ = REF; }
;

bloque_instrucciones:
    tPRINCIPIO lista_instrucciones tFIN
|   tPRINCIPIO tFIN
;

lista_instrucciones:
      instruccion
|     lista_instrucciones instruccion
;

instruccion:
     leer
|    escribir
|    asignacion
|    asignacion_vector
|    seleccion
|    mientras_que
|    invocacion_accion
|    nula
;

nula: tNULA ';'

leer:
   tLEER
   '(' lista_asignables ')' ';'
;

lista_asignables:
   tIDENTIFICADOR
   {
     $$ = 1;
     /* Comprobamos que esta declarado y es entero o caracter */
     if ($1.simbolo == NULL)
     {
       sprintf(errorBuf, "Identificador %s no declarado", $1.nombre);
       error_semantico(errorBuf);
     }
     else
     {
       if (($1.simbolo->tipo != VARIABLE) && ($1.simbolo->tipo != PARAMETRO))
       {
         /* Permitimos que sean tambien parametros por valor para ser consecuentes
	    con permitir asignarlos. Sin embargo, no sera visible desde fuera el cambio sobre
	    la variable o parametro por valor ya que este es una copia del valor de la variable. */
         sprintf(errorBuf, "Identificador %s debe ser variable o parametro", $1.nombre);
         error_semantico(errorBuf);
       }
       else if (($1.simbolo->variable != ENTERO) && ($1.simbolo->variable != CHAR) && ($1.simbolo->variable != DESCONOCIDO))
       {
         sprintf(errorBuf, "Identificador %s debe ser de tipo entero o caracter", $1.nombre);
         error_semantico(errorBuf);
       }
       else
       {
         $1.simbolo->referenciada = TRUE;
       }
     }
   }
|   lista_asignables ',' tIDENTIFICADOR
   {
     /* Comprobamos que esta declarado y es entero o caracter  */
     $$ = $1 + 1;
     if ($3.simbolo == NULL)     
     {
       sprintf(errorBuf, "Identificador %s no declarado", $3.nombre);
       error_semantico(errorBuf);
     }
     else
     {
       if (($3.simbolo->tipo != VARIABLE) && ($3.simbolo->tipo != PARAMETRO))
       {
         sprintf(errorBuf, "Identificador %s debe ser variable o parametro", $3.nombre);
         error_semantico(errorBuf);
       }
       else if (($3.simbolo->variable != ENTERO) && ($3.simbolo->variable != CHAR) && ($3.simbolo->variable != DESCONOCIDO))
       {
         sprintf(errorBuf, "Identificador %s debe ser de tipo entero o caracter", $3.nombre);
         error_semantico(errorBuf);
       }
       else
       {
         $3.simbolo->referenciada = TRUE;
       }
     }
   }
;

escribir:
   tESCRIBIR
   '(' lista_escribibles ')' ';'
;

lista_escribibles:
  lista_escribibles ',' expresion
  {
    $$ = $1 + 1;
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if (($3.tipo == BOOLEANO) || ($3.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento %d de escribir es de tipo incorrecto, debe ser cadena, entero o caracter", $$);
      error_semantico(errorBuf);
    }
  }
|  expresion
  {
    $$ = 1;
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if (($1.tipo == BOOLEANO) || ($1.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento 1 de escribir es de tipo incorrecto, debe ser cadena, entero o caracter");
      error_semantico(errorBuf);
    }
  }
;

asignacion:
   tIDENTIFICADOR
   {
     $<ok>$ = FALSE; /* Indica si existe o no el identificador */
     if ($1.simbolo == NULL)
     {
       sprintf(errorBuf, "Identificador %s no declarado", $1.nombre);
       error_semantico(errorBuf);
     }
     else if (($1.simbolo->tipo != VARIABLE) && ($1.simbolo->tipo != PARAMETRO))
     {
       $<ok>$ = TRUE;
       sprintf(errorBuf, "Identificador %s debe ser variable o parametro", $1.nombre);
       error_semantico(errorBuf);
     }
     else 
     { 
       $<ok>$ = TRUE;
       $1.simbolo->referenciada = TRUE;
     }
   }
   tOPAS expresion     
   {
     $<ok>$ = TRUE; /* Si ha habido error en la asignacion, consideramos que no se ha asignado */
     /* Puede ser asignacion directa de vectores, asignacion de una componente de un vector ($4.tipo contendra el tipo de
        esa componente, no VECTOR) a una variable simple o asignacion entre variables simples */
     if (($<ok>2) && ($4.tipo != DESCONOCIDO) && ($1.simbolo->variable != $4.tipo))
     {
       $<ok>$ = FALSE;
       sprintf(errorBuf, "Tipos incompatibles en la asignacion");
       error_semantico(errorBuf);
     }
     else 
     {
       if (($<ok>2) && ($1.simbolo->variable == VECTOR) && ($4.simbolo != NULL) && ($4.simbolo->variable == VECTOR) &&
         ($1.simbolo->dimension != $4.simbolo->dimension))
       {
         $<ok>$ = FALSE;
         sprintf(errorBuf, "En la asignacion directa de vectores el tamaño de ambos vectores no coincide");
         error_semantico(errorBuf);
       }     
       if (($<ok>2) && ($1.simbolo->variable == VECTOR) && ($4.simbolo != NULL) && ($4.simbolo->variable == VECTOR) &&
           ($1.simbolo->tipo_componentes != $4.simbolo->tipo_componentes))
       {
         $<ok>$ = FALSE;
         sprintf(errorBuf, "En la asignacion directa de vectores el tipo de las componentes de ambos vectores no coincide");
         error_semantico(errorBuf);
       }
     }  
   }
   ';' 
;

asignacion_vector:
      tIDENTIFICADOR
      {
        $<ok>$ = FALSE; /* Indica si existe o no el identificador */
        if ($1.simbolo == NULL)
	{
	  sprintf(errorBuf, "Identificador %s no encontrado", $1.nombre);
          error_semantico(errorBuf);
	}
        else if ($1.simbolo->tipo != VARIABLE)
	{
	  $<ok>$ = TRUE;
	  sprintf(errorBuf, "El identificador %s debe ser variable", $1.nombre);
          error_semantico(errorBuf);
	}
        else if (($1.simbolo->variable != VECTOR) && ($1.simbolo->variable != DESCONOCIDO))
	{
	  $<ok>$ = TRUE;
	  sprintf(errorBuf, "El identificador %s debe ser vector", $1.nombre);
          error_semantico(errorBuf);
	}
        else 
	{ 
	  $<ok>$ = TRUE;
	  $1.simbolo->referenciada = TRUE;
	}
      }
      '[' expresion ']'
      {
        if (($4.tipo != ENTERO) && ($4.tipo != DESCONOCIDO))
	{
	  sprintf(errorBuf, "El indice del vector %s debe ser de tipo entero", $1.nombre);
          error_semantico(errorBuf);
	}	
	if ($4.esConstEntera == TRUE)
	{
	  if (($4.valorConstEntera > $1.simbolo->indiceSup) || ($4.valorConstEntera < $1.simbolo->indiceInf))
	  {
	    if (warnings == 1)
	    {
              sprintf(errorBuf, "El indice %d del vector %s no existe", $4.valorConstEntera, $1.nombre);
              warning(errorBuf);
	    }  
	  }
	}
	else /*- ($4.esConstEntera == FALSE) */
	{
	  if (warnings == 1) 
          {
	    sprintf(errorBuf, "El indice del vector %s puede no existir", $1.nombre);
            warning(errorBuf);
	  }
	}
        
      }
      tOPAS expresion 
      {
        /* Puede ser una componente de un vector ($8.tipo contendra el tipo de sus componentes, no VECTOR) 
	   o una variable simple */
        if (($<ok>2) && ($8.tipo != $1.simbolo->tipo_componentes))
	{
	  sprintf(errorBuf, "Tipos incompatibles en la asignacion");
          error_semantico(errorBuf);
	}
      }
      ';'

;

mientras_que:
  tMQ
  expresion
  {
    if (($2.tipo != BOOLEANO) && ($2.tipo != DESCONOCIDO))
    {
      error_semantico("Mq: condicion invalida.");
    }
  }
  lista_instrucciones
  tFMQ
;

seleccion:
  tSI
  expresion
  {
    if (($2.tipo != BOOLEANO) && ($2.tipo != DESCONOCIDO))
    {
      error_semantico("Seleccion: condicion invalida.");
    }
  }
  tENT
  lista_instrucciones
  resto_seleccion
  tFSI
;

resto_seleccion:
|
  tSI_NO
  lista_instrucciones
;

invocacion_accion:
   tIDENTIFICADOR
   {
     $<ok>$ = FALSE;
     if ($1.simbolo == NULL)
     {  
       sprintf(errorBuf, "Accion %s no encontrada", $1.nombre);
       error_semantico(errorBuf);
       if (strcmp($1.nombre, "LEE") == 0) 
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir LEER");
	 }  
       }
       else if (strcmp($1.nombre, "ESCRIBE") == 0)
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir ESCRIBIR");
	 } 
       }
     }
     else if ($1.simbolo->tipo != ACCION)
     {
       sprintf(errorBuf, "%s no es una accion", $1.nombre);
       error_semantico(errorBuf);
     }
     else $<ok>$ = TRUE;
   }
   argumentos
   { 
     if (($<ok>2) && ($1.simbolo->parametros.elementos != $3))
     {
       /* Especificar si sobran o faltan argumentos y cuantos */
       if ($1.simbolo->parametros.elementos < $3) 
         sprintf(errorBuf, "Numero de argumentos en invocacion de la accion %s incorrecto: sobran %d argumentos" 
	                   ,$1.nombre, $3 - $1.simbolo->parametros.elementos);
       else 
         sprintf(errorBuf, "Numero de argumentos en la invocacion de la accion %s incorrecto: faltan %d argumentos" 
	                   ,$1.nombre, $1.simbolo->parametros.elementos - $3);
       error_semantico(errorBuf);
     }

   }
   ';'
|  tIDENTIFICADOR
   {
     $<ok>$ = FALSE;
     if ($1.simbolo == NULL)
     {
       sprintf(errorBuf, "Accion %s no encontrada", $1.nombre);
       error_semantico(errorBuf);  
       if (strcmp($1.nombre, "LEE") == 0) 
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir LEER");
	 }  
       }
       else if (strcmp($1.nombre, "ESCRIBE") == 0)
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir ESCRIBIR");
	 }  
       }
     }
     else if ($1.simbolo->tipo != ACCION)
     {
       sprintf(errorBuf, "%s no es una accion", $1.nombre);
       error_semantico(errorBuf);
     }
     else if (($1.simbolo->tipo == ACCION) && ($1.simbolo->parametros.elementos != 0))
     {
       /* Especificar cuantos argumentos faltan */
       sprintf(errorBuf, "Numero de argumentos en invocacion de la accion %s incorrecto: faltan %d argumentos" 
                         ,$1.nombre, $1.simbolo->parametros.elementos);
       error_semantico(errorBuf); 
     }
     else $<ok>$ = TRUE;
   }
   ';'
;

argumentos:
  '(' lista_expresiones ')'
   { $$ = $2; }
;

lista_expresiones:
   lista_expresiones ',' expresion
   {
     LISTA pars;
     SIMBOLO *p;
     int i;

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if ($<ok>-1)
     {
       pars = (*($<paraID.simbolo>-2)).parametros;
       
       if (longitud_lista(pars) >= ($1+1)) 
       {

         p = observar (pars, $1+1);
         /* Verificaciones de los argumentos de la invocacion */
	 if ($3.tipo == VECTOR)
	 {
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != $3.tipo) && ($3.tipo != DESCONOCIDO))
         { 
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   sprintf(errorBuf, "Los tipos del parametro y el argumento numero %d no coinciden", $1+1);
           error_semantico(errorBuf);
         }
         if (((*p).parametro == REF) && ($3.esVariable != TRUE) && ($3.esParametroRef != TRUE))
         {
           /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   sprintf(errorBuf, "El argumento numero %d debe ser una variable o parametro por referencia", $1+1);		      
           error_semantico(errorBuf);
         }	 
       }
       $$ = $1 + 1; /* Para contar el numero de argumentos en la invocacion a la accion */
     }
   }
|  expresion
   {
     LISTA pars;
     SIMBOLO *p;
     int i;

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if ($<ok>-1)
     {
       pars = (*($<paraID.simbolo>-2)).parametros;

       if (longitud_lista (pars) >= 1)
       {
         p = observar (pars, 1);
         /* Verificaciones */
	 if ($1.tipo == VECTOR)
	 {
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != $1.tipo) &&  ($1.tipo != DESCONOCIDO))
         {
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   sprintf(errorBuf, "Los tipos del parametro y el argumento 1 no coinciden");
           error_semantico(errorBuf);
         } 
         if (((*p).parametro == REF) && ($1.esVariable != TRUE) && ($1.esParametroRef !=TRUE))
         {  /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   sprintf(errorBuf, "El argumento numero 1 debe ser una variable o un parametro por referencia");		      
           error_semantico(errorBuf);
         }
       }
	 
       $$ = 1; /* Numero de argumentos: Solo hay uno */
     }
   }
;

expresion:
   expresion_simple
   {
     $$ = $1;
   }
|  expresion operador_relacional expresion_simple
   {
     $$.tipo = BOOLEANO;
     $$.esVariable = FALSE;
     $$.esParametroRef = FALSE;
     $$.esConstEntera = FALSE;
     $$.esConstChar = FALSE;
     $$.simbolo = NULL;
     
     if (($1.tipo == CADENA) || ($3.tipo == CADENA))
     {
       error_semantico("Los operandos no pueden ser de tipo cadena");
     }
     else if (($1.tipo == VECTOR) || ($3.tipo == VECTOR))
     {
       error_semantico("Los operandos no pueden ser vectores");
     }
     else if (($1.tipo != DESCONOCIDO) && ($3.tipo != DESCONOCIDO) && ($1.tipo != $3.tipo))
     { 
       error_semantico("Los operandos deben ser de igual tipo");
     }
     else if (($2 != '=') && ($2 != tNI) && ($1.tipo == BOOLEANO))
     {
       error_semantico("El operador no se puede aplicar a booleanos");
     }

   }
;

operador_relacional:
    '='    
    { $$ = '='; }
|    '<'
    { $$ = '='; }
|    '>'
    { $$ = '='; }
|    tMEI
    { $$ = tMEI; }
|    tMAI
    { $$ = tMAI; }
|    tNI
    { $$ = tNI; }
;

expresion_simple:
   termino
   {
     $$ = $1;
   }
|  expresion_simple operador_aditivo termino
   {
     if ($2 == tOR)
     {
       $$.tipo = BOOLEANO;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.esConstEntera = FALSE;
       $$.esConstChar = FALSE;
       $$.simbolo = NULL;
       
       if (($1.tipo != BOOLEANO) && ($1.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser booleano");
       }
       if (($3.tipo != BOOLEANO) && ($3.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser booleano");
       }
     }
     else if ($2 == '+')
     {
       $$.tipo = ENTERO; 
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.esConstChar = FALSE;
       $$.simbolo = NULL;
       $$.esConstEntera = FALSE; /* De momento */
       
       if (($1.tipo != ENTERO) && ($1.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if (($3.tipo != ENTERO) && ($3.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero");
       }
       if (($1.esConstEntera == TRUE) && ($3.esConstEntera == TRUE))
       {
         $$.esConstEntera = TRUE;
         $$.valorConstEntera = $1.valorConstEntera + $3.valorConstEntera;
       }
     }
     else if ($2 == '-')
     {
       $$.tipo = ENTERO;     
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.esConstChar = FALSE;
       $$.simbolo = NULL;
       $$.esConstEntera = FALSE; /* De momento */
       
       if (($1.tipo != ENTERO) && ($1.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if (($3.tipo != ENTERO) && ($3.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero");
       }
       if (($1.esConstEntera == TRUE) && ($3.esConstEntera == TRUE))
       {
         $$.esConstEntera = TRUE;
         $$.valorConstEntera = $1.valorConstEntera - $3.valorConstEntera;
       }
     }
   }
;

operador_aditivo:
     '+' { $$ = '+'; }
|    '-' { $$ = '-'; }
|    tOR { $$ = tOR; }
;

termino:
   factor
   {
     $$ = $1;
   }
|  termino operador_multiplicativo factor
   {
     if ($2 == '*')
     {
       $$.tipo = ENTERO;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.esConstChar = FALSE;
       $$.simbolo = NULL;
       $$.esConstEntera = FALSE; /* De momento */
       
       if (($1.tipo != ENTERO) && ($1.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if (($3.tipo != ENTERO) && ($3.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero.");
       }  
       if (($1.esConstEntera == TRUE) && ($3.esConstEntera == TRUE))
       {
         $$.esConstEntera = TRUE;
         $$.valorConstEntera = $1.valorConstEntera * $3.valorConstEntera;
       }
     }
     else if ($2 == tDIV)
     {
       $$.tipo = ENTERO;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.esConstChar = FALSE;
       $$.simbolo = NULL;
       $$.esConstEntera = FALSE; /* De momento */
       
       if (($1.tipo != ENTERO) && ($1.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if (($3.tipo != ENTERO) && ($3.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero.");
       }
       if (($1.esConstEntera == TRUE) && ($3.esConstEntera == TRUE))
       {
         $$.esConstEntera = TRUE;
	 if ($3.valorConstEntera == 0) 
	 {
	   $$.esConstEntera = FALSE;
	   if (warnings == 1) 
           {
	     warning("Division por cero");
	   }  
	 }  
	 else $$.valorConstEntera = $1.valorConstEntera / $3.valorConstEntera;
       }
       else if ($3.esConstEntera == TRUE)
       {
         if ($3.valorConstEntera == 0) 
	 {
	   $$.esConstEntera = FALSE;
	   if (warnings == 1) 
           {
	     warning("Division por cero");
	   }  
	 }  
       }
       else if ($3.esConstEntera == FALSE)
       {
         if (warnings == 1) 
         {
           warning("Verifique que no divide por 0");     
	 }  
       }
     }
     else if ($2 == tMOD)
     {
       $$.tipo = ENTERO;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.esConstChar = FALSE;
       $$.simbolo = NULL;
       $$.esConstEntera = FALSE; /* De momento */
     
       if (($1.tipo != ENTERO) && ($1.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if (($3.tipo != ENTERO) && ($3.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero.");
       }     
       if (($1.esConstEntera == TRUE) && ($3.esConstEntera == TRUE))
       {
         $$.esConstEntera = TRUE;
         $$.valorConstEntera = $1.valorConstEntera % $3.valorConstEntera;
       }
     }
     else if ($2 == tAND) 
     {
       $$.tipo = BOOLEANO;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.esConstEntera = FALSE;
       $$.esConstChar = FALSE;
       $$.simbolo = NULL;
       
       if (($1.tipo != BOOLEANO) && ($1.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser booleano");
       }
       if (($3.tipo != BOOLEANO) && ($3.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser booleano");
       }
     }
   }
;

operador_multiplicativo:
     '*'  { $$ = '*'; }
|    tDIV { $$ = tDIV; }
|    tMOD { $$ = tMOD; }
|    tAND { $$ = tAND; }
;

factor:
   '-' factor %prec MENOSU
    {
      $$ = $2;
      if ($2.esConstEntera == TRUE)
        $$.valorConstEntera = - ($2.valorConstEntera);
	
      $$.tipo = ENTERO;
      
      if ($2.tipo != ENTERO)
      {
        error_semantico("Argumento de - unario debe ser entero");
      }
    }
|   tNOT factor
    {
      $$ = $2;
      $$.tipo = BOOLEANO;
      if ($2.tipo != BOOLEANO)
      {
        error_semantico("Argumento de not debe ser booleano");
      }
    }
|    '(' expresion ')' 
    { 
      $$ = $2; 
    }
|    tENTACAR '(' expresion ')'
    {
      $$.tipo = CHAR;
      $$.esVariable = FALSE;
      $$.esParametroRef = FALSE;
      $$.esConstChar = FALSE; /* De momento */
      $$.simbolo = NULL;
      $$.esConstEntera = FALSE; 
      
      if ($3.tipo != ENTERO)
      {
        error_semantico("Argumento de entacar debe ser entero");
      }
      else
      {
        if ($3.esConstEntera == TRUE)
	{
	  $$.esConstChar = TRUE;
	  $$.valorConstChar = (char) $3.valorConstEntera;
	  
	  if (($3.valorConstEntera < 0) || ($3.valorConstEntera >= 256))
	  {
	    if (warnings == 1) warning("Se truncara el argumento de entacar");
	    $$.valorConstChar = (char) abs($3.valorConstEntera % 256);
	  }	 	

	}
      }
    }
|    tCARAENT '(' expresion ')'
    {
      $$.tipo = ENTERO;
      $$.esVariable = FALSE;
      $$.esParametroRef = FALSE;
      $$.simbolo = NULL;
      $$.esConstEntera = FALSE; /* De momento */
      $$.esConstChar = FALSE; 
      
      if ($3.tipo != CHAR)
      {
        error_semantico("Argumento de caraent debe ser caracter");
      }
      else 
      {
        if ($3.esConstChar == TRUE)
        {
	  $$.esConstEntera = TRUE;
	  $$.valorConstEntera = (int) $3.valorConstChar;
	}
      }
    }
|    tIDENTIFICADOR
    {
      $$.tipo = DESCONOCIDO; 
      $$.esVariable = FALSE;
      $$.esParametroRef = FALSE;
      $$.esConstEntera = FALSE;
      $$.esConstChar = FALSE;
      $$.simbolo = NULL;
      
      if ($1.simbolo == NULL)
      {
        sprintf(errorBuf, "Identificador %s no declarado", $1.nombre);
        error_semantico(errorBuf);
      }      
      else if (($1.simbolo->tipo != VARIABLE) && ($1.simbolo->tipo != PARAMETRO))
      {
        sprintf(errorBuf, "Identificador %s debe ser variable o parametro", $1.nombre);
        error_semantico(errorBuf);
      }
      else if ($1.simbolo->tipo == VARIABLE)
      {
        $$.simbolo = $1.simbolo;
	$$.esVariable = TRUE;
        $$.tipo = $1.simbolo->variable; 
	$1.simbolo->referenciada = TRUE;
      }
      else /* Es un parametro */
      {  
        $$.simbolo = $1.simbolo; 
	$$.esVariable = FALSE;
	$$.tipo = $1.simbolo->variable; /* El tipo de la expresion es el del parametro */
	if ($1.simbolo->parametro == REF) $$.esParametroRef = TRUE;
	else $$.esParametroRef = FALSE;
      }
    }
|    tIDENTIFICADOR '[' expresion ']'
    {
      $$.tipo = DESCONOCIDO; 
      $$.esVariable = FALSE;
      $$.esParametroRef = FALSE;
      $$.esConstEntera = FALSE;
      $$.esConstChar = FALSE;
      $$.simbolo = NULL;
      
      if ($1.simbolo == NULL)
      {
        sprintf(errorBuf, "Identificador %s no declarado", $1.nombre);
        error_semantico(errorBuf);
      }
      else if ($1.simbolo->tipo != VARIABLE)
        /* Parametro no puede ser porque los parametros son simples (los vectores no se
           pasan como parametro) */
      {	   
        sprintf(errorBuf, "Identificador %s debe ser variable", $1.nombre);
        error_semantico(errorBuf);  
      }
      else if (($1.simbolo->variable != DESCONOCIDO) && ($1.simbolo->variable != VECTOR))
      {
        sprintf(errorBuf, "Identificador %s debe ser vector");
        error_semantico(errorBuf);
      }
      else /* Es variable de tipo vector o desconocido */
      { 
        $$.esVariable = TRUE; 
	$$.simbolo = $1.simbolo; 
	/* Hago que sea el tipo de la expresion el de las componentes del vector */
	$$.tipo = $1.simbolo->tipo_componentes;
	$1.simbolo->referenciada = TRUE;
      }
      if (($1.simbolo != NULL)  && ($1.simbolo->variable == VECTOR) && ($3.tipo == ENTERO) && ($3.esConstEntera == TRUE))
      {
        /* Comprobar, si expresion es constEntera que esta dentro del rango de indices del vector */
	if (($3.valorConstEntera > $1.simbolo->indiceSup) || ($3.valorConstEntera < $1.simbolo->indiceInf))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", $3.valorConstEntera ,$1.nombre);
           warning(errorBuf);
	  } 
	}
      }
      if (($1.simbolo != NULL) && ($1.simbolo->variable == VECTOR) && ($3.tipo == ENTERO) && ($3.esConstEntera != TRUE))
      {
        if (warnings == 1) 
        {
	  sprintf(errorBuf, "El indice del vector %s puede no existir", $1.nombre);
          warning(errorBuf);
	} 
      }
      if (($1.simbolo != NULL) && ($1.simbolo->variable == VECTOR) && ($3.tipo != ENTERO))
      {
        sprintf(errorBuf, "El indice del vector %s debe ser de tipo entero", $1.nombre);
        error_semantico(errorBuf);
      }
    }
|    tCONSTENTERA 
     { 
       $$.tipo = ENTERO;   
       $$.esConstEntera = TRUE;
       $$.valorConstEntera = $1;
       $$.esConstChar = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.simbolo = NULL;
     }
|    tCONSTCHAR   
     { 
       $$.tipo = CHAR;     
       $$.esConstChar = TRUE;
       $$.valorConstChar = (char) $1;
       $$.esConstEntera = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE;
       $$.simbolo = NULL;
     }
|    tCONSTCAD    
     { 
       $$.tipo = CADENA;  
       $$.esConstChar = FALSE;
       $$.esConstEntera = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE; 
       $$.simbolo = NULL;
     }
|    tTRUE        
     { 
       $$.tipo = BOOLEANO; 
       $$.esConstChar = FALSE;
       $$.esConstEntera = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE; 
       $$.simbolo = NULL;
     }
|    tFALSE       
     { 
       $$.tipo = BOOLEANO; 
       $$.esConstChar = FALSE;
       $$.esConstEntera = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE; 
       $$.simbolo = NULL;
     }
;


%%

/**********************************************************************/
main(int argc, char *argv[])
/**********************************************************************/
{

   if ((argc != 2) && (argc != 3))
   {
     fprintf (stderr, "Numero de argumentos incorrecto\n");
     fprintf (stderr, "Uso: pascual1 fuente (sin la extension .pc) [-w]\n");
     exit (-1);
   }

   strcpy (namein, argv[1]);
   strcat (namein, ".pc");
   yyin = fopen (namein, "r");
   
   if (yyin == NULL) {
      fprintf (stderr, "Fichero %s no existe.\n", namein);
      exit (1);
   }
   
   if ((argc == 3) && (strcmp(argv[2], "-w") == 0))
   /* Activamos el modo de mostrar warnings */   
     warnings = 1;
   else if ((argc == 3) && (strcmp(argv[2], "-w") != 0))
   {
     fprintf (stderr, "El tercer argumento es erroneo\n");
     fprintf (stderr, "Uso: pascual1 fuente (sin la extension .pc) [-w]\n");
     exit (-1);
   }  
   else 
     warnings = 0;  

   inicializar_tabla (tabsim);
   strcpy (nameout, argv[1]);
   strcat (nameout, ".xml");
   yyout = fopen (nameout, "w");
   yyparse ();

   if (error)
   {
     remove (nameout);
     fprintf (stderr, "ATENCION! Ha habido errores y NO se ha generado el fichero %s\n", nameout);
   }
   else
   { 
     fprintf (stderr, "Fichero %s generado correctamente\n", nameout);
   }
   fclose (yyout);
   fclose (yyin);
}

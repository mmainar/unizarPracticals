%{
/**********************************************************************
 * fichero: pascual.y
 *          Generador de codigo intermedio.
 *
 * modificado por: Marcos Mainar Lalmolda
 * modificaciones realizadas:
 *   - Completada la gramatica para generar codigo usando generacion no
 *     secuencial (AST).
 *   - Limitacion: No podemos tener acciones que tengan nombres de 
 *                 etiquetas (L0, L1, L2, ..., LN).
 * fecha ultima modificacion: 25 de mayo de 2009
 *
 *
 **********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "errores.h"
#include "listas.h"
#include "tabla.h"
#include "codigop.h"
#include "genast.h"

#define INICIAL 3
#define MAXANID 100


TABLA_SIMBOLOS tabsim; /* Tabla de simbolos para el analisis semantico y la generacion de codigo */
int nivel = 0; /* Bloque, ambito o nivel actual en el que nos encontramos */
int error = 0; /* Flag que indica si ha habido algun error semantico en yyparse. 
                  Para borrar los ficheros de salida si hay error en yyparse */
FILE *yyin, *yyout; /* Fichero fuente Pascual de entrada, fichero de salida
                       con el codigo intermedio. */
char namein[100], nameout[100]; /* Nombres de los ficheros de entrada y salida */
int warnings = 0; /* Flag que indica si se ha seleccionado la opcion -w */
char errorBuf[100]; /* Buffer para escribir los mensajes de error semantico por pantalla */

/* Generacion de codigo */

int sig[MAXANID]; /* Vector donde guardamos la siguiente dir para el bloque
                     cuyo nivel se corresponde con el nivel actual en la compilacion */
		     
char *lenp; /* Etiqueta del programa principal */
char *llvp;  /* Etiqueta de la ultima instruccion */
char *lerror; /* Etiqueta de la rutina de acceso a indice fuera del rango en un vector */
int hay_vector = FALSE; /* Flag que indica si hay vectores en el programa (para poner rutina de indice erroneo) */


void abrir_bloque ()
/* Abre un nuevo bloque actualizando la variable global nivel */
{
  sig[++nivel] = INICIAL;
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

void crear_var (char *nom, int tipo)
{ 
  SIMBOLO *simbolo = buscar_simbolo (tabsim, nom);
  
  if (simbolo != NULL)
  {
    simbolo->dir = sig[nivel];
    /* Todos los tipos de datos usan 1 palabra (2 Bytes) aunque algunos
       como los booleanos o caracteres no la lleguen a ocupar entera */
    sig[nivel] += 1;
  }  
}

void crear_var_vector (char *nom, int tipo_componentes, int dimension)
{
  SIMBOLO *simbolo = buscar_simbolo (tabsim, nom);
  
  if (simbolo != NULL)
  {
    simbolo->dir = sig[nivel]; 
    sig[nivel] += dimension;
  }  
}

void rutina_error (LISTA *l)
{
  emit(l, STC, 65);
  emit(l, WRT,  0);
  emit(l, STC, 98);
  emit(l, WRT,  0);
  emit(l, STC, 111);
  emit(l, WRT,  0);
  emit(l, STC, 114);
  emit(l, WRT,  0);
  emit(l, STC, 116);
  emit(l, WRT,  0);
  emit(l, STC, 97);
  emit(l, WRT,  0);
  emit(l, STC, 110);
  emit(l, WRT,  0);
  emit(l, STC, 100);
  emit(l, WRT,  0);
  emit(l, STC, 111);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 108);
  emit(l, WRT,  0);
  emit(l, STC, 97);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 101);
  emit(l, WRT,  0);
  emit(l, STC, 106);
  emit(l, WRT,  0);
  emit(l, STC, 101);
  emit(l, WRT,  0);
  emit(l, STC, 99);
  emit(l, WRT,  0);
  emit(l, STC, 117);
  emit(l, WRT,  0);
  emit(l, STC, 99);
  emit(l, WRT,  0);
  emit(l, STC, 105);
  emit(l, WRT,  0);
  emit(l, STC, 111);
  emit(l, WRT,  0);
  emit(l, STC, 110);
  emit(l, WRT,  0);
  emit(l, STC, 44);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 105);
  emit(l, WRT,  0);
  emit(l, STC, 110);
  emit(l, WRT,  0);
  emit(l, STC, 100);
  emit(l, WRT,  0);
  emit(l, STC, 105);
  emit(l, WRT,  0);
  emit(l, STC, 99);
  emit(l, WRT,  0);
  emit(l, STC, 101);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 100);
  emit(l, WRT,  0);
  emit(l, STC, 101);
  emit(l, WRT,  0);
  emit(l, STC, 108);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 118);
  emit(l, WRT,  0);
  emit(l, STC, 101);
  emit(l, WRT,  0);
  emit(l, STC, 99);
  emit(l, WRT,  0);
  emit(l, STC, 116);
  emit(l, WRT,  0);
  emit(l, STC, 111);
  emit(l, WRT,  0);  
  emit(l, STC, 114);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 102);
  emit(l, WRT,  0);
  emit(l, STC, 117);
  emit(l, WRT,  0);
  emit(l, STC, 101);
  emit(l, WRT,  0);
  emit(l, STC, 114);
  emit(l, WRT,  0);
  emit(l, STC, 97);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 100);
  emit(l, WRT,  0);
  emit(l, STC, 101);
  emit(l, WRT,  0);
  emit(l, STC, 32);
  emit(l, WRT,  0);
  emit(l, STC, 114);
  emit(l, WRT,  0);
  emit(l, STC, 97);
  emit(l, WRT,  0);
  emit(l, STC, 110);
  emit(l, WRT,  0);
  emit(l, STC, 103);
  emit(l, WRT,  0);
  emit(l, STC, 111);
  emit(l, WRT,  0);
  emit(l, STC, 13);
  emit(l, WRT, 0);
  emit(l, STC, 10);
  emit(l, WRT, 0);
  /* Saltamos a la ultima instruccion */
  emit (l, JMP, llvp);   
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
%left tMEI tMAI tNI '=' '>' '<'
%left '+' '-' tOR
%left '*' tDIV tMOD tAND
%left tNOT
%nonassoc MENOSU



%type <paraID> tIDENTIFICADOR 
%type <paraExp> expresion expresion_simple termino factor 
%type <tipo> tipo_variables
%type <constante> operador_aditivo operador_multiplicativo 
%type <constante> tCONSTENTERA operador_relacional
%type <lista> parametros_formales parametros lista_parametros declaracion_parametros listaIDs_parametros
%type <clase> clase_parametros
%type <paraVector> tipo_variable_vector
%type <constante> tCONSTCHAR
%type <cadena> tCONSTCAD
%type <cod> programa bloque_instrucciones declaracion_acciones declaracion_acciones2 declaracion_variables
%type <cod> seleccion resto_seleccion lista_instrucciones mientras_que asignacion_vector asignacion
%type <cod> leer nula asignacion instruccion escribir invocacion_accion declaracion_accion 
%type <paraListas> lista_escribibles lista_asignables lista_expresiones argumentos
%type <paraCabAccion> cabecera_accion

%union {
 LISTA cod; /* Codigo generado */
 char *cadena;
 int constante;
 struct{
   char *cad; /* Nombre de la accion */
   char *etiq; /* Etiqueta de la accion en la TS */
   SIMBOLO *simbolo; /* Puntero a la accion en la TS */
 }paraCabAccion;
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
  int longitud; /* De las constCad, para saber cuantos WRT hacer */
  LISTA cod; /* Para generacion de codigo */
  char *cad; /* Para almacenar las cadenas de caracteres */
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
 struct{
   int constante; /* Numero de elementos hasta el momento */
   LISTA cod; /* Codigo generado */
 }paraListas;
}

%start programa
%%

programa:
  tPROGRAMA tIDENTIFICADOR ';'
  {	
    nivel = 0;
    sig[nivel] = INICIAL;
    lenp = newlabel();
    lerror = newlabel(); /* Para saltar a la rutina de error */
    llvp = newlabel(); /* Para saltar al final del programa desde rutinas de error */
    introducir_programa (tabsim, $2.nombre, lenp); 
  }
  declaracion_variables
  declaracion_acciones2
  bloque_instrucciones
  {
    char msg[100];
      
    eliminar_programa (tabsim); 
    cerrar_bloque();

    /* Generacion de codigo */
    $$ = code (ENP, lenp); 
    /* Si hay vectores, ponemos rutina de error de acceso a indices fuera del rango */
    if (hay_vector == TRUE)
    {
      label (&($$), lerror);  
      rutina_error(&($$));
    }
    concatenar (&($$), $6);
    sprintf (msg, "Comienzo del programa %s", $2.nombre);
    comment (&($$), msg);
    label (&($$), lenp);
    concatenar (&($$), $7);
    sprintf (msg, "Fin del programa %s", $2.nombre);
    comment (&($$), msg);
    label (&($$), llvp); /* para rutinas de error */
    emit (&($$), LVP);
    if (error == 0)
    { 
      /* Volcamos a disco si no ha habido errores sintacticos ni semanticos */
      dumpcode ($$, yyout);
    }  
  }
;

declaracion_acciones2:
    {
      crear_vacia(&($$)); 
    }
|   declaracion_acciones
    {
      $$ = $1; 
    }
;

declaracion_variables:
   {
    ; 
   }
|  lista_declaraciones ';'
   {
     ;
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
       crear_var ($1.nombre, $<tipo>0);
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
       crear_var ($3.nombre, $<tipo>0);
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
       introducir_variable_vector (tabsim, $1.nombre, nivel, 0, $<paraVector>0.tipo_componentes,
                                   $<paraVector>0.indiceInf, $<paraVector>0.indiceSup,
                                   $<paraVector>0.dimension);
       crear_var_vector ($1.nombre, $<paraVector>0.tipo_componentes, $<paraVector>0.dimension);
     }
     else if (($1.simbolo == NULL) || ($1.simbolo->nivel != nivel))
     {
       introducir_variable_vector (tabsim, $1.nombre, nivel, 0, $<paraVector>0.tipo_componentes,
                                   $<paraVector>0.indiceInf, $<paraVector>0.indiceSup,
                                   $<paraVector>0.dimension);
       crear_var_vector ($1.nombre, $<paraVector>0.tipo_componentes, $<paraVector>0.dimension);
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
     }
     else if (($3.simbolo == NULL) || ($3.simbolo->nivel != nivel))
     {
       introducir_variable_vector (tabsim, $3.nombre, nivel, 0, $<paraVector>0.tipo_componentes,
                                   $<paraVector>0.indiceInf, $<paraVector>0.indiceSup,
                                   $<paraVector>0.dimension);
       crear_var_vector ($3.nombre, $<paraVector>0.tipo_componentes, $<paraVector>0.dimension);
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
    { $$ = $1; }
|   declaracion_acciones  declaracion_accion
    { 
      concatenar (&($1), $2); 
      $$ = $1;
    }
;

declaracion_accion:
   cabecera_accion ';'
   declaracion_variables
   declaracion_acciones2
   bloque_instrucciones
   {
     
     SIMBOLO *p;
     int i;      
     $$ = newcode(); 
     /* Recuperamos los argumentos en orden inverso a su declaracion */     
     if ($1.simbolo != NULL)
     {     
       char msg[100], *laccion = newlabel();
       
       sprintf (msg, "Comienzo de accion %s", $1.cad);
       comment (&($$), msg);   
       label (&($$), $1.cad);           
       
       for (i = longitud_lista($1.simbolo->parametros); i > 0 ; i--)
       {
         p = observar($1.simbolo->parametros, i);
	 emit (&($$), SRF, nivel - p->nivel, p->dir);
	 emit (&($$), ASGI);
       }
       emit (&($$), JMP, laccion);
       concatenar (&($$), $4);
       label (&($$), laccion);
       /* Concatenamos el codigo de la accion */
       concatenar (&($$), $5);
       /* Destruir BA */
       sprintf (msg, "Fin de accion %s", $1.cad);
       comment (&($$), msg); 
       emit (&($$), CSF);
       cerrar_bloque();
     }
   }
;

cabecera_accion:
   tACCION tIDENTIFICADOR
   {
     
     $<simbolo>$ = NULL;
     if (($2.simbolo == NULL) || ($2.simbolo->nivel != nivel))
     {
       $<simbolo>$ = introducir_accion (tabsim, $2.nombre, nivel, $2.nombre);
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
   }
   parametros_formales
   {
     if ($<simbolo>3 != NULL)
     {
       /* Almacenamos los parametros de la accion en la TS */
       $<simbolo>3->parametros = $4; 
     }
     $$.cad = $2.nombre;
     $$.simbolo = $<simbolo>3;
   }
;

parametros_formales: 
     { 
       crear_vacia(&($$)); /* No hay parametros formales en la accion */
     }
|    '(' lista_parametros ')'  
     { 
       $$ = $2; 
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
	 crear_var($1.nombre, $<tipo>0);
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
         anadir_derecha(introducir_parametro (tabsim, $3.nombre, $<tipo>0, $<clase>-1, nivel, 0), &($1));
	 crear_var($3.nombre, $<tipo>0);
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
    { $$ = $2; }
|   tPRINCIPIO tFIN
    { crear_vacia (&($$)); }
;

lista_instrucciones:
      instruccion
      { $$ = $1; }
|     lista_instrucciones instruccion
      { 
        concatenar (&($1), $2); 
        $$ = $1;
      }
;

instruccion:
     leer
     { $$ = $1; }
|    escribir
     { $$ = $1; }
|    asignacion
     { $$ = $1; }
|    asignacion_vector
     { $$ = $1; }
|    seleccion
     { $$ = $1; }
|    mientras_que
     { $$ = $1; }
|    invocacion_accion
     { $$ = $1; }
|    nula
     { $$ = $1; }
;

nula: tNULA ';'
    { $$ = code(NOP); }

leer:
   tLEER
   '(' lista_asignables ')' ';'
   { $$ = $3.cod; }
;

lista_asignables:
   tIDENTIFICADOR
   {
     $$.constante = 1;
     /* Comprobamos que esta declarado y es entero o caracter */
     $$.cod = newcode();
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
	 /* Generar codigo */
	 emit (&($$.cod), SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);
	 /* Duda de si hacer esto */
	 if (($1.simbolo->tipo == PARAMETRO) && ($1.simbolo->parametro == REF))
	 {
	   emit (&($$.cod), DRF);
	 }
	 
	 if ($1.simbolo->variable == CHAR)
	 {
	   emit (&($$.cod), RD, 0);
	 }  
	 else if ($1.simbolo->variable == ENTERO)
	 {
	   emit (&($$.cod), RD, 1);  
	 }  
       }
     }
   }
|   lista_asignables ',' tIDENTIFICADOR
   {
     /* Comprobamos que esta declarado y es entero o caracter  */
     $$.constante = $1.constante + 1;
     $$.cod = newcode();
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
	 /* Generar codigo */
	 concatenar(&($$.cod), $1.cod);
	 
	 emit (&($$.cod), SRF, nivel - $3.simbolo->nivel, $3.simbolo->dir);
	 /* Duda de si hacer esto */
	 if (($3.simbolo->tipo == PARAMETRO) && ($3.simbolo->parametro == REF))
	 {
	   emit (&($$.cod), DRF);
	 }
	 
	 if ($3.simbolo->variable == CHAR)
	 {
	   emit (&($$.cod), RD, 0);
	 }  
	 else if ($3.simbolo->variable == ENTERO)
	 {
	   emit (&($$.cod), RD, 1); 
	 }  
       }
     }
   }
;

escribir:
   tESCRIBIR
   '(' lista_escribibles ')' ';'
   { $$ = $3.cod; }
;

lista_escribibles:
  lista_escribibles ',' expresion
  {
    int i,c;
    $$.constante = $1.constante + 1;
    $$.cod = newcode();
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if (($3.tipo == BOOLEANO) || ($3.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento %d de escribir es de tipo incorrecto, debe ser cadena, entero o caracter", $$.constante);
      error_semantico(errorBuf);
    }
    else
    {
      /* Generamos codigo */
      if ($3.tipo == ENTERO)
      {
        concatenar (&($1.cod), $3.cod);
	concatenar (&($$.cod), $1.cod);
	emit (&($$.cod), WRT, 1);
      }	
      else if ($3.tipo == CHAR)
      { 
        concatenar(&($1.cod), $3.cod);
	concatenar (&($$.cod), $1.cod);
	emit (&($$.cod), WRT, 0);
      }
      else if ($3.tipo == CADENA) 
      {
        /* Ponemos tantos WRT como longitud tenga la cadena */
	concatenar (&($1.cod), $3.cod);
	concatenar (&($$.cod), $1.cod);
	for (i = 0; i < $3.longitud; i++)
	{ 	  
	  emit (&($$.cod), STC, *($3.cad + i));
	  emit (&($$.cod), WRT, 0);
	}  	 	
      }
    }
  }
|  expresion
  {
    int i;
    $$.constante = 1;
    $$.cod = newcode();
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if (($1.tipo == BOOLEANO) || ($1.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento 1 de escribir es de tipo incorrecto, debe ser cadena, entero o caracter");
      error_semantico(errorBuf);
    }
    else
    {
      /* Generamos codigo */
      if ($1.tipo == ENTERO)
      {        
	$$.cod = $1.cod;
	emit (&($$.cod), WRT, 1);
      }	
      else if ($1.tipo == CHAR)
      { 
	$$.cod = $1.cod;
	emit (&($$.cod), WRT, 0);
      }
      else if ($1.tipo == CADENA) 
      {
        /* Ponemos tantos WRT como longitud tenga la cadena */
	$$.cod = $1.cod;
	for (i = 0; i < $1.longitud; i++)
	{ 	  
	  emit (&($$.cod), STC, *($1.cad + i));
	  emit (&($$.cod), WRT, 0);
	}  
	
      }
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
       /* $<ok>$ = TRUE; */
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
   {
     int i, t, ce; 
     char *lcond, *lbloque;
     $$ = newcode();
   
     if (($<ok>2) && ($<ok>5) && (($1.simbolo->variable != VECTOR) || (($4.simbolo != NULL) && ($4.simbolo->variable != VECTOR))))
     {
       /* Generar codigo para una asignacion entre tipos simples */
       emit (&($$), SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);     
       if (($1.simbolo->tipo == PARAMETRO) && ($1.simbolo->parametro == REF))
       {
         emit (&($$), DRF);
       }
       concatenar (&($$), $4.cod);
       emit (&($$), ASG);
     }
     else if (($<ok>2) && ($<ok>5) && ($1.simbolo->variable == VECTOR) && ($4.simbolo != NULL) && ($4.simbolo->variable == VECTOR))
     {
       lcond = newlabel(); 
       lbloque = newlabel();
       /* Almacenamos en la pila el numero de iteracion i (0..dimension-1) */
       emit (&($$), STC, 0);
       emit (&($$), DUP);
       emit (&($$), DUP); 
       emit (&($$), DUP);
       /* Almacenamos en la pila la dimension de los vectores a asignarse */
       emit (&($$), STC, $1.simbolo->dimension);
       emit (&($$), JMP, lcond);
       label (&($$), lbloque);
       /* @ base del vector LHS */
       emit (&($$), SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);     
       emit (&($$), PLUS);
       emit (&($$), SWP);
       emit (&($$), SRF, nivel - $4.simbolo->nivel, $4.simbolo->dir);
       emit (&($$), PLUS);
       emit (&($$), DRF);
       emit (&($$), ASG);
       
       /* Incrementar i al final y volver a apilar la dimension del vector */
       emit (&($$), STC, 1);
       emit (&($$), PLUS);
       emit (&($$), DUP);
       emit (&($$), DUP);
       emit (&($$), DUP);
       emit (&($$), STC, $1.simbolo->dimension);      
       /* COND: */
       label (&($$), lcond);
       emit (&($$), LT);
       emit (&($$), JMT, lbloque);
       /* Limpiar la pila si no saltamos */
       emit (&($$), POP);
       emit (&($$), POP);
       emit (&($$), POP);
     }  
   }
;

asignacion_vector:
      tIDENTIFICADOR
      {
        $<ok>$ = FALSE; /* Indica si existe o no el identificador */
	hay_vector = TRUE;
        if ($1.simbolo == NULL)
	{
	  sprintf(errorBuf, "Identificador %s no encontrado", $1.nombre);
          error_semantico(errorBuf);
	}
        else if ($1.simbolo->tipo != VARIABLE)
	{
	  $<ok>$ = FALSE;
	  sprintf(errorBuf, "El identificador %s debe ser variable", $1.nombre);
          error_semantico(errorBuf);
	}
        else if (($1.simbolo->variable != VECTOR) && ($1.simbolo->variable != DESCONOCIDO))
	{
	  $<ok>$ = FALSE;
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
        $<ok>$ = TRUE;
        if (($4.tipo != ENTERO) && ($4.tipo != DESCONOCIDO))
	{
	  $<ok>$ = FALSE;
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
	$<ok>$ = TRUE;   
        if (($<ok>2) && ($8.tipo != $1.simbolo->tipo_componentes))
	{
	  $<ok>$ = FALSE;
	  sprintf(errorBuf, "Tipos incompatibles en la asignacion");
          error_semantico(errorBuf);
	}
      }
      ';'
      {           
        /* Generar codigo si TODO correcto */  
	$$ = newcode();
	
        if (($<ok>2) && ($<ok>6) && ($<ok>9))
	{	
	  
	  /* argumentos f y o de SRF dependen de la declaracion del vector (T.S.) */
	  $$ = code (SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);
	  /* Codigo para expresion 1 */
	  concatenar (&($$), $4.cod);
	  /* Comprobaciones indice fuera de rango */
	  emit (&($$), DUP);
	  emit (&($$), DUP);
	  emit (&($$), STC, $1.simbolo->indiceInf);
	  emit (&($$), GTE);
	  emit (&($$), JMF, lerror);
	  emit (&($$), STC, $1.simbolo->indiceSup);
	  emit (&($$), LTE);
	  emit (&($$), JMF, lerror);
	  /* Limite inferior */
	  emit (&($$), STC, $1.simbolo->indiceInf);
	  emit (&($$), SBT);
	  /* Tamaño del vector -> En este caso no hace falta */
	  emit (&($$), PLUS);
	  /* Codigo para expresion 2 */
	  concatenar (&($$), $8.cod);
	  /* Asignacion */
	  emit (&($$), ASG);
	}
      }     
;

mientras_que:
  tMQ
  expresion
  {
    $<ok>$ = TRUE;
    if (($2.tipo != BOOLEANO) && ($2.tipo != DESCONOCIDO))
    {
      $<ok>$ = FALSE;
      error_semantico("Mq: condicion invalida.");
    }
  }
  lista_instrucciones
  tFMQ
  { 
    /* Generacion de codigo */
    $$ = newcode();
   
    if ($<ok>3 == TRUE)
    {
      char *lcond = newlabel(),
           *lbloque = newlabel();
	 
      $$ = code (JMP, lcond);	 
      label (&($$), lbloque);
      concatenar (&($$), $4);
      label (&($$), lcond);
      concatenar (&($$), $2.cod);
      emit (&($$), JMT, lbloque);
    } 
  }
;

seleccion:
  tSI
  expresion
  {
    $<ok>$ = TRUE;
    if (($2.tipo != BOOLEANO) && ($2.tipo != DESCONOCIDO))
    {
      $<ok>$ = FALSE;
      error_semantico("Seleccion: condicion invalida.");
    }
  }
  tENT
  lista_instrucciones
  resto_seleccion
  tFSI
  {
    /* Generacion de codigo */
     
    $$ = newcode();
    
    if ($<ok>3 == TRUE)
    {	         
      char *lsino = newlabel(), 
           *lfin  = newlabel();
	   
      $$ = $2.cod;
      emit (&($$), JMF, lsino);
      concatenar (&($$), $5);	
      if (longitud_lista($6)) 
      {
        emit (&($$), JMP, lfin);
        label (&($$), lsino);
        concatenar (&($$), $6);
        label (&($$), lfin);
      } 
      else label (&($$), lsino);
    }  
  }
;

resto_seleccion:
  { $$ = newcode(); }
| tSI_NO lista_instrucciones
  { $$ = $2; }
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
     if (($<ok>2 == TRUE) && ($1.simbolo->parametros.elementos != $3.constante))
     {
       /* Especificar si sobran o faltan argumentos y cuantos */
       if ($1.simbolo->parametros.elementos < $3.constante) 
         sprintf(errorBuf, "Numero de argumentos en invocacion de la accion %s incorrecto: sobran %d argumentos" 
	                   ,$1.nombre, $3.constante - $1.simbolo->parametros.elementos);
       else 
         sprintf(errorBuf, "Numero de argumentos en la invocacion de la accion %s incorrecto: faltan %d argumentos" 
	                   ,$1.nombre, $1.simbolo->parametros.elementos - $3.constante);
       error_semantico(errorBuf);
     }
     else $<ok>$ = TRUE;
   }
   ';'
   {    
     char msg[100];
     $$ = newcode();
     /* Generacion de codigo */
     if (($<ok>2 == TRUE) && ($<ok>4 == TRUE))
     {
       /* Apilamos los argumentos */
       /* Cuidado, si el argumento es a parametro por referencia, hay que eliminar el DRF que
          pone expresion para pasarle la direccion. Ya lo hago en el no terminal argumentos */
       $$ = $3.cod;
       sprintf (msg, "Invocar %s", $1.nombre);
       comment (&($$), msg);
       emit (&($$), OSF, sig[nivel], nivel - $1.simbolo->nivel, $1.simbolo->etiq); 
     }
   }
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
   {
     char msg[100];
     $$ = newcode();
     /* Generacion de codigo */
     if ($<ok>2 == TRUE)
     {
       /* No hay argumentos que apilar */
       sprintf (msg, "Invocar %s", $1);
       comment (&($$), msg);
       emit (&($$), OSF, sig[nivel], nivel - $1.simbolo->nivel, $1.simbolo->etiq); 
     }
   }
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
     int i, ok;
     
     $$.cod = newcode();

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if (($<paraID.simbolo>-2 != NULL) && ($<paraID.simbolo>-2->tipo == ACCION))
     {
       pars = (*($<paraID.simbolo>-2)).parametros;
       
       if (longitud_lista(pars) >= ($1.constante + 1)) 
       {
         p = observar (pars, $1.constante + 1);
	 ok = TRUE;
         /* Verificaciones de los argumentos de la invocacion */
	 if ($3.tipo == VECTOR)
	 {
	   ok = FALSE;
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != $3.tipo) && ($3.tipo != DESCONOCIDO))
         { 
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   ok = FALSE;
	   sprintf(errorBuf, "Los tipos del parametro y el argumento numero %d no coinciden", $1.constante + 1);
           error_semantico(errorBuf);
         }
         if (((*p).parametro == REF) && ($3.esVariable != TRUE) && ($3.esParametroRef != TRUE))
         {
           /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   ok = FALSE;
	   sprintf(errorBuf, "El argumento numero %d debe ser una variable o parametro por referencia", $1.constante + 1);		      
           error_semantico(errorBuf);
         }	 
       }
       $$.constante = $1.constante + 1; /* Para contar el numero de argumentos en la invocacion a la accion */
       /* Generacion de codigo */
       if (ok == TRUE)
       {
	 if ((*p).parametro == REF)
	 { 
	   /* Para los parametros ref eliminado la ultima instruccion de codigo generada por expresion (DRF)
	      para quedarnos con la direccion del parametro ref, no con su valor. */	   
	   eliminar_derecha(&($3.cod)); 
	   concatenar (&($1.cod), $3.cod);
	   $$.cod = $1.cod;  	     
	 }
	 else
	 { 
	   concatenar (&($1.cod), $3.cod);
           $$.cod = $1.cod; 
	 }  
       }
     }
   }
|  expresion
   {
     LISTA pars;
     SIMBOLO *p;
     int i, ok;
     
     $$.cod = newcode();

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if ($<ok>-1)
     {
       pars = (*($<paraID.simbolo>-2)).parametros;

       if (longitud_lista (pars) >= 1)
       {
         p = observar (pars, 1);
         /* Verificaciones */
	 ok = TRUE;
	 
	 if ($1.tipo == VECTOR)
	 {
	   ok = FALSE;
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != $1.tipo) &&  ($1.tipo != DESCONOCIDO))
         {
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   ok = FALSE;
	   sprintf(errorBuf, "Los tipos del parametro y el argumento 1 no coinciden");
           error_semantico(errorBuf);
         } 
         if (((*p).parametro == REF) && ($1.esVariable != TRUE) && ($1.esParametroRef !=TRUE))
         {  /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   ok = FALSE;	
	   sprintf(errorBuf, "El argumento numero 1 debe ser una variable o un parametro por referencia");		      
           error_semantico(errorBuf);
         }
       }
	 
       $$.constante = 1; /* Numero de argumentos: Solo hay uno */
       /* Generacion de codigo */
       if (ok == TRUE)
       {
         if ((*p).parametro == REF)
	 { 
	   /* Para los parametros ref elimino la ultima instruccion de codigo generado por expresion (DRF) 
	      para quedarnos con la dir del parametro por referencia, no con su valor */
	   $$.cod = $1.cod; 
	   eliminar_derecha(&($$.cod));  
	 }
	 else
	 {
           $$.cod = $1.cod;
	 }  
       }
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
     $$.cod = newcode();
     
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
     else
     {
       /* Generacion de codigo */
       
       /* Expresion 1 */
       $$.cod = $1.cod;
              
       /* Expresion 2 */
       concatenar(&($$.cod), $3.cod);
       
       switch ($2)
       {
         case '=': emit (&($$.cod), EQ); break;
	 case '<': emit (&($$.cod), LT); break;
	 case '>': emit (&($$.cod), GT); break;
	 case tMEI: emit (&($$.cod), LTE); break;
	 case tMAI: emit (&($$.cod), GTE); break;
	 case tNI: emit (&($$.cod), NEQ); break;
       }	 

     }

   }
;

operador_relacional:
    '='    
    { $$ = '='; }
|    '<'
    { $$ = '<'; }
|    '>'
    { $$ = '>'; }
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
     $$.cod = newcode();
     if ($2 == OR)
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
     else if ($2 == PLUS)
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
     else if ($2 == SBT)
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
       /* Generacion de codigo */
       if ($$.esConstEntera == TRUE) /* Optimizacion */
       {
	 emit (&($$.cod), STC, $$.valorConstEntera);
       }	 
       else
       {
         /* Expresion 1 */
         $$.cod = $1.cod;
         /* Expresion 2 */
         concatenar(&($$.cod), $3.cod);
       
         switch ($2)
         {
           case PLUS: emit (&($$.cod), PLUS); break;
	   case SBT: emit (&($$.cod), SBT); break;
	   case OR: emit (&($$.cod), OR); break;
         }
       }	 	        
   }
;

operador_aditivo:
     '+' { $$ = PLUS; }
|    '-' { $$ = SBT; }
|    tOR { $$ = OR; }
;

termino:
   factor
   {
     $$ = $1;
   }
|  termino operador_multiplicativo factor
   {
     $$.cod = newcode();
     if ($2 == TMS)
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
     else if ($2 == DIV)
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
     else if ($2 == MOD)
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
     else if ($2 == AND) 
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
       /* Generar codigo */
       
	  
       if ($$.esConstEntera == TRUE) /* Optimizacion */
       {
	 emit (&($$.cod), STC, $$.valorConstEntera);
       }	 
       else
       {

	 /* Expresion 1 */
	 $$.cod = $1.cod;

         /* Expresion 2 */
         concatenar(&($$.cod), $3.cod);

         switch ($2)
         {
           case TMS:  emit (&($$.cod), TMS); break;
	   case DIV:  emit (&($$.cod), DIV); break;
	   case MOD:  emit (&($$.cod), MOD); break;
	   case AND:  emit (&($$.cod), AND); break;
         }	
       }   
   }
;

operador_multiplicativo:
     '*'  { $$ = TMS; }
|    tDIV { $$ = DIV; }
|    tMOD { $$ = MOD; }
|    tAND { $$ = AND; }
;

factor:
   '-' factor %prec MENOSU
    {
      $$ = $2;
      $$.cod = newcode();
      if ($2.esConstEntera == TRUE)
        $$.valorConstEntera = - ($2.valorConstEntera);
	
      $$.tipo = ENTERO;
      
      if ($2.tipo != ENTERO)
      {
        error_semantico("Argumento de - unario debe ser entero");
      }
      else
      {
        /* Generar codigo */
	concatenar (&($$.cod), $2.cod);
	emit(&($$.cod), NGI);
      }
    }
|   tNOT factor
    {
      $$ = $2;
      $$.tipo = BOOLEANO;
      $$.cod = newcode();
      if ($2.tipo != BOOLEANO)
      {
        error_semantico("Argumento de not debe ser booleano");
      }
      else
      {
        /* Generar codigo */
	concatenar (&($$.cod), $2.cod);
	emit(&($$.cod), NGB);
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
      $$.cod = newcode();
      
      if ($3.tipo != ENTERO)
      {
        error_semantico("Argumento de entacar debe ser entero");
      }
      else
      {
        /* Generar codigo */
        if ($3.esConstEntera == TRUE)
	{
	  $$.esConstChar = TRUE;
	  $$.valorConstChar = (char) $3.valorConstEntera;
	  
	  if (($3.valorConstEntera < 0) || ($3.valorConstEntera >= 256))
	  {
	    if (warnings == 1) warning("Se truncara el argumento de entacar al ser este negativo");
	    $$.valorConstChar = abs ($3.valorConstEntera % 256) ;
	    emit (&($$.cod), STC, $$.valorConstChar);
          }		
	  else emit (&($$.cod), STC, $$.valorConstChar);
	}
	else $$.cod = $3.cod;
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
      $$.cod = newcode();
      
      if ($3.tipo != CHAR)
      {
        error_semantico("Argumento de caraent debe ser caracter");
      }
      else 
      {
        /* Generar codigo */
	
        if ($3.esConstChar == TRUE)
        {
	  $$.esConstEntera = TRUE;
	  $$.valorConstEntera = (int) $3.valorConstChar;
	  emit (&($$.cod), STC, $3.valorConstEntera);
	}
	else $$.cod = $3.cod;
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
      $$.cod = newcode();
      
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
	$$.cod = code (SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);
	emit (&($$.cod), DRF);
      }
      else /* Es un parametro */
      {  
        $$.simbolo = $1.simbolo; 
	$$.esVariable = FALSE;
	$$.tipo = $1.simbolo->variable; /* El tipo de la expresion es el del parametro */
	if ($1.simbolo->parametro == REF)
	{ 
	  $$.esParametroRef = TRUE;
	  /* 2 niveles de indireccion, primero, con SRF, guardamos en la pila la @ donde esta el
	     parametro relativa al BP, luego, con el primer DRF, guardamos el contenido de esa direccion,
	     que sera la direccion del parametro, y finalmente otro DRF mas para acceder
	     al valor del parametro con su direccion */
	  $$.cod = code (SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);
	  emit (&($$.cod), DRF);
	  emit (&($$.cod), DRF);
	}  
	else /* Parametro por valor */
	{
	  $$.esParametroRef = FALSE;
	  $$.cod = code (SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);
	  emit (&($$.cod), DRF); 
	}  
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
      hay_vector = TRUE;
      
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
	
	/* Generacion de codigo */
	
	/* @ base del vector en la pila de ejecucion (FRAMES) */	
        emit (&($$.cod), SRF, nivel - $1.simbolo->nivel, $1.simbolo->dir);
	/* ¿Parametro? */
	/* Codigo para expresion */
	concatenar (&($$.cod), $3.cod);
	/* Comprobaciones indice fuera de rango */
	emit (&($$.cod), DUP);
	emit (&($$.cod), DUP);
	emit (&($$.cod), STC, $1.simbolo->indiceInf);
	emit (&($$.cod), GTE);
	emit (&($$.cod), JMF, lerror);
	emit (&($$.cod), STC, $1.simbolo->indiceSup);
	emit (&($$.cod), LTE);
	emit (&($$.cod), JMF, lerror);
	/* Apilamos el limite inferior del vector */
	emit (&($$.cod), STC,  $1.simbolo->indiceInf);
	/* Apilamos expresion - limite inferior */
	emit (&($$.cod), SBT);
	/* Como el tamaño es 1, no hace falta multiplicar por el mismo */
	/* Sumamos el desplazamiento del vector a su @base */
        emit (&($$.cod), PLUS);	
	emit (&($$.cod), DRF);
      }
      /* Codigo para los warnings de indice del vector fuera de rango */
      if (($1.simbolo != NULL)  && ($1.simbolo->variable == VECTOR) && ($3.tipo == ENTERO) && ($3.esConstEntera == TRUE))
      {
        /* Comprobar, si expresion es constEntera que esta dentro del rango de indices del vector */
	if ( (($1.simbolo->indiceSup > 0) && ($1.simbolo->indiceInf > 0)) && 
	     (($3.valorConstEntera > $1.simbolo->indiceSup) || ($3.valorConstEntera < $1.simbolo->indiceInf)))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", $3.valorConstEntera, $1.nombre);
           warning(errorBuf);
	  } 
	}	
        else if ( (($1.simbolo->indiceInf < 0) && ($1.simbolo->indiceSup < 0)) &&
	          (($3.valorConstEntera < $1.simbolo->indiceInf) || ($3.valorConstEntera > $1.simbolo->indiceSup)))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", $3.valorConstEntera, $1.nombre);
           warning(errorBuf);
	  } 
	}
	else if ( (($1.simbolo->indiceInf < 0) && ($1.simbolo->indiceSup > 0)) &&
	          (($3.valorConstEntera > $1.simbolo->indiceSup) || ($3.valorConstEntera < $1.simbolo->indiceInf)))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", $3.valorConstEntera, $1.nombre);
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
       /* Generacion de codigo */
       $$.cod = code (STC, $1);
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
       /* Generacion de codigo */
       $$.cod = code (STC, $1);
     }
|    tCONSTCAD    
     { 
       int i = 0;
     
       $$.tipo = CADENA;  
       $$.esConstChar = FALSE;
       $$.esConstEntera = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE; 
       $$.simbolo = NULL;
       $$.longitud = strlen($1);
       /* Generacion de codigo */
       $$.cad = $1;
       
     }
|    tTRUE        
     { 
       $$.tipo = BOOLEANO; 
       $$.esConstChar = FALSE;
       $$.esConstEntera = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE; 
       $$.simbolo = NULL;
       /* Generacion de codigo */
       $$.cod = code (STC, 1);
     }
|    tFALSE       
     { 
       $$.tipo = BOOLEANO; 
       $$.esConstChar = FALSE;
       $$.esConstEntera = FALSE;
       $$.esVariable = FALSE;
       $$.esParametroRef = FALSE; 
       $$.simbolo = NULL;
       /* Generacion de codigo */
       $$.cod = code (STC, 0);
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
     fprintf (stderr, "Uso: pascual fuente (sin la extension .pc) [-w]\n");
     exit (-1);
   }

   strcpy (namein, argv[1]);
   strcat (namein, ".pc");
   yyin = fopen (namein, "r");
   
   if (yyin == NULL) {
      fprintf (stderr, "Fichero %s no existe.\n", namein);
      exit (-1);
   }
   
   if ((argc == 3) && (strcmp(argv[2], "-w") == 0))
   /* Activamos el modo de mostrar warnings */   
     warnings = 1;
   else if ((argc == 3) && (strcmp(argv[2], "-w") != 0))
   {
     fprintf (stderr, "El tercer argumento es erroneo\n");
     fprintf (stderr, "Uso: pascual fuente (sin la extension .pc) [-w]\n");
     exit (-1);
   }  
   else 
     warnings = 0;  

   inicializar_tabla (tabsim);
   strcpy (nameout, argv[1]);
   strcat (nameout, ".cp");
   yyout = fopen (nameout, "w");
   /* yydebug = 1; /* Depuracion */
   yyparse ();

   if (error == 1)
   {
     remove (nameout);
     fprintf (stderr, "ATENCION! Ha habido errores y NO se ha generado el fichero %s\n", nameout);
     exit (-1);
   }
   else
   { 
     fprintf (stderr, "Fichero %s generado correctamente\n", nameout);
   }
   
   fclose (yyout);
   fclose (yyin);
   exit(0);
}

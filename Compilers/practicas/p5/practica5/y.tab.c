
/*  A Bison parser, made from pascual.y
    by GNU Bison version 1.28  */

#define YYBISON 1  /* Identify Bison output.  */

#define	tPROGRAMA	257
#define	tACCION	258
#define	tCONSTENTERA	259
#define	tCONSTCHAR	260
#define	tCONSTCAD	261
#define	tTRUE	262
#define	tFALSE	263
#define	tENTACAR	264
#define	tCARAENT	265
#define	tIDENTIFICADOR	266
#define	tENTERO	267
#define	tCARACTER	268
#define	tBOOLEANO	269
#define	tESCRIBIR	270
#define	tLEER	271
#define	tOPAS	272
#define	tPRINCIPIO	273
#define	tFIN	274
#define	tNULA	275
#define	tVECTOR	276
#define	tDE	277
#define	tAND	278
#define	tOR	279
#define	tNOT	280
#define	tMQ	281
#define	tFMQ	282
#define	tMEI	283
#define	tMAI	284
#define	tNI	285
#define	tMOD	286
#define	tDIV	287
#define	tSI	288
#define	tENT	289
#define	tSI_NO	290
#define	tFSI	291
#define	tVAL	292
#define	tREF	293
#define	MENOSU	294

#line 1 "pascual.y"

/**********************************************************************
 * fichero: pascual.y
 *          Generador de codigo intermedio.
 *
 * modificado por: Marcos Mainar Lalmolda
 * modificaciones realizadas:
 *   - Completada la gramatica para generar codigo usando generacion no
 *     secuencial (AST).
 *
 * fecha ultima modificacion: 3 de junio de 2009
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
  int i;

  emit (l, STC, 13);
  emit (l, STC, 10);
  emit (l, STC, 111); 
  emit (l, STC, 100); 
  emit (l, STC, 110); 
  emit (l, STC, 97); 
  emit (l, STC, 116); 
  emit (l, STC, 114); 
  emit (l, STC, 111); 
  emit (l, STC, 98); 
  emit (l, STC, 65); 
  for (i = 1; i <= 11; i++)
    emit (l, WRT, 0);    
}


#line 150 "pascual.y"
typedef union {
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
} YYSTYPE;
#ifndef YYDEBUG
#define YYDEBUG 1
#endif

#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#define const
#endif
#endif



#define	YYFINAL		200
#define	YYFLAG		-32768
#define	YYNTBASE	54

#define YYTRANSLATE(x) ((unsigned)(x) <= 294 ? yytranslate[x] : 107)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,    52,
    53,    45,    43,    51,    44,    49,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,    47,    42,
    40,    41,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
    48,     2,    50,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     3,     4,     5,     6,
     7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
    17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
    27,    28,    29,    30,    31,    32,    33,    34,    35,    36,
    37,    38,    39,    46
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     1,     9,    10,    12,    13,    16,    20,    22,    25,
    28,    30,    32,    34,    44,    55,    66,    78,    80,    84,
    86,    90,    92,    95,   101,   102,   107,   108,   112,   116,
   118,   121,   124,   126,   130,   132,   134,   138,   141,   143,
   146,   148,   150,   152,   154,   156,   158,   160,   162,   165,
   171,   173,   177,   183,   187,   189,   190,   191,   198,   199,
   200,   201,   212,   213,   219,   220,   228,   229,   232,   233,
   234,   240,   241,   245,   249,   253,   255,   257,   261,   263,
   265,   267,   269,   271,   273,   275,   279,   281,   283,   285,
   287,   291,   293,   295,   297,   299,   302,   305,   309,   314,
   319,   321,   326,   328,   330,   332,   334
};

static const short yyrhs[] = {    -1,
     3,    12,    47,    55,    57,    56,    74,     0,     0,    64,
     0,     0,    58,    47,     0,    58,    47,    59,     0,    59,
     0,    60,    62,     0,    61,    63,     0,    13,     0,    14,
     0,    15,     0,    22,    48,     5,    49,    49,     5,    50,
    23,    60,     0,    22,    48,    44,     5,    49,    49,     5,
    50,    23,    60,     0,    22,    48,     5,    49,    49,    44,
     5,    50,    23,    60,     0,    22,    48,    44,     5,    49,
    49,    44,     5,    50,    23,    60,     0,    12,     0,    62,
    51,    12,     0,    12,     0,    63,    51,    12,     0,    65,
     0,    64,    65,     0,    66,    47,    57,    56,    74,     0,
     0,     4,    12,    67,    68,     0,     0,    52,    69,    53,
     0,    69,    47,    70,     0,    70,     0,    73,    71,     0,
    60,    72,     0,    12,     0,    72,    51,    12,     0,    38,
     0,    39,     0,    19,    75,    20,     0,    19,    20,     0,
    76,     0,    75,    76,     0,    78,     0,    80,     0,    82,
     0,    85,     0,    91,     0,    89,     0,    94,     0,    77,
     0,    21,    47,     0,    17,    52,    79,    53,    47,     0,
    12,     0,    79,    51,    12,     0,    16,    52,    81,    53,
    47,     0,    81,    51,   100,     0,   100,     0,     0,     0,
    12,    83,    18,   100,    84,    47,     0,     0,     0,     0,
    12,    86,    48,   100,    50,    87,    18,   100,    88,    47,
     0,     0,    27,   100,    90,    75,    28,     0,     0,    34,
   100,    92,    35,    75,    93,    37,     0,     0,    36,    75,
     0,     0,     0,    12,    95,    98,    96,    47,     0,     0,
    12,    97,    47,     0,    52,    99,    53,     0,    99,    51,
   100,     0,   100,     0,   102,     0,   100,   101,   102,     0,
    40,     0,    42,     0,    41,     0,    29,     0,    30,     0,
    31,     0,   104,     0,   102,   103,   104,     0,    43,     0,
    44,     0,    25,     0,   106,     0,   104,   105,   106,     0,
    45,     0,    33,     0,    32,     0,    24,     0,    44,   106,
     0,    26,   106,     0,    52,   100,    53,     0,    10,    52,
   100,    53,     0,    11,    52,   100,    53,     0,    12,     0,
    12,    48,   100,    50,     0,     5,     0,     6,     0,     7,
     0,     8,     0,     9,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   196,   206,   233,   237,   243,   247,   254,   256,   259,   261,
   265,   267,   268,   271,   282,   292,   304,   317,   351,   386,
   439,   488,   491,   498,   537,   577,   588,   592,   598,   604,
   607,   612,   617,   631,   646,   648,   651,   654,   658,   661,
   668,   671,   673,   675,   677,   679,   681,   683,   687,   690,
   696,   744,   792,   798,   840,   881,   902,   932,   989,  1016,
  1046,  1059,  1101,  1113,  1133,  1145,  1173,  1175,  1179,  1210,
  1225,  1240,  1277,  1291,  1296,  1356,  1416,  1421,  1472,  1475,
  1477,  1479,  1481,  1483,  1487,  1492,  1581,  1583,  1584,  1587,
  1592,  1735,  1737,  1738,  1739,  1742,  1763,  1779,  1783,  1816,
  1843,  1896,  2012,  2024,  2036,  2053,  2064
};
#endif


#if YYDEBUG != 0 || defined (YYERROR_VERBOSE)

static const char * const yytname[] = {   "$","error","$undefined.","tPROGRAMA",
"tACCION","tCONSTENTERA","tCONSTCHAR","tCONSTCAD","tTRUE","tFALSE","tENTACAR",
"tCARAENT","tIDENTIFICADOR","tENTERO","tCARACTER","tBOOLEANO","tESCRIBIR","tLEER",
"tOPAS","tPRINCIPIO","tFIN","tNULA","tVECTOR","tDE","tAND","tOR","tNOT","tMQ",
"tFMQ","tMEI","tMAI","tNI","tMOD","tDIV","tSI","tENT","tSI_NO","tFSI","tVAL",
"tREF","'='","'>'","'<'","'+'","'-'","'*'","MENOSU","';'","'['","'.'","']'",
"','","'('","')'","programa","@1","declaracion_acciones2","declaracion_variables",
"lista_declaraciones","declaracion","tipo_variables","tipo_variable_vector",
"identificadores","identificadores_vector","declaracion_acciones","declaracion_accion",
"cabecera_accion","@2","parametros_formales","lista_parametros","parametros",
"declaracion_parametros","listaIDs_parametros","clase_parametros","bloque_instrucciones",
"lista_instrucciones","instruccion","nula","leer","lista_asignables","escribir",
"lista_escribibles","asignacion","@3","@4","asignacion_vector","@5","@6","@7",
"mientras_que","@8","seleccion","@9","resto_seleccion","invocacion_accion","@10",
"@11","@12","argumentos","lista_expresiones","expresion","operador_relacional",
"expresion_simple","operador_aditivo","termino","operador_multiplicativo","factor", NULL
};
#endif

static const short yyr1[] = {     0,
    55,    54,    56,    56,    57,    57,    58,    58,    59,    59,
    60,    60,    60,    61,    61,    61,    61,    62,    62,    63,
    63,    64,    64,    65,    67,    66,    68,    68,    69,    69,
    70,    71,    72,    72,    73,    73,    74,    74,    75,    75,
    76,    76,    76,    76,    76,    76,    76,    76,    77,    78,
    79,    79,    80,    81,    81,    83,    84,    82,    86,    87,
    88,    85,    90,    89,    92,    91,    93,    93,    95,    96,
    94,    97,    94,    98,    99,    99,   100,   100,   101,   101,
   101,   101,   101,   101,   102,   102,   103,   103,   103,   104,
   104,   105,   105,   105,   105,   106,   106,   106,   106,   106,
   106,   106,   106,   106,   106,   106,   106
};

static const short yyr2[] = {     0,
     0,     7,     0,     1,     0,     2,     3,     1,     2,     2,
     1,     1,     1,     9,    10,    10,    11,     1,     3,     1,
     3,     1,     2,     5,     0,     4,     0,     3,     3,     1,
     2,     2,     1,     3,     1,     1,     3,     2,     1,     2,
     1,     1,     1,     1,     1,     1,     1,     1,     2,     5,
     1,     3,     5,     3,     1,     0,     0,     6,     0,     0,
     0,    10,     0,     5,     0,     7,     0,     2,     0,     0,
     5,     0,     3,     3,     3,     1,     1,     3,     1,     1,
     1,     1,     1,     1,     1,     3,     1,     1,     1,     1,
     3,     1,     1,     1,     1,     2,     2,     3,     4,     4,
     1,     4,     1,     1,     1,     1,     1
};

static const short yydefact[] = {     0,
     0,     0,     1,     5,    11,    12,    13,     0,     3,     0,
     8,     0,     0,     0,     0,     0,     4,    22,     0,     6,
    18,     9,    20,    10,     0,     0,    25,     0,     2,    23,
     5,     7,     0,     0,     0,     0,    27,    56,     0,     0,
    38,     0,     0,     0,     0,    39,    48,    41,    42,    43,
    44,    46,    45,    47,     3,    19,    21,     0,     0,     0,
    26,     0,     0,     0,     0,     0,     0,    49,   103,   104,
   105,   106,   107,     0,     0,   101,     0,     0,     0,    63,
    77,    85,    90,    65,    37,    40,     0,     0,     0,     0,
    35,    36,     0,    30,     0,     0,     0,     0,    70,    73,
     0,    55,    51,     0,     0,     0,     0,    97,    96,     0,
    82,    83,    84,    79,    81,    80,     0,     0,    89,    87,
    88,     0,    95,    94,    93,    92,     0,     0,    24,     0,
     0,     0,     0,     0,    28,     0,    31,    57,     0,     0,
    76,     0,     0,     0,     0,     0,     0,     0,     0,    98,
     0,    78,    86,    91,     0,     0,     0,     0,     0,    29,
    33,    32,     0,    60,     0,    74,    71,    54,    53,    52,
    50,    99,   100,   102,    64,    67,    14,     0,     0,     0,
     0,    58,     0,    75,     0,     0,    16,    15,     0,    34,
     0,    68,    66,    17,    61,     0,    62,     0,     0,     0
};

static const short yydefgoto[] = {   198,
     4,    16,     9,    10,    11,    12,    13,    22,    24,    17,
    18,    19,    37,    61,    93,    94,   137,   162,    95,    29,
    45,    46,    47,    48,   104,    49,   101,    50,    62,   163,
    51,    63,   183,   196,    52,   117,    53,   128,   186,    54,
    64,   142,    65,    99,   140,    80,   118,    81,   122,    82,
   127,    83
};

static const short yypact[] = {    14,
     9,   -18,-32768,    88,-32768,-32768,-32768,    -6,    47,    -2,
-32768,    45,    48,    -1,    61,    49,    47,-32768,    33,    88,
-32768,    34,-32768,    53,    67,    93,-32768,   102,-32768,-32768,
    88,-32768,   105,   108,    75,    76,    80,    27,    85,    86,
-32768,    81,     4,     4,   114,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,    47,-32768,-32768,     2,    78,    73,
-32768,   121,    92,    90,    96,     4,   132,-32768,-32768,-32768,
-32768,-32768,-32768,   104,   115,    97,     4,     4,     4,   145,
    15,    60,-32768,   145,-32768,-32768,    49,   107,   161,     3,
-32768,-32768,    -3,-32768,    18,     4,     4,     4,-32768,-32768,
   -33,   145,-32768,    37,     4,     4,     4,-32768,-32768,    -4,
-32768,-32768,-32768,-32768,-32768,-32768,     7,     4,-32768,-32768,
-32768,     4,-32768,-32768,-32768,-32768,     4,   137,-32768,   154,
   128,   130,   176,    73,-32768,   170,-32768,   145,   123,    56,
   145,   136,     4,   141,   172,   142,    36,    41,   129,-32768,
   134,    15,    60,-32768,     7,    18,   167,   168,   143,-32768,
-32768,   144,   147,-32768,     4,-32768,-32768,   145,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,    79,-32768,    18,    18,   169,
   184,-32768,   179,   145,     7,   162,-32768,-32768,    18,-32768,
     4,     7,-32768,-32768,   145,   151,-32768,   200,   201,-32768
};

static const short yypgoto[] = {-32768,
-32768,   148,   171,-32768,   185,   -92,-32768,-32768,-32768,-32768,
   187,-32768,-32768,-32768,-32768,    72,-32768,-32768,-32768,   120,
  -116,   -43,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,   -44,-32768,    91,-32768,    89,
-32768,   -72
};


#define	YYLAST		211


static const short yytable[] = {    84,
   151,    86,   136,    25,   108,   109,    88,   132,    69,    70,
    71,    72,    73,    74,    75,    76,     1,   143,    38,   144,
     2,   102,    39,    40,   111,   112,   113,    42,     3,    77,
     5,     6,     7,    43,   110,   114,   115,   116,   176,   119,
    44,    14,    26,   134,    20,    89,   133,    78,   150,   135,
    15,   138,   139,   141,   154,    79,    21,   120,   121,    23,
   147,   148,   149,   177,   111,   112,   113,    28,   192,   111,
   112,   113,    27,   -72,   -59,   114,   115,   116,   -69,    31,
   114,   115,   116,   123,    33,   187,   188,   145,   172,   146,
    38,   124,   125,   173,    39,    40,   194,    36,   168,    42,
     5,     6,     7,    34,   126,    43,   165,    86,   166,     8,
    91,    92,    44,    38,   185,    35,    56,    39,    40,    57,
   184,    41,    42,    58,    59,    38,    90,    68,    43,    39,
    40,    60,    86,    85,    42,    44,    66,    67,    96,    97,
    43,    98,   100,   103,   107,    38,   195,    44,    86,    39,
    40,   111,   112,   113,    42,   105,   130,   111,   112,   113,
    43,   175,   114,   115,   116,   131,   106,    44,   114,   115,
   116,   155,   164,   111,   112,   113,   156,   157,   174,   158,
   159,   161,   167,   170,   114,   115,   116,   169,   171,   178,
   179,   189,   180,   182,   181,   190,   191,   197,   193,   199,
   200,    55,    87,    30,    32,   160,   129,     0,   152,     0,
   153
};

static const short yycheck[] = {    44,
   117,    45,    95,     5,    77,    78,     5,     5,     5,     6,
     7,     8,     9,    10,    11,    12,     3,    51,    12,    53,
    12,    66,    16,    17,    29,    30,    31,    21,    47,    26,
    13,    14,    15,    27,    79,    40,    41,    42,   155,    25,
    34,    48,    44,    47,    47,    44,    44,    44,    53,    53,
     4,    96,    97,    98,   127,    52,    12,    43,    44,    12,
   105,   106,   107,   156,    29,    30,    31,    19,   185,    29,
    30,    31,    12,    47,    48,    40,    41,    42,    52,    47,
    40,    41,    42,    24,    51,   178,   179,    51,    53,    53,
    12,    32,    33,    53,    16,    17,   189,     5,   143,    21,
    13,    14,    15,    51,    45,    27,    51,   151,    53,    22,
    38,    39,    34,    12,    36,    49,    12,    16,    17,    12,
   165,    20,    21,    49,    49,    12,    49,    47,    27,    16,
    17,    52,   176,    20,    21,    34,    52,    52,    18,    48,
    27,    52,    47,    12,    48,    12,   191,    34,   192,    16,
    17,    29,    30,    31,    21,    52,    50,    29,    30,    31,
    27,    28,    40,    41,    42,     5,    52,    34,    40,    41,
    42,    35,    50,    29,    30,    31,    23,    50,    50,    50,
     5,    12,    47,    12,    40,    41,    42,    47,    47,    23,
    23,    23,    50,    47,    51,    12,    18,    47,    37,     0,
     0,    31,    55,    17,    20,   134,    87,    -1,   118,    -1,
   122
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "/opt/bison/share/bison.simple"
/* This file comes from bison-1.28.  */

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

#ifndef YYSTACK_USE_ALLOCA
#ifdef alloca
#define YYSTACK_USE_ALLOCA
#else /* alloca not defined */
#ifdef __GNUC__
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi) || (defined (__sun) && defined (__i386))
#define YYSTACK_USE_ALLOCA
#include <alloca.h>
#else /* not sparc */
/* We think this test detects Watcom and Microsoft C.  */
/* This used to test MSDOS, but that is a bad idea
   since that symbol is in the user namespace.  */
#if (defined (_MSDOS) || defined (_MSDOS_)) && !defined (__TURBOC__)
#if 0 /* No need for malloc.h, which pollutes the namespace;
	 instead, just don't use alloca.  */
#include <malloc.h>
#endif
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
/* I don't know what this was needed for, but it pollutes the namespace.
   So I turned it off.   rms, 2 May 1997.  */
/* #include <malloc.h>  */
 #pragma alloca
#define YYSTACK_USE_ALLOCA
#else /* not MSDOS, or __TURBOC__, or _AIX */
#if 0
#ifdef __hpux /* haible@ilog.fr says this works for HPUX 9.05 and up,
		 and on HPUX 10.  Eventually we can turn this on.  */
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#endif /* __hpux */
#endif
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc */
#endif /* not GNU C */
#endif /* alloca not defined */
#endif /* YYSTACK_USE_ALLOCA not defined */

#ifdef YYSTACK_USE_ALLOCA
#define YYSTACK_ALLOC alloca
#else
#define YYSTACK_ALLOC malloc
#endif

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	goto yyacceptlab
#define YYABORT 	goto yyabortlab
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Define __yy_memcpy.  Note that the size argument
   should be passed with type unsigned int, because that is what the non-GCC
   definitions require.  With GCC, __builtin_memcpy takes an arg
   of type size_t, but it can handle unsigned int.  */

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(TO,FROM,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (to, from, count)
     char *to;
     char *from;
     unsigned int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *to, char *from, unsigned int count)
{
  register char *t = to;
  register char *f = from;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 217 "/opt/bison/share/bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#ifdef __cplusplus
#define YYPARSE_PARAM_ARG void *YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#else /* not __cplusplus */
#define YYPARSE_PARAM_ARG YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#endif /* not __cplusplus */
#else /* not YYPARSE_PARAM */
#define YYPARSE_PARAM_ARG
#define YYPARSE_PARAM_DECL
#endif /* not YYPARSE_PARAM */

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
#ifdef YYPARSE_PARAM
int yyparse (void *);
#else
int yyparse (void);
#endif
#endif

int
yyparse(YYPARSE_PARAM_ARG)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;
  int yyfree_stacks = 0;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  if (yyfree_stacks)
	    {
	      free (yyss);
	      free (yyvs);
#ifdef YYLSP_NEEDED
	      free (yyls);
#endif
	    }
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
#ifndef YYSTACK_USE_ALLOCA
      yyfree_stacks = 1;
#endif
      yyss = (short *) YYSTACK_ALLOC (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss, (char *)yyss1,
		   size * (unsigned int) sizeof (*yyssp));
      yyvs = (YYSTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs, (char *)yyvs1,
		   size * (unsigned int) sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls, (char *)yyls1,
		   size * (unsigned int) sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 1:
#line 198 "pascual.y"
{	
    nivel = 0;
    sig[nivel] = INICIAL;
    lenp = newlabel();
    llvp = newlabel(); /* Para saltar al final del programa desde rutinas de error */
    introducir_programa (tabsim, yyvsp[-1].paraID.nombre, lenp); 
  ;
    break;}
case 2:
#line 208 "pascual.y"
{
    char msg[100];
      
    eliminar_programa (tabsim); 
    cerrar_bloque();

    /* Generacion de codigo */
    yyval.cod = code (ENP, lenp); 
    concatenar (&(yyval.cod), yyvsp[-1].cod);
    sprintf (msg, "Comienzo del programa %s", yyvsp[-5].paraID.nombre);
    comment (&(yyval.cod), msg);
    label (&(yyval.cod), lenp);
    concatenar (&(yyval.cod), yyvsp[0].cod);
    sprintf (msg, "Fin del programa %s", yyvsp[-5].paraID.nombre);
    comment (&(yyval.cod), msg);
    label (&(yyval.cod), llvp); /* para rutinas de error */
    emit (&(yyval.cod), LVP);
    if (error == 0)
    { 
      /* Volcamos a disco si no ha habido errores sintacticos ni semanticos */
      dumpcode (yyval.cod, yyout);
    }  
  ;
    break;}
case 3:
#line 234 "pascual.y"
{
      crear_vacia(&(yyval.cod)); 
    ;
    break;}
case 4:
#line 238 "pascual.y"
{
      yyval.cod = yyvsp[0].cod; 
    ;
    break;}
case 5:
#line 244 "pascual.y"
{
    ; 
   ;
    break;}
case 6:
#line 248 "pascual.y"
{
     ;
   ;
    break;}
case 9:
#line 260 "pascual.y"
{ ; ;
    break;}
case 10:
#line 262 "pascual.y"
{ ; ;
    break;}
case 11:
#line 266 "pascual.y"
{ yyval.tipo = ENTERO;   ;
    break;}
case 12:
#line 267 "pascual.y"
{ yyval.tipo = CHAR;     ;
    break;}
case 13:
#line 268 "pascual.y"
{ yyval.tipo = BOOLEANO; ;
    break;}
case 14:
#line 273 "pascual.y"
{
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         yyval.paraVector.tipo = VECTOR;
         yyval.paraVector.indiceInf = yyvsp[-6].constante;
         yyval.paraVector.indiceSup = yyvsp[-3].constante;
         yyval.paraVector.dimension = yyval.paraVector.indiceSup - yyval.paraVector.indiceInf + 1;
         yyval.paraVector.tipo_componentes = yyvsp[0].tipo;
       ;
    break;}
case 15:
#line 283 "pascual.y"
{
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         yyval.paraVector.tipo = VECTOR;
         yyval.paraVector.indiceInf = -(yyvsp[-6].constante);
         yyval.paraVector.indiceSup = yyvsp[-3].constante;
         yyval.paraVector.dimension = yyval.paraVector.indiceSup - yyval.paraVector.indiceInf + 1;
         yyval.paraVector.tipo_componentes = yyvsp[0].tipo;
       ;
    break;}
case 16:
#line 293 "pascual.y"
{
         /* En este caso, los indices del vector son incorrectos, ya que el inferior
	    es >= 0 y el superior es < 0. Daremos el error semantico mas tarde  */
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         yyval.paraVector.tipo = VECTOR;
         yyval.paraVector.indiceInf = yyvsp[-7].constante;
         yyval.paraVector.indiceSup = -(yyvsp[-3].constante);
         yyval.paraVector.dimension = yyval.paraVector.indiceSup - yyval.paraVector.indiceInf + 1;
         yyval.paraVector.tipo_componentes = yyvsp[0].tipo;
       ;
    break;}
case 17:
#line 305 "pascual.y"
{
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         yyval.paraVector.tipo = VECTOR;
         yyval.paraVector.indiceInf = -(yyvsp[-7].constante);
         yyval.paraVector.indiceSup = -(yyvsp[-3].constante);
         yyval.paraVector.dimension = yyval.paraVector.indiceSup - yyval.paraVector.indiceInf + 1;
         yyval.paraVector.tipo_componentes = yyvsp[0].tipo;
       ;
    break;}
case 18:
#line 319 "pascual.y"
{
     if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       introducir_variable(tabsim, yyvsp[0].paraID.nombre, yyvsp[-1].tipo, nivel, 0); 
       crear_var (yyvsp[0].paraID.nombre, yyvsp[-1].tipo);
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch (yyvsp[0].paraID.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", yyvsp[0].paraID.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", yyvsp[0].paraID.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", yyvsp[0].paraID.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", yyvsp[0].paraID.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   ;
    break;}
case 19:
#line 352 "pascual.y"
{
     if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       introducir_variable(tabsim, yyvsp[0].paraID.nombre, yyvsp[-3].tipo, nivel, 0);
       crear_var (yyvsp[0].paraID.nombre, yyvsp[-3].tipo);
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch (yyvsp[0].paraID.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", yyvsp[0].paraID.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", yyvsp[0].paraID.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", yyvsp[0].paraID.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", yyvsp[0].paraID.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   ;
    break;}
case 20:
#line 388 "pascual.y"
{
     if (yyvsp[-1].paraVector.indiceInf > yyvsp[-1].paraVector.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son incorrectos", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if (yyvsp[-1].paraVector.indiceInf == yyvsp[-1].paraVector.indiceSup)
     {
       if (warnings == 1) 
       { 
         sprintf(errorBuf, "Los indices del vector %s son iguales", yyvsp[0].paraID.nombre);
         warning(errorBuf);
       }
       introducir_variable_vector (tabsim, yyvsp[0].paraID.nombre, nivel, 0, yyvsp[-1].paraVector.tipo_componentes,
                                   yyvsp[-1].paraVector.indiceInf, yyvsp[-1].paraVector.indiceSup,
                                   yyvsp[-1].paraVector.dimension);
       crear_var_vector (yyvsp[0].paraID.nombre, yyvsp[-1].paraVector.tipo_componentes, yyvsp[-1].paraVector.dimension);
     }
     else if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       introducir_variable_vector (tabsim, yyvsp[0].paraID.nombre, nivel, 0, yyvsp[-1].paraVector.tipo_componentes,
                                   yyvsp[-1].paraVector.indiceInf, yyvsp[-1].paraVector.indiceSup,
                                   yyvsp[-1].paraVector.dimension);
       crear_var_vector (yyvsp[0].paraID.nombre, yyvsp[-1].paraVector.tipo_componentes, yyvsp[-1].paraVector.dimension);
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch (yyvsp[0].paraID.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", yyvsp[0].paraID.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", yyvsp[0].paraID.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", yyvsp[0].paraID.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", yyvsp[0].paraID.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   ;
    break;}
case 21:
#line 440 "pascual.y"
{
     if (yyvsp[-3].paraVector.indiceInf > yyvsp[-3].paraVector.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son incorrectos", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if (yyvsp[-3].paraVector.indiceInf == yyvsp[-3].paraVector.indiceSup)
     {
       if (warnings == 1) 
       {
         sprintf(errorBuf, "Los indices del vector %s son iguales", yyvsp[0].paraID.nombre);
         warning(errorBuf);
       }
     }
     else if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       introducir_variable_vector (tabsim, yyvsp[0].paraID.nombre, nivel, 0, yyvsp[-3].paraVector.tipo_componentes,
                                   yyvsp[-3].paraVector.indiceInf, yyvsp[-3].paraVector.indiceSup,
                                   yyvsp[-3].paraVector.dimension);
       crear_var_vector (yyvsp[0].paraID.nombre, yyvsp[-3].paraVector.tipo_componentes, yyvsp[-3].paraVector.dimension);
     }
     else
     {
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch (yyvsp[0].paraID.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que el programa principal", yyvsp[0].paraID.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que una accion", yyvsp[0].paraID.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Identificador %s tiene el mismo nombre que otra variable", yyvsp[0].paraID.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Identificado %s tiene el mismo nombre que un parametro", yyvsp[0].paraID.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }
   ;
    break;}
case 22:
#line 490 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 23:
#line 492 "pascual.y"
{ 
      concatenar (&(yyvsp[-1].cod), yyvsp[0].cod); 
      yyval.cod = yyvsp[-1].cod;
    ;
    break;}
case 24:
#line 503 "pascual.y"
{
     
     SIMBOLO *p;
     int i;      
     yyval.cod = newcode(); 
     /* Recuperamos los argumentos en orden inverso a su declaracion */     
     if (yyvsp[-4].paraCabAccion.simbolo != NULL)
     {     
       char msg[100], *laccion = newlabel();
       
       sprintf (msg, "Comienzo de accion %s", yyvsp[-4].paraCabAccion.cad);
       comment (&(yyval.cod), msg);   
       label (&(yyval.cod), yyvsp[-4].paraCabAccion.cad);           
       
       for (i = longitud_lista(yyvsp[-4].paraCabAccion.simbolo->parametros); i > 0 ; i--)
       {
         p = observar(yyvsp[-4].paraCabAccion.simbolo->parametros, i);
	 emit (&(yyval.cod), SRF, nivel - p->nivel, p->dir);
	 emit (&(yyval.cod), ASGI);
       }
       emit (&(yyval.cod), JMP, laccion);
       concatenar (&(yyval.cod), yyvsp[-1].cod);
       label (&(yyval.cod), laccion);
       /* Concatenamos el codigo de la accion */
       concatenar (&(yyval.cod), yyvsp[0].cod);
       /* Destruir BA */
       sprintf (msg, "Fin de accion %s", yyvsp[-4].paraCabAccion.cad);
       comment (&(yyval.cod), msg); 
       emit (&(yyval.cod), CSF);
       cerrar_bloque();
     }
   ;
    break;}
case 25:
#line 539 "pascual.y"
{
     
     yyval.simbolo = NULL;
     if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       yyval.simbolo = introducir_accion (tabsim, yyvsp[0].paraID.nombre, nivel, yyvsp[0].paraID.nombre);
     }
     else 
     {    
       /* Especificar si hay accion del mismo nombre, variable, parametro, programa, que es
          lo que da lugar a conflicto */    
       switch (yyvsp[0].paraID.simbolo->tipo)
       {
         case PROGRAMA: {
	                  sprintf(errorBuf, "Accion %s en conflicto con programa principal", yyvsp[0].paraID.nombre);
			  break;
			}
         case ACCION:   {
	                  sprintf(errorBuf, "Accion %s en conflicto con otra accion", yyvsp[0].paraID.nombre);
			  break;
			}
         case VARIABLE: {
	                  sprintf(errorBuf, "Accion %s en conflicto con variable", yyvsp[0].paraID.nombre);
			  break;
			}
         case PARAMETRO: {
	                   sprintf(errorBuf, "Accion %s en conflicto con parametro", yyvsp[0].paraID.nombre);
			   break;
			 }
       }
       error_semantico(errorBuf);
     }

     /* Despues de procesar el identificador y antes de los parametros formales,
        abrimos nuevo bloque */
     abrir_bloque();
   ;
    break;}
case 26:
#line 577 "pascual.y"
{
     if (yyvsp[-1].simbolo != NULL)
     {
       /* Almacenamos los parametros de la accion en la TS */
       yyvsp[-1].simbolo->parametros = yyvsp[0].lista; 
     }
     yyval.paraCabAccion.cad = yyvsp[-2].paraID.nombre;
     yyval.paraCabAccion.simbolo = yyvsp[-1].simbolo;
   ;
    break;}
case 27:
#line 589 "pascual.y"
{ 
       crear_vacia(&(yyval.lista)); /* No hay parametros formales en la accion */
     ;
    break;}
case 28:
#line 593 "pascual.y"
{ 
       yyval.lista = yyvsp[-1].lista; 
     ;
    break;}
case 29:
#line 600 "pascual.y"
{
     concatenar(&(yyvsp[-2].lista), yyvsp[0].lista);
     yyval.lista = yyvsp[-2].lista;
   ;
    break;}
case 30:
#line 604 "pascual.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 31:
#line 609 "pascual.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 32:
#line 614 "pascual.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 33:
#line 619 "pascual.y"
{
       if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
       {
         crear_unitaria(&(yyval.lista), (introducir_parametro (tabsim, yyvsp[0].paraID.nombre, yyvsp[-1].tipo, yyvsp[-2].clase, nivel, 0)));
	 crear_var(yyvsp[0].paraID.nombre, yyvsp[-1].tipo);
       }
       else 
       { 
         sprintf(errorBuf, "Parametro %s duplicado", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
     ;
    break;}
case 34:
#line 632 "pascual.y"
{
       if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
       {	 
         anadir_derecha(introducir_parametro (tabsim, yyvsp[0].paraID.nombre, yyvsp[-3].tipo, yyvsp[-4].clase, nivel, 0), &(yyvsp[-2].lista));
	 crear_var(yyvsp[0].paraID.nombre, yyvsp[-3].tipo);
         yyval.lista = yyvsp[-2].lista;
       }
       else 
       { 
         sprintf(errorBuf, "Parametro %s duplicado", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
     ;
    break;}
case 35:
#line 647 "pascual.y"
{ yyval.clase = VAL; ;
    break;}
case 36:
#line 648 "pascual.y"
{ yyval.clase = REF; ;
    break;}
case 37:
#line 653 "pascual.y"
{ yyval.cod = yyvsp[-1].cod; ;
    break;}
case 38:
#line 655 "pascual.y"
{ crear_vacia (&(yyval.cod)); ;
    break;}
case 39:
#line 660 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 40:
#line 662 "pascual.y"
{ 
        concatenar (&(yyvsp[-1].cod), yyvsp[0].cod); 
        yyval.cod = yyvsp[-1].cod;
      ;
    break;}
case 41:
#line 670 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 42:
#line 672 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 43:
#line 674 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 44:
#line 676 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 45:
#line 678 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 46:
#line 680 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 47:
#line 682 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 48:
#line 684 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 49:
#line 688 "pascual.y"
{ yyval.cod = code(NOP); ;
    break;}
case 50:
#line 693 "pascual.y"
{ yyval.cod = yyvsp[-2].paraListas.cod; ;
    break;}
case 51:
#line 698 "pascual.y"
{
     yyval.paraListas.constante = 1;
     /* Comprobamos que esta declarado y es entero o caracter */
     yyval.paraListas.cod = newcode();
     if (yyvsp[0].paraID.simbolo == NULL)
     {
       sprintf(errorBuf, "Identificador %s no declarado", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else
     {
       if ((yyvsp[0].paraID.simbolo->tipo != VARIABLE) && (yyvsp[0].paraID.simbolo->tipo != PARAMETRO))
       {
         /* Permitimos que sean tambien parametros por valor para ser consecuentes
	    con permitir asignarlos. Sin embargo, no sera visible desde fuera el cambio sobre
	    la variable o parametro por valor ya que este es una copia del valor de la variable. */
         sprintf(errorBuf, "Identificador %s debe ser variable o parametro", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
       else if ((yyvsp[0].paraID.simbolo->variable != ENTERO) && (yyvsp[0].paraID.simbolo->variable != CHAR) && (yyvsp[0].paraID.simbolo->variable != DESCONOCIDO))
       {
         sprintf(errorBuf, "Identificador %s debe ser de tipo entero o caracter", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
       else
       {
         yyvsp[0].paraID.simbolo->referenciada = TRUE;
	 /* Generar codigo */
	 emit (&(yyval.paraListas.cod), SRF, nivel - yyvsp[0].paraID.simbolo->nivel, yyvsp[0].paraID.simbolo->dir);
	 /* Duda de si hacer esto */
	 if ((yyvsp[0].paraID.simbolo->tipo == PARAMETRO) && (yyvsp[0].paraID.simbolo->parametro == REF))
	 {
	   emit (&(yyval.paraListas.cod), DRF);
	 }
	 
	 if (yyvsp[0].paraID.simbolo->variable == CHAR)
	 {
	   emit (&(yyval.paraListas.cod), RD, 0);
	 }  
	 else if (yyvsp[0].paraID.simbolo->variable == ENTERO)
	 {
	   emit (&(yyval.paraListas.cod), RD, 1);  
	 }  
       }
     }
   ;
    break;}
case 52:
#line 745 "pascual.y"
{
     /* Comprobamos que esta declarado y es entero o caracter  */
     yyval.paraListas.constante = yyvsp[-2].paraListas.constante + 1;
     yyval.paraListas.cod = newcode();
     if (yyvsp[0].paraID.simbolo == NULL)     
     {
       sprintf(errorBuf, "Identificador %s no declarado", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else
     {
       if ((yyvsp[0].paraID.simbolo->tipo != VARIABLE) && (yyvsp[0].paraID.simbolo->tipo != PARAMETRO))
       {
         sprintf(errorBuf, "Identificador %s debe ser variable o parametro", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
       else if ((yyvsp[0].paraID.simbolo->variable != ENTERO) && (yyvsp[0].paraID.simbolo->variable != CHAR) && (yyvsp[0].paraID.simbolo->variable != DESCONOCIDO))
       {
         sprintf(errorBuf, "Identificador %s debe ser de tipo entero o caracter", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
       else
       {
         yyvsp[0].paraID.simbolo->referenciada = TRUE;
	 /* Generar codigo */
	 concatenar(&(yyval.paraListas.cod), yyvsp[-2].paraListas.cod);
	 
	 emit (&(yyval.paraListas.cod), SRF, nivel - yyvsp[0].paraID.simbolo->nivel, yyvsp[0].paraID.simbolo->dir);
	 /* Duda de si hacer esto */
	 if ((yyvsp[0].paraID.simbolo->tipo == PARAMETRO) && (yyvsp[0].paraID.simbolo->parametro == REF))
	 {
	   emit (&(yyval.paraListas.cod), DRF);
	 }
	 
	 if (yyvsp[0].paraID.simbolo->variable == CHAR)
	 {
	   emit (&(yyval.paraListas.cod), RD, 0);
	 }  
	 else if (yyvsp[0].paraID.simbolo->variable == ENTERO)
	 {
	   emit (&(yyval.paraListas.cod), RD, 1); 
	 }  
       }
     }
   ;
    break;}
case 53:
#line 795 "pascual.y"
{ yyval.cod = yyvsp[-2].paraListas.cod; ;
    break;}
case 54:
#line 800 "pascual.y"
{
    int i,c;
    yyval.paraListas.constante = yyvsp[-2].paraListas.constante + 1;
    yyval.paraListas.cod = newcode();
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if ((yyvsp[0].paraExp.tipo == BOOLEANO) || (yyvsp[0].paraExp.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento %d de escribir es de tipo incorrecto, debe ser cadena, entero o caracter", yyval.paraListas.constante);
      error_semantico(errorBuf);
    }
    else
    {
      /* Generamos codigo */
      if (yyvsp[0].paraExp.tipo == ENTERO)
      {
        concatenar (&(yyvsp[-2].paraListas.cod), yyvsp[0].paraExp.cod);
	concatenar (&(yyval.paraListas.cod), yyvsp[-2].paraListas.cod);
	emit (&(yyval.paraListas.cod), WRT, 1);
      }	
      else if (yyvsp[0].paraExp.tipo == CHAR)
      { 
        concatenar(&(yyvsp[-2].paraListas.cod), yyvsp[0].paraExp.cod);
	concatenar (&(yyval.paraListas.cod), yyvsp[-2].paraListas.cod);
	emit (&(yyval.paraListas.cod), WRT, 0);
      }
      else if (yyvsp[0].paraExp.tipo == CADENA) 
      {
        /* Ponemos tantos WRT como longitud tenga la cadena */
	concatenar (&(yyvsp[-2].paraListas.cod), yyvsp[0].paraExp.cod);
	concatenar (&(yyval.paraListas.cod), yyvsp[-2].paraListas.cod);
	for (i = 0; i < yyvsp[0].paraExp.longitud; i++)
	{ 	  
	  emit (&(yyval.paraListas.cod), STC, *(yyvsp[0].paraExp.cad + i));
	  emit (&(yyval.paraListas.cod), WRT, 0);
	}  	 	
      }
    }
  ;
    break;}
case 55:
#line 841 "pascual.y"
{
    int i;
    yyval.paraListas.constante = 1;
    yyval.paraListas.cod = newcode();
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if ((yyvsp[0].paraExp.tipo == BOOLEANO) || (yyvsp[0].paraExp.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento 1 de escribir es de tipo incorrecto, debe ser cadena, entero o caracter");
      error_semantico(errorBuf);
    }
    else
    {
      /* Generamos codigo */
      if (yyvsp[0].paraExp.tipo == ENTERO)
      {        
	yyval.paraListas.cod = yyvsp[0].paraExp.cod;
	emit (&(yyval.paraListas.cod), WRT, 1);
      }	
      else if (yyvsp[0].paraExp.tipo == CHAR)
      { 
	yyval.paraListas.cod = yyvsp[0].paraExp.cod;
	emit (&(yyval.paraListas.cod), WRT, 0);
      }
      else if (yyvsp[0].paraExp.tipo == CADENA) 
      {
        /* Ponemos tantos WRT como longitud tenga la cadena */
	yyval.paraListas.cod = yyvsp[0].paraExp.cod;
	for (i = 0; i < yyvsp[0].paraExp.longitud; i++)
	{ 	  
	  emit (&(yyval.paraListas.cod), STC, *(yyvsp[0].paraExp.cad + i));
	  emit (&(yyval.paraListas.cod), WRT, 0);
	}  
	
      }
    }
  ;
    break;}
case 56:
#line 883 "pascual.y"
{
     yyval.ok = FALSE; /* Indica si existe o no el identificador */
     if (yyvsp[0].paraID.simbolo == NULL)
     {
       sprintf(errorBuf, "Identificador %s no declarado", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if ((yyvsp[0].paraID.simbolo->tipo != VARIABLE) && (yyvsp[0].paraID.simbolo->tipo != PARAMETRO))
     {
       /* $<ok>$ = TRUE; */
       sprintf(errorBuf, "Identificador %s debe ser variable o parametro", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else 
     { 
       yyval.ok = TRUE;
       yyvsp[0].paraID.simbolo->referenciada = TRUE;
     }
   ;
    break;}
case 57:
#line 903 "pascual.y"
{
     yyval.ok = TRUE; /* Si ha habido error en la asignacion, consideramos que no se ha asignado */
     /* Puede ser asignacion directa de vectores, asignacion de una componente de un vector ($4.tipo contendra el tipo de
        esa componente, no VECTOR) a una variable simple o asignacion entre variables simples */
     if ((yyvsp[-2].ok) && (yyvsp[0].paraExp.tipo != DESCONOCIDO) && (yyvsp[-3].paraID.simbolo->variable != yyvsp[0].paraExp.tipo))
     {
       yyval.ok = FALSE;
       sprintf(errorBuf, "Tipos incompatibles en la asignacion");
       error_semantico(errorBuf);
     }
     else 
     {
       if ((yyvsp[-2].ok) && (yyvsp[-3].paraID.simbolo->variable == VECTOR) && (yyvsp[0].paraExp.simbolo != NULL) && (yyvsp[0].paraExp.simbolo->variable == VECTOR) &&
         (yyvsp[-3].paraID.simbolo->dimension != yyvsp[0].paraExp.simbolo->dimension))
       {
         yyval.ok = FALSE;
         sprintf(errorBuf, "En la asignacion directa de vectores el tamaño de ambos vectores no coincide");
         error_semantico(errorBuf);
       }     
       if ((yyvsp[-2].ok) && (yyvsp[-3].paraID.simbolo->variable == VECTOR) && (yyvsp[0].paraExp.simbolo != NULL) && (yyvsp[0].paraExp.simbolo->variable == VECTOR) &&
           (yyvsp[-3].paraID.simbolo->tipo_componentes != yyvsp[0].paraExp.simbolo->tipo_componentes))
       {
         yyval.ok = FALSE;
         sprintf(errorBuf, "En la asignacion directa de vectores el tipo de las componentes de ambos vectores no coincide");
         error_semantico(errorBuf);
       }
     }     
   ;
    break;}
case 58:
#line 932 "pascual.y"
{
     int i, t, ce; 
     char *lcond, *lbloque;
     yyval.cod = newcode();
   
     if ((yyvsp[-4].ok) && (yyvsp[-1].ok) && ((yyvsp[-5].paraID.simbolo->variable != VECTOR) || ((yyvsp[-2].paraExp.simbolo != NULL) && (yyvsp[-2].paraExp.simbolo->variable != VECTOR))))
     {
       /* Generar codigo para una asignacion entre tipos simples */
       emit (&(yyval.cod), SRF, nivel - yyvsp[-5].paraID.simbolo->nivel, yyvsp[-5].paraID.simbolo->dir);     
       if ((yyvsp[-5].paraID.simbolo->tipo == PARAMETRO) && (yyvsp[-5].paraID.simbolo->parametro == REF))
       {
         emit (&(yyval.cod), DRF);
       }
       concatenar (&(yyval.cod), yyvsp[-2].paraExp.cod);
       emit (&(yyval.cod), ASG);
     }
     else if ((yyvsp[-4].ok) && (yyvsp[-1].ok) && (yyvsp[-5].paraID.simbolo->variable == VECTOR) && (yyvsp[-2].paraExp.simbolo != NULL) && (yyvsp[-2].paraExp.simbolo->variable == VECTOR))
     {
       lcond = newlabel(); 
       lbloque = newlabel();
       /* Almacenamos en la pila el numero de iteracion i (0..dimension-1) */
       emit (&(yyval.cod), STC, 0);
       emit (&(yyval.cod), DUP);
       emit (&(yyval.cod), DUP); 
       emit (&(yyval.cod), DUP);
       /* Almacenamos en la pila la dimension de los vectores a asignarse */
       emit (&(yyval.cod), STC, yyvsp[-5].paraID.simbolo->dimension);
       emit (&(yyval.cod), JMP, lcond);
       label (&(yyval.cod), lbloque);
       /* @ base del vector LHS */
       emit (&(yyval.cod), SRF, nivel - yyvsp[-5].paraID.simbolo->nivel, yyvsp[-5].paraID.simbolo->dir);     
       emit (&(yyval.cod), PLUS);
       emit (&(yyval.cod), SWP);
       emit (&(yyval.cod), SRF, nivel - yyvsp[-2].paraExp.simbolo->nivel, yyvsp[-2].paraExp.simbolo->dir);
       emit (&(yyval.cod), PLUS);
       emit (&(yyval.cod), DRF);
       emit (&(yyval.cod), ASG);
       
       /* Incrementar i al final y volver a apilar la dimension del vector */
       emit (&(yyval.cod), STC, 1);
       emit (&(yyval.cod), PLUS);
       emit (&(yyval.cod), DUP);
       emit (&(yyval.cod), DUP);
       emit (&(yyval.cod), DUP);
       emit (&(yyval.cod), STC, yyvsp[-5].paraID.simbolo->dimension);      
       /* COND: */
       label (&(yyval.cod), lcond);
       emit (&(yyval.cod), LT);
       emit (&(yyval.cod), JMT, lbloque);
       /* Limpiar la pila si no saltamos */
       emit (&(yyval.cod), POP);
       emit (&(yyval.cod), POP);
       emit (&(yyval.cod), POP);
     }  
   ;
    break;}
case 59:
#line 991 "pascual.y"
{
        yyval.ok = FALSE; /* Indica si existe o no el identificador */
        if (yyvsp[0].paraID.simbolo == NULL)
	{
	  sprintf(errorBuf, "Identificador %s no encontrado", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else if (yyvsp[0].paraID.simbolo->tipo != VARIABLE)
	{
	  yyval.ok = FALSE;
	  sprintf(errorBuf, "El identificador %s debe ser variable", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else if ((yyvsp[0].paraID.simbolo->variable != VECTOR) && (yyvsp[0].paraID.simbolo->variable != DESCONOCIDO))
	{
	  yyval.ok = FALSE;
	  sprintf(errorBuf, "El identificador %s debe ser vector", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else 
	{ 
	  yyval.ok = TRUE;
	  yyvsp[0].paraID.simbolo->referenciada = TRUE;
	}
      ;
    break;}
case 60:
#line 1017 "pascual.y"
{
        yyval.ok = TRUE;
        if ((yyvsp[-1].paraExp.tipo != ENTERO) && (yyvsp[-1].paraExp.tipo != DESCONOCIDO))
	{
	  yyval.ok = FALSE;
	  sprintf(errorBuf, "El indice del vector %s debe ser de tipo entero", yyvsp[-4].paraID.nombre);
          error_semantico(errorBuf);
	}	
	if (yyvsp[-1].paraExp.esConstEntera == TRUE)
	{
	  if ((yyvsp[-1].paraExp.valorConstEntera > yyvsp[-4].paraID.simbolo->indiceSup) || (yyvsp[-1].paraExp.valorConstEntera < yyvsp[-4].paraID.simbolo->indiceInf))
	  {
	    if (warnings == 1)
	    {
              sprintf(errorBuf, "El indice %d del vector %s no existe", yyvsp[-1].paraExp.valorConstEntera, yyvsp[-4].paraID.nombre);
              warning(errorBuf);
	    }  
	  }
	}
	else /*- ($4.esConstEntera == FALSE) */
	{
	  if (warnings == 1) 
          {
	    sprintf(errorBuf, "El indice del vector %s puede no existir", yyvsp[-4].paraID.nombre);
            warning(errorBuf);
	  }
	}
        
      ;
    break;}
case 61:
#line 1047 "pascual.y"
{
        /* Puede ser una componente de un vector ($8.tipo contendra el tipo de sus componentes, no VECTOR) 
	   o una variable simple */
	yyval.ok = TRUE;   
        if ((yyvsp[-6].ok) && (yyvsp[0].paraExp.tipo != yyvsp[-7].paraID.simbolo->tipo_componentes))
	{
	  yyval.ok = FALSE;
	  sprintf(errorBuf, "Tipos incompatibles en la asignacion");
          error_semantico(errorBuf);
	}
      ;
    break;}
case 62:
#line 1059 "pascual.y"
{           
        /* Generar codigo si TODO correcto */  
	yyval.cod = newcode();
	
        if ((yyvsp[-8].ok) && (yyvsp[-4].ok) && (yyvsp[-1].ok))
	{	
	  char *lerror = newlabel();
	  char *lseguir = newlabel();
	  
	  /* argumentos f y o de SRF dependen de la declaracion del vector (T.S.) */
	  yyval.cod = code (SRF, nivel - yyvsp[-9].paraID.simbolo->nivel, yyvsp[-9].paraID.simbolo->dir);
	  /* Codigo para expresion 1 */
	  concatenar (&(yyval.cod), yyvsp[-6].paraExp.cod);
	  /* Comprobaciones indice fuera de rango */
	  emit (&(yyval.cod), DUP);
	  emit (&(yyval.cod), DUP);
	  emit (&(yyval.cod), STC, yyvsp[-9].paraID.simbolo->indiceInf);
	  emit (&(yyval.cod), GTE);
	  emit (&(yyval.cod), JMF, lerror);
	  emit (&(yyval.cod), STC, yyvsp[-9].paraID.simbolo->indiceSup);
	  emit (&(yyval.cod), LTE);
	  emit (&(yyval.cod), JMF, lerror);
	  /* Limite inferior */
	  emit (&(yyval.cod), STC, yyvsp[-9].paraID.simbolo->indiceInf);
	  emit (&(yyval.cod), SBT);
	  /* Tamaño del vector -> En este caso no hace falta */
	  emit (&(yyval.cod), PLUS);
	  /* Codigo para expresion 2 */
	  concatenar (&(yyval.cod), yyvsp[-2].paraExp.cod);
	  /* Asignacion */
	  emit (&(yyval.cod), ASG);
	  /* Etiqueta de la rutina de error */
	  emit (&(yyval.cod), JMP, lseguir);
	  label (&(yyval.cod), lerror);
	  rutina_error(&(yyval.cod));
	  /* Saltamos a la ultima instruccion */
	  emit (&(yyval.cod), JMP, llvp);
	  label (&(yyval.cod), lseguir);
	}
      ;
    break;}
case 63:
#line 1104 "pascual.y"
{
    yyval.ok = TRUE;
    if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
    {
      yyval.ok = FALSE;
      error_semantico("Mq: condicion invalida.");
    }
  ;
    break;}
case 64:
#line 1114 "pascual.y"
{ 
    /* Generacion de codigo */
    yyval.cod = newcode();
   
    if (yyvsp[-2].ok == TRUE)
    {
      char *lcond = newlabel(),
           *lbloque = newlabel();
	 
      yyval.cod = code (JMP, lcond);	 
      label (&(yyval.cod), lbloque);
      concatenar (&(yyval.cod), yyvsp[-1].cod);
      label (&(yyval.cod), lcond);
      concatenar (&(yyval.cod), yyvsp[-3].paraExp.cod);
      emit (&(yyval.cod), JMT, lbloque);
    } 
  ;
    break;}
case 65:
#line 1136 "pascual.y"
{
    yyval.ok = TRUE;
    if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
    {
      yyval.ok = FALSE;
      error_semantico("Seleccion: condicion invalida.");
    }
  ;
    break;}
case 66:
#line 1148 "pascual.y"
{
    /* Generacion de codigo */
     
    yyval.cod = newcode();
    
    if (yyvsp[-4].ok == TRUE)
    {	         
      char *lsino = newlabel(), 
           *lfin  = newlabel();
	   
      yyval.cod = yyvsp[-5].paraExp.cod;
      emit (&(yyval.cod), JMF, lsino);
      concatenar (&(yyval.cod), yyvsp[-2].cod);	
      if (longitud_lista(yyvsp[-1].cod)) 
      {
        emit (&(yyval.cod), JMP, lfin);
        label (&(yyval.cod), lsino);
        concatenar (&(yyval.cod), yyvsp[-1].cod);
        label (&(yyval.cod), lfin);
      } 
      else label (&(yyval.cod), lsino);
    }  
  ;
    break;}
case 67:
#line 1174 "pascual.y"
{ yyval.cod = newcode(); ;
    break;}
case 68:
#line 1176 "pascual.y"
{ yyval.cod = yyvsp[0].cod; ;
    break;}
case 69:
#line 1181 "pascual.y"
{
     yyval.ok = FALSE;
     if (yyvsp[0].paraID.simbolo == NULL)
     {  
       sprintf(errorBuf, "Accion %s no encontrada", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
       if (strcmp(yyvsp[0].paraID.nombre, "LEE") == 0) 
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir LEER");
	 }  
       }
       else if (strcmp(yyvsp[0].paraID.nombre, "ESCRIBE") == 0)
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir ESCRIBIR");
	 } 
       }
     }
     else if (yyvsp[0].paraID.simbolo->tipo != ACCION)
     {
       sprintf(errorBuf, "%s no es una accion", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else yyval.ok = TRUE;
   ;
    break;}
case 70:
#line 1210 "pascual.y"
{ 
     if ((yyvsp[-1].ok == TRUE) && (yyvsp[-2].paraID.simbolo->parametros.elementos != yyvsp[0].paraListas.constante))
     {
       /* Especificar si sobran o faltan argumentos y cuantos */
       if (yyvsp[-2].paraID.simbolo->parametros.elementos < yyvsp[0].paraListas.constante) 
         sprintf(errorBuf, "Numero de argumentos en invocacion de la accion %s incorrecto: sobran %d argumentos" 
	                   ,yyvsp[-2].paraID.nombre, yyvsp[0].paraListas.constante - yyvsp[-2].paraID.simbolo->parametros.elementos);
       else 
         sprintf(errorBuf, "Numero de argumentos en la invocacion de la accion %s incorrecto: faltan %d argumentos" 
	                   ,yyvsp[-2].paraID.nombre, yyvsp[-2].paraID.simbolo->parametros.elementos - yyvsp[0].paraListas.constante);
       error_semantico(errorBuf);
     }
     else yyval.ok = TRUE;
   ;
    break;}
case 71:
#line 1225 "pascual.y"
{    
     char msg[100];
     yyval.cod = newcode();
     /* Generacion de codigo */
     if ((yyvsp[-3].ok == TRUE) && (yyvsp[-1].ok == TRUE))
     {
       /* Apilamos los argumentos */
       /* Cuidado, si el argumento es a parametro por referencia, hay que eliminar el DRF que
          pone expresion para pasarle la direccion. Ya lo hago en el no terminal argumentos */
       yyval.cod = yyvsp[-2].paraListas.cod;
       sprintf (msg, "Invocar %s", yyvsp[-4].paraID.nombre);
       comment (&(yyval.cod), msg);
       emit (&(yyval.cod), OSF, sig[nivel], nivel - yyvsp[-4].paraID.simbolo->nivel, yyvsp[-4].paraID.simbolo->etiq); 
     }
   ;
    break;}
case 72:
#line 1241 "pascual.y"
{
     yyval.ok = FALSE;
     if (yyvsp[0].paraID.simbolo == NULL)
     {
       sprintf(errorBuf, "Accion %s no encontrada", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);  
       if (strcmp(yyvsp[0].paraID.nombre, "LEE") == 0) 
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir LEER");
	 }  
       }
       else if (strcmp(yyvsp[0].paraID.nombre, "ESCRIBE") == 0)
       {
         if (warnings == 1) 
         {
           warning("Posible equivocacion al escribir ESCRIBIR");
	 }  
       }
     }
     else if (yyvsp[0].paraID.simbolo->tipo != ACCION)
     {
       sprintf(errorBuf, "%s no es una accion", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if ((yyvsp[0].paraID.simbolo->tipo == ACCION) && (yyvsp[0].paraID.simbolo->parametros.elementos != 0))
     {
       /* Especificar cuantos argumentos faltan */
       sprintf(errorBuf, "Numero de argumentos en invocacion de la accion %s incorrecto: faltan %d argumentos" 
                         ,yyvsp[0].paraID.nombre, yyvsp[0].paraID.simbolo->parametros.elementos);
       error_semantico(errorBuf); 
     }
     else yyval.ok = TRUE; 
   ;
    break;}
case 73:
#line 1277 "pascual.y"
{
     char msg[100];
     yyval.cod = newcode();
     /* Generacion de codigo */
     if (yyvsp[-1].ok == TRUE)
     {
       /* No hay argumentos que apilar */
       sprintf (msg, "Invocar %s", yyvsp[-2].paraID);
       comment (&(yyval.cod), msg);
       emit (&(yyval.cod), OSF, sig[nivel], nivel - yyvsp[-2].paraID.simbolo->nivel, yyvsp[-2].paraID.simbolo->etiq); 
     }
   ;
    break;}
case 74:
#line 1293 "pascual.y"
{ yyval.paraListas = yyvsp[-1].paraListas; ;
    break;}
case 75:
#line 1298 "pascual.y"
{
     LISTA pars;
     SIMBOLO *p;
     int i, ok;
     
     yyval.paraListas.cod = newcode();

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if ((yyvsp[-5].paraID.simbolo != NULL) && (yyvsp[-5].paraID.simbolo->tipo == ACCION))
     {
       pars = (*(yyvsp[-5].paraID.simbolo)).parametros;
       
       if (longitud_lista(pars) >= (yyvsp[-2].paraListas.constante + 1)) 
       {
         p = observar (pars, yyvsp[-2].paraListas.constante + 1);
	 ok = TRUE;
         /* Verificaciones de los argumentos de la invocacion */
	 if (yyvsp[0].paraExp.tipo == VECTOR)
	 {
	   ok = FALSE;
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != yyvsp[0].paraExp.tipo) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
         { 
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   ok = FALSE;
	   sprintf(errorBuf, "Los tipos del parametro y el argumento numero %d no coinciden", yyvsp[-2].paraListas.constante + 1);
           error_semantico(errorBuf);
         }
         if (((*p).parametro == REF) && (yyvsp[0].paraExp.esVariable != TRUE) && (yyvsp[0].paraExp.esParametroRef != TRUE))
         {
           /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   ok = FALSE;
	   sprintf(errorBuf, "El argumento numero %d debe ser una variable o parametro por referencia", yyvsp[-2].paraListas.constante + 1);		      
           error_semantico(errorBuf);
         }	 
       }
       yyval.paraListas.constante = yyvsp[-2].paraListas.constante + 1; /* Para contar el numero de argumentos en la invocacion a la accion */
       /* Generacion de codigo */
       if (ok == TRUE)
       {
	 if ((*p).parametro == REF)
	 { 
	   /* Para los parametros ref eliminado la ultima instruccion de codigo generada por expresion (DRF)
	      para quedarnos con la direccion del parametro ref, no con su valor. */	   
	   eliminar_derecha(&(yyvsp[0].paraExp.cod)); 
	   concatenar (&(yyvsp[-2].paraListas.cod), yyvsp[0].paraExp.cod);
	   yyval.paraListas.cod = yyvsp[-2].paraListas.cod;  	     
	 }
	 else
	 { 
	   concatenar (&(yyvsp[-2].paraListas.cod), yyvsp[0].paraExp.cod);
           yyval.paraListas.cod = yyvsp[-2].paraListas.cod; 
	 }  
       }
     }
   ;
    break;}
case 76:
#line 1357 "pascual.y"
{
     LISTA pars;
     SIMBOLO *p;
     int i, ok;
     
     yyval.paraListas.cod = newcode();

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if (yyvsp[-2].ok)
     {
       pars = (*(yyvsp[-3].paraID.simbolo)).parametros;

       if (longitud_lista (pars) >= 1)
       {
         p = observar (pars, 1);
         /* Verificaciones */
	 ok = TRUE;
	 
	 if (yyvsp[0].paraExp.tipo == VECTOR)
	 {
	   ok = FALSE;
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != yyvsp[0].paraExp.tipo) &&  (yyvsp[0].paraExp.tipo != DESCONOCIDO))
         {
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   ok = FALSE;
	   sprintf(errorBuf, "Los tipos del parametro y el argumento 1 no coinciden");
           error_semantico(errorBuf);
         } 
         if (((*p).parametro == REF) && (yyvsp[0].paraExp.esVariable != TRUE) && (yyvsp[0].paraExp.esParametroRef !=TRUE))
         {  /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   ok = FALSE;	
	   sprintf(errorBuf, "El argumento numero 1 debe ser una variable o un parametro por referencia");		      
           error_semantico(errorBuf);
         }
       }
	 
       yyval.paraListas.constante = 1; /* Numero de argumentos: Solo hay uno */
       /* Generacion de codigo */
       if (ok == TRUE)
       {
         if ((*p).parametro == REF)
	 { 
	   /* Para los parametros ref elimino la ultima instruccion de codigo generado por expresion (DRF) 
	      para quedarnos con la dir del parametro por referencia, no con su valor */
	   yyval.paraListas.cod = yyvsp[0].paraExp.cod; 
	   eliminar_derecha(&(yyval.paraListas.cod));  
	 }
	 else
	 {
           yyval.paraListas.cod = yyvsp[0].paraExp.cod;
	 }  
       }
     }
   ;
    break;}
case 77:
#line 1418 "pascual.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 78:
#line 1422 "pascual.y"
{
     yyval.paraExp.tipo = BOOLEANO;
     yyval.paraExp.esVariable = FALSE;
     yyval.paraExp.esParametroRef = FALSE;
     yyval.paraExp.esConstEntera = FALSE;
     yyval.paraExp.esConstChar = FALSE;
     yyval.paraExp.simbolo = NULL;
     yyval.paraExp.cod = newcode();
     
     if ((yyvsp[-2].paraExp.tipo == CADENA) || (yyvsp[0].paraExp.tipo == CADENA))
     {
       error_semantico("Los operandos no pueden ser de tipo cadena");
     }
     else if ((yyvsp[-2].paraExp.tipo == VECTOR) || (yyvsp[0].paraExp.tipo == VECTOR))
     {
       error_semantico("Los operandos no pueden ser vectores");
     }
     else if ((yyvsp[-2].paraExp.tipo != DESCONOCIDO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO) && (yyvsp[-2].paraExp.tipo != yyvsp[0].paraExp.tipo))
     { 
       error_semantico("Los operandos deben ser de igual tipo");
     }
     else if ((yyvsp[-1].constante != '=') && (yyvsp[-1].constante != tNI) && (yyvsp[-2].paraExp.tipo == BOOLEANO))
     {
       error_semantico("El operador no se puede aplicar a booleanos");
     }
     else
     {
       /* Generacion de codigo */
       
       /* Expresion 1 */
       yyval.paraExp.cod = yyvsp[-2].paraExp.cod;
              
       /* Expresion 2 */
       concatenar(&(yyval.paraExp.cod), yyvsp[0].paraExp.cod);
       
       switch (yyvsp[-1].constante)
       {
         case '=': emit (&(yyval.paraExp.cod), EQ); break;
	 case '<': emit (&(yyval.paraExp.cod), LT); break;
	 case '>': emit (&(yyval.paraExp.cod), GT); break;
	 case tMEI: emit (&(yyval.paraExp.cod), LTE); break;
	 case tMAI: emit (&(yyval.paraExp.cod), GTE); break;
	 case tNI: emit (&(yyval.paraExp.cod), NEQ); break;
       }	 

     }

   ;
    break;}
case 79:
#line 1474 "pascual.y"
{ yyval.constante = '='; ;
    break;}
case 80:
#line 1476 "pascual.y"
{ yyval.constante = '<'; ;
    break;}
case 81:
#line 1478 "pascual.y"
{ yyval.constante = '>'; ;
    break;}
case 82:
#line 1480 "pascual.y"
{ yyval.constante = tMEI; ;
    break;}
case 83:
#line 1482 "pascual.y"
{ yyval.constante = tMAI; ;
    break;}
case 84:
#line 1484 "pascual.y"
{ yyval.constante = tNI; ;
    break;}
case 85:
#line 1489 "pascual.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 86:
#line 1493 "pascual.y"
{
     yyval.paraExp.cod = newcode();
     if (yyvsp[-1].constante == OR)
     {
       yyval.paraExp.tipo = BOOLEANO;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.simbolo = NULL;
             
       if ((yyvsp[-2].paraExp.tipo != BOOLEANO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser booleano");
       }
       if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser booleano");
       }
     }
     else if (yyvsp[-1].constante == PLUS)
     {
       yyval.paraExp.tipo = ENTERO; 
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.simbolo = NULL;
       yyval.paraExp.esConstEntera = FALSE; /* De momento */
       
       if ((yyvsp[-2].paraExp.tipo != ENTERO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if ((yyvsp[0].paraExp.tipo != ENTERO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero");
       }
       if ((yyvsp[-2].paraExp.esConstEntera == TRUE) && (yyvsp[0].paraExp.esConstEntera == TRUE))
       {
         yyval.paraExp.esConstEntera = TRUE;
         yyval.paraExp.valorConstEntera = yyvsp[-2].paraExp.valorConstEntera + yyvsp[0].paraExp.valorConstEntera;
       }
     }
     else if (yyvsp[-1].constante == SBT)
     {
       yyval.paraExp.tipo = ENTERO;     
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.simbolo = NULL;
       yyval.paraExp.esConstEntera = FALSE; /* De momento */
       
       if ((yyvsp[-2].paraExp.tipo != ENTERO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if ((yyvsp[0].paraExp.tipo != ENTERO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero");
       }
       if ((yyvsp[-2].paraExp.esConstEntera == TRUE) && (yyvsp[0].paraExp.esConstEntera == TRUE))
       {
         yyval.paraExp.esConstEntera = TRUE;
         yyval.paraExp.valorConstEntera = yyvsp[-2].paraExp.valorConstEntera - yyvsp[0].paraExp.valorConstEntera;
       }
     }
       /* Generacion de codigo */
       if (yyval.paraExp.esConstEntera == TRUE) /* Optimizacion */
       {
	 emit (&(yyval.paraExp.cod), STC, yyval.paraExp.valorConstEntera);
       }	 
       else
       {
         /* Expresion 1 */
         yyval.paraExp.cod = yyvsp[-2].paraExp.cod;
         /* Expresion 2 */
         concatenar(&(yyval.paraExp.cod), yyvsp[0].paraExp.cod);
       
         switch (yyvsp[-1].constante)
         {
           case PLUS: emit (&(yyval.paraExp.cod), PLUS); break;
	   case SBT: emit (&(yyval.paraExp.cod), SBT); break;
	   case OR: emit (&(yyval.paraExp.cod), OR); break;
         }
       }	 	        
   ;
    break;}
case 87:
#line 1582 "pascual.y"
{ yyval.constante = PLUS; ;
    break;}
case 88:
#line 1583 "pascual.y"
{ yyval.constante = SBT; ;
    break;}
case 89:
#line 1584 "pascual.y"
{ yyval.constante = OR; ;
    break;}
case 90:
#line 1589 "pascual.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 91:
#line 1593 "pascual.y"
{
     yyval.paraExp.cod = newcode();
     if (yyvsp[-1].constante == TMS)
     {
       yyval.paraExp.tipo = ENTERO;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.simbolo = NULL;
       yyval.paraExp.esConstEntera = FALSE; /* De momento */
       
       if ((yyvsp[-2].paraExp.tipo != ENTERO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if ((yyvsp[0].paraExp.tipo != ENTERO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero.");
       }  
       if ((yyvsp[-2].paraExp.esConstEntera == TRUE) && (yyvsp[0].paraExp.esConstEntera == TRUE))
       {
         yyval.paraExp.esConstEntera = TRUE;
         yyval.paraExp.valorConstEntera = yyvsp[-2].paraExp.valorConstEntera * yyvsp[0].paraExp.valorConstEntera;
       }
     }
     else if (yyvsp[-1].constante == DIV)
     {
       yyval.paraExp.tipo = ENTERO;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.simbolo = NULL;
       yyval.paraExp.esConstEntera = FALSE; /* De momento */
       
       if ((yyvsp[-2].paraExp.tipo != ENTERO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if ((yyvsp[0].paraExp.tipo != ENTERO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero.");
       }
       if ((yyvsp[-2].paraExp.esConstEntera == TRUE) && (yyvsp[0].paraExp.esConstEntera == TRUE))
       {
         yyval.paraExp.esConstEntera = TRUE;
	 if (yyvsp[0].paraExp.valorConstEntera == 0) 
	 {
	   yyval.paraExp.esConstEntera = FALSE;
	   if (warnings == 1) 
           {
	     warning("Division por cero");
	   }  
	 }  
	 else yyval.paraExp.valorConstEntera = yyvsp[-2].paraExp.valorConstEntera / yyvsp[0].paraExp.valorConstEntera;
       }
       else if (yyvsp[0].paraExp.esConstEntera == TRUE)
       {
         if (yyvsp[0].paraExp.valorConstEntera == 0) 
	 {
	   yyval.paraExp.esConstEntera = FALSE;
	   if (warnings == 1) 
           {
	     warning("Division por cero");
	   }  
	 }  
       }
       else if (yyvsp[0].paraExp.esConstEntera == FALSE)
       {
         if (warnings == 1) 
         {
           warning("Verifique que no divide por 0");     
	 }  
       }
     }
     else if (yyvsp[-1].constante == MOD)
     {
       yyval.paraExp.tipo = ENTERO;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.simbolo = NULL;
       yyval.paraExp.esConstEntera = FALSE; /* De momento */
     
       if ((yyvsp[-2].paraExp.tipo != ENTERO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if ((yyvsp[0].paraExp.tipo != ENTERO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero.");
       }     
       if ((yyvsp[-2].paraExp.esConstEntera == TRUE) && (yyvsp[0].paraExp.esConstEntera == TRUE))
       {
         yyval.paraExp.esConstEntera = TRUE;
         yyval.paraExp.valorConstEntera = yyvsp[-2].paraExp.valorConstEntera % yyvsp[0].paraExp.valorConstEntera;
       }
     }
     else if (yyvsp[-1].constante == AND) 
     {
       yyval.paraExp.tipo = BOOLEANO;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.simbolo = NULL;
       
       if ((yyvsp[-2].paraExp.tipo != BOOLEANO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser booleano");
       }
       if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser booleano");
       }
     }  
       /* Generar codigo */
       
	  
       if (yyval.paraExp.esConstEntera == TRUE) /* Optimizacion */
       {
	 emit (&(yyval.paraExp.cod), STC, yyval.paraExp.valorConstEntera);
       }	 
       else
       {

	 /* Expresion 1 */
	 yyval.paraExp.cod = yyvsp[-2].paraExp.cod;

         /* Expresion 2 */
         concatenar(&(yyval.paraExp.cod), yyvsp[0].paraExp.cod);

         switch (yyvsp[-1].constante)
         {
           case TMS:  emit (&(yyval.paraExp.cod), TMS); break;
	   case DIV:  emit (&(yyval.paraExp.cod), DIV); break;
	   case MOD:  emit (&(yyval.paraExp.cod), MOD); break;
	   case AND:  emit (&(yyval.paraExp.cod), AND); break;
         }	
       }   
   ;
    break;}
case 92:
#line 1736 "pascual.y"
{ yyval.constante = TMS; ;
    break;}
case 93:
#line 1737 "pascual.y"
{ yyval.constante = DIV; ;
    break;}
case 94:
#line 1738 "pascual.y"
{ yyval.constante = MOD; ;
    break;}
case 95:
#line 1739 "pascual.y"
{ yyval.constante = AND; ;
    break;}
case 96:
#line 1744 "pascual.y"
{
      yyval.paraExp = yyvsp[0].paraExp;
      yyval.paraExp.cod = newcode();
      if (yyvsp[0].paraExp.esConstEntera == TRUE)
        yyval.paraExp.valorConstEntera = - (yyvsp[0].paraExp.valorConstEntera);
	
      yyval.paraExp.tipo = ENTERO;
      
      if (yyvsp[0].paraExp.tipo != ENTERO)
      {
        error_semantico("Argumento de - unario debe ser entero");
      }
      else
      {
        /* Generar codigo */
	concatenar (&(yyval.paraExp.cod), yyvsp[0].paraExp.cod);
	emit(&(yyval.paraExp.cod), NGI);
      }
    ;
    break;}
case 97:
#line 1764 "pascual.y"
{
      yyval.paraExp = yyvsp[0].paraExp;
      yyval.paraExp.tipo = BOOLEANO;
      yyval.paraExp.cod = newcode();
      if (yyvsp[0].paraExp.tipo != BOOLEANO)
      {
        error_semantico("Argumento de not debe ser booleano");
      }
      else
      {
        /* Generar codigo */
	concatenar (&(yyval.paraExp.cod), yyvsp[0].paraExp.cod);
	emit(&(yyval.paraExp.cod), NGB);
      }
    ;
    break;}
case 98:
#line 1780 "pascual.y"
{ 
      yyval.paraExp = yyvsp[-1].paraExp; 
    ;
    break;}
case 99:
#line 1784 "pascual.y"
{
      yyval.paraExp.tipo = CHAR;
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.esConstChar = FALSE; /* De momento */
      yyval.paraExp.simbolo = NULL;
      yyval.paraExp.esConstEntera = FALSE; 
      yyval.paraExp.cod = newcode();
      
      if (yyvsp[-1].paraExp.tipo != ENTERO)
      {
        error_semantico("Argumento de entacar debe ser entero");
      }
      else
      {
        /* Generar codigo */
        if (yyvsp[-1].paraExp.esConstEntera == TRUE)
	{
	  yyval.paraExp.esConstChar = TRUE;
	  yyval.paraExp.valorConstChar = (char) yyvsp[-1].paraExp.valorConstEntera;
	  
	  if ((yyvsp[-1].paraExp.valorConstEntera < 0) || (yyvsp[-1].paraExp.valorConstEntera >= 256))
	  {
	    if (warnings == 1) warning("Se truncara el argumento de entacar al ser este negativo");
	    yyval.paraExp.valorConstChar = abs (yyvsp[-1].paraExp.valorConstEntera % 256) ;
	    emit (&(yyval.paraExp.cod), STC, yyval.paraExp.valorConstChar);
          }		
	  else emit (&(yyval.paraExp.cod), STC, yyval.paraExp.valorConstChar);
	}
	else yyval.paraExp.cod = yyvsp[-1].paraExp.cod;
      }
    ;
    break;}
case 100:
#line 1817 "pascual.y"
{
      yyval.paraExp.tipo = ENTERO;
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.simbolo = NULL;
      yyval.paraExp.esConstEntera = FALSE; /* De momento */
      yyval.paraExp.esConstChar = FALSE; 
      yyval.paraExp.cod = newcode();
      
      if (yyvsp[-1].paraExp.tipo != CHAR)
      {
        error_semantico("Argumento de caraent debe ser caracter");
      }
      else 
      {
        /* Generar codigo */
	
        if (yyvsp[-1].paraExp.esConstChar == TRUE)
        {
	  yyval.paraExp.esConstEntera = TRUE;
	  yyval.paraExp.valorConstEntera = (int) yyvsp[-1].paraExp.valorConstChar;
	  emit (&(yyval.paraExp.cod), STC, yyvsp[-1].paraExp.valorConstEntera);
	}
	else yyval.paraExp.cod = yyvsp[-1].paraExp.cod;
      }
    ;
    break;}
case 101:
#line 1844 "pascual.y"
{
      yyval.paraExp.tipo = DESCONOCIDO; 
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.esConstEntera = FALSE;
      yyval.paraExp.esConstChar = FALSE;
      yyval.paraExp.simbolo = NULL;
      yyval.paraExp.cod = newcode();
      
      if (yyvsp[0].paraID.simbolo == NULL)
      {
        sprintf(errorBuf, "Identificador %s no declarado", yyvsp[0].paraID.nombre);
        error_semantico(errorBuf);
      }      
      else if ((yyvsp[0].paraID.simbolo->tipo != VARIABLE) && (yyvsp[0].paraID.simbolo->tipo != PARAMETRO))
      {
        sprintf(errorBuf, "Identificador %s debe ser variable o parametro", yyvsp[0].paraID.nombre);
        error_semantico(errorBuf);
      }
      else if (yyvsp[0].paraID.simbolo->tipo == VARIABLE)
      {
        yyval.paraExp.simbolo = yyvsp[0].paraID.simbolo;
	yyval.paraExp.esVariable = TRUE;
        yyval.paraExp.tipo = yyvsp[0].paraID.simbolo->variable; 
	yyvsp[0].paraID.simbolo->referenciada = TRUE;
	yyval.paraExp.cod = code (SRF, nivel - yyvsp[0].paraID.simbolo->nivel, yyvsp[0].paraID.simbolo->dir);
	emit (&(yyval.paraExp.cod), DRF);
      }
      else /* Es un parametro */
      {  
        yyval.paraExp.simbolo = yyvsp[0].paraID.simbolo; 
	yyval.paraExp.esVariable = FALSE;
	yyval.paraExp.tipo = yyvsp[0].paraID.simbolo->variable; /* El tipo de la expresion es el del parametro */
	if (yyvsp[0].paraID.simbolo->parametro == REF)
	{ 
	  yyval.paraExp.esParametroRef = TRUE;
	  /* 2 niveles de indireccion, primero, con SRF, guardamos en la pila la @ donde esta el
	     parametro relativa al BP, luego, con el primer DRF, guardamos el contenido de esa direccion,
	     que sera la direccion del parametro, y finalmente otro DRF mas para acceder
	     al valor del parametro con su direccion */
	  yyval.paraExp.cod = code (SRF, nivel - yyvsp[0].paraID.simbolo->nivel, yyvsp[0].paraID.simbolo->dir);
	  emit (&(yyval.paraExp.cod), DRF);
	  emit (&(yyval.paraExp.cod), DRF);
	}  
	else /* Parametro por valor */
	{
	  yyval.paraExp.esParametroRef = FALSE;
	  yyval.paraExp.cod = code (SRF, nivel - yyvsp[0].paraID.simbolo->nivel, yyvsp[0].paraID.simbolo->dir);
	  emit (&(yyval.paraExp.cod), DRF); 
	}  
      }
    ;
    break;}
case 102:
#line 1897 "pascual.y"
{
      yyval.paraExp.tipo = DESCONOCIDO; 
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.esConstEntera = FALSE;
      yyval.paraExp.esConstChar = FALSE;
      yyval.paraExp.simbolo = NULL;
      yyval.paraExp.cod = newcode();
      
      if (yyvsp[-3].paraID.simbolo == NULL)
      {
        sprintf(errorBuf, "Identificador %s no declarado", yyvsp[-3].paraID.nombre);
        error_semantico(errorBuf);
      }
      else if (yyvsp[-3].paraID.simbolo->tipo != VARIABLE)
        /* Parametro no puede ser porque los parametros son simples (los vectores no se
           pasan como parametro) */
      {	   
        sprintf(errorBuf, "Identificador %s debe ser variable", yyvsp[-3].paraID.nombre);
        error_semantico(errorBuf);  
      }
      else if ((yyvsp[-3].paraID.simbolo->variable != DESCONOCIDO) && (yyvsp[-3].paraID.simbolo->variable != VECTOR))
      {
        sprintf(errorBuf, "Identificador %s debe ser vector");
        error_semantico(errorBuf);
      }
      else /* Es variable de tipo vector o desconocido */
      { 
        char *lerror = newlabel();
	char *lseguir = newlabel();
      
        yyval.paraExp.esVariable = TRUE; 
	yyval.paraExp.simbolo = yyvsp[-3].paraID.simbolo; 
	/* Hago que sea el tipo de la expresion el de las componentes del vector */
	yyval.paraExp.tipo = yyvsp[-3].paraID.simbolo->tipo_componentes;
	yyvsp[-3].paraID.simbolo->referenciada = TRUE;
	
	/* Generacion de codigo */
	
	/* @ base del vector en la pila de ejecucion (FRAMES) */	
        emit (&(yyval.paraExp.cod), SRF, nivel - yyvsp[-3].paraID.simbolo->nivel, yyvsp[-3].paraID.simbolo->dir);
	/* ¿Parametro? */
	/* Codigo para expresion */
	concatenar (&(yyval.paraExp.cod), yyvsp[-1].paraExp.cod);
	/* Comprobaciones indice fuera de rango */
	emit (&(yyval.paraExp.cod), DUP);
	emit (&(yyval.paraExp.cod), DUP);
	emit (&(yyval.paraExp.cod), STC, yyvsp[-3].paraID.simbolo->indiceInf);
	emit (&(yyval.paraExp.cod), GTE);
	emit (&(yyval.paraExp.cod), JMF, lerror);
	emit (&(yyval.paraExp.cod), STC, yyvsp[-3].paraID.simbolo->indiceSup);
	emit (&(yyval.paraExp.cod), LTE);
	emit (&(yyval.paraExp.cod), JMF, lerror);
	/* Apilamos el limite inferior del vector */
	emit (&(yyval.paraExp.cod), STC,  yyvsp[-3].paraID.simbolo->indiceInf);
	/* Apilamos expresion - limite inferior */
	emit (&(yyval.paraExp.cod), SBT);
	/* Como el tamaño es 1, no hace falta multiplicar por el mismo */
	/* Sumamos el desplazamiento del vector a su @base */
        emit (&(yyval.paraExp.cod), PLUS);	
	emit (&(yyval.paraExp.cod), DRF);
	/* Etiqueta de la rutina de error */
	emit (&(yyval.paraExp.cod), JMP, lseguir);
	label (&(yyval.paraExp.cod), lerror);
	rutina_error(&(yyval.paraExp.cod));
	/* Saltamos a la ultima instruccion */
	emit (&(yyval.paraExp.cod), JMP, llvp);
	label (&(yyval.paraExp.cod), lseguir);
      }
      /* Codigo para los warnings de indice del vector fuera de rango */
      if ((yyvsp[-3].paraID.simbolo != NULL)  && (yyvsp[-3].paraID.simbolo->variable == VECTOR) && (yyvsp[-1].paraExp.tipo == ENTERO) && (yyvsp[-1].paraExp.esConstEntera == TRUE))
      {
        /* Comprobar, si expresion es constEntera que esta dentro del rango de indices del vector */
	if ( ((yyvsp[-3].paraID.simbolo->indiceSup > 0) && (yyvsp[-3].paraID.simbolo->indiceInf > 0)) && 
	     ((yyvsp[-1].paraExp.valorConstEntera > yyvsp[-3].paraID.simbolo->indiceSup) || (yyvsp[-1].paraExp.valorConstEntera < yyvsp[-3].paraID.simbolo->indiceInf)))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", yyvsp[-1].paraExp.valorConstEntera, yyvsp[-3].paraID.nombre);
           warning(errorBuf);
	  } 
	}	
        else if ( ((yyvsp[-3].paraID.simbolo->indiceInf < 0) && (yyvsp[-3].paraID.simbolo->indiceSup < 0)) &&
	          ((yyvsp[-1].paraExp.valorConstEntera < yyvsp[-3].paraID.simbolo->indiceInf) || (yyvsp[-1].paraExp.valorConstEntera > yyvsp[-3].paraID.simbolo->indiceSup)))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", yyvsp[-1].paraExp.valorConstEntera, yyvsp[-3].paraID.nombre);
           warning(errorBuf);
	  } 
	}
	else if ( ((yyvsp[-3].paraID.simbolo->indiceInf < 0) && (yyvsp[-3].paraID.simbolo->indiceSup > 0)) &&
	          ((yyvsp[-1].paraExp.valorConstEntera > yyvsp[-3].paraID.simbolo->indiceSup) || (yyvsp[-1].paraExp.valorConstEntera < yyvsp[-3].paraID.simbolo->indiceInf)))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", yyvsp[-1].paraExp.valorConstEntera, yyvsp[-3].paraID.nombre);
           warning(errorBuf);
	  } 
	}
      }
      if ((yyvsp[-3].paraID.simbolo != NULL) && (yyvsp[-3].paraID.simbolo->variable == VECTOR) && (yyvsp[-1].paraExp.tipo == ENTERO) && (yyvsp[-1].paraExp.esConstEntera != TRUE))
      {
        if (warnings == 1) 
        {
	  sprintf(errorBuf, "El indice del vector %s puede no existir", yyvsp[-3].paraID.nombre);
          warning(errorBuf);
	} 
      }
      if ((yyvsp[-3].paraID.simbolo != NULL) && (yyvsp[-3].paraID.simbolo->variable == VECTOR) && (yyvsp[-1].paraExp.tipo != ENTERO))
      {
        sprintf(errorBuf, "El indice del vector %s debe ser de tipo entero", yyvsp[-3].paraID.nombre);
        error_semantico(errorBuf);
      }
    ;
    break;}
case 103:
#line 2013 "pascual.y"
{ 
       yyval.paraExp.tipo = ENTERO;   
       yyval.paraExp.esConstEntera = TRUE;
       yyval.paraExp.valorConstEntera = yyvsp[0].constante;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.simbolo = NULL;
       /* Generacion de codigo */
       yyval.paraExp.cod = code (STC, yyvsp[0].constante);
     ;
    break;}
case 104:
#line 2025 "pascual.y"
{ 
       yyval.paraExp.tipo = CHAR;     
       yyval.paraExp.esConstChar = TRUE;
       yyval.paraExp.valorConstChar = (char) yyvsp[0].constante;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.simbolo = NULL;
       /* Generacion de codigo */
       yyval.paraExp.cod = code (STC, yyvsp[0].constante);
     ;
    break;}
case 105:
#line 2037 "pascual.y"
{ 
       int i = 0;
     
       yyval.paraExp.tipo = CADENA;  
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE; 
       yyval.paraExp.simbolo = NULL;
       yyval.paraExp.longitud = strlen(yyvsp[0].cadena);
       /* Generacion de codigo */
       yyval.paraExp.cad = yyvsp[0].cadena;
       /* for (i = strlen ($1) - 1; i >= 0 ; i--)
         emit (&($$.cod), STC, $1[i]); */
       
     ;
    break;}
case 106:
#line 2054 "pascual.y"
{ 
       yyval.paraExp.tipo = BOOLEANO; 
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE; 
       yyval.paraExp.simbolo = NULL;
       /* Generacion de codigo */
       yyval.paraExp.cod = code (STC, 1);
     ;
    break;}
case 107:
#line 2065 "pascual.y"
{ 
       yyval.paraExp.tipo = BOOLEANO; 
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE; 
       yyval.paraExp.simbolo = NULL;
       /* Generacion de codigo */
       yyval.paraExp.cod = code (STC, 0);
     ;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 543 "/opt/bison/share/bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;

 yyacceptlab:
  /* YYACCEPT comes here.  */
  if (yyfree_stacks)
    {
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
    }
  return 0;

 yyabortlab:
  /* YYABORT comes here.  */
  if (yyfree_stacks)
    {
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
    }
  return 1;
}
#line 2078 "pascual.y"


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
      exit (1);
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
   }
   else
   { 
     fprintf (stderr, "Fichero %s generado correctamente\n", nameout);
   }
   
   fclose (yyout);
   fclose (yyin);
}

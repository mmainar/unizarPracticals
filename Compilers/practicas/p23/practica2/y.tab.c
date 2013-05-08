
/*  A Bison parser, made from pascual1.y
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

#line 1 "pascual1.y"

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
 * fecha ultima modificacion: 8 de mayo de 2009
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


#line 93 "pascual1.y"
typedef union {
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



#define	YYFINAL		202
#define	YYFLAG		-32768
#define	YYNTBASE	54

#define YYTRANSLATE(x) ((unsigned)(x) <= 294 ? yytranslate[x] : 109)

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
    86,    90,    92,    95,    96,    97,   105,   106,   111,   112,
   116,   120,   122,   125,   128,   130,   134,   136,   138,   142,
   145,   147,   150,   152,   154,   156,   158,   160,   162,   164,
   166,   169,   175,   177,   181,   187,   191,   193,   194,   195,
   202,   203,   204,   205,   216,   217,   223,   224,   232,   233,
   236,   237,   238,   244,   245,   249,   253,   257,   259,   261,
   265,   267,   269,   271,   273,   275,   277,   279,   283,   285,
   287,   289,   291,   295,   297,   299,   301,   303,   306,   309,
   313,   318,   323,   325,   330,   332,   334,   336,   338
};

static const short yyrhs[] = {    -1,
     3,    12,    47,    55,    57,    56,    76,     0,     0,    64,
     0,     0,    58,    47,     0,    58,    47,    59,     0,    59,
     0,    60,    62,     0,    61,    63,     0,    13,     0,    14,
     0,    15,     0,    22,    48,     5,    49,    49,     5,    50,
    23,    60,     0,    22,    48,    44,     5,    49,    49,     5,
    50,    23,    60,     0,    22,    48,     5,    49,    49,    44,
     5,    50,    23,    60,     0,    22,    48,    44,     5,    49,
    49,    44,     5,    50,    23,    60,     0,    12,     0,    62,
    51,    12,     0,    12,     0,    63,    51,    12,     0,    65,
     0,    64,    65,     0,     0,     0,    68,    47,    66,    57,
    67,    56,    76,     0,     0,     4,    12,    69,    70,     0,
     0,    52,    71,    53,     0,    71,    47,    72,     0,    72,
     0,    75,    73,     0,    60,    74,     0,    12,     0,    74,
    51,    12,     0,    38,     0,    39,     0,    19,    77,    20,
     0,    19,    20,     0,    78,     0,    77,    78,     0,    80,
     0,    82,     0,    84,     0,    87,     0,    93,     0,    91,
     0,    96,     0,    79,     0,    21,    47,     0,    17,    52,
    81,    53,    47,     0,    12,     0,    81,    51,    12,     0,
    16,    52,    83,    53,    47,     0,    83,    51,   102,     0,
   102,     0,     0,     0,    12,    85,    18,   102,    86,    47,
     0,     0,     0,     0,    12,    88,    48,   102,    50,    89,
    18,   102,    90,    47,     0,     0,    27,   102,    92,    77,
    28,     0,     0,    34,   102,    94,    35,    77,    95,    37,
     0,     0,    36,    77,     0,     0,     0,    12,    97,   100,
    98,    47,     0,     0,    12,    99,    47,     0,    52,   101,
    53,     0,   101,    51,   102,     0,   102,     0,   104,     0,
   102,   103,   104,     0,    40,     0,    42,     0,    41,     0,
    29,     0,    30,     0,    31,     0,   106,     0,   104,   105,
   106,     0,    43,     0,    44,     0,    25,     0,   108,     0,
   106,   107,   108,     0,    45,     0,    33,     0,    32,     0,
    24,     0,    44,   108,     0,    26,   108,     0,    52,   102,
    53,     0,    10,    52,   102,    53,     0,    11,    52,   102,
    53,     0,    12,     0,    12,    48,   102,    50,     0,     5,
     0,     6,     0,     7,     0,     8,     0,     9,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   126,   138,   147,   153,   161,   173,   188,   190,   193,   195,
   199,   201,   202,   205,   216,   226,   238,   251,   285,   320,
   370,   420,   422,   425,   429,   431,   438,   479,   489,   494,
   501,   507,   510,   515,   520,   534,   552,   554,   557,   559,
   562,   564,   567,   569,   570,   571,   572,   573,   574,   575,
   578,   580,   585,   616,   645,   650,   663,   677,   698,   728,
   730,   757,   785,   797,   799,   809,   812,   822,   827,   828,
   833,   864,   879,   879,   916,   918,   923,   961,   999,  1004,
  1029,  1032,  1034,  1036,  1038,  1040,  1044,  1049,  1118,  1120,
  1121,  1124,  1129,  1247,  1249,  1250,  1251,  1254,  1268,  1277,
  1281,  1310,  1332,  1367,  1427,  1437,  1447,  1456,  1465
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
"@2","@3","cabecera_accion","@4","parametros_formales","lista_parametros","parametros",
"declaracion_parametros","listaIDs_parametros","clase_parametros","bloque_instrucciones",
"lista_instrucciones","instruccion","nula","leer","lista_asignables","escribir",
"lista_escribibles","asignacion","@5","@6","asignacion_vector","@7","@8","@9",
"mientras_que","@10","seleccion","@11","resto_seleccion","invocacion_accion",
"@12","@13","@14","argumentos","lista_expresiones","expresion","operador_relacional",
"expresion_simple","operador_aditivo","termino","operador_multiplicativo","factor", NULL
};
#endif

static const short yyr1[] = {     0,
    55,    54,    56,    56,    57,    57,    58,    58,    59,    59,
    60,    60,    60,    61,    61,    61,    61,    62,    62,    63,
    63,    64,    64,    66,    67,    65,    69,    68,    70,    70,
    71,    71,    72,    73,    74,    74,    75,    75,    76,    76,
    77,    77,    78,    78,    78,    78,    78,    78,    78,    78,
    79,    80,    81,    81,    82,    83,    83,    85,    86,    84,
    88,    89,    90,    87,    92,    91,    94,    93,    95,    95,
    97,    98,    96,    99,    96,   100,   101,   101,   102,   102,
   103,   103,   103,   103,   103,   103,   104,   104,   105,   105,
   105,   106,   106,   107,   107,   107,   107,   108,   108,   108,
   108,   108,   108,   108,   108,   108,   108,   108,   108
};

static const short yyr2[] = {     0,
     0,     7,     0,     1,     0,     2,     3,     1,     2,     2,
     1,     1,     1,     9,    10,    10,    11,     1,     3,     1,
     3,     1,     2,     0,     0,     7,     0,     4,     0,     3,
     3,     1,     2,     2,     1,     3,     1,     1,     3,     2,
     1,     2,     1,     1,     1,     1,     1,     1,     1,     1,
     2,     5,     1,     3,     5,     3,     1,     0,     0,     6,
     0,     0,     0,    10,     0,     5,     0,     7,     0,     2,
     0,     0,     5,     0,     3,     3,     3,     1,     1,     3,
     1,     1,     1,     1,     1,     1,     1,     3,     1,     1,
     1,     1,     3,     1,     1,     1,     1,     2,     2,     3,
     4,     4,     1,     4,     1,     1,     1,     1,     1
};

static const short yydefact[] = {     0,
     0,     0,     1,     5,    11,    12,    13,     0,     3,     0,
     8,     0,     0,     0,     0,     0,     4,    22,     0,     6,
    18,     9,    20,    10,     0,     0,    27,     0,     2,    23,
    24,     7,     0,     0,     0,     0,    29,    58,     0,     0,
    40,     0,     0,     0,     0,    41,    50,    43,    44,    45,
    46,    48,    47,    49,     5,    19,    21,     0,     0,     0,
    28,     0,     0,     0,     0,     0,     0,    51,   105,   106,
   107,   108,   109,     0,     0,   103,     0,     0,     0,    65,
    79,    87,    92,    67,    39,    42,    25,     0,     0,     0,
    37,    38,     0,    32,     0,     0,     0,     0,    72,    75,
     0,    57,    53,     0,     0,     0,     0,    99,    98,     0,
    84,    85,    86,    81,    83,    82,     0,     0,    91,    89,
    90,     0,    97,    96,    95,    94,     0,     0,     3,     0,
     0,     0,     0,     0,    30,     0,    33,    59,     0,     0,
    78,     0,     0,     0,     0,     0,     0,     0,     0,   100,
     0,    80,    88,    93,     0,     0,     0,     0,     0,     0,
    31,    35,    34,     0,    62,     0,    76,    73,    56,    55,
    54,    52,   101,   102,   104,    66,    69,    26,    14,     0,
     0,     0,     0,    60,     0,    77,     0,     0,    16,    15,
     0,    36,     0,    70,    68,    17,    63,     0,    64,     0,
     0,     0
};

static const short yydefgoto[] = {   200,
     4,    16,     9,    10,    11,    12,    13,    22,    24,    17,
    18,    55,   129,    19,    37,    61,    93,    94,   137,   163,
    95,    29,    45,    46,    47,    48,   104,    49,   101,    50,
    62,   164,    51,    63,   185,   198,    52,   117,    53,   128,
   188,    54,    64,   142,    65,    99,   140,    80,   118,    81,
   122,    82,   127,    83
};

static const short yypact[] = {    26,
     5,   -26,-32768,    18,-32768,-32768,-32768,    16,    41,    29,
-32768,    39,    68,    -2,    70,    72,    41,-32768,    46,    18,
-32768,    47,-32768,    59,    74,   116,-32768,    85,-32768,-32768,
-32768,-32768,   113,   117,    79,    81,    83,    40,    90,    91,
-32768,   101,     4,     4,    97,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,    18,-32768,-32768,     2,   103,    65,
-32768,   135,   102,   112,   119,     4,   155,-32768,-32768,-32768,
-32768,-32768,-32768,   123,   124,   130,     4,     4,     4,   132,
    35,    62,-32768,   132,-32768,-32768,-32768,   118,   172,     3,
-32768,-32768,    -3,-32768,   125,     4,     4,     4,-32768,-32768,
   -33,   132,-32768,    14,     4,     4,     4,-32768,-32768,    -4,
-32768,-32768,-32768,-32768,-32768,-32768,   120,     4,-32768,-32768,
-32768,     4,-32768,-32768,-32768,-32768,     4,   145,    41,   158,
   133,   134,   177,    65,-32768,   173,-32768,   132,   115,    24,
   132,   139,     4,   140,   176,   142,    28,    43,   129,-32768,
    99,    35,    62,-32768,   120,    72,   125,   167,   168,   143,
-32768,-32768,   141,   147,-32768,     4,-32768,-32768,   132,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,     7,-32768,-32768,   125,
   125,   174,   183,-32768,   178,   132,   120,   161,-32768,-32768,
   125,-32768,     4,   120,-32768,-32768,   132,   152,-32768,   200,
   201,-32768
};

static const short yypgoto[] = {-32768,
-32768,    73,   148,-32768,   184,   -91,-32768,-32768,-32768,-32768,
   188,-32768,-32768,-32768,-32768,-32768,-32768,    75,-32768,-32768,
-32768,    50,  -116,   -43,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,   -44,-32768,    89,
-32768,    86,-32768,   -72
};


#define	YYLAST		209


static const short yytable[] = {    84,
   151,    86,    25,   136,   108,   109,    88,   132,    69,    70,
    71,    72,    73,    74,    75,    76,     2,   143,    38,   144,
     3,   102,    39,    40,   111,   112,   113,    42,     1,    77,
     5,     6,     7,    43,   110,   114,   115,   116,   177,     8,
    44,    26,   187,   134,    15,    89,   133,    78,   150,   135,
    21,   138,   139,   141,   154,    79,   111,   112,   113,   119,
   147,   148,   149,    14,   145,   179,   146,   114,   115,   116,
   194,   111,   112,   113,   166,    20,   167,   120,   121,    23,
   173,    27,   114,   115,   116,   123,   -74,   -61,   189,   190,
    28,   -71,    31,   124,   125,   174,    38,    33,   169,   196,
    39,    40,    91,    92,    41,    42,   126,    86,    38,    34,
    38,    43,    39,    40,    39,    40,    85,    42,    44,    42,
    36,   186,    35,    43,    56,    43,   176,    58,    57,    59,
    44,    38,    44,    86,    60,    39,    40,     5,     6,     7,
    42,    66,    67,   111,   112,   113,    43,    68,   197,    97,
    86,    90,    96,    44,   114,   115,   116,   111,   112,   113,
   111,   112,   113,    98,   165,   100,   103,   130,   114,   115,
   116,   114,   115,   116,   105,   106,   131,   107,   175,   155,
   157,   160,   158,   159,   162,   168,   170,   171,   172,   180,
   181,   183,   182,   184,   192,   193,   191,   195,   199,   201,
   202,   156,    87,    32,    30,   178,   152,   153,   161
};

static const short yycheck[] = {    44,
   117,    45,     5,    95,    77,    78,     5,     5,     5,     6,
     7,     8,     9,    10,    11,    12,    12,    51,    12,    53,
    47,    66,    16,    17,    29,    30,    31,    21,     3,    26,
    13,    14,    15,    27,    79,    40,    41,    42,   155,    22,
    34,    44,    36,    47,     4,    44,    44,    44,    53,    53,
    12,    96,    97,    98,   127,    52,    29,    30,    31,    25,
   105,   106,   107,    48,    51,   157,    53,    40,    41,    42,
   187,    29,    30,    31,    51,    47,    53,    43,    44,    12,
    53,    12,    40,    41,    42,    24,    47,    48,   180,   181,
    19,    52,    47,    32,    33,    53,    12,    51,   143,   191,
    16,    17,    38,    39,    20,    21,    45,   151,    12,    51,
    12,    27,    16,    17,    16,    17,    20,    21,    34,    21,
     5,   166,    49,    27,    12,    27,    28,    49,    12,    49,
    34,    12,    34,   177,    52,    16,    17,    13,    14,    15,
    21,    52,    52,    29,    30,    31,    27,    47,   193,    48,
   194,    49,    18,    34,    40,    41,    42,    29,    30,    31,
    29,    30,    31,    52,    50,    47,    12,    50,    40,    41,
    42,    40,    41,    42,    52,    52,     5,    48,    50,    35,
    23,     5,    50,    50,    12,    47,    47,    12,    47,    23,
    23,    51,    50,    47,    12,    18,    23,    37,    47,     0,
     0,   129,    55,    20,    17,   156,   118,   122,   134
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
#line 128 "pascual1.y"
{
    nivel = 0;
    ident = 0; /* XML */
    introducir_programa (tabsim, yyvsp[-1].paraID.nombre, 0); /* XML */
    generar_inicio_programa(yyvsp[-1].paraID.nombre); /* XML */
    ident++; /* XML */
    generar_dec_var(ident); /* XML */
    ident++; /* XML */
  ;
    break;}
case 2:
#line 140 "pascual1.y"
{
    eliminar_programa (tabsim); /* XML */
    cerrar_bloque();
    generar_cierre_programa(yyvsp[-5].paraID.nombre); /* XML */
  ;
    break;}
case 3:
#line 148 "pascual1.y"
{
      /* XML */
      ident--;
      if (ident == 1) generar_cierre_dec_acc(ident);
    ;
    break;}
case 4:
#line 154 "pascual1.y"
{
      /* XML */
      ident--;
      if (ident == 1) generar_cierre_dec_acc(ident);
    ;
    break;}
case 5:
#line 162 "pascual1.y"
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
   ;
    break;}
case 6:
#line 174 "pascual1.y"
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
   ;
    break;}
case 9:
#line 194 "pascual1.y"
{ ; ;
    break;}
case 10:
#line 196 "pascual1.y"
{ ; ;
    break;}
case 11:
#line 200 "pascual1.y"
{ yyval.tipo = ENTERO;   ;
    break;}
case 12:
#line 201 "pascual1.y"
{ yyval.tipo = CHAR;     ;
    break;}
case 13:
#line 202 "pascual1.y"
{ yyval.tipo = BOOLEANO; ;
    break;}
case 14:
#line 207 "pascual1.y"
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
#line 217 "pascual1.y"
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
#line 227 "pascual1.y"
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
#line 239 "pascual1.y"
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
#line 253 "pascual1.y"
{
     if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       introducir_variable(tabsim, yyvsp[0].paraID.nombre, yyvsp[-1].tipo, nivel, 0); 
       generar_nueva_var_simple(ident, yyvsp[0].paraID.nombre, yyvsp[-1].tipo); /* XML */ 
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
#line 286 "pascual1.y"
{
     if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       introducir_variable(tabsim, yyvsp[0].paraID.nombre, yyvsp[-3].tipo, nivel, 0);
       generar_nueva_var_simple(ident, yyvsp[0].paraID.nombre, yyvsp[-3].tipo); /* XML */
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
#line 322 "pascual1.y"
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
     }
     else if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       introducir_variable_vector (tabsim, yyvsp[0].paraID.nombre, nivel, 0, yyvsp[-1].paraVector.tipo_componentes,
                                   yyvsp[-1].paraVector.indiceInf, yyvsp[-1].paraVector.indiceSup,
                                   yyvsp[-1].paraVector.dimension);
       generar_nueva_var_vector(ident+1, yyvsp[0].paraID.nombre, yyvsp[-1].paraVector.tipo_componentes,
                                yyvsp[-1].paraVector.indiceInf, yyvsp[-1].paraVector.indiceSup); /* XML */
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
#line 371 "pascual1.y"
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
       generar_nueva_var_vector(ident+1, yyvsp[0].paraID.nombre, yyvsp[-3].paraVector.tipo_componentes,
                                yyvsp[-3].paraVector.indiceInf, yyvsp[-3].paraVector.indiceSup); /* XML */
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
case 24:
#line 427 "pascual1.y"
{ ident++; /* XML */;
    break;}
case 25:
#line 429 "pascual1.y"
{ ident++; /* XML */;
    break;}
case 26:
#line 432 "pascual1.y"
{
     generar_cierre_acc(ident); /* XML */
     cerrar_bloque();
   ;
    break;}
case 27:
#line 440 "pascual1.y"
{
     yyval.simbolo = NULL;
     if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
     {
       yyval.simbolo = introducir_accion (tabsim, yyvsp[0].paraID.nombre, nivel, 0);
       generar_nueva_acc(ident, yyvsp[0].paraID.nombre); /* XML */
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
     ident++; /* XML */
   ;
    break;}
case 28:
#line 479 "pascual1.y"
{
     if (yyvsp[-1].simbolo != NULL)
     {
       /* Almacenamos los parametros de la accion en la TS */
       yyvsp[-1].simbolo->parametros = yyvsp[0].lista; 
     }
   ;
    break;}
case 29:
#line 490 "pascual1.y"
{ 
       crear_vacia(&(yyval.lista)); /* No hay parametros formales en la accion */
       generar_dec_var(ident); /* XML */
     ;
    break;}
case 30:
#line 495 "pascual1.y"
{ 
       yyval.lista = yyvsp[-1].lista; 
       generar_dec_var(ident);  /* XML */
     ;
    break;}
case 31:
#line 503 "pascual1.y"
{
     concatenar(&(yyvsp[-2].lista), yyvsp[0].lista);
     yyval.lista = yyvsp[-2].lista;
   ;
    break;}
case 32:
#line 507 "pascual1.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 33:
#line 512 "pascual1.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 34:
#line 517 "pascual1.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 35:
#line 522 "pascual1.y"
{
       if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
       {
         crear_unitaria(&(yyval.lista), (introducir_parametro (tabsim, yyvsp[0].paraID.nombre, yyvsp[-1].tipo, yyvsp[-2].clase, nivel, 0)));
         generar_nuevo_par(ident, yyvsp[0].paraID.nombre, yyvsp[-1].tipo, yyvsp[-2].clase); /* XML */
       }
       else 
       { 
         sprintf(errorBuf, "Parametro %s duplicado", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
     ;
    break;}
case 36:
#line 535 "pascual1.y"
{
       if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
       {
         crear_unitaria(&(yyval.lista), (introducir_parametro (tabsim, yyvsp[0].paraID.nombre, yyvsp[-3].tipo, yyvsp[-4].clase, nivel, 0)));
         concatenar(&(yyvsp[-2].lista), yyval.lista);
         /* Las 2 formas funcionan (son equivalentes) */
         /* anadir_derecha(introducir_parametro (tabsim, $3.nombre, $<tipo>0, $<clase>-1, nivel, 0) , &($1)); */
         generar_nuevo_par(ident, yyvsp[0].paraID.nombre, yyvsp[-3].tipo, yyvsp[-4].clase); /* XML */
         yyval.lista = yyvsp[-2].lista;
       }
       else 
       { 
         sprintf(errorBuf, "Parametro %s duplicado", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
     ;
    break;}
case 37:
#line 553 "pascual1.y"
{ yyval.clase = VAL; ;
    break;}
case 38:
#line 554 "pascual1.y"
{ yyval.clase = REF; ;
    break;}
case 53:
#line 587 "pascual1.y"
{
     yyval.constante = 1;
     /* Comprobamos que esta declarado y es entero o caracter */
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
       }
     }
   ;
    break;}
case 54:
#line 617 "pascual1.y"
{
     /* Comprobamos que esta declarado y es entero o caracter  */
     yyval.constante = yyvsp[-2].constante + 1;
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
       }
     }
   ;
    break;}
case 56:
#line 652 "pascual1.y"
{
    yyval.constante = yyvsp[-2].constante + 1;
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if ((yyvsp[0].paraExp.tipo == BOOLEANO) || (yyvsp[0].paraExp.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento %d de escribir es de tipo incorrecto, debe ser cadena, entero o caracter", yyval.constante);
      error_semantico(errorBuf);
    }
  ;
    break;}
case 57:
#line 664 "pascual1.y"
{
    yyval.constante = 1;
    /* Comprobar que no es booleano ni vector (desconocido si para no dar cadena de errores).
       Podra ser por tanto char, entero o cadena.
       Esto incluye a las componentes de vectores de tipos char o entero. */
    if ((yyvsp[0].paraExp.tipo == BOOLEANO) || (yyvsp[0].paraExp.tipo == VECTOR))
    {
      sprintf(errorBuf, "El argumento 1 de escribir es de tipo incorrecto, debe ser cadena, entero o caracter");
      error_semantico(errorBuf);
    }
  ;
    break;}
case 58:
#line 679 "pascual1.y"
{
     yyval.ok = FALSE; /* Indica si existe o no el identificador */
     if (yyvsp[0].paraID.simbolo == NULL)
     {
       sprintf(errorBuf, "Identificador %s no declarado", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if ((yyvsp[0].paraID.simbolo->tipo != VARIABLE) && (yyvsp[0].paraID.simbolo->tipo != PARAMETRO))
     {
       yyval.ok = TRUE;
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
case 59:
#line 699 "pascual1.y"
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
case 61:
#line 732 "pascual1.y"
{
        yyval.ok = FALSE; /* Indica si existe o no el identificador */
        if (yyvsp[0].paraID.simbolo == NULL)
	{
	  sprintf(errorBuf, "Identificador %s no encontrado", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else if (yyvsp[0].paraID.simbolo->tipo != VARIABLE)
	{
	  yyval.ok = TRUE;
	  sprintf(errorBuf, "El identificador %s debe ser variable", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else if ((yyvsp[0].paraID.simbolo->variable != VECTOR) && (yyvsp[0].paraID.simbolo->variable != DESCONOCIDO))
	{
	  yyval.ok = TRUE;
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
case 62:
#line 758 "pascual1.y"
{
        if ((yyvsp[-1].paraExp.tipo != ENTERO) && (yyvsp[-1].paraExp.tipo != DESCONOCIDO))
	{
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
case 63:
#line 786 "pascual1.y"
{
        /* Puede ser una componente de un vector ($8.tipo contendra el tipo de sus componentes, no VECTOR) 
	   o una variable simple */
        if ((yyvsp[-6].ok) && (yyvsp[0].paraExp.tipo != yyvsp[-7].paraID.simbolo->tipo_componentes))
	{
	  sprintf(errorBuf, "Tipos incompatibles en la asignacion");
          error_semantico(errorBuf);
	}
      ;
    break;}
case 65:
#line 802 "pascual1.y"
{
    if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
    {
      error_semantico("Mq: condicion invalida.");
    }
  ;
    break;}
case 67:
#line 815 "pascual1.y"
{
    if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
    {
      error_semantico("Seleccion: condicion invalida.");
    }
  ;
    break;}
case 71:
#line 835 "pascual1.y"
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
case 72:
#line 864 "pascual1.y"
{ 
     if ((yyvsp[-1].ok) && (yyvsp[-2].paraID.simbolo->parametros.elementos != yyvsp[0].constante))
     {
       /* Especificar si sobran o faltan argumentos y cuantos */
       if (yyvsp[-2].paraID.simbolo->parametros.elementos < yyvsp[0].constante) 
         sprintf(errorBuf, "Numero de argumentos en invocacion de la accion %s incorrecto: sobran %d argumentos" 
	                   ,yyvsp[-2].paraID.nombre, yyvsp[0].constante - yyvsp[-2].paraID.simbolo->parametros.elementos);
       else 
         sprintf(errorBuf, "Numero de argumentos en la invocacion de la accion %s incorrecto: faltan %d argumentos" 
	                   ,yyvsp[-2].paraID.nombre, yyvsp[-2].paraID.simbolo->parametros.elementos - yyvsp[0].constante);
       error_semantico(errorBuf);
     }

   ;
    break;}
case 74:
#line 880 "pascual1.y"
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
case 76:
#line 920 "pascual1.y"
{ yyval.constante = yyvsp[-1].constante; ;
    break;}
case 77:
#line 925 "pascual1.y"
{
     LISTA pars;
     SIMBOLO *p;
     int i;

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if (yyvsp[-4].ok)
     {
       pars = (*(yyvsp[-5].paraID.simbolo)).parametros;
       
       if (longitud_lista(pars) >= (yyvsp[-2].constante+1)) 
       {

         p = observar (pars, yyvsp[-2].constante+1);
         /* Verificaciones de los argumentos de la invocacion */
	 if (yyvsp[0].paraExp.tipo == VECTOR)
	 {
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != yyvsp[0].paraExp.tipo) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
         { 
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   sprintf(errorBuf, "Los tipos del parametro y el argumento numero %d no coinciden", yyvsp[-2].constante+1);
           error_semantico(errorBuf);
         }
         if (((*p).parametro == REF) && (yyvsp[0].paraExp.esVariable != TRUE) && (yyvsp[0].paraExp.esParametroRef != TRUE))
         {
           /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   sprintf(errorBuf, "El argumento numero %d debe ser una variable o parametro por referencia", yyvsp[-2].constante+1);		      
           error_semantico(errorBuf);
         }	 
       }
       yyval.constante = yyvsp[-2].constante + 1; /* Para contar el numero de argumentos en la invocacion a la accion */
     }
   ;
    break;}
case 78:
#line 962 "pascual1.y"
{
     LISTA pars;
     SIMBOLO *p;
     int i;

     /* Si la accion a invocar no estaba declarada, no compruebo sus argumentos */
     if (yyvsp[-2].ok)
     {
       pars = (*(yyvsp[-3].paraID.simbolo)).parametros;

       if (longitud_lista (pars) >= 1)
       {
         p = observar (pars, 1);
         /* Verificaciones */
	 if (yyvsp[0].paraExp.tipo == VECTOR)
	 {
	   error_semantico("Los argumentos de las acciones solo pueden ser tipos simples, no vectores");
	 } 
         if (((*p).variable != yyvsp[0].paraExp.tipo) &&  (yyvsp[0].paraExp.tipo != DESCONOCIDO))
         {
           /* Verificamos tipo: los tipos de argumento y parametro deben coincidir */
	   sprintf(errorBuf, "Los tipos del parametro y el argumento 1 no coinciden");
           error_semantico(errorBuf);
         } 
         if (((*p).parametro == REF) && (yyvsp[0].paraExp.esVariable != TRUE) && (yyvsp[0].paraExp.esParametroRef !=TRUE))
         {  /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables o parametros por referencia */
	   sprintf(errorBuf, "El argumento numero 1 debe ser una variable o un parametro por referencia");		      
           error_semantico(errorBuf);
         }
       }
	 
       yyval.constante = 1; /* Numero de argumentos: Solo hay uno */
     }
   ;
    break;}
case 79:
#line 1001 "pascual1.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 80:
#line 1005 "pascual1.y"
{
     yyval.paraExp.tipo = BOOLEANO;
     yyval.paraExp.esVariable = FALSE;
     yyval.paraExp.esParametroRef = FALSE;
     yyval.paraExp.esConstEntera = FALSE;
     yyval.paraExp.esConstChar = FALSE;
     yyval.paraExp.simbolo = NULL;
     
     if ((yyvsp[-2].paraExp.tipo == CADENA) || (yyvsp[0].paraExp.tipo == CADENA))
     {
       error_semantico("Los operandos no pueden ser de tipo cadena");
     }
     else if ((yyvsp[-2].paraExp.tipo != DESCONOCIDO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO) && (yyvsp[-2].paraExp.tipo != yyvsp[0].paraExp.tipo))
     { 
       error_semantico("Los operandos deben ser de igual tipo");
     }
     else if ((yyvsp[-1].constante != '=') && (yyvsp[-1].constante != tNI) && (yyvsp[-2].paraExp.tipo == BOOLEANO))
     {
       error_semantico("El operador no se puede aplicar a booleanos");
     }

   ;
    break;}
case 81:
#line 1031 "pascual1.y"
{ yyval.constante = '='; ;
    break;}
case 82:
#line 1033 "pascual1.y"
{ yyval.constante = '='; ;
    break;}
case 83:
#line 1035 "pascual1.y"
{ yyval.constante = '='; ;
    break;}
case 84:
#line 1037 "pascual1.y"
{ yyval.constante = tMEI; ;
    break;}
case 85:
#line 1039 "pascual1.y"
{ yyval.constante = tMAI; ;
    break;}
case 86:
#line 1041 "pascual1.y"
{ yyval.constante = tNI; ;
    break;}
case 87:
#line 1046 "pascual1.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 88:
#line 1050 "pascual1.y"
{
     if (yyvsp[-1].constante == tOR)
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
     else if (yyvsp[-1].constante == '+')
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
     else if (yyvsp[-1].constante == '-')
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
   ;
    break;}
case 89:
#line 1119 "pascual1.y"
{ yyval.constante = '+'; ;
    break;}
case 90:
#line 1120 "pascual1.y"
{ yyval.constante = '-'; ;
    break;}
case 91:
#line 1121 "pascual1.y"
{ yyval.constante = tOR; ;
    break;}
case 92:
#line 1126 "pascual1.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 93:
#line 1130 "pascual1.y"
{
     if (yyvsp[-1].constante == '*')
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
     else if (yyvsp[-1].constante == tDIV)
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
     else if (yyvsp[-1].constante == tMOD)
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
     else if (yyvsp[-1].constante == tAND) 
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
   ;
    break;}
case 94:
#line 1248 "pascual1.y"
{ yyval.constante = '*'; ;
    break;}
case 95:
#line 1249 "pascual1.y"
{ yyval.constante = tDIV; ;
    break;}
case 96:
#line 1250 "pascual1.y"
{ yyval.constante = tMOD; ;
    break;}
case 97:
#line 1251 "pascual1.y"
{ yyval.constante = tAND; ;
    break;}
case 98:
#line 1256 "pascual1.y"
{
      yyval.paraExp = yyvsp[0].paraExp;
      if (yyvsp[0].paraExp.esConstEntera == TRUE)
        yyval.paraExp.valorConstEntera = - (yyvsp[0].paraExp.valorConstEntera);
	
      yyval.paraExp.tipo = ENTERO;
      
      if (yyvsp[0].paraExp.tipo != ENTERO)
      {
        error_semantico("Argumento de - unario debe ser entero");
      }
    ;
    break;}
case 99:
#line 1269 "pascual1.y"
{
      yyval.paraExp = yyvsp[0].paraExp;
      yyval.paraExp.tipo = BOOLEANO;
      if (yyvsp[0].paraExp.tipo != BOOLEANO)
      {
        error_semantico("Argumento de not debe ser booleano");
      }
    ;
    break;}
case 100:
#line 1278 "pascual1.y"
{ 
      yyval.paraExp = yyvsp[-1].paraExp; 
    ;
    break;}
case 101:
#line 1282 "pascual1.y"
{
      yyval.paraExp.tipo = CHAR;
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.esConstChar = FALSE; /* De momento */
      yyval.paraExp.simbolo = NULL;
      yyval.paraExp.esConstEntera = FALSE; 
      
      if (yyvsp[-1].paraExp.tipo != ENTERO)
      {
        error_semantico("Argumento de entacar debe ser entero");
      }
      else
      {
        if (yyvsp[-1].paraExp.esConstEntera == TRUE)
	{
	  yyval.paraExp.esConstChar = TRUE;
	  yyval.paraExp.valorConstChar = (char) yyvsp[-1].paraExp.valorConstEntera;
	  
	  if ((yyvsp[-1].paraExp.valorConstEntera < 0) || (yyvsp[-1].paraExp.valorConstEntera >= 256))
	  {
	    if (warnings == 1) warning("Se truncara el argumento de entacar");
	    yyval.paraExp.valorConstChar = (char) abs(yyvsp[-1].paraExp.valorConstEntera % 256);
	  }	 	

	}
      }
    ;
    break;}
case 102:
#line 1311 "pascual1.y"
{
      yyval.paraExp.tipo = ENTERO;
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.simbolo = NULL;
      yyval.paraExp.esConstEntera = FALSE; /* De momento */
      yyval.paraExp.esConstChar = FALSE; 
      
      if (yyvsp[-1].paraExp.tipo != CHAR)
      {
        error_semantico("Argumento de caraent debe ser caracter");
      }
      else 
      {
        if (yyvsp[-1].paraExp.esConstChar == TRUE)
        {
	  yyval.paraExp.esConstEntera = TRUE;
	  yyval.paraExp.valorConstEntera = (int) yyvsp[-1].paraExp.valorConstChar;
	}
      }
    ;
    break;}
case 103:
#line 1333 "pascual1.y"
{
      yyval.paraExp.tipo = DESCONOCIDO; 
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.esConstEntera = FALSE;
      yyval.paraExp.esConstChar = FALSE;
      yyval.paraExp.simbolo = NULL;
      
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
      }
      else /* Es un parametro */
      {  
        yyval.paraExp.simbolo = yyvsp[0].paraID.simbolo; 
	yyval.paraExp.esVariable = FALSE;
	yyval.paraExp.tipo = yyvsp[0].paraID.simbolo->variable; /* El tipo de la expresion es el del parametro */
	if (yyvsp[0].paraID.simbolo->parametro == REF) yyval.paraExp.esParametroRef = TRUE;
	else yyval.paraExp.esParametroRef = FALSE;
      }
    ;
    break;}
case 104:
#line 1368 "pascual1.y"
{
      yyval.paraExp.tipo = DESCONOCIDO; 
      yyval.paraExp.esVariable = FALSE;
      yyval.paraExp.esParametroRef = FALSE;
      yyval.paraExp.esConstEntera = FALSE;
      yyval.paraExp.esConstChar = FALSE;
      yyval.paraExp.simbolo = NULL;
      
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
        yyval.paraExp.esVariable = TRUE; 
	yyval.paraExp.simbolo = yyvsp[-3].paraID.simbolo; 
	/* Hago que sea el tipo de la expresion el de las componentes del vector */
	yyval.paraExp.tipo = yyvsp[-3].paraID.simbolo->tipo_componentes;
	yyvsp[-3].paraID.simbolo->referenciada = TRUE;
      }
      if ((yyvsp[-3].paraID.simbolo != NULL)  && (yyvsp[-3].paraID.simbolo->variable == VECTOR) && (yyvsp[-1].paraExp.tipo == ENTERO) && (yyvsp[-1].paraExp.esConstEntera == TRUE))
      {
        /* Comprobar, si expresion es constEntera que esta dentro del rango de indices del vector */
	if ((yyvsp[-1].paraExp.valorConstEntera > yyvsp[-3].paraID.simbolo->indiceSup) || (yyvsp[-1].paraExp.valorConstEntera < yyvsp[-3].paraID.simbolo->indiceInf))
	{
	  if (warnings == 1)
	  {
           sprintf(errorBuf, "El indice %d del vector %s no existe", yyvsp[-1].paraExp.valorConstEntera ,yyvsp[-3].paraID.nombre);
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
case 105:
#line 1428 "pascual1.y"
{ 
       yyval.paraExp.tipo = ENTERO;   
       yyval.paraExp.esConstEntera = TRUE;
       yyval.paraExp.valorConstEntera = yyvsp[0].constante;
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.simbolo = NULL;
     ;
    break;}
case 106:
#line 1438 "pascual1.y"
{ 
       yyval.paraExp.tipo = CHAR;     
       yyval.paraExp.esConstChar = TRUE;
       yyval.paraExp.valorConstChar = (char) yyvsp[0].constante;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE;
       yyval.paraExp.simbolo = NULL;
     ;
    break;}
case 107:
#line 1448 "pascual1.y"
{ 
       yyval.paraExp.tipo = CADENA;  
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE; 
       yyval.paraExp.simbolo = NULL;
     ;
    break;}
case 108:
#line 1457 "pascual1.y"
{ 
       yyval.paraExp.tipo = BOOLEANO; 
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE; 
       yyval.paraExp.simbolo = NULL;
     ;
    break;}
case 109:
#line 1466 "pascual1.y"
{ 
       yyval.paraExp.tipo = BOOLEANO; 
       yyval.paraExp.esConstChar = FALSE;
       yyval.paraExp.esConstEntera = FALSE;
       yyval.paraExp.esVariable = FALSE;
       yyval.paraExp.esParametroRef = FALSE; 
       yyval.paraExp.simbolo = NULL;
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
#line 1477 "pascual1.y"


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

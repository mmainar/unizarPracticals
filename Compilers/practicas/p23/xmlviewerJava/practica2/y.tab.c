
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
#define	tVECTOR	275
#define	tDE	276
#define	tAND	277
#define	tOR	278
#define	tNOT	279
#define	tMQ	280
#define	tFMQ	281
#define	tMEI	282
#define	tMAI	283
#define	tNI	284
#define	tMOD	285
#define	tDIV	286
#define	tSI	287
#define	tENT	288
#define	tSI_NO	289
#define	tFSI	290
#define	tVAL	291
#define	tREF	292
#define	MENOSU	293

#line 1 "pascual1.y"

/**********************************************************************
 * fichero: pascual.y
 *          Analizador sintatico de Pascual
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
  /* printf("Abriendo bloque de nivel %d (%d, %d)\n", nivel, lineno, linepos); */
}

void cerrar_bloque ()
/* Cierra el bloque actual realizando las acciones necesarias sobre 
   la TS */
{
  /* printf("Cerrando nivel %d (%d, %d)\n", nivel, lineno, linepos); */
  eliminar_variables (tabsim, nivel); 
  /* Eliminamos los parametros ocultos del nivel cerrado anteriormente
    ya que ya no se va a invocar mas a las acciones a las que pertenecen. */
  eliminar_parametros_ocultos (tabsim, nivel+1); 
  ocultar_parametros (tabsim, nivel);  
  eliminar_acciones (tabsim, nivel);  
  nivel--;
}


#line 89 "pascual1.y"
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
  int esConstante;  /* Para comprobar expresiones constantes */
  int valorConstante; /* Calculo el valor constante */
 }paraExp; /* Para todos los no terminales relacionados con expresiones */
 int ok;      /* Para varias acciones intermedias */
 SIMBOLO *simbolo;
 LISTA lista; /* Para los parametros */
 CLASE_PARAMETRO clase;
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



#define	YYFINAL		197
#define	YYFLAG		-32768
#define	YYNTBASE	54

#define YYTRANSLATE(x) ((unsigned)(x) <= 293 ? yytranslate[x] : 106)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,    52,
    53,    44,    42,    51,    43,    49,    45,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,    47,    41,
    39,    40,     2,     2,     2,     2,     2,     2,     2,     2,
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
    37,    38,    46
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     1,     9,    10,    12,    13,    16,    20,    22,    25,
    28,    30,    32,    34,    44,    55,    66,    78,    80,    84,
    86,    90,    92,    95,    96,    97,   105,   106,   111,   112,
   116,   120,   122,   125,   128,   130,   134,   136,   138,   142,
   145,   147,   150,   152,   154,   156,   158,   160,   162,   164,
   170,   172,   176,   182,   186,   188,   189,   195,   196,   197,
   207,   208,   214,   215,   223,   224,   227,   228,   229,   235,
   236,   240,   244,   248,   250,   252,   256,   258,   260,   262,
   264,   266,   268,   270,   274,   276,   278,   280,   282,   286,
   288,   290,   292,   294,   297,   300,   304,   309,   314,   316,
   321,   323,   325,   327,   329
};

static const short yyrhs[] = {    -1,
     3,    12,    47,    55,    57,    56,    76,     0,     0,    64,
     0,     0,    58,    47,     0,    58,    47,    59,     0,    59,
     0,    60,    62,     0,    61,    63,     0,    13,     0,    14,
     0,    15,     0,    21,    48,     5,    49,    49,     5,    50,
    22,    60,     0,    21,    48,    43,     5,    49,    49,     5,
    50,    22,    60,     0,    21,    48,     5,    49,    49,    43,
     5,    50,    22,    60,     0,    21,    48,    43,     5,    49,
    49,    43,     5,    50,    22,    60,     0,    12,     0,    62,
    51,    12,     0,    12,     0,    63,    51,    12,     0,    65,
     0,    64,    65,     0,     0,     0,    68,    47,    66,    57,
    67,    56,    76,     0,     0,     4,    12,    69,    70,     0,
     0,    52,    71,    53,     0,    71,    47,    72,     0,    72,
     0,    75,    73,     0,    60,    74,     0,    12,     0,    74,
    51,    12,     0,    37,     0,    38,     0,    19,    77,    20,
     0,    19,    20,     0,    78,     0,    77,    78,     0,    79,
     0,    81,     0,    83,     0,    85,     0,    90,     0,    88,
     0,    93,     0,    17,    52,    80,    53,    47,     0,    12,
     0,    80,    51,    12,     0,    16,    52,    82,    53,    47,
     0,    82,    51,    99,     0,    99,     0,     0,    12,    84,
    18,    99,    47,     0,     0,     0,    12,    86,    48,    99,
    50,    87,    18,    99,    47,     0,     0,    26,    99,    89,
    77,    27,     0,     0,    33,    99,    91,    34,    77,    92,
    36,     0,     0,    35,    77,     0,     0,     0,    12,    94,
    97,    95,    47,     0,     0,    12,    96,    47,     0,    52,
    98,    53,     0,    98,    51,    99,     0,    99,     0,   101,
     0,    99,   100,   101,     0,    39,     0,    41,     0,    40,
     0,    28,     0,    29,     0,    30,     0,   103,     0,   101,
   102,   103,     0,    42,     0,    43,     0,    24,     0,   105,
     0,   103,   104,   105,     0,    44,     0,    32,     0,    31,
     0,    23,     0,    43,   105,     0,    25,   105,     0,    52,
    99,    53,     0,    10,    52,    99,    53,     0,    11,    52,
    99,    53,     0,    12,     0,    12,    48,    99,    50,     0,
     5,     0,     6,     0,     7,     0,     8,     0,     9,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   120,   134,   146,   152,   160,   172,   187,   189,   192,   194,
   198,   200,   201,   204,   215,   225,   230,   243,   278,   314,
   362,   410,   412,   415,   419,   421,   430,   473,   483,   488,
   495,   501,   504,   509,   514,   528,   546,   548,   551,   553,
   556,   558,   561,   563,   564,   565,   566,   567,   568,   571,
   576,   599,   623,   628,   638,   649,   668,   701,   722,   731,
   748,   758,   761,   771,   776,   777,   782,   799,   808,   808,
   829,   831,   836,   874,   912,   917,   933,   935,   936,   937,
   938,   939,   942,   947,   976,   978,   979,   982,   987,  1016,
  1018,  1019,  1020,  1023,  1032,  1040,  1041,  1049,  1057,  1092,
  1121,  1127,  1131,  1135,  1139
};
#endif


#if YYDEBUG != 0 || defined (YYERROR_VERBOSE)

static const char * const yytname[] = {   "$","error","$undefined.","tPROGRAMA",
"tACCION","tCONSTENTERA","tCONSTCHAR","tCONSTCAD","tTRUE","tFALSE","tENTACAR",
"tCARAENT","tIDENTIFICADOR","tENTERO","tCARACTER","tBOOLEANO","tESCRIBIR","tLEER",
"tOPAS","tPRINCIPIO","tFIN","tVECTOR","tDE","tAND","tOR","tNOT","tMQ","tFMQ",
"tMEI","tMAI","tNI","tMOD","tDIV","tSI","tENT","tSI_NO","tFSI","tVAL","tREF",
"'='","'>'","'<'","'+'","'-'","'*'","'/'","MENOSU","';'","'['","'.'","']'","','",
"'('","')'","programa","@1","declaracion_acciones2","declaracion_variables",
"lista_declaraciones","declaracion","tipo_variables","tipo_variable_vector",
"identificadores","identificadores_vector","declaracion_acciones","declaracion_accion",
"@2","@3","cabecera_accion","@4","parametros_formales","lista_parametros","parametros",
"declaracion_parametros","listaIDs_parametros","clase_parametros","bloque_instrucciones",
"lista_instrucciones","instruccion","leer","lista_asignables","escribir","lista_escribibles",
"asignacion","@5","asignacion_vector","@6","@7","mientras_que","@8","seleccion",
"@9","resto_seleccion","invocacion_accion","@10","@11","@12","argumentos","lista_expresiones",
"expresion","operador_relacional","expresion_simple","operador_aditivo","termino",
"operador_multiplicativo","factor", NULL
};
#endif

static const short yyr1[] = {     0,
    55,    54,    56,    56,    57,    57,    58,    58,    59,    59,
    60,    60,    60,    61,    61,    61,    61,    62,    62,    63,
    63,    64,    64,    66,    67,    65,    69,    68,    70,    70,
    71,    71,    72,    73,    74,    74,    75,    75,    76,    76,
    77,    77,    78,    78,    78,    78,    78,    78,    78,    79,
    80,    80,    81,    82,    82,    84,    83,    86,    87,    85,
    89,    88,    91,    90,    92,    92,    94,    95,    93,    96,
    93,    97,    98,    98,    99,    99,   100,   100,   100,   100,
   100,   100,   101,   101,   102,   102,   102,   103,   103,   104,
   104,   104,   104,   105,   105,   105,   105,   105,   105,   105,
   105,   105,   105,   105,   105
};

static const short yyr2[] = {     0,
     0,     7,     0,     1,     0,     2,     3,     1,     2,     2,
     1,     1,     1,     9,    10,    10,    11,     1,     3,     1,
     3,     1,     2,     0,     0,     7,     0,     4,     0,     3,
     3,     1,     2,     2,     1,     3,     1,     1,     3,     2,
     1,     2,     1,     1,     1,     1,     1,     1,     1,     5,
     1,     3,     5,     3,     1,     0,     5,     0,     0,     9,
     0,     5,     0,     7,     0,     2,     0,     0,     5,     0,
     3,     3,     3,     1,     1,     3,     1,     1,     1,     1,
     1,     1,     1,     3,     1,     1,     1,     1,     3,     1,
     1,     1,     1,     2,     2,     3,     4,     4,     1,     4,
     1,     1,     1,     1,     1
};

static const short yydefact[] = {     0,
     0,     0,     1,     5,    11,    12,    13,     0,     3,     0,
     8,     0,     0,     0,     0,     0,     4,    22,     0,     6,
    18,     9,    20,    10,     0,     0,    27,     0,     2,    23,
    24,     7,     0,     0,     0,     0,    29,    56,     0,     0,
    40,     0,     0,     0,    41,    43,    44,    45,    46,    48,
    47,    49,     5,    19,    21,     0,     0,     0,    28,     0,
     0,     0,     0,     0,     0,   101,   102,   103,   104,   105,
     0,     0,    99,     0,     0,     0,    61,    75,    83,    88,
    63,    39,    42,    25,     0,     0,     0,    37,    38,     0,
    32,     0,     0,     0,     0,    68,    71,     0,    55,    51,
     0,     0,     0,     0,    95,    94,     0,    80,    81,    82,
    77,    79,    78,     0,     0,    87,    85,    86,     0,    93,
    92,    91,    90,     0,     0,     3,     0,     0,     0,     0,
     0,    30,     0,    33,     0,     0,     0,    74,     0,     0,
     0,     0,     0,     0,     0,     0,    96,     0,    76,    84,
    89,     0,     0,     0,     0,     0,     0,    31,    35,    34,
    57,    59,     0,    72,    69,    54,    53,    52,    50,    97,
    98,   100,    62,    65,    26,    14,     0,     0,     0,     0,
     0,    73,     0,     0,    16,    15,     0,    36,     0,    66,
    64,    17,     0,    60,     0,     0,     0
};

static const short yydefgoto[] = {   195,
     4,    16,     9,    10,    11,    12,    13,    22,    24,    17,
    18,    53,   126,    19,    37,    59,    90,    91,   134,   160,
    92,    29,    44,    45,    46,   101,    47,    98,    48,    60,
    49,    61,   181,    50,   114,    51,   125,   184,    52,    62,
   139,    63,    96,   137,    77,   115,    78,   119,    79,   124,
    80
};

static const short yypact[] = {    19,
    25,     0,-32768,   171,-32768,-32768,-32768,    -6,    42,    11,
-32768,    50,    58,    12,    62,    66,    42,-32768,    34,   171,
-32768,    37,-32768,    47,    44,   100,-32768,   117,-32768,-32768,
-32768,-32768,    97,    98,    70,    72,    71,   146,    76,    79,
-32768,     1,     1,   135,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,   171,-32768,-32768,    13,    73,   -22,-32768,   112,
    90,    89,    95,     1,   132,-32768,-32768,-32768,-32768,-32768,
    93,   101,   106,     1,     1,     1,   150,    59,    68,-32768,
   150,-32768,-32768,-32768,   107,   160,    14,-32768,-32768,   -33,
-32768,    17,     1,     1,     1,-32768,-32768,    -8,   150,-32768,
    20,     1,     1,     1,-32768,-32768,    -5,-32768,-32768,-32768,
-32768,-32768,-32768,   123,     1,-32768,-32768,-32768,     1,-32768,
-32768,-32768,-32768,     1,   133,    42,   144,   122,   126,   177,
   -22,-32768,   175,-32768,   130,    -1,    31,   150,   136,     1,
   141,   183,   149,    36,    39,    86,-32768,    91,    59,    68,
-32768,   123,    66,    17,   178,   179,   147,-32768,-32768,   148,
-32768,-32768,     1,-32768,-32768,   150,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,    78,-32768,-32768,    17,    17,   180,   191,
   186,   150,   123,   169,-32768,-32768,    17,-32768,     1,   123,
-32768,-32768,   134,-32768,   206,   207,-32768
};

static const short yypgoto[] = {-32768,
-32768,    82,   156,-32768,   190,   -91,-32768,-32768,-32768,-32768,
   194,-32768,-32768,-32768,-32768,-32768,-32768,    81,-32768,-32768,
-32768,    60,  -111,   -42,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,   -43,-32768,    99,-32768,    96,-32768,
   -70
};


#define	YYLAST		215


static const short yytable[] = {    81,
   133,    83,   148,   105,   106,    66,    67,    68,    69,    70,
    71,    72,    73,   131,    88,    89,    25,    85,   129,   132,
    99,     1,   108,   109,   110,    74,   108,   109,   110,     5,
     6,     7,   107,   111,   112,   113,     2,   111,   112,   113,
   174,    14,   140,    75,   141,    15,     3,   147,   162,   135,
   136,   138,    76,   151,    26,    86,   130,    20,   144,   145,
   146,    21,   176,   108,   109,   110,   108,   109,   110,    23,
   142,   190,   143,    27,   111,   112,   113,   111,   112,   113,
    31,   163,   116,   164,    28,   185,   186,    33,   170,    38,
   120,   171,    35,    39,    40,   192,   166,    34,   121,   122,
   117,   118,    38,    42,    36,    83,    39,    40,    54,    55,
    43,   123,   183,   108,   109,   110,    42,   173,    56,   182,
    57,    87,    58,    43,   111,   112,   113,    64,    38,    93,
    65,    83,    39,    40,    38,   172,    41,    94,    39,    40,
    95,    97,    42,   100,   102,   193,    38,    83,    42,    43,
    39,    40,   103,   104,    82,    43,   127,   108,   109,   110,
    42,   108,   109,   110,   128,   154,   152,    43,   111,   112,
   113,   155,   111,   112,   113,   156,   161,   108,   109,   110,
   194,   157,   165,     5,     6,     7,   159,   167,   111,   112,
   113,     8,   -70,   -58,   168,   169,   179,   -67,   180,   177,
   178,   187,   188,   189,   191,   196,   197,   153,    84,    32,
    30,   158,   175,   149,   150
};

static const short yycheck[] = {    43,
    92,    44,   114,    74,    75,     5,     6,     7,     8,     9,
    10,    11,    12,    47,    37,    38,     5,     5,     5,    53,
    64,     3,    28,    29,    30,    25,    28,    29,    30,    13,
    14,    15,    76,    39,    40,    41,    12,    39,    40,    41,
   152,    48,    51,    43,    53,     4,    47,    53,    50,    93,
    94,    95,    52,   124,    43,    43,    43,    47,   102,   103,
   104,    12,   154,    28,    29,    30,    28,    29,    30,    12,
    51,   183,    53,    12,    39,    40,    41,    39,    40,    41,
    47,    51,    24,    53,    19,   177,   178,    51,    53,    12,
    23,    53,    49,    16,    17,   187,   140,    51,    31,    32,
    42,    43,    12,    26,     5,   148,    16,    17,    12,    12,
    33,    44,    35,    28,    29,    30,    26,    27,    49,   163,
    49,    49,    52,    33,    39,    40,    41,    52,    12,    18,
    52,   174,    16,    17,    12,    50,    20,    48,    16,    17,
    52,    47,    26,    12,    52,   189,    12,   190,    26,    33,
    16,    17,    52,    48,    20,    33,    50,    28,    29,    30,
    26,    28,    29,    30,     5,    22,    34,    33,    39,    40,
    41,    50,    39,    40,    41,    50,    47,    28,    29,    30,
    47,     5,    47,    13,    14,    15,    12,    47,    39,    40,
    41,    21,    47,    48,    12,    47,    50,    52,    51,    22,
    22,    22,    12,    18,    36,     0,     0,   126,    53,    20,
    17,   131,   153,   115,   119
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
#line 122 "pascual1.y"
{
    nivel = 0;
    ident = 0; /* XML */
    introducir_programa (tabsim, yyvsp[-1].paraID.nombre, 0); /* XML */
    printf("En inicio programa nivel %d (%d, %d)\n", nivel, lineno, linepos);
    /* mostrar_tabla(tabsim); /* depuracion */
    generar_inicio_programa(yyvsp[-1].paraID.nombre); /* XML */
    ident++; /* XML */
    generar_dec_var(ident); /* XML */
    ident++; /* XML */
  ;
    break;}
case 2:
#line 136 "pascual1.y"
{
    /* mostrar_tabla(tabsim); /* depuracion */
    printf("El programa en nivel %d (%d, %d)\n", nivel, lineno, linepos);
    eliminar_programa (tabsim); /* XML */
    cerrar_bloque();
    /* mostrar_tabla(tabsim); /* depuracion */
    generar_cierre_programa(yyvsp[-5].paraID.nombre); /* XML */
  ;
    break;}
case 3:
#line 147 "pascual1.y"
{
      /* XML */
      ident--;
      if (ident == 1) generar_cierre_dec_acc(ident);
    ;
    break;}
case 4:
#line 153 "pascual1.y"
{
      /* XML */
      ident--;
      if (ident == 1) generar_cierre_dec_acc(ident);
    ;
    break;}
case 5:
#line 161 "pascual1.y"
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
#line 173 "pascual1.y"
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
#line 193 "pascual1.y"
{ ; ;
    break;}
case 10:
#line 195 "pascual1.y"
{ ; ;
    break;}
case 11:
#line 199 "pascual1.y"
{ yyval.tipo = ENTERO;   ;
    break;}
case 12:
#line 200 "pascual1.y"
{ yyval.tipo = CHAR;     ;
    break;}
case 13:
#line 201 "pascual1.y"
{ yyval.tipo = BOOLEANO; ;
    break;}
case 14:
#line 206 "pascual1.y"
{
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         yyval.paraVector.tipo = VECTOR;
         yyval.paraVector.indiceInf = yyvsp[-6].constante;
         yyval.paraVector.indiceSup = yyvsp[-3].constante;
         yyval.paraVector.dimension = yyvsp[-3].constante - yyvsp[-6].constante + 1;
         yyval.paraVector.tipo_componentes = yyvsp[0].tipo;
       ;
    break;}
case 15:
#line 216 "pascual1.y"
{
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         yyval.paraVector.tipo = VECTOR;
         yyval.paraVector.indiceInf = yyvsp[-6].constante;
         yyval.paraVector.indiceSup = yyvsp[-3].constante;
         yyval.paraVector.dimension = yyvsp[-3].constante - yyvsp[-6].constante + 1;
         yyval.paraVector.tipo_componentes = yyvsp[0].tipo;
       ;
    break;}
case 16:
#line 226 "pascual1.y"
{
          sprintf(errorBuf, "Los indices del vector son incorrectos");
          error_semantico(errorBuf);
       ;
    break;}
case 17:
#line 231 "pascual1.y"
{
         /* Almacenamos la informacion del vector: tipo de sus componentes,
	    indices, tamaño y que es vector. */
         yyval.paraVector.tipo = VECTOR;
         yyval.paraVector.indiceInf = yyvsp[-7].constante;
         yyval.paraVector.indiceSup = yyvsp[-3].constante;
         yyval.paraVector.dimension = yyvsp[-3].constante - yyvsp[-7].constante + 1;
         yyval.paraVector.tipo_componentes = yyvsp[0].tipo;
       ;
    break;}
case 18:
#line 245 "pascual1.y"
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
       /* sprintf(errorBuf, "Identificador %s duplicado", $1.nombre); */
       error_semantico(errorBuf);
     }
   ;
    break;}
case 19:
#line 279 "pascual1.y"
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
       /* sprintf(errorBuf, "Identificador %s duplicado", $3.nombre); */
       error_semantico(errorBuf);
     }
   ;
    break;}
case 20:
#line 316 "pascual1.y"
{
     if (yyvsp[-1].paraVector.indiceInf > yyvsp[-1].paraVector.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son incorrectos", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if (yyvsp[-1].paraVector.indiceInf == yyvsp[-1].paraVector.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son iguales", yyvsp[0].paraID.nombre);
       warning(errorBuf);
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
       /* sprintf(errorBuf, "Identificador %s duplicado", $1.nombre); */
       error_semantico(errorBuf);
     }
   ;
    break;}
case 21:
#line 363 "pascual1.y"
{
     if (yyvsp[-3].paraVector.indiceInf > yyvsp[-3].paraVector.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son incorrectos", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if (yyvsp[-3].paraVector.indiceInf == yyvsp[-3].paraVector.indiceSup)
     {
       sprintf(errorBuf, "Los indices del vector %s son iguales", yyvsp[0].paraID.nombre);
       warning(errorBuf);
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
       /* sprintf(errorBuf, "Identificador %s duplicado", $3.nombre); */
       error_semantico(errorBuf);
     }
   ;
    break;}
case 24:
#line 417 "pascual1.y"
{ ident++; /* XML */;
    break;}
case 25:
#line 419 "pascual1.y"
{ ident++; /* XML */;
    break;}
case 26:
#line 422 "pascual1.y"
{
     generar_cierre_acc(ident); /* XML */
     /* mostrar_tabla (tabsim); /* depuracion */
     cerrar_bloque();
     /* mostrar_tabla (tabsim); /* depuracion */
   ;
    break;}
case 27:
#line 432 "pascual1.y"
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
     /* mostrar_tabla(tabsim); /* depuracion */
     abrir_bloque();
     /* mostrar_tabla(tabsim); /* depuracion */
     ident++; /* XML */
   ;
    break;}
case 28:
#line 473 "pascual1.y"
{
     if (yyvsp[-1].simbolo != NULL)
     {
       /* Almacenamos los parametros de la accion en la TS */
       yyvsp[-1].simbolo->parametros = yyvsp[0].lista; 
     }
   ;
    break;}
case 29:
#line 484 "pascual1.y"
{ 
       crear_vacia(&(yyval.lista)); /* No hay parametros formales en la accion */
       generar_dec_var(ident); /* XML */
     ;
    break;}
case 30:
#line 489 "pascual1.y"
{ 
       yyval.lista = yyvsp[-1].lista; 
       generar_dec_var(ident);  /* XML */
     ;
    break;}
case 31:
#line 497 "pascual1.y"
{
     concatenar(&(yyvsp[-2].lista), yyvsp[0].lista);
     yyval.lista = yyvsp[-2].lista;
   ;
    break;}
case 32:
#line 501 "pascual1.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 33:
#line 506 "pascual1.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 34:
#line 511 "pascual1.y"
{ yyval.lista = yyvsp[0].lista; ;
    break;}
case 35:
#line 516 "pascual1.y"
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
#line 529 "pascual1.y"
{
       if ((yyvsp[0].paraID.simbolo == NULL) || (yyvsp[0].paraID.simbolo->nivel != nivel))
       {
         crear_unitaria(&(yyval.lista), (introducir_parametro (tabsim, yyvsp[0].paraID.nombre, yyvsp[-3].tipo, yyvsp[-4].clase, nivel, 0)));
         concatenar(&(yyvsp[-2].lista), yyval.lista);
         /* Las 2 formas funcionan (y creo que son equivalentes pero no seguro) */
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
#line 547 "pascual1.y"
{ yyval.clase = VAL; ;
    break;}
case 38:
#line 548 "pascual1.y"
{ yyval.clase = REF; ;
    break;}
case 51:
#line 578 "pascual1.y"
{
     /* Comprobamos que esta declarado y es entero o caracter o booleano? */
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
       else if ((yyvsp[0].paraID.simbolo->variable != ENTERO) && (yyvsp[0].paraID.simbolo->variable != CHAR))
       {
         sprintf(errorBuf, "Identificador %s debe ser de tipo entero o caracter", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
     }
   ;
    break;}
case 52:
#line 600 "pascual1.y"
{
     /* Comprobamos que esta declarado y es entero o caracter o booleano? */
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
       else if ((yyvsp[0].paraID.simbolo->variable != ENTERO) && (yyvsp[0].paraID.simbolo->variable != CHAR))
       {
         sprintf(errorBuf, "Identificador %s debe ser de tipo entero o caracter", yyvsp[0].paraID.nombre);
         error_semantico(errorBuf);
       }
     }
   ;
    break;}
case 54:
#line 630 "pascual1.y"
{
    /* Comprobar que no es booleano ni vector ni desconocido */
    if ((yyvsp[0].paraExp.tipo == DESCONOCIDO) || (yyvsp[0].paraExp.tipo == BOOLEANO) || (yyvsp[0].paraExp.tipo == VECTOR))
    {
      sprintf(errorBuf, "Argumento en escribir es de tipo incorrecto");
      error_semantico(errorBuf);
    }
  ;
    break;}
case 55:
#line 639 "pascual1.y"
{
    /* Comprobar que no es booleano ni vector ni desconocido */
    if ((yyvsp[0].paraExp.tipo == DESCONOCIDO) || (yyvsp[0].paraExp.tipo == BOOLEANO) || (yyvsp[0].paraExp.tipo == VECTOR))
    {
      sprintf(errorBuf, "Argumento en escribir es de tipo incorrecto");
      error_semantico(errorBuf);
    }
  ;
    break;}
case 56:
#line 651 "pascual1.y"
{
     yyval.ok = FALSE;
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
     /* else if (($1.simbolo->tipo == PARAMETRO) && ($1.simbolo->parametro != REF))
       error_semantico("id debe ser parametro por referencia."); -> No, enunciado.pc */
     else yyval.ok = TRUE;
   ;
    break;}
case 57:
#line 669 "pascual1.y"
{
     if ((yyvsp[-3].ok) && (yyvsp[-4].paraID.simbolo->variable == VECTOR) && (yyvsp[-1].paraExp.simbolo != NULL) && (yyvsp[-1].paraExp.simbolo->variable == VECTOR) &&
         (yyvsp[-4].paraID.simbolo->dimension != yyvsp[-1].paraExp.simbolo->dimension))
     {
       sprintf(errorBuf, "En la asignacion directa de vectores el tamaño de ambos vectores no coincide");
       error_semantico(errorBuf);
     }     
     if ((yyvsp[-3].ok) && (yyvsp[-4].paraID.simbolo->variable == VECTOR) && (yyvsp[-1].paraExp.simbolo != NULL) && (yyvsp[-1].paraExp.simbolo->variable == VECTOR) &&
         (yyvsp[-4].paraID.simbolo->tipo_componentes != yyvsp[-1].paraExp.simbolo->tipo_componentes))
     {
       sprintf(errorBuf, "En la asignacion directa de vectores el tipo de las componentes de ambos vectores no coincide");
       error_semantico(errorBuf);
     }
     /* if (($<ok>2) && ( ($1.simbolo->variable == VECTOR) && ($4.simbolo != NULL) && ($4.simbolo->variable != VECTOR) |
                       ($4.simbolo->variable != VECTOR) && ($4.simbolo != NULL) && ($1.simbolo->variable == VECTOR)))
     {
       sprintf(errorBuf, "Tipos incompatibles en la asignacion");
       error_semantico(errorBuf);
     }		       
     if (($<ok>2) && ($1.simbolo->variable != VECTOR) && ($4.tipo != DESCONOCIDO) && ($1.simbolo->variable != $4.tipo))
     {
       sprintf(errorBuf, "Tipos incompatibles en la asignacion");
       error_semantico(errorBuf);
     } */
     if ((yyvsp[-3].ok) && (yyvsp[-1].paraExp.tipo != DESCONOCIDO) && (yyvsp[-4].paraID.simbolo->variable != yyvsp[-1].paraExp.tipo))
     {
       sprintf(errorBuf, "Tipos incompatibles en la asignacion");
       error_semantico(errorBuf);
     }
   ;
    break;}
case 58:
#line 703 "pascual1.y"
{
        yyval.ok = FALSE;
        if (yyvsp[0].paraID.simbolo == NULL)
	{
	  sprintf(errorBuf, "Identificador %s no encontrado", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else if (yyvsp[0].paraID.simbolo->tipo != VARIABLE)
	{
	  sprintf(errorBuf, "El identificador %s debe ser variable", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else if ((yyvsp[0].paraID.simbolo->variable != VECTOR) && (yyvsp[0].paraID.simbolo->variable != DESCONOCIDO))
	{
	  sprintf(errorBuf, "El identificador %s debe ser vector", yyvsp[0].paraID.nombre);
          error_semantico(errorBuf);
	}
        else yyval.ok = TRUE;
      ;
    break;}
case 59:
#line 723 "pascual1.y"
{
        if ((yyvsp[-3].ok) && (yyvsp[-1].paraExp.tipo != ENTERO) && (yyvsp[-1].paraExp.tipo != DESCONOCIDO))
	{
	  sprintf(errorBuf, "El indice del vector %s debe ser de tipo entero", yyvsp[-4].paraID.nombre);
          error_semantico(errorBuf);
	}
         /*  Pensar lo de decir que no existe esta componente del vector */
      ;
    break;}
case 60:
#line 732 "pascual1.y"
{
        if ((yyvsp[-7].ok) && (yyvsp[-1].paraExp.tipo != DESCONOCIDO) && (yyvsp[-1].paraExp.tipo == VECTOR) && (yyvsp[-8].paraID.simbolo->tipo_componentes !=
	                 yyvsp[-1].paraExp.simbolo->tipo_componentes))
	{
	  sprintf(errorBuf, "Tipos incompatibles en la asignacion");
          error_semantico(errorBuf);
	}
	else if ((yyvsp[-7].ok) && (yyvsp[-1].paraExp.tipo != DESCONOCIDO) && (yyvsp[-1].paraExp.tipo != VECTOR) && (yyvsp[-8].paraID.simbolo->tipo_componentes != yyvsp[-1].paraExp.tipo))
	{
	  sprintf(errorBuf, "Tipos incompatibles en la asignacion");
          error_semantico(errorBuf);
	}
      ;
    break;}
case 61:
#line 751 "pascual1.y"
{
    if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
    {
      error_semantico("Mq: condicion invalida.");
    }
  ;
    break;}
case 63:
#line 764 "pascual1.y"
{
    if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
    {
      error_semantico("Seleccion: condicion invalida.");
    }
  ;
    break;}
case 67:
#line 784 "pascual1.y"
{
     yyval.ok = FALSE;
     if (yyvsp[0].paraID.simbolo == NULL)
     {  
       sprintf(errorBuf, "Accion %s no encontrada", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if (yyvsp[0].paraID.simbolo->tipo != ACCION)
     {
       sprintf(errorBuf, "%s no es una accion", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else yyval.ok = TRUE;
   ;
    break;}
case 68:
#line 799 "pascual1.y"
{ 
     if ((yyvsp[-1].ok) && (yyvsp[-2].paraID.simbolo->parametros.elementos != yyvsp[0].constante))
     {
       sprintf(errorBuf, "Numero de argumentos en la accion %s incorrecto", yyvsp[-2].paraID.nombre);
       error_semantico(errorBuf);
     }
       /* Especificar si sobran o faltan */
   ;
    break;}
case 70:
#line 809 "pascual1.y"
{
     yyval.ok = FALSE;
     if (yyvsp[0].paraID.simbolo == NULL)
     {
       sprintf(errorBuf, "Accion %s no encontrada", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);  
     }
     else if (yyvsp[0].paraID.simbolo->tipo != ACCION)
     {
       sprintf(errorBuf, "%s no es una accion", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf);
     }
     else if ((yyvsp[0].paraID.simbolo->tipo == ACCION) && (yyvsp[0].paraID.simbolo->parametros.elementos != 0))
     {
       sprintf(errorBuf, "Numero de argumentos en la accion %s incorrecto", yyvsp[0].paraID.nombre);
       error_semantico(errorBuf); 
     }
     else yyval.ok = TRUE;
   ;
    break;}
case 72:
#line 833 "pascual1.y"
{ yyval.constante = yyvsp[-1].constante; ;
    break;}
case 73:
#line 838 "pascual1.y"
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
                                 solo pueden ser variables */
	   sprintf(errorBuf, "El argumento numero %d debe ser una variable o parametro por referencia", yyvsp[-2].constante+1);		      
           error_semantico(errorBuf);
         }	 
       }
       yyval.constante = yyvsp[-2].constante + 1; /* Para contar el numero de argumentos en la invocacion a la accion */
     }
   ;
    break;}
case 74:
#line 875 "pascual1.y"
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
	   sprintf(errorBuf, "Los tipos del parametro y el argumento no coinciden");
           error_semantico(errorBuf);
         } 
         if (((*p).parametro == REF) && (yyvsp[0].paraExp.esVariable != TRUE))
         {  /* Verificamos clase: los argumentos a parametros por referencia
                                 solo pueden ser variables */
	   sprintf(errorBuf, "El argumento debe ser una variable");		      
           error_semantico(errorBuf);
         }
       }
	 
       yyval.constante = 1; /* Numero de argumentos: Solo hay uno */
     }
   ;
    break;}
case 75:
#line 914 "pascual1.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 76:
#line 918 "pascual1.y"
{
     yyval.paraExp.tipo = BOOLEANO;
     if ((yyvsp[-2].paraExp.tipo != DESCONOCIDO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO) && (yyvsp[-2].paraExp.tipo != yyvsp[0].paraExp.tipo))
     { 
       yyval.paraExp.tipo = DESCONOCIDO;
       error_semantico("Los operandos deben ser de igual tipo");
     }
     else if ((yyvsp[-2].paraExp.tipo == CADENA) || (yyvsp[0].paraExp.tipo == CADENA))
     {
       yyval.paraExp.tipo = DESCONOCIDO;
       error_semantico("Los operandos no pueden ser de tipo cadena");
     }
   ;
    break;}
case 83:
#line 944 "pascual1.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 84:
#line 948 "pascual1.y"
{
     if (yyvsp[-1].constante == tOR)
     {
       yyval.paraExp.tipo = BOOLEANO;
       if ((yyvsp[-2].paraExp.tipo != BOOLEANO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser booleano");
       }
       if ((yyvsp[0].paraExp.tipo != BOOLEANO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser booleano");
       }
     }
     else /* operador_aditivo es '+' o '-' */
     {
       yyval.paraExp.tipo = ENTERO;
       if ((yyvsp[-2].paraExp.tipo != ENTERO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if ((yyvsp[0].paraExp.tipo != ENTERO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero");
       }
     }
   ;
    break;}
case 85:
#line 977 "pascual1.y"
{ yyval.constante = '+'; ;
    break;}
case 86:
#line 978 "pascual1.y"
{ yyval.constante = '-'; ;
    break;}
case 87:
#line 979 "pascual1.y"
{ yyval.constante = tOR; ;
    break;}
case 88:
#line 984 "pascual1.y"
{
     yyval.paraExp = yyvsp[0].paraExp;
   ;
    break;}
case 89:
#line 988 "pascual1.y"
{
     if ((yyvsp[-1].constante == '*') || (yyvsp[-1].constante == tDIV) || (yyvsp[-1].constante == tMOD))
     {
       yyval.paraExp.tipo = ENTERO;
       if ((yyvsp[-2].paraExp.tipo != ENTERO) && (yyvsp[-2].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 1 debe ser entero");
       }
       if ((yyvsp[0].paraExp.tipo != ENTERO) && (yyvsp[0].paraExp.tipo != DESCONOCIDO))
       {
         error_semantico("Operando 2 debe ser entero.");
       }
     }
     else /* operador_multiplicativo es AND */
     {
       yyval.paraExp.tipo = BOOLEANO;
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
case 90:
#line 1017 "pascual1.y"
{ yyval.constante = '*'; ;
    break;}
case 91:
#line 1018 "pascual1.y"
{ yyval.constante = tDIV; ;
    break;}
case 92:
#line 1019 "pascual1.y"
{ yyval.constante = tMOD; ;
    break;}
case 93:
#line 1020 "pascual1.y"
{ yyval.constante = tAND; ;
    break;}
case 94:
#line 1025 "pascual1.y"
{
      yyval.paraExp.tipo = ENTERO;
      if (yyvsp[0].paraExp.tipo != ENTERO)
      {
        error_semantico("Argumento de - unario debe ser entero");
      }
    ;
    break;}
case 95:
#line 1033 "pascual1.y"
{
      yyval.paraExp.tipo = BOOLEANO;
      if (yyvsp[0].paraExp.tipo != BOOLEANO)
      {
        error_semantico("Argumento de not debe ser booleano");
      }
    ;
    break;}
case 96:
#line 1040 "pascual1.y"
{ yyval.paraExp = yyvsp[-1].paraExp; ;
    break;}
case 97:
#line 1042 "pascual1.y"
{
      yyval.paraExp.tipo = CHAR;
      if (yyvsp[-1].paraExp.tipo != ENTERO)
      {
        error_semantico("Argumento de entacar debe ser entero");
      }
    ;
    break;}
case 98:
#line 1050 "pascual1.y"
{
      yyval.paraExp.tipo = ENTERO;
      if (yyvsp[-1].paraExp.tipo != CHAR)
      {
        error_semantico("Argumento de caraent debe ser caracter");
      }
    ;
    break;}
case 99:
#line 1058 "pascual1.y"
{
      yyval.paraExp.tipo = DESCONOCIDO; yyval.paraExp.esVariable = FALSE;
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
      else if ((yyvsp[0].paraID.simbolo->tipo == VARIABLE) && (yyvsp[0].paraID.simbolo->variable == VECTOR))
      {
        /* Si es un vector, devolvemos en tipo el tipo de las componentes */
	yyval.paraExp.simbolo = yyvsp[0].paraID.simbolo;
	yyval.paraExp.esVariable = TRUE;
        yyval.paraExp.tipo = yyvsp[0].paraID.simbolo->variable;
      }
      else if (yyvsp[0].paraID.simbolo->tipo == VARIABLE)
      {
        yyval.paraExp.simbolo = yyvsp[0].paraID.simbolo;
	yyval.paraExp.esVariable = TRUE;
        yyval.paraExp.tipo = yyvsp[0].paraID.simbolo->variable; 
      }
      else /* Es parametro */
      {  
        yyval.paraExp.simbolo = yyvsp[0].paraID.simbolo; 
	yyval.paraExp.esVariable = FALSE;
	yyval.paraExp.tipo = yyvsp[0].paraID.simbolo->variable;
	if (yyvsp[0].paraID.simbolo->parametro == REF) yyval.paraExp.esParametroRef = TRUE;
	else yyval.paraExp.esParametroRef = FALSE;
      }
    ;
    break;}
case 100:
#line 1093 "pascual1.y"
{
      yyval.paraExp.tipo = DESCONOCIDO; yyval.paraExp.esVariable = FALSE;
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
      else 
      { 
        yyval.paraExp.esVariable = TRUE; 
	yyval.paraExp.simbolo = yyvsp[-3].paraID.simbolo; 
	/* ATENCION, CAMBIO ESTO, HAGO QUE SEA EL TIPO DEL VECTOR */
	yyval.paraExp.tipo = yyvsp[-3].paraID.simbolo->tipo_componentes;
      }
      warning("El indice del vector puede no existir");
    ;
    break;}
case 101:
#line 1122 "pascual1.y"
{ 
       yyval.paraExp.tipo = ENTERO;   
       yyval.paraExp.esConstante = TRUE;
       yyval.paraExp.valorConstante = yyvsp[0].constante;
     ;
    break;}
case 102:
#line 1128 "pascual1.y"
{ 
       yyval.paraExp.tipo = CHAR;     
     ;
    break;}
case 103:
#line 1132 "pascual1.y"
{ 
       yyval.paraExp.tipo = CADENA;   
     ;
    break;}
case 104:
#line 1136 "pascual1.y"
{ 
       yyval.paraExp.tipo = BOOLEANO; 
     ;
    break;}
case 105:
#line 1140 "pascual1.y"
{ 
       yyval.paraExp.tipo = BOOLEANO; 
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
#line 1146 "pascual1.y"


/**********************************************************************/
main(int argc, char *argv[])
/**********************************************************************/
{

   if (argc != 2)
   {
     fprintf (stderr, "Numero de argumentos incorrecto\n");
     fprintf (stderr, "Uso: pascual1 fuente (sin la extension .pc)\n");
     exit (-1);
   }

   strcpy (namein, argv[1]);
   strcat (namein, ".pc");
   yyin = fopen (namein, "r");
   if (yyin == NULL) {
      fprintf (stderr, "Fichero %s no existe.\n", namein);
      exit (1);
   }

   inicializar_tabla (tabsim);
   strcpy (nameout, argv[1]);
   strcat (nameout, ".xml");
   yyout = fopen (nameout, "w");
   printf ("Antes de yyparse\n");
   yyparse ();
   printf ("Despues de yyparse\n");

   if (error)
   {
     remove (nameout);
     fprintf (stderr, "ATENCION! Ha habido errores y NO se ha generado el fichero %s\n", nameout);
   }
   fclose (yyout);
   fclose (yyin);
}


/*  A Bison parser, made from codigop.y
    by GNU Bison version 1.28  */

#define YYBISON 1  /* Identify Bison output.  */

#define	TAND	257
#define	TASG	258
#define	TASGI	259
#define	TCSF	260
#define	TDIV	261
#define	TDRF	262
#define	TDUP	263
#define	TENP	264
#define	TEQ	265
#define	TGT	266
#define	TGTE	267
#define	TJMF	268
#define	TJMP	269
#define	TJMT	270
#define	TLT	271
#define	TLTE	272
#define	TLVP	273
#define	TPOP	274
#define	TMOD	275
#define	TNEQ	276
#define	TNGB	277
#define	TNGI	278
#define	TNOP	279
#define	TOR	280
#define	TOSF	281
#define	TPLUS	282
#define	TRD	283
#define	TSBT	284
#define	TSRF	285
#define	TSTC	286
#define	TTMS	287
#define	TSWP	288
#define	TWRT	289
#define	TCONSTENT	290
#define	TCONSTCHAR	291
#define	TETIQUETA	292

#line 1 "codigop.y"

/**********************************************************************
* Practicas de Compiladores II, 2008/2009
* Fichero: codigop.y
*          Analizador sintatico y semantico de codigo P
* autor: Marcos Mainar Lalmolda
* modificaciones realizadas: completado de la gramatica y las acciones.
* fecha: 19-MAR-09
**********************************************************************/

#include <stdio.h>
#include "codigop.h"
#include "p1.h"

extern char yytext[];
extern int lineno, linepos;

#line 19 "codigop.y"
typedef union{
   int constante;
   char *identificador;
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



#define	YYFINAL		106
#define	YYFLAG		-32768
#define	YYNTBASE	40

#define YYTRANSLATE(x) ((unsigned)(x) <= 292 ? yytranslate[x] : 85)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,    39,     2,     2,
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
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     3,     4,     5,     6,
     7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
    17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
    27,    28,    29,    30,    31,    32,    33,    34,    35,    36,
    37,    38
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     5,     9,    13,    16,    20,    23,    26,    29,    31,
    34,    37,    41,    43,    46,    48,    51,    54,    57,    61,
    66,    71,    73,    75,    77,    79,    81,    83,    85,    87,
    89,    91,    93,    95,    97,    99,   101,   103,   105,   107,
   109,   111,   113,   115,   117,   119,   121,   123,   125,   127,
   129,   131,   133,   135,   137,   139,   141,   143,   145,   147,
   149,   151,   153,   155,   157,   159,   161,   163,   165,   167,
   169,   171,   173,   175,   177,   179,   181,   183,   185,   187,
   189,   191,   193,   195,   197,   199,   201,   203,   205
};

static const short yyrhs[] = {    41,
    42,    43,    44,     0,    41,    42,    44,     0,    42,    43,
    44,     0,    42,    44,     0,    41,    38,    39,     0,    38,
    39,     0,    59,    36,     0,    59,    38,     0,    45,     0,
    41,    45,     0,    43,    45,     0,    43,    41,    45,     0,
    68,     0,    41,    68,     0,    46,     0,    47,    36,     0,
    48,    37,     0,    49,    38,     0,    50,    36,    36,     0,
    51,    36,    36,    36,     0,    51,    36,    36,    38,     0,
    52,     0,    53,     0,    54,     0,    55,     0,    57,     0,
    60,     0,    61,     0,    62,     0,    56,     0,    69,     0,
    75,     0,    66,     0,    67,     0,    70,     0,    71,     0,
    72,     0,    74,     0,    79,     0,    82,     0,    73,     0,
    58,     0,    77,     0,    84,     0,    63,     0,    64,     0,
    65,     0,    81,     0,    78,     0,    83,     0,    81,     0,
    63,     0,    64,     0,    65,     0,    80,     0,    76,     0,
     3,     0,     4,     0,     5,     0,     6,     0,     7,     0,
     8,     0,     9,     0,    10,     0,    11,     0,    12,     0,
    13,     0,    14,     0,    15,     0,    16,     0,    17,     0,
    18,     0,    19,     0,    21,     0,    22,     0,    23,     0,
    24,     0,    25,     0,    28,     0,    26,     0,    27,     0,
    20,     0,    29,     0,    30,     0,    31,     0,    32,     0,
    33,     0,    35,     0,    34,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
    45,    46,    47,    48,    51,    53,    56,    60,    66,    67,
    68,    69,    72,    73,    79,    83,    87,    91,    95,    99,
   103,   108,   109,   110,   111,   112,   113,   114,   115,   116,
   117,   118,   119,   120,   121,   122,   123,   124,   125,   126,
   127,   128,   129,   130,   133,   134,   135,   136,   137,   138,
   141,   144,   145,   146,   149,   152,   155,   156,   157,   158,
   159,   160,   161,   162,   163,   164,   165,   166,   167,   168,
   169,   170,   171,   172,   173,   174,   175,   176,   177,   178,
   179,   180,   181,   182,   183,   184,   185,   186,   187
};
#endif


#if YYDEBUG != 0 || defined (YYERROR_VERBOSE)

static const char * const yytname[] = {   "$","error","$undefined.","TAND","TASG",
"TASGI","TCSF","TDIV","TDRF","TDUP","TENP","TEQ","TGT","TGTE","TJMF","TJMP",
"TJMT","TLT","TLTE","TLVP","TPOP","TMOD","TNEQ","TNGB","TNGI","TNOP","TOR","TOSF",
"TPLUS","TRD","TSBT","TSRF","TSTC","TTMS","TSWP","TWRT","TCONSTENT","TCONSTCHAR",
"TETIQUETA","':'","programa","etiq","instInicio","cuerpoProg","instFin","instruccion",
"sin_argumentos","un_argumento_entero","un_argumento_caracter","un_argumento_etiqueta",
"dos_argumentos","tres_argumentos","logical_and","assign","assign_inverse","close_stack_frame",
"integer_div","dereference","duplicate","enter_program","equals","greater_than",
"greater_equal","jump_if_false","jump","jump_if_true","less_than","less_equal",
"leave_program","integer_mod","not_equal_to","negate_boolean","negate_integer",
"nop","integer_add","logical_or","open_stack_frame","stack_pop","read","integer_substract",
"set_reference","store_constant","integer_product","write","swap", NULL
};
#endif

static const short yyr1[] = {     0,
    40,    40,    40,    40,    41,    41,    42,    42,    43,    43,
    43,    43,    44,    44,    45,    45,    45,    45,    45,    45,
    45,    46,    46,    46,    46,    46,    46,    46,    46,    46,
    46,    46,    46,    46,    46,    46,    46,    46,    46,    46,
    46,    46,    46,    46,    47,    47,    47,    47,    47,    47,
    48,    49,    49,    49,    50,    51,    52,    53,    54,    55,
    56,    57,    58,    59,    60,    61,    62,    63,    64,    65,
    66,    67,    68,    69,    70,    71,    72,    73,    74,    75,
    76,    77,    78,    79,    80,    81,    82,    83,    84
};

static const short yyr2[] = {     0,
     4,     3,     3,     2,     3,     2,     2,     2,     1,     2,
     2,     3,     1,     2,     1,     2,     2,     2,     3,     4,
     4,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1
};

static const short yydefact[] = {     0,
    64,     0,     0,     0,     0,     6,     0,     0,    57,    58,
    59,    60,    61,    62,    63,    65,    66,    67,    68,    69,
    70,    71,    72,    73,    82,    74,    75,    76,    77,    78,
    80,    81,    79,    83,    84,    85,    86,    87,    89,    88,
     0,     0,     4,     9,    15,     0,     0,     0,     0,     0,
    22,    23,    24,    25,    30,    26,    42,    27,    28,    29,
    45,    46,    47,    33,    34,    13,    31,    35,    36,    37,
    41,    38,    32,    56,    43,    49,    39,    55,    48,    40,
    50,    44,     7,     8,     5,     0,     2,    10,    14,     0,
     3,    11,    16,    17,    18,     0,     0,     1,    12,    19,
     0,    20,    21,     0,     0,     0
};

static const short yydefgoto[] = {   104,
    41,     4,    42,    43,    44,    45,    46,    47,    48,    49,
    50,    51,    52,    53,    54,    55,    56,    57,     5,    58,
    59,    60,    61,    62,    63,    64,    65,    66,    67,    68,
    69,    70,    71,    72,    73,    74,    75,    76,    77,    78,
    79,    80,    81,    82
};

static const short yypact[] = {    -5,
-32768,   -27,    -4,    84,   -29,-32768,   -26,    84,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
   120,    84,-32768,-32768,-32768,   -25,   -23,   -22,   -21,   -19,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
   -20,   -18,   -17,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,   -15,-32768,
-32768,-32768,-32768,-32768,-32768,    84,-32768,-32768,-32768,   120,
-32768,-32768,-32768,-32768,-32768,   -13,   -12,-32768,-32768,-32768,
   -28,-32768,-32768,    19,    25,-32768
};

static const short yypgoto[] = {-32768,
     0,    23,    20,    -7,   -39,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,   -37,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768
};


#define	YYLAST		158


static const short yytable[] = {     3,
    87,    88,    92,    89,     1,     1,    83,   102,    84,   103,
    93,     6,    85,    94,    96,    95,    97,   -52,   105,   -53,
   -54,   -51,   100,   101,   106,     8,     0,    86,     0,     0,
     0,     0,     2,     7,    91,     0,     0,     0,     0,     0,
     0,    90,     0,     0,     0,     0,    92,     0,     0,     0,
    99,     0,    89,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,    98,     0,
     0,     0,     0,     0,     0,    90,     9,    10,    11,    12,
    13,    14,    15,     0,    16,    17,    18,    19,    20,    21,
    22,    23,    24,    25,    26,    27,    28,    29,    30,    31,
    32,    33,    34,    35,    36,    37,    38,    39,    40,     0,
     0,     2,     9,    10,    11,    12,    13,    14,    15,     0,
    16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
    26,    27,    28,    29,    30,    31,    32,    33,    34,    35,
    36,    37,    38,    39,    40,     0,     0,     7
};

static const short yycheck[] = {     0,
     8,    41,    42,    41,    10,    10,    36,    36,    38,    38,
    36,    39,    39,    37,    36,    38,    36,    38,     0,    38,
    38,    37,    36,    36,     0,     3,    -1,     8,    -1,    -1,
    -1,    -1,    38,    38,    42,    -1,    -1,    -1,    -1,    -1,
    -1,    42,    -1,    -1,    -1,    -1,    86,    -1,    -1,    -1,
    90,    -1,    90,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    86,    -1,
    -1,    -1,    -1,    -1,    -1,    86,     3,     4,     5,     6,
     7,     8,     9,    -1,    11,    12,    13,    14,    15,    16,
    17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
    27,    28,    29,    30,    31,    32,    33,    34,    35,    -1,
    -1,    38,     3,     4,     5,     6,     7,     8,     9,    -1,
    11,    12,    13,    14,    15,    16,    17,    18,    19,    20,
    21,    22,    23,    24,    25,    26,    27,    28,    29,    30,
    31,    32,    33,    34,    35,    -1,    -1,    38
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

case 5:
#line 52 "codigop.y"
{ agregar_etiqueta(yyvsp[-1].identificador); ;
    break;}
case 6:
#line 53 "codigop.y"
{ agregar_etiqueta(yyvsp[-1].identificador); ;
    break;}
case 7:
#line 57 "codigop.y"
{ 
	     tratar_instruccion_con_1_argumento(yyvsp[-1].constante, yyvsp[0].constante); 
	   ;
    break;}
case 8:
#line 61 "codigop.y"
{ 
	     tratar_instruccion_con_1_argumento(yyvsp[-1].constante, referencia(yyvsp[0].identificador)); 
	   ;
    break;}
case 13:
#line 72 "codigop.y"
{ tratar_instruccion_sin_argumentos(yyvsp[0].constante); ;
    break;}
case 14:
#line 74 "codigop.y"
{ 
	    tratar_instruccion_sin_argumentos(yyvsp[0].constante);
	  ;
    break;}
case 15:
#line 80 "codigop.y"
{ 
              tratar_instruccion_sin_argumentos(yyvsp[0].constante);
            ;
    break;}
case 16:
#line 84 "codigop.y"
{ 
	      tratar_instruccion_con_1_argumento(yyvsp[-1].constante, yyvsp[0].constante);
	    ;
    break;}
case 17:
#line 88 "codigop.y"
{
	      tratar_instruccion_con_1_argumento(yyvsp[-1].constante, yyvsp[0].constante);
	    ;
    break;}
case 18:
#line 92 "codigop.y"
{
	      tratar_instruccion_con_1_argumento(yyvsp[-1].constante, referencia(yyvsp[0].identificador));
	    ;
    break;}
case 19:
#line 96 "codigop.y"
{
	       tratar_instruccion_con_2_argumentos(yyvsp[-2].constante, yyvsp[-1].constante, yyvsp[0].constante);
	    ;
    break;}
case 20:
#line 100 "codigop.y"
{
	       tratar_instruccion_con_3_argumentos(yyvsp[-3].constante, yyvsp[-2].constante, yyvsp[-1].constante, yyvsp[0].constante);
	    ;
    break;}
case 21:
#line 104 "codigop.y"
{
	      tratar_instruccion_con_3_argumentos(yyvsp[-3].constante, yyvsp[-2].constante, yyvsp[-1].constante, referencia(yyvsp[0].identificador));
	    ;
    break;}
case 57:
#line 155 "codigop.y"
{ yyval.constante = AND; ;
    break;}
case 58:
#line 156 "codigop.y"
{ yyval.constante = ASG; ;
    break;}
case 59:
#line 157 "codigop.y"
{ yyval.constante = ASGI; ;
    break;}
case 60:
#line 158 "codigop.y"
{ yyval.constante = CSF; ;
    break;}
case 61:
#line 159 "codigop.y"
{ yyval.constante = DIV; ;
    break;}
case 62:
#line 160 "codigop.y"
{ yyval.constante = DRF; ;
    break;}
case 63:
#line 161 "codigop.y"
{ yyval.constante = DUP; ;
    break;}
case 64:
#line 162 "codigop.y"
{ yyval.constante = ENP; ;
    break;}
case 65:
#line 163 "codigop.y"
{ yyval.constante = EQ; ;
    break;}
case 66:
#line 164 "codigop.y"
{ yyval.constante = GT; ;
    break;}
case 67:
#line 165 "codigop.y"
{ yyval.constante = GTE; ;
    break;}
case 68:
#line 166 "codigop.y"
{ yyval.constante = JMF; ;
    break;}
case 69:
#line 167 "codigop.y"
{ yyval.constante = JMP; ;
    break;}
case 70:
#line 168 "codigop.y"
{ yyval.constante = JMT; ;
    break;}
case 71:
#line 169 "codigop.y"
{ yyval.constante = LT; ;
    break;}
case 72:
#line 170 "codigop.y"
{ yyval.constante = LTE; ;
    break;}
case 73:
#line 171 "codigop.y"
{ yyval.constante = LVP; ;
    break;}
case 74:
#line 172 "codigop.y"
{ yyval.constante = MOD; ;
    break;}
case 75:
#line 173 "codigop.y"
{ yyval.constante = NEQ; ;
    break;}
case 76:
#line 174 "codigop.y"
{ yyval.constante = NGB; ;
    break;}
case 77:
#line 175 "codigop.y"
{ yyval.constante = NGI; ;
    break;}
case 78:
#line 176 "codigop.y"
{ yyval.constante = NOP; ;
    break;}
case 79:
#line 177 "codigop.y"
{ yyval.constante = PLUS; ;
    break;}
case 80:
#line 178 "codigop.y"
{ yyval.constante = OR; ;
    break;}
case 81:
#line 179 "codigop.y"
{ yyval.constante = OSF; ;
    break;}
case 82:
#line 180 "codigop.y"
{ yyval.constante = POP; ;
    break;}
case 83:
#line 181 "codigop.y"
{ yyval.constante = RD; ;
    break;}
case 84:
#line 182 "codigop.y"
{ yyval.constante = SBT; ;
    break;}
case 85:
#line 183 "codigop.y"
{ yyval.constante = SRF; ;
    break;}
case 86:
#line 184 "codigop.y"
{ yyval.constante = STC; ;
    break;}
case 87:
#line 185 "codigop.y"
{ yyval.constante = TMS; ;
    break;}
case 88:
#line 186 "codigop.y"
{ yyval.constante = WRT; ;
    break;}
case 89:
#line 187 "codigop.y"
{ yyval.constante = SWP; ;
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
#line 188 "codigop.y"


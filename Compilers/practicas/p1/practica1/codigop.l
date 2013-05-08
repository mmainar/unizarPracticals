%{
/**********************************************************************
* Practicas de Compiladores II, 2008/2009
* fichero: codigop.l
*          Analizador lexico de codigo P
* modificaciones por: Marcos Mainar Lalmolda
* modificaciones realizadas: Agrego inicializaciones de lineno, linepos
*                            y patron-accion de la instruccion swap(SWP).
* fecha: 19-MAR-09
**********************************************************************/

#include "y.tab.h"   /* lo genera yacc */
#include <string.h>
#include <stdlib.h>

int lineno = 1, linepos = 1;

#define TRATA(token) { linepos += yyleng; return (token); }

/**********************************************************************/
void warning (char *mens,  int lin,  int col)
/**********************************************************************/
{
    fprintf (stderr, "\n/*-----------------------------------------\n");
    fprintf (stderr, "AVISO! Lin:%d Col:%d. %s\n",  lin,  col,  mens);
    fprintf (stderr, "Car:'%s'\n",  yytext);
    fprintf (stderr, "\n/*-----------------------------------------\n");
}
%}

comentario      ";".*$
separador       [\t ]
letra           [a-zA-Z_]
digito          [0-9]
etiqueta        {letra}({letra}|{digito})*
constEntera     -?{digito}+
constChar       \".\"
dosPuntos       [\:]
A               [Aa]
B               [Bb]
C               [Cc]
D               [Dd]
E               [Ee]
F               [Ff]
G               [Gg]
H               [Hh]
I               [Ii]
J               [Jj]
K               [Kk]
L               [Ll]
M               [Mm]
N               [Nn]
O               [Oo]
P               [Pp]
Q               [Qq]
R               [Rr]
S               [Ss]
T               [Tt]
U               [Uu]
V               [Vv]
W               [Ww]
X               [Xx]
Y               [Yy]
Z               [Zz]

%array
%%
{A}{N}{D}         { TRATA (TAND); }   
{A}{S}{G}         { TRATA (TASG); }
{A}{S}{G}{I}      { TRATA (TASGI); }
{C}{S}{F}         { TRATA (TCSF); }
{D}{I}{V}         { TRATA (TDIV); }
{D}{U}{P}         { TRATA (TDUP); }
{D}{R}{F}         { TRATA (TDRF); }
{E}{N}{P}         { TRATA (TENP); }
{E}{Q}            { TRATA (TEQ); }
{G}{T}            { TRATA (TGT); }
{G}{T}{E}         { TRATA (TGTE); }
{J}{M}{F}         { TRATA (TJMF); }
{J}{M}{P}         { TRATA (TJMP); }
{J}{M}{T}         { TRATA (TJMT); }
{L}{T}            { TRATA (TLT); }
{L}{T}{E}         { TRATA (TLTE); }
{L}{V}{P}         { TRATA (TLVP); }
{M}{O}{D}         { TRATA (TMOD); }
{N}{E}{Q}         { TRATA (TNEQ); }
{N}{G}{B}         { TRATA (TNGB); }
{N}{G}{I}         { TRATA (TNGI); }
{N}{O}{P}         { TRATA (TNOP); }
{O}{R}            { TRATA (TOR); }
{O}{S}{F}         { TRATA (TOSF); }
{P}{L}{U}{S}      { TRATA (TPLUS); }
{P}{O}{P}         { TRATA (TPOP); }
{R}{D}            { TRATA (TRD); }
{S}{B}{T}         { TRATA (TSBT); }
{S}{R}{F}         { TRATA (TSRF); }
{S}{T}{C}         { TRATA (TSTC); }
{T}{M}{S}         { TRATA (TTMS); }
{S}{W}{P} 	  { TRATA (TSWP); }
{W}{R}{T}         { TRATA (TWRT); }
{dosPuntos}       { TRATA (yytext[0]); }
{comentario}      { 
					linepos = 1; 
				  }
{constEntera}     {
                    linepos += yyleng;
                    sscanf (yytext, "%d", & (yylval.constante));
                    return (TCONSTENT);
                  }
{constChar}       {
				    yylval.constante = yytext[1];
				    return(TCONSTCHAR);

			      }
{etiqueta}        {
                    linepos += yyleng;
                    yylval.identificador = strdup(yytext);
                    return (TETIQUETA);
                  }
[ \t]             { 
                    linepos++;
                  }
\n                { 
                    linepos = 1;
                    lineno++;
                  }
.                 { 
                    linepos++;
                    warning ("Caracter extraño. Eliminado.", lineno, linepos);
                  }
%%

%{
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
%}

%union{
   int constante;
   char *identificador;
}

%token TAND TASG TASGI TCSF TDIV TDRF TDUP TENP TEQ TGT TGTE TJMF TJMP 
%token TJMT TLT TLTE TLVP  TPOP
%token TMOD TNEQ TNGB TNGI TNOP TOR TOSF TPLUS TRD TSBT TSRF TSTC
%token TTMS TSWP TWRT TCONSTENT TCONSTCHAR TETIQUETA

%type <constante> TCONSTENT TCONSTCHAR
%type <identificador> TETIQUETA etiq cuerpoProg instruccion programa instInicio instFin

%type <constante> sin_argumentos un_argumento_entero un_argumento_caracter 
%type <constante> un_argumento_etiqueta dos_argumentos tres_argumentos
%type <constante> logical_and assign assign_inverse close_stack_frame 
%type <constante> dereference equals greater_than greater_equal integer_div 
%type <constante> integer_mod logical_or less_than less_equal leave_program 
%type <constante> not_equal_to negate_boolean negate_integer integer_add 
%type <constante> integer_substract integer_product nop duplicate
%type <constante> enter_program jump_if_false jump jump_if_true store_constant 
%type <constante> read write enter_program jump_if_false jump jump_if_true
%type <constante> set_reference open_stack_frame stack_pop swap

%%

programa : etiq instInicio cuerpoProg instFin 
         | etiq instInicio instFin 
	 | instInicio cuerpoProg instFin 
	 | instInicio instFin 


etiq : etiq TETIQUETA ':'
       { agregar_etiqueta($2); }
     | TETIQUETA ':' { agregar_etiqueta($1); }
;

instInicio : enter_program TCONSTENT 
           { 
	     tratar_instruccion_con_1_argumento($1, $2); 
	   }
           | enter_program TETIQUETA 
	   { 
	     tratar_instruccion_con_1_argumento($1, referencia($2)); 
	   }
;

cuerpoProg : instruccion
           | etiq instruccion 
	   | cuerpoProg instruccion 
	   | cuerpoProg etiq instruccion 
;

instFin : leave_program { tratar_instruccion_sin_argumentos($1); }
        | etiq leave_program 
	  { 
	    tratar_instruccion_sin_argumentos($2);
	  }
;

instruccion : sin_argumentos   
            { 
              tratar_instruccion_sin_argumentos($1);
            }
            | un_argumento_entero TCONSTENT 
	    { 
	      tratar_instruccion_con_1_argumento($1, $2);
	    }	    
            | un_argumento_caracter TCONSTCHAR
	    {
	      tratar_instruccion_con_1_argumento($1, $2);
	    }
            | un_argumento_etiqueta TETIQUETA
	    {
	      tratar_instruccion_con_1_argumento($1, referencia($2));
	    }
            | dos_argumentos TCONSTENT TCONSTENT
	    {
	       tratar_instruccion_con_2_argumentos($1, $2, $3);
	    }
            | tres_argumentos TCONSTENT TCONSTENT TCONSTENT
	    {
	       tratar_instruccion_con_3_argumentos($1, $2, $3, $4);
	    }
            | tres_argumentos TCONSTENT TCONSTENT TETIQUETA
	    {
	      tratar_instruccion_con_3_argumentos($1, $2, $3, referencia($4));
	    }
;
sin_argumentos : logical_and
               | assign
               | assign_inverse
               | close_stack_frame
               | dereference
               | equals
               | greater_than
               | greater_equal
               | integer_div
               | integer_mod
               | logical_or
               | less_than
               | less_equal
               | not_equal_to
               | negate_boolean
               | negate_integer
               | integer_add
               | integer_substract
               | integer_product
               | nop
               | duplicate
               | stack_pop
	       | swap
;

un_argumento_entero : jump_if_false
                    | jump
                    | jump_if_true
                    | store_constant
                    | read
                    | write
;

un_argumento_caracter : store_constant
;

un_argumento_etiqueta : jump_if_false
                      | jump
                      | jump_if_true
;

dos_argumentos : set_reference
;

tres_argumentos : open_stack_frame
;

logical_and         : TAND  { $$ = AND; } ;
assign              : TASG  { $$ = ASG; } ;
assign_inverse      : TASGI { $$ = ASGI; } ;
close_stack_frame   : TCSF  { $$ = CSF; } ;
integer_div         : TDIV  { $$ = DIV; } ;
dereference         : TDRF  { $$ = DRF; } ;
duplicate           : TDUP  { $$ = DUP; } ;
enter_program       : TENP  { $$ = ENP; } ;
equals              : TEQ   { $$ = EQ; } ;
greater_than        : TGT   { $$ = GT; } ;
greater_equal       : TGTE  { $$ = GTE; } ;
jump_if_false       : TJMF  { $$ = JMF; } ;
jump                : TJMP  { $$ = JMP; } ;
jump_if_true        : TJMT  { $$ = JMT; } ;
less_than           : TLT   { $$ = LT; } ;
less_equal          : TLTE  { $$ = LTE; } ;
leave_program       : TLVP  { $$ = LVP; } ;
integer_mod         : TMOD  { $$ = MOD; } ;
not_equal_to        : TNEQ  { $$ = NEQ; } ;
negate_boolean      : TNGB  { $$ = NGB; } ;
negate_integer      : TNGI  { $$ = NGI; } ;
nop                 : TNOP  { $$ = NOP; } ;
integer_add         : TPLUS { $$ = PLUS; } ;
logical_or          : TOR   { $$ = OR; } ;
open_stack_frame    : TOSF  { $$ = OSF; } ;
stack_pop           : TPOP  { $$ = POP; } ;
read                : TRD   { $$ = RD; } ;
integer_substract   : TSBT  { $$ = SBT; } ;
set_reference       : TSRF  { $$ = SRF; } ;
store_constant      : TSTC  { $$ = STC; } ;
integer_product     : TTMS  { $$ = TMS; } ;
write               : TWRT  { $$ = WRT; } ;
swap                : TSWP  { $$ = SWP; } ;
%%

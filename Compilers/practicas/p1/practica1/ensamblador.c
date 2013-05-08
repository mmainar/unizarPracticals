/**********************************************************************
* Practicas de Compiladores II 2008/2009
* Fichero: ensamblador.c
*          ensamblador de codigo P
* autor del programa principal: Marcos Mainar Lalmolda
* otras modificaciones: agregada la funcion finalizar_pasada().
* fecha: 19-MAR-09
***********************************************************************/

/**********************************************************************/
/*                  F I C H E R O S  I N C L U I D O S                */
/**********************************************************************/

#include <ctype.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdarg.h>
#include "codigop.h"
#include "etiquetas.h"

/**********************************************************************/
/*                V A R I A B L E S   E S T A T I C A S               */
/**********************************************************************/

extern int lineno, linepos;
extern char yytext[];
extern FILE *yyin, *yyout;
extern int numPasada;
extern int instno;
extern int error; 
extern int numInst;

/**********************************************************************/
void yyerror(char *m)
/**********************************************************************
Escribe en stderr la descripcion de un error sintactico
***********************************************************************/
{
    fprintf (stderr, "ERROR SINTACTICO! (%d, %d, %s): %s\n", 
                     lineno, linepos, yytext, m);
    exit (1);
}

/**********************************************************************/
void generar (FILE *fichero, unsigned char op, ...)
/**********************************************************************
Escribe en fichero el codigo binario de la instruccion op.
!!!El numero de argumentos ... debe ser el correcto para op!!!!!
!!!Y todos deben ser de tipo int!!!!!
***********************************************************************/
{
   va_list args;
   short int arg;

   va_start (args, op);
   fwrite (&op, sizeof (op), 1, fichero);
   switch (op) 
   {
          case AND  :
          case ASG  :
          case ASGI :
          case CSF  :
          case DRF  :
          case EQ   :
          case GT   :
          case GTE  :
          case DIV  :
          case MOD  :
          case OR   :
          case LT   :
          case LTE  :
          case LVP  :
          case NEQ  :
          case NGB  :
          case NGI  :
          case PLUS :
          case SBT  :
          case TMS  :
	  case SWP  :
          case NOP  :
          case DUP  : 
          case POP  : 
                    break ;
          case ENP  :
          case JMF  :
          case JMP  :
          case JMT  :
          case STC  :
          case RD   :
          case WRT  :
                    arg = va_arg (args, int);
                    fwrite (&arg, sizeof (arg), 1, fichero);
                    break;
          case SRF  :
                    arg = va_arg (args, int);
                    fwrite (&arg, sizeof (arg), 1, fichero);
                    arg = va_arg (args, int);
                    fwrite (&arg, sizeof (arg), 1, fichero);
                    break;
          case OSF  :
                    arg = va_arg (args, int);
                    fwrite (&arg, sizeof (arg), 1, fichero);
                    arg = va_arg (args, int);
                    fwrite (&arg, sizeof (arg), 1, fichero);
                    arg = va_arg (args, int);
                    fwrite (&arg, sizeof (arg), 1, fichero);
                    break;
          default : fprintf (stderr, "GENERAR: codigo %d desconocido!!!\n", op);
   }
}

/**********************************************************************/
void finalizar_pasada()
/**********************************************************************/
/* Actualiza los valores de las variables numInst, instno, lineno, 
   linepos y numPasada cuando finaliza una pasada al fichero de codigo P. 
*/
{
  numInst = instno;
  instno = -1;
  lineno = 1;
  linepos = 1;
  numPasada++;
}


/**********************************************************************/
main (int argc, char* argv[])
/**********************************************************************/
{
  char namein[100], nameout[100];
    
  if (argc != 2)
  {
    printf("Numero de argumentos incorrecto\n");
    printf("Uso: ensamblador fuente (sin la extension .cp)\n");
    exit(-1);
  }
  
  strcpy(namein, argv[1]);
  strcpy(nameout, argv[1]);
  strcat(namein, ".cp");
  strcat(nameout, ".x");  
  
  if (!(yyin = fopen(namein, "r")))
    printf("ERROR al abrir el fichero fuente %s\n", namein);
  else
  {    
    yyparse(); /* Pasada 1 */
    fseek(yyin, 0, SEEK_SET);    
    finalizar_pasada();
    if (error) 
    { 
      printf("ATENCION! Ha habido errores y NO se ha generado el fichero %s\n", nameout);
      exit(-1);
    }
    yyout = fopen(nameout, "wb");
    yyparse(); /* Pasada 2 */
    fclose(yyout);
    /* Si ha habido algun error, no generamos el fichero .x */
    if (error) 
    { 
      remove(nameout);
      printf("ATENCION! Ha habido errores y NO se ha generado el fichero %s\n", nameout);
    }
    else printf("Fichero %s generado correctamente\n", nameout);
    fclose(yyin);
  }
}

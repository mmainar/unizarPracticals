/**********************************************************************
* Practicas de Compiladores II 2008/2009
* Fichero: desensamblador.c
*          desensamblador de Codigo P
***********************************************************************/

/**********************************************************************/
/*                  F I C H E R O S  I N C L U I D O S                */
/**********************************************************************/

#include <stdio.h>
#include <math.h>
#include "codigop.h"

/**********************************************************************/
void mnemonic (int code)
/**********************************************************************/
{
   switch (code) {
          case AND   :  fprintf (stdout, "AND "); break;
          case ASG   :  fprintf (stdout, "ASG "); break;
          case ASGI  :  fprintf (stdout, "ASGI "); break;
          case CSF   :  fprintf (stdout, "CSF "); break;
          case DIV   :  fprintf (stdout, "DIV "); break;
          case DRF   :  fprintf (stdout, "DRF "); break;
          case DUP   :  fprintf (stdout, "DUP "); break;
          case ENP   :  fprintf (stdout, "ENP "); break;
          case EQ    :  fprintf (stdout, "EQ "); break;
          case GT    :  fprintf (stdout, "GT "); break;
          case GTE   :  fprintf (stdout, "GTE "); break;
          case JMF   :  fprintf (stdout, "JMF "); break;
          case JMP   :  fprintf (stdout, "JMP "); break;
          case JMT   :  fprintf (stdout, "JMT "); break;
          case LT    :  fprintf (stdout, "LT "); break;
          case LTE   :  fprintf (stdout, "LTE "); break;
          case LVP   :  fprintf (stdout, "LVP "); break;
          case MOD   :  fprintf (stdout, "MOD "); break;
          case NEQ   :  fprintf (stdout, "NEQ "); break;
          case NGB   :  fprintf (stdout, "NGB "); break;
          case NGI   :  fprintf (stdout, "NGI "); break;
          case NOP   :  fprintf (stdout, "NOP "); break;
          case OR    :  fprintf (stdout, "OR "); break;
          case OSF   :  fprintf (stdout, "OSF "); break;
          case PLUS  :  fprintf (stdout, "PLUS "); break;
          case RD    :  fprintf (stdout, "RD "); break;
          case SBT   :  fprintf (stdout, "SBT "); break;
          case SRF   :  fprintf (stdout, "SRF "); break;
          case STC   :  fprintf (stdout, "STC "); break;
          case TMS   :  fprintf (stdout, "TMS "); break;
          case WRT   :  fprintf (stdout, "WRT "); break;
          case SWP   :  fprintf (stdout, "SWP "); break;
          case POP   :  fprintf (stdout, "POP "); break;
		  default : fprintf (stdout, "desensamblador: instruccion %d desconocida!!!!\n", code);
   }
}

/**********************************************************************/
void terminar (char *msg)
/**********************************************************************/
{
  fprintf (stdout, "%s\n", msg);
  exit (1);
}

/**********************************************************************/
void mostrar_programa (char *name)
/**********************************************************************/
{
   FILE *fp = fopen (name, "rb");

   if (fp == NULL)
      terminar ("Programa objeto no existe.");
   else {
	  int i = 0;
	  unsigned char op;
	  short int arg;

      fread (& op, sizeof (op), 1, fp);
      while (!feof (fp)) {
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
                   case NOP  :
                   case DUP  :
                   case SWP  :
                   case POP  :
				   {
                        fprintf (stdout, "%3d: ", i);
                        mnemonic (op);
                        fprintf (stdout, "\n");
                        break ;
				   }
                   case ENP  :
                   case JMF  :
                   case JMP  :
                   case JMT  :
                   case STC  :
                   case RD   :
                   case WRT  :
				   {
                        short arg;

                        fread (& arg, sizeof (arg), 1, fp);

                        fprintf (stdout, "%3d: ", i);
                        mnemonic (op);
                        fprintf (stdout, "%2d\n", arg);
                        break;
				   }
                   case SRF  :
				   {
                        short arg1, arg2;

                        fread (& arg1, sizeof (arg1), 1, fp);
                        fread (& arg2, sizeof (arg2), 1, fp);

                        fprintf (stdout, "%3d: ", i);
                        mnemonic (op);
                        fprintf (stdout, "%2d %2d\n", arg1, arg2);
                        break;
				   }
                   case OSF  :
				   {
                        short arg1, arg2, arg3;

                        fread (& arg1, sizeof (arg1), 1, fp);
                        fread (& arg2, sizeof (arg2), 1, fp);
                        fread (& arg3, sizeof (arg3), 1, fp);

                        fprintf (stdout, "%3d: ", i);
                        mnemonic (op);
                        fprintf (stdout, "%2d %2d %2d\n", arg1, arg2, arg3);
                        break;
				   }
            }
            ++i;
            fread (&op, sizeof (op), 1, fp);
      }

      fclose (fp);
   }
}

/**********************************************************************/
main (int argc, char* argv[])
/**********************************************************************/
{
   char namein[100];

   strcpy (namein, argv[1]);
   strcat (namein, ".x");

   mostrar_programa (namein);
   terminar ("Terminacion normal.");
}

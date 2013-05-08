/**********************************************************************
  * fichero: maquinap.c
 *          Interprete de Codigo P
 *
 * modificado por: Marcos Mainar Lalmolda                              
 * fecha ultima modificacion: 21 de mayo de 2009
 **********************************************************************/

/**********************************************************************/
/*                  F I C H E R O S  I N C L U I D O S                */
/**********************************************************************/

#include <stdio.h>
#include <math.h>
#include "codigop.h"

/**********************************************************************/
/*                         C O N S T A N T E S                        */
/**********************************************************************/

#define TOPE_CODE     10000
#define TOPE_STACK    500
#define TOPE_FRAMES   1000
#define TOPE_DISPLAY  100
#define MAX_SHORT     32767
#define MIN_SHORT     -32768

/**********************************************************************/
/*                              M A C R O S                           */
/**********************************************************************/

#define OPERATOR(inst) (CODE[inst].op)
#define ARG1(inst)     (CODE[inst].arg1)
#define ARG2(inst)     (CODE[inst].arg2)
#define ARG3(inst)     (CODE[inst].arg3)

/**********************************************************************/
/*                V A R I A B L E S   E S T A T I C A S               */
/**********************************************************************/

int PC, SP, BP, DP;
/* Variables añadidas */
int tam_prog = 0; /* Para controlar saltos mas alla del programa */
int paso_a_paso = 0; /* Para controlar modo -t */
int hay_enp = 0; /* Para dar error si hay mas de una instruccion ENP */

/**********************************************************************/
/*                      D E F I N I C I O N E S                       */
/**********************************************************************/

typedef struct {
           unsigned char op;
           short arg1, arg2, arg3;
        } INSTR;

INSTR CODE[TOPE_CODE];
int   STACK[TOPE_STACK];
int   FRAMES[TOPE_FRAMES];
int   DISPLAY[TOPE_DISPLAY];

/**********************************************************************/
char *mnemonic (int code)
/**********************************************************************/
{  char *result;

   switch (code) {
          case AND   :  result = "AND"; break;
          case ASG   :  result = "ASG"; break;
          case ASGI  :  result = "ASGI"; break;
          case CSF   :  result = "CSF"; break;
          case DIV   :  result = "DIV"; break;
          case DRF   :  result = "DRF"; break;
          case DUP   :  result = "DUP"; break;
          case ENP   :  result = "ENP"; break;
          case EQ    :  result = "EQ"; break;
          case GT    :  result = "GT"; break;
          case GTE   :  result = "GTE"; break;
          case JMF   :  result = "JMF"; break;
          case JMP   :  result = "JMP"; break;
          case JMT   :  result = "JMT"; break;
          case LT    :  result = "LT"; break;
          case LTE   :  result = "LTE"; break;
          case LVP   :  result = "LVP"; break;
          case MOD   :  result = "MOD"; break;
          case NEQ   :  result = "NEQ"; break;
          case NGB   :  result = "NGB"; break;
          case NGI   :  result = "NGI"; break;
          case NOP   :  result = "NOP"; break;
          case OR    :  result = "OR"; break;
          case OSF   :  result = "OSF"; break;
          case PLUS  :  result = "PLUS"; break;
          case POP   :  result = "POP"; break;
          case RD    :  result = "RD"; break;
          case SBT   :  result = "SBT"; break;
          case SRF   :  result = "SRF"; break;
          case STC   :  result = "STC"; break;
          case SWP   :  result = "SWP"; break;
          case TMS   :  result = "TMS"; break;
          case WRT   :  result = "WRT"; break;
          default    : fprintf (stdout, 
               "MNEMONIC: instruccion %d desconocida!!!!\n", code);
   }
   return result;
}

/**********************************************************************/
void terminar (char *msg)
/**********************************************************************/
{
  fprintf (stdout, "%s\n", msg);
  exit (1);
}

/**********************************************************************/
void push (int v)
/**********************************************************************/
{
  SP++;
  if (SP >= TOPE_STACK) terminar("STACK overflow.");
  else STACK[SP] = v;
}

/**********************************************************************/
int pop ()
/**********************************************************************/
{
  int v;

  if (SP < 0) terminar("STACK underflow."); 
  else
  {
    v = STACK[SP];
    SP--;
  }

  return v;
}

/**********************************************************************/
void dpush (int v)
/**********************************************************************/
{
  DP++;
  if (DP >= TOPE_DISPLAY) terminar("DISPLAY overflow.");
  else DISPLAY[DP] = v;
}

/**********************************************************************/
int dpop ()
/**********************************************************************/
{
  int v;

  if (DP < 0) terminar("DISPLAY underflow.");
  else
  {
    v = DISPLAY[DP];
    DP--; 
  }

  return v;
}

/**********************************************************************/
void penp (int addr)
/**********************************************************************/
{
  /* Comprobamos que solo haya una instruccion ENP */
  if (hay_enp == 1) terminar("Error, solo puede haber una instruccion ENP.");
  hay_enp = 1;
  /* Construir el bloque de activacion del programa */
  FRAMES[0] = -1;
  BP = 0;
  /* Establecer encadenamiento estatico */
  dpush (BP);
  /* Comenzar ejecucion si addr es valida */
  if ((addr > 0) && (addr < tam_prog))
    PC = addr;
  else 
    terminar("El argumento de ENP debe ser mayor que 0 y menor que el tamaño del programa.");
}

/**********************************************************************/
void prd (int mode)
/**********************************************************************/
{
   int v = pop ();

   if (v < 0) terminar("Direccion de RD incorrecta.");
   else if (v >= TOPE_FRAMES) terminar("Direccion de RD incorrecta.");
   else
   {
     if (mode == 0) /* Leer como caracter */
        FRAMES[v] = getchar ();
     else /* Leer como entero */
        scanf ("%d", & (FRAMES[v]));
     ++PC;
   }
}

/**********************************************************************/
void pstc (int n)
/**********************************************************************/
{
   /* El ensamblador nos truncara ya el entero al generar para que
      entre dentro del rango de los SHORT */
   push (n);
   ++PC;
}

/**********************************************************************/
void pwrt (int mode)
/**********************************************************************/
{
   if (mode == 0) /* Lo escribimos como caracter */
      putc ( (char) pop (), stdout);
   else /* Lo escribimos como entero */
      fprintf (stdout, "%d", pop ());
   ++PC;
}

/**********************************************************************/
void pand ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 && v1);
   ++PC;
}

/**********************************************************************/
void pasg ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop(); /* valor para la asignacion */
   v2 = pop(); /* dir para la asignacion */
   if (v2 < 0) terminar("Direccion para ASG erronea.");
   else if (v2 >= TOPE_FRAMES) terminar("Direccion para ASG erronea.");
   else FRAMES[v2] = v1;
   ++PC;
}

/**********************************************************************/
void pasgi ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop(); /* dir para la asignacion */
   v2 = pop(); /* valor para la asignacion */
   if (v1 < 0) terminar("Direccion para ASGI erronea.");
   else if (v1 >= TOPE_FRAMES) terminar("Direccion para ASGI erronea.");
   else FRAMES[v1] = v2;
   ++PC;
}

/**********************************************************************/
void pcsf ()
/**********************************************************************/
{
   /* Close stack Frame (destruir BA) */
   int i, l;
   
   /* Recuperar el valor de l, numero de posiciones guardadas del BA anterior */
   if (BP == 0) /* No ha habido OSF antes luego no puede haber CSF */
     terminar("FRAMES underflow");
   l = FRAMES[BP + 1];   
   /* Controlar FRAMES underflows y overflows */   
   if ((l > 0) && ((BP - l) < 0))
     terminar("FRAMES underflow.");
   /* Recuperar la direccion de retorno */
   PC = FRAMES[BP + 2];
   /* Eliminar el encadenamiento estatico actual */
   dpop();
   /* Restaurar el encadenamiento estatico anterior */
   for (i = 1; i <= l; i++) dpush(FRAMES[BP - i]);
   /* Restaurar el bloque de activacion anterior a traves del encadenamiento
      dinamico */
   BP = FRAMES[BP];
}

/**********************************************************************/
void pdiv ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   
   if (v1 != 0) 
   {   
    if (((v2 / v1) > MAX_SHORT) || ((v2 / v1) < MIN_SHORT))
    {
      terminar("MATH overflow.");
    } 
    else
    { 
      push (v2 / v1);
      ++PC;
    }  
   }  
   else terminar("Division por cero.");
   
}


/**********************************************************************/
void pdrf ()
/**********************************************************************/
{
   int v = pop ();
   if (v < 0) terminar("Direccion para DRF incorrecta.");
   else if (v >= TOPE_FRAMES) terminar("Direccion para DRF incorrecta.");
   else push (FRAMES[v]);
   ++PC;
}

/**********************************************************************/
void pdup ()
/**********************************************************************/
{
   int v1;
   v1 = pop();
   push (v1);
   push (v1);
   ++PC;
}

/**********************************************************************/
void peq ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 == v1);
   ++PC;
}

/**********************************************************************/
void pgt ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 > v1);
   ++PC;
}

/**********************************************************************/
void pgte ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 >= v1);
   ++PC;
}

/**********************************************************************/
void pjmf (int addr)
/**********************************************************************/
{
   int cond = pop();
   
   /* 0 = False */
   if (cond == 0) 
   {  
     /* Comprobamos que addr esta dentro del vector de codigo */
     if ((addr > 0) && (addr < tam_prog))
       PC = addr;
     else 
       terminar("No se puede saltar a una instruccion mas alla del final del programa ni a una instruccion cero o negativa.");  
   }  
   else PC++;
}

/**********************************************************************/
void pjmp (int addr)
/**********************************************************************/
{

   if (addr == PC)
     terminar("No se puede realizar un salto incondicional a la propia instruccion: bucle infinito.");
   else if ((addr > 0) && (addr < tam_prog ))
     PC = addr;   
   else
     terminar("No se puede saltar a una instruccion mas alla del final del programa ni a una instruccion cero o negativa.");

}


/**********************************************************************/
void pjmt (int addr)
/**********************************************************************/
{
   int cond = pop();
   
   /* 1 = True */
   if (cond == 1)
   {
     if ((addr > 0) && (addr < tam_prog ))
       PC = addr;
     else
       terminar("No se puede saltar a una instruccion mas alla del final del programa ni a una instruccion cero o negativa");
   }   
   else PC++;
}

/**********************************************************************/
void plt ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 < v1);
   ++PC;
}

/**********************************************************************/
void plte ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 <= v1);
   ++PC;
}

/**********************************************************************/
void plvp ()
/**********************************************************************/
{
   terminar("Fin de ejecucion.");
}

/**********************************************************************/
void pmod ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();   
   
   if (v1 == 0)
   {
     terminar("Modulo por cero.");
   }  
   else if (((v2 % v1) > MAX_SHORT) || ((v2 % v1) < MIN_SHORT))
   {
     terminar("MATH overflow.");
   }  
   else
   {
     push (v2 % v1);
     ++PC;
   }  
}

/**********************************************************************/
void pneq ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 != v1);
   ++PC;
}

/**********************************************************************/
void pngb ()
/**********************************************************************/
{
   push (!pop());
   ++PC;
}

/**********************************************************************/
void pngi ()
/**********************************************************************/
{
   int v = pop();
   
   if (v == MIN_SHORT)
     terminar("MATH overflow.");
   else
   {
     push (-v);
     ++PC;
   }  
}

/**********************************************************************/
void pnop ()
/**********************************************************************/
{
   ++PC;
}

/**********************************************************************/
void por ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v2 || v1);
   ++PC;
}

/**********************************************************************/
void posf (int s, int l, int a)
/**********************************************************************/
{
   /* Open stack Frame (crear BA) */
   int i;
   
   if (s <= 0)
     terminar("Error, primer argumento de OSF incorrecto, debe ser mayor que 0.");
   else if (l < 0)
     terminar("Error, segundo argumento de OSF incorrecto, debe ser mayor o igual que 0.");
   else if (a == PC)
     terminar("Error, OSF genera bucle infinito al ser su tercer parametro igual al PC actual.");
   else if ((a <= 0) || (a >= tam_prog))
     terminar("El tercer argumento de OSF es incorrecto, debe estar dentro del programa.");  
   else /* Los 3 argumentos son correctos */
   {        
     /* Controlar FRAMES overflows */
     if ((BP + s)  >= TOPE_FRAMES)
       terminar("FRAMES overflow.");
     /* 1. Salvar l componentes de DISPLAY en FRAMES 
           respetando s componentes del bloque anterior. */
     for (i = 1; i <= l ; i++) FRAMES[BP + s + i] = dpop();
     /* 2. Eliminar l componentes de DISPLAY: 
           Ya se ha hecho en el paso anterior con el dpop(). */
     /* 3. Salvar el BP en FRAMES */
     FRAMES[BP + s + l + 1] = BP ;
     /* 4. BP <- El nuevo tope de FRAMES */
     BP = BP + s + l + 1;
     /* 5. Salvar l en FRAMES */
     FRAMES[BP + 1] = l;
     /* 6. Salvar direccion retorno en FRAMES */
     FRAMES[BP + 2] = PC + 1;
     /* 7. Salvar el BP en DISPLAY */
     dpush(BP);
     /* 8. PC <- a */
     PC = a;    
   }
}

/**********************************************************************/
void pplus ()
/**********************************************************************/
{
   short v1, v2;
   v1 = pop();
   v2 = pop();
   if (((v2 + v1) > MAX_SHORT) || ((v2 + v1) < MIN_SHORT))
   {
     terminar("MATH overflow.");
   }     
   else
   {
     push (v2 + v1);
     ++PC;
   }   
}

/**********************************************************************/
void ppop ()
/**********************************************************************/
{
  pop();
  ++PC;
}

/**********************************************************************/
void psbt ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   if (((v2 - v1) > MAX_SHORT) || ((v2 - v1) < MIN_SHORT))
   {
     terminar("MATH overflow.");
   }  
   else
   {
     push (v2 - v1);
     ++PC;
   }  
}

/**********************************************************************/
void psrf (int f, int o)
/**********************************************************************/
{
   if (((DP - f) < TOPE_DISPLAY) && ((DP - f) >= 0) && (o >= 3) && (f >= 0))
   {
     push (DISPLAY[DP - f] + o);
     /* Comprobar tambien si la @ = DISPLAY[DP - f] + o existe ? */
     ++PC;
   }
   else if ((DP - f) < 0)
     terminar("Error en SRF, se intenta acceder a una posicion del DISPLAY no valida.");
   else if ((DP - f) >= TOPE_DISPLAY)
     terminar("Error en SRF, se intenta acceder a una posicion del display no valida"); 
   else if (o < 3)
     terminar("Error en SRF, el segundo argumento (offset) de SRF debe ser al menos 3."); 
   else if (f < 0)
     terminar("Error en SRF, el primer argumento debe ser al menos 0."); 
}

/**********************************************************************/
void pswp ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   push (v1);
   push (v2);
   ++PC;
}

/**********************************************************************/
void ptms ()
/**********************************************************************/
{
   int v1, v2;
   v1 = pop();
   v2 = pop();
   if (((v2 * v1) > MAX_SHORT) || ((v2 * v1) < MIN_SHORT))
   {
     terminar("MATH overflow.");
   }  
   else
   {
     push (v2 * v1);
     ++PC;
   }  
}

/**********************************************************************/
short argumento (FILE *fp)
/**********************************************************************/
{
  unsigned char l, h;

  fread (& h, sizeof (char), 1, fp);
  fread (& l, sizeof (char), 1, fp);
  return (short) (h << 8) | l;
}


/**********************************************************************/
void mostrar_estado(int i)
/**********************************************************************/
{
  int k;
  fprintf(stdout, "Siguiente instruccion: PC=%d, SP=%d, BP=%d, DP=%d, ", PC, SP, BP, DP);

  switch (OPERATOR(i))
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
                   case DUP  :
                   case MOD  :
                   case OR   :
                   case LT   :
                   case LTE  :
                   case LVP  :
                   case NEQ  :
                   case NGB  :
                   case NGI  :
                   case NOP  :
                   case PLUS :
                   case POP  :
                   case SBT  :
                   case SWP  :
                   case TMS  :
                   {
		     fprintf(stdout, "%s", mnemonic(OPERATOR(i)));
		     fprintf(stdout, "\n"); 
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
			fprintf(stdout, "%s ", mnemonic(OPERATOR(i)));
			fprintf(stdout, "%2d\n", ARG1(i)); 
                        break;
                   }
                   break;
                   case SRF  :
                   {
			fprintf(stdout, "%s ", mnemonic(OPERATOR(i)));
			fprintf(stdout, "%2d %2d\n", ARG1(i), ARG2(i));  
                        break;
                   }
                   case OSF  :
                   {
			fprintf(stdout, "%s ", mnemonic(OPERATOR(i)));
			fprintf(stdout, "%2d %2d %2d\n", ARG1(i), ARG2(i), ARG3(i));
                        break;
                   }
                   default    : fprintf (stdout, 
                                "mostrar estado: instruccion %d desconocida!!!!\n", OPERATOR(i));
  }

  fprintf(stdout, "PILA: FRAMES, TOPE = %d\n", BP);
  for (k = 0; k <= (BP + 5); k++)
    /* Mostramos hasta el tope y 5 componentes mas porque en Frames, la pila de ejecucion,
       BP no es el tope. En las otras 2 pilas, Stack y Display, SP y DP si son el tope,
       respectivamente, y, por tanto, no hace falta mostrar mas que hasta estos registros */
    fprintf(stdout, " %d[%2d]\n", k, FRAMES[k]);

  fprintf(stdout, "\n");
  fprintf(stdout, "PILA: STACK, TOPE = %d\n", SP);
  for (k = 0; k <= SP; k++)
    fprintf(stdout, " %d[%2d]\n", k, STACK[k]);

  fprintf(stdout, "\n");
  fprintf(stdout, "PILA: DISPLAY, TOPE = %d\n", DP);
  for (k = 0; k <= DP ; k++)
    fprintf(stdout, " %d[%2d]\n", k, DISPLAY[k]);

  fprintf(stdout, "\n");
}

/**********************************************************************/
void cargar_programa (char *name)
/**********************************************************************/
{
   int j;
   FILE *fp = fopen (name, "rb");

   if (fp == NULL) {
      fprintf (stderr, "Programa objeto '%s' no existe.\n", name);
      exit (1);
   }
   else {
      int i = 0;
      unsigned char op;
      short arg;

      fread (& op, sizeof (unsigned char), 1, fp);
      while (!feof (fp) && (i < TOPE_CODE)) {
            OPERATOR(i) = op;
            switch (OPERATOR(i))
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
                   case DUP  :
                   case MOD  :
                   case OR   :
                   case LT   :
                   case LTE  :
                   case LVP  :
                   case NEQ  :
                   case NGB  :
                   case NGI  :
                   case NOP  :
                   case PLUS :
                   case POP  :
                   case SBT  :
                   case SWP  :
                   case TMS  :
                   {
                     if (paso_a_paso == 1)
		     {
		       fprintf(stdout, "%3d: ", i);
		       fprintf(stdout, "%s", mnemonic(op));
		       fprintf(stdout, "\n");
		     } 
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
                        ARG1(i) = argumento (fp);
			if (paso_a_paso == 1)
			{
			  fprintf(stdout, "%3d: ", i);
			  fprintf(stdout, "%s ", mnemonic(op));
			  fprintf(stdout, "%2d\n", ARG1(i));
			}  
                        break;
                   }
                   break;
                   case SRF  :
                   {
                        ARG1(i) = argumento (fp);
                        ARG2(i) = argumento (fp);
			if (paso_a_paso == 1)
			{
			  fprintf(stdout, "%3d: ", i);
			  fprintf(stdout, "%s ", mnemonic(op));
			  fprintf(stdout, "%2d %2d\n", ARG1(i), ARG2(i));
			}  
                        break;
                   }
                   case OSF  :
                   {
                        ARG1(i) = argumento (fp);
                        ARG2(i) = argumento (fp);
                        ARG3(i) = argumento (fp);
			if (paso_a_paso == 1)
			{
			  fprintf(stdout, "%3d: ", i);
			  fprintf(stdout, "%s ", mnemonic(op));
			  fprintf(stdout, "%2d %2d %2d\n", ARG1(i), ARG2(i), ARG3(i));
			}
                        break;
                   }
                   default    : fprintf (stdout, 
                                "CARGAR PROGRAMA: instruccion %d desconocida!!!!\n", OPERATOR(i));
            }
            ++i;
            fread (& op, sizeof (unsigned char), 1, fp);
      }

      if (i >= TOPE_CODE) terminar("CODE overflow: El programa no cabe en el vector de codigo");
      else
      { 
        /* Guardamos el tamaño del programa para verificar saltos */
        tam_prog = i;
	/* Verificamos que la primera instruccion es ENP */
	if (CODE[0].op != ENP) 
	  terminar("Error, la primera instruccion debe ser ENP");
	if (CODE[tam_prog - 1].op != LVP)
	  terminar("Error, la ultima instruccion debe ser LVP");
        /* Inicializar pilas */
        DP = -1;
        SP = -1;
	hay_enp = 0;
        if (paso_a_paso == 1) 
        {
          for (j = 0; j <= 80; j++) fprintf(stdout, "-");
          fprintf(stdout, "\n");
        }
      }

      fclose (fp);
   }
}

/**********************************************************************/
void ejecutar ()
/**********************************************************************/
{
  int c, j, k;

  PC = 0;
  while ((PC >= 0) && (PC <= tam_prog))
  {
       	
	if (paso_a_paso == 1) 
        {
	  /* Esperamos a que pulse una tecla para ejecutar la siguiente instruccion */
          mostrar_estado(PC);
	  c = getchar();
	  /* Escribir 2 lineas de separacion */
          for (j = 0; j <= 1; j++)
          {
            for (k = 0; k <= 80; k++)
              fprintf(stdout, "-");

            fprintf(stdout, "\n");
          }
        }
		 
        switch (OPERATOR (PC)) {
               case AND   :  pand (); break;
               case ASG   :  pasg (); break;
               case ASGI  :  pasgi (); break;
               case CSF   :  pcsf (); break;
               case DIV   :  pdiv (); break;
               case DRF   :  pdrf (); break;
               case DUP   :  pdup (); break;
               case ENP   :  penp (ARG1 (PC)); break;
               case EQ    :  peq (); break;
               case GT    :  pgt (); break;
               case GTE   :  pgte (); break;
               case JMF   :  pjmf (ARG1 (PC)); break;
               case JMP   :  pjmp (ARG1 (PC)); break;
               case JMT   :  pjmt (ARG1 (PC)); break;
               case LT    :  plt (); break;
               case LTE   :  plte (); break;
               case LVP   :  plvp (); break;
               case MOD   :  pmod (); break;
               case NEQ   :  pneq (); break;
               case NGB   :  pngb (); break;
               case NGI   :  pngi (); break;
               case NOP   :  pnop (); break;
               case OR    :  por (); break;
               case OSF   :  posf (ARG1 (PC), ARG2 (PC), ARG3 (PC)); break;
               case PLUS  :  pplus (); break;
               case POP   :  ppop (); break;
               case RD    :  prd (ARG1 (PC)); break;
               case SBT   :  psbt (); break;
               case SRF   :  psrf (ARG1 (PC), ARG2 (PC)); break;
               case SWP   :  pswp (); break;
               case STC   :  pstc (ARG1 (PC)); break;
               case TMS   :  ptms (); break;
               case WRT   :  pwrt (ARG1 (PC)); break;
               default    : fprintf (stdout, 
                            "EJECUTAR: instruccion %d desconocida!!!!\n", OPERATOR(PC));
        }
	
  }
  if (PC > tam_prog)
  {
     fprintf(stderr, "Error, la instruccion %d no existe\n", PC);
     terminar("Abortando la ejecucion");
  }   
}


/**********************************************************************/
main (int argc, char* argv[])
/**********************************************************************/
{
   char namein[100];
   
   if ((argc != 2) && (argc != 3))
   {
     fprintf(stderr, "Numero de argumentos incorrecto\n");
     fprintf(stderr, "Uso: maquinap programa [-t]\n");
     exit(-1);
   }
   
   if ((argc == 3) && (strcmp(argv[2], "-t") == 0))     
     /* Activamos el modo de ejecucion paso a paso del interprete */
     paso_a_paso = 1;
   else if ((argc == 3) && (strcmp(argv[2], "-t") == 0))
   {
     fprintf(stderr, "El tercer argumento es incorrecto\n");
     fprintf(stderr, "Uso: maquinap programa [-t]\n");
     exit(-1);
   }  
   else /* No activar el modo de ejecucion paso a paso del interprete */
     paso_a_paso = 0;  

   strcpy (namein, argv[1]);
   strcat (namein, ".x");

   cargar_programa (namein);     
   ejecutar ();
}

#include <stdio.h>
#include <conio.h>

extern void inicializarLinea(void);
extern void cambiarTablaInt(void);
extern void restaurarTablaInt(void);
extern void limpiarLinea(void);
extern void pintarPantalla(void);
extern void ponerCaracter(int x, int y);


extern char terminar;
extern char caracter_recibido;
extern char caracter_envio;
extern char recibido;
extern char local;
extern char leido;
extern char sobrecarga;
extern char formato;
extern char leidoTeclado;
extern char enviado;



int pos (int x, int y)
{
  return 2*(x+80*(y-1))-2;
}


void main()
{
  int i,j,x1 = 2, y1 = 4, x2 = 2, y2 = 13, x3 = 2 , y3 = 22;
  char sobcar[20] = "Error de sobrecarga";
  char form[17] = "Error de formato";
  inicializarLinea();
  cambiarTablaInt();
  clrscr();
  pintarPantalla();



  while (!terminar)
  {
    if (leidoTeclado) /* Mostramos por pantalla el caracter enviado */
    {
     /* Si hace falta, limpiamos la pantalla */
     if (caracter_envio != 8 && x1 == 2 && y1 == 10)
     {
	for (i=4;i<=9;i++)
	{
	  for (j=2;j<=79;j++)
	  {
	    ponerCaracter(' ',pos(j,i));
	  }
	}
	x1 = 2; y1 = 4;
     }
     switch (caracter_envio)
     {
       case '\n': /* Nueva linea */
	 y1++;
	 x1 = 2;
	 break;
       case 8: /* Caracter de borrado */
	if (x1 == 2 && y1 > 4)
	{
	  y1--;
	  x1 = 79;
	  ponerCaracter(' ',pos(x1,y1));

	}
	else if(x1>2)
	{
	 x1-=1;
	 ponerCaracter(' ',pos(x1,y1));
	}
	break;
       default:  /* Caracter imprimible */
	 ponerCaracter(caracter_envio,pos(x1,y1));
	 if (x1 == 79) {x1=2; y1++;}
	 else x1++;
     }
     leidoTeclado = 0;
     enviado = 0;

    }
    if (recibido)
    /* Mostramos por pantalla el caracter enviado */
    {
     /* Si hace falta, limpiamos la pantalla */
     if (caracter_recibido != 8 && x2 == 2 && y2 == 19)
     {
	for (i=13;i<=18;i++)
	{
	  for (j=2;j<=79;j++)
	  {
	    ponerCaracter(' ',pos(j,i));
	  }
	}
	x1 = 2; y1 = 13;
     }
     switch (caracter_recibido)
     {
       case '\n':  /* Nueva linea */
	 y2++;
	 x2 = 2;
	 break;
      case 8:   /* Caracter de borrado */
	if (x2 == 2 && y1 > 13)
	{
	  y1--;
	  x1 = 79;
	  ponerCaracter(' ',pos(x2,y2));

	}
	else if(x2>2)
	{
	 x2-=1;
	 ponerCaracter(' ',pos(x2,y2));
	}
	break;
       default:  /* Caracter imprimible */
	 ponerCaracter(caracter_recibido,pos(x2,y2));
	if (x2 == 79) {x2=2; y2++;}
	else x2++;
     }
      recibido = 0;
    }

    if (sobrecarga)
    {
      for (i=0;i<=18;i++)
	ponerCaracter(sobcar[i],pos(x3,y3));
      y3++;
      sobrecarga = 0;
    }
    if (formato)
    {
      gotoxy(x3,y3);
      for (i=0; i<=15;i++)
	ponerCaracter(form[i],pos(x3,y3));
      y3++;
      formato = 0;
    }

  }
  restaurarTablaInt();
}


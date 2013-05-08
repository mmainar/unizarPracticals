#include <stdio.h>


extern void inicializarLinea(void);
extern void enviarDatos(int dato);
extern int  recibirDatos(void);
extern void limpiarLinea(void);
extern void habilitarInt(void);
extern void deshabilitarInt(void);
extern void cambiarTablaInt(void);
extern void restaurarTablaInt(void);
extern char terminar;

void main()
{
  int puerto, modo, caracter = 0;


  printf("com1 o com2 (1/2)? "); scanf("%d", &puerto);
  printf("1) encuesta-enviar\n");
  printf("2) encuesta-recibir\n");
  printf("3) interrupcion\n");
  printf("modo (1-3)? ");  scanf("%d", &modo);
  cambiarTablaInt();
  switch (modo)
  {
    case 1:  printf("Enviando por el puerto COM1 a 9600 bps:\n");
	     inicializarLinea();
	     while(1)
	     {
	       enviarDato(caracter);
	       printf("%c",caracter);
	       fflush(stdout);
	       caracter++;
		   if (terminar) break;
	     }

	     break;

    case 2:  printf("Recibiendo por el puerto COM1 a 9600 bps:\n");
	     inicializarLinea();
	     while(1)
	     {
	       caracter = recibirDato();
	       printf("%c",caracter);
	       fflush(stdout);
		   if (terminar) break;
	     }
	     break;

    case 3:
	     break;

    default: ;

  }
  restaurarTablaInt();
}
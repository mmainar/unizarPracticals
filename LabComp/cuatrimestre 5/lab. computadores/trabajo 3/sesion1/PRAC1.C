#include <stdio.h>

extern int max(int a, int b);
extern void min(int *a, int *b, int *res);

extern void min2(void);
/* Calcula el minimo de las var a y b
   definidas en C y deja el resultado
   en res3 definido en ASM */

extern int max2(int n, int a, int b, ...);
/* Devuelve el maximo de n numeros */

extern int res3;   /* La variable res3 esta definida en ASM */

/* Variables definidas en C */

int n = 4, a = 1, b= 4, c = 3, d = 7 , e, res;


void main()
{
  char fin;

  printf("a=%d  b=%d  c=%d  d=%d\n", a,b,c,d);
  min(&a,&b,&res); min2();
  printf("min(a,b)=%d  ", res);
  printf("max(a,b)=%d  ", max(a,b));
  printf("min2()=%d  ", res3);
  printf("max2(%d,a,b,c,d)=%d\n", n, max2(n,a,b,c,d));
  printf("Pulse cualquier tecla para finalizar"); scanf("%c", &fin);


}

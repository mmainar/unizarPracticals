#include <stdio.h>


int a; /* Declaracion global */
  
void first() 
{
  a = 1;
}


void second(int j) 
{
  int a; /* Declaracion local */
  first();
}


int f(int v[][10]) /* OK */
{
  v[1][2] = 8;
}  

int j(int v[10][]) /* Error */
{
  v[1][3] = 8;
}

  
int main(int argc, char *argv[])
{ /* de prueba */
  char *w[]; /* Error, falta el tamaño del array */
  int n;
  short int arg;
  int v[][10];
  float h;
  int **r[][]; /* Error: No se sabe el tamaño de la matriz */
  int *q()(); /* Error: funcion que devuelve una funcion */
  int *o()[]; /* Error: funcion que devuelve vector de punteros a enteros */
  int *(*s[10])[];
  int *(*f())();
  a = 2.0;
  /* int j;  Error sintactico */
  printf("%d\n", a);
  scanf("%d", &n);
  if (n > 0)
    second(); /* Error semantico, second tiene un parametro */
  else 
    first();
  int h;  /* Error sintactico */
  printf("%s\n", h);
  printf("%d", sizeof(arg));
}


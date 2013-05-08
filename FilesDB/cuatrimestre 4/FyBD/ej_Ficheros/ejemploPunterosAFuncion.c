#include "stdio.h"
char c;

void prueba(int v1, int v2, int (*ptFunc)(int,int)){
  int c;
  c = ptFunc(v1,v2);
  printf("Valor: %d\n",c);
}

int sumar(int c1, int c2){
  return c1 + c2;
}

int restar(int c1, int c2){
  return c1 - c2;
}


int main(){
  prueba(10,5,&sumar); 
  prueba(10,5,&restar); 
}

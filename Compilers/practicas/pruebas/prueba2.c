#include <stdio.h>

 
struct {
  char c1;
  short s;
  char c2;
} r;

struct {
  short s;
  char c1;
  char c2;
} q;

int *n;
void *j;
void h;
  
int main(int argc, char *argv[])
{ 
  printf("r.c1: %d, r.s: %d, r: %d\n", sizeof(r.c1), sizeof(r.s), sizeof(r));
  printf("q.s: %d, q.c1: %d, q: %d\n", sizeof(q.s), sizeof(q.c1), sizeof(q));  
  printf("size pointer to int: %d\n", sizeof(n));
  printf("size pointer to void: %d\n", sizeof(j));
  printf("size void: %d\n", sizeof(h));
  printf("%d\n", 8 == 8);
}


ensamblador:	lex.yy.o y.tab.o ensamblador.o etiquetas.o p1.o Makefile
	gcc lex.yy.o y.tab.o ensamblador.o etiquetas.o p1.o -lm -ll -o ensamblador

lex.yy.o:	lex.yy.c y.tab.h
			gcc -c lex.yy.c

lex.yy.c:	codigop.l
			flex codigop.l

y.tab.h:	codigop.h codigop.y
			bison -ydvt codigop.y

y.tab.o:	y.tab.c
			gcc -c y.tab.c

y.tab.c:	codigop.h codigop.y
			bison -ydvt codigop.y

ensamblador.o:	codigop.h p1.h ensamblador.c
			gcc -c ensamblador.c

p1.o:	codigop.h p1.h p1.c
			gcc -c p1.c

etiquetas.o:	etiquetas.h etiquetas.c
			gcc -c etiquetas.c

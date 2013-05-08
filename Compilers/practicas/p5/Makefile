LEX=flex
YACC=bison 
CC=gcc 

app: app.o
	$(CC) -o app app.o

app.o: pascual pascual1 maquinap ensamblador
	$(CC) -c app.c

pascual: y.tab.o lex.yy.o tabla.o errores.o listas.o genast.o
	$(CC) -o pascual y.tab.o lex.yy.o tabla.o errores.o listas.o genast.o -ll -ly	
	
genast.o: genast.c genast.h
	$(CC) -c genast.c	
	
genvec.o: genvec.c genavec.h
	$(CC) -c genvec.c

listas.o: listas.c listas.h
	$(CC) -c listas.c	
			
tabla.o: tabla.c tabla.h
	$(CC) -c tabla.c
			
errores.o: errores.c
	$(CC) -c errores.c
			
lex.yy.o: y.tab.h errores.h
	$(CC) -c lex.yy.c
	
y.tab.o: y.tab.c errores.h
	$(CC) -c y.tab.c -DYYDEBUG

y.tab.c: pascual.y
	$(YACC) -ydvt pascual.y

lex.yy.c: pascual.l
	$(LEX) pascual.l
	
clean: 
	rm *.o pascual y.tab.c y.tab.h y.output lex.yy.c app

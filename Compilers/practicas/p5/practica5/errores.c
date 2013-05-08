/**********************************************************************
 Prog.:		errores.c
 Tema:		rutinas de manejo de error para COMPII
 Fecha:		Enero-98
 Fuente:	Propio
 Com.:		Se sumistra a los alumnos compilado
**********************************************************************/

#include <stdio.h>
#include <stdlib.h>			  /*para "exit ()"*/

extern int yydebug;           /*para usar el debugger*/

extern int lineno,linepos;    /*Estas variables globales se usan para 
                                almacenar la linea y columna del fuente,
                                y se suponen declaradas en el fuente Lex.
                                Algunos generadores de analizadores lexicos
                                las incluyen en la libreria del analizador.
                                Para usar en "yyerror()", que redefine la
                                rutina de error de Yacc (para el analisis
                                sintactico)
                              */
extern char *yytext;         /*Contenida en la librer'ia de Lex
                                (compilacion con la opcion "-ll")
                              */
extern char nameout[100]; /* Contenido en pascual1.y. Nombre del fichero xml 
                            de salida */			      
extern int error; /* Contenido en pascual1.y. Flag para indicar si ha
                     habido errores en yyparse */		     

/**********************************************************************/
void warning (char *mens)
/**********************************************************************
    Pre:     (lin, col) es la localizaci'on del principio del
            lexema causa del error. (*mens) contiene el mensaje
            de error a sacar por stderr. (*lexema) contiene
            el lexema que se est'a analizando
    Post: escribe (*mens) en stderr y sigue ejecuci'on
**********************************************************************/
{ 
        fprintf (stderr, "AVISO! (%d, %d, %s): %s\n", lineno, linepos, yytext, mens);
}

/**********************************************************************/
void yyerror (char *mens)
/**********************************************************************
	Pre:	 (lin, col) es la localizaci'on del principio del 
			lexema causa del error. (*mens) contiene el mensaje
			de error a sacar por stderr. (*lexema) contiene
			el lexema que se est'a analizando
	Post: escribe (*mens) en stderr y aborta ejecuci'on
	   
			Lo invoca el analizador sint'actico "yyparse ()"
**********************************************************************/
{
	fprintf (stderr, "ERROR SINTACTICO! (%d, %d, %s): %s\n", lineno, linepos, yytext, mens);
	remove (nameout);
        fprintf (stderr, "ATENCION! Ha habido errores y NO se ha generado el fichero %s\n", nameout);
	exit (1);
}

/**********************************************************************/
void error_semantico (char *mens)
/**********************************************************************
	Pre: (lin, col) es la localizaci'on del principio del 
			lexema causa del error. (*mens) contiene el mensaje
			de error a sacar por stderr. (*lexema) contiene
			el lexema que se est'a analizando
	Post: escribe (*mens) en stderr
	   
			Lo invoca el an'alisis sem'antico
**********************************************************************/
{
        error = 1;
	fprintf (stderr, "ERROR SEMANTICO! (%d, %d, %s) %s\n", lineno, linepos, yytext, mens);
}

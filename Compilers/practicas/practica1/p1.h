/**********************************************************************
* Practicas de Compiladores II, 2008/2009
* fichero: p1.h
*          Funciones del analizador sintactico y semantico de codigo P
* autor: Marcos Mainar Lalmolda
* fecha: 19-MAR-09
**********************************************************************/

void tratar_instruccion_sin_argumentos (int instruccion);

void tratar_instruccion_con_1_argumento (int instruccion, int arg1);

void tratar_instruccion_con_2_argumentos (int instruccion, int arg1, int arg2);

void tratar_instruccion_con_3_argumentos (int instruccion, int arg1, int arg2, int arg3);

/* Estas 4 funciones actualizan el numero de instrucciones procesadas.
   Si estamos en la segunda pasada al fichero de codigo P, ademas, generan
   el codigo binario correspondiente a la instruccion junto con sus argumentos
   en cada caso y escriben dicho codigo binario en el fichero binario. 
   Tambien realizan, si procede, tratamiento de errores. */
   

void agregar_etiqueta (char *etiqueta);
/* Actua si estamos en la primera pasada al fichero de codigo P.
   En ese caso, si etiqueta no esta presente en la tabla de etiquetas, la
   añade. Si ya estaba presente, muestra un mensaje de error en stdout. */

int referencia (char *etiqueta);
/* Devuelve la instruccion a la que esta asociada la etiqueta si esta aparece
   en la tabla de simbolos y estamos en la segunda pasada. 
   En caso contrario, devuelve NULO. */

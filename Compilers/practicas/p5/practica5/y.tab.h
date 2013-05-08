typedef union {
 LISTA cod; /* Codigo generado */
 char *cadena;
 int constante;
 struct{
   char *cad; /* Nombre de la accion */
   char *etiq; /* Etiqueta de la accion en la TS */
   SIMBOLO *simbolo; /* Puntero a la accion en la TS */
 }paraCabAccion;
 struct{
   SIMBOLO *simbolo; /* Puntero a la posicion en la TS */
   char *nombre;
 }paraID;
 TIPO_VARIABLE tipo;
 struct{
  TIPO_VARIABLE tipo; /* El tipo original */
  int esVariable; /* Para comprobar parametros por REF */
  int esParametroRef; /* Para comprobar parametros por REF */
  SIMBOLO *simbolo; /* Para la asignacion directa de vectores */
  int esConstEntera;  /* Para comprobar expresiones constantes al indexar un vector */
  int valorConstEntera; /* Calculo el valor constante para ver si esta dentro de los indices del vector */
  int esConstChar; /* Para comprobar constantes devueltas por caraent y entacar al indexar un vector */
  char valorConstChar; 
  int longitud; /* De las constCad, para saber cuantos WRT hacer */
  LISTA cod; /* Para generacion de codigo */
  char *cad; /* Para almacenar las cadenas de caracteres */
 }paraExp; /* Para todos los no terminales relacionados con expresiones */
 int ok;      /* Para varias acciones intermedias */
 LISTA lista; /* Para almacenar los parametros */
 CLASE_PARAMETRO clase; 
 SIMBOLO *simbolo;
 struct{
  TIPO_VARIABLE tipo;
  int indiceInf, indiceSup;
  int dimension;
  TIPO_VARIABLE tipo_componentes;
 }paraVector;
 struct{
   int constante; /* Numero de elementos hasta el momento */
   LISTA cod; /* Codigo generado */
 }paraListas;
} YYSTYPE;
#define	tPROGRAMA	257
#define	tACCION	258
#define	tCONSTENTERA	259
#define	tCONSTCHAR	260
#define	tCONSTCAD	261
#define	tTRUE	262
#define	tFALSE	263
#define	tENTACAR	264
#define	tCARAENT	265
#define	tIDENTIFICADOR	266
#define	tENTERO	267
#define	tCARACTER	268
#define	tBOOLEANO	269
#define	tESCRIBIR	270
#define	tLEER	271
#define	tOPAS	272
#define	tPRINCIPIO	273
#define	tFIN	274
#define	tNULA	275
#define	tVECTOR	276
#define	tDE	277
#define	tAND	278
#define	tOR	279
#define	tNOT	280
#define	tMQ	281
#define	tFMQ	282
#define	tMEI	283
#define	tMAI	284
#define	tNI	285
#define	tMOD	286
#define	tDIV	287
#define	tSI	288
#define	tENT	289
#define	tSI_NO	290
#define	tFSI	291
#define	tVAL	292
#define	tREF	293
#define	MENOSU	294


extern YYSTYPE yylval;

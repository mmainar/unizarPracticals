typedef union {
 int constante;
 char *cadena;
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
  int esConstante;  /* Para comprobar expresiones constantes */
  int valorConstante; /* Calculo el valor constante */
 }paraExp; /* Para todos los no terminales relacionados con expresiones */
 int ok;      /* Para varias acciones intermedias */
 SIMBOLO *simbolo;
 LISTA lista; /* Para los parametros */
 CLASE_PARAMETRO clase;
 struct{
  TIPO_VARIABLE tipo;
  int indiceInf, indiceSup;
  int dimension;
  TIPO_VARIABLE tipo_componentes;
 }paraVector;
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
#define	tVECTOR	275
#define	tDE	276
#define	tAND	277
#define	tOR	278
#define	tNOT	279
#define	tMQ	280
#define	tFMQ	281
#define	tMEI	282
#define	tMAI	283
#define	tNI	284
#define	tMOD	285
#define	tDIV	286
#define	tSI	287
#define	tENT	288
#define	tSI_NO	289
#define	tFSI	290
#define	tVAL	291
#define	tREF	292
#define	MENOSU	293


extern YYSTYPE yylval;

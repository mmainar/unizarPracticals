/**********************************************************************
 * Practicas de Compiladores II, 2008/2009
 * Fichero: etiquetas.h
 *          manejo de etiquetas para el ensamblador de codigo P
 **********************************************************************/

/**********************************************************************/
/*                        C O N S T A N T E S                         */
/**********************************************************************/

#define TRUE   1
#define FALSE  0
#define NULO  -1

#define MAXETIQ  10000

/**********************************************************************/
/*                              T I P O S                             */
/**********************************************************************/

typedef struct {
           char *nombre;
           short instr;
           short referenciada;
        } ETIQ;

/**********************************************************************/
/*                           F U N C I O N E S                        */
/**********************************************************************/

/**********************************************************************/
 void mostrar_etiquetas ();
/**********************************************************************
 Escribe en stderr los datos completos de las etiquetas que hay en la
 tabla de etiquetas.
***********************************************************************/

/**********************************************************************/
 void mostrar_etiquetas_no_referenciadas ();
/**********************************************************************
 Escribe en stderr los datos completos de las etiquetas que hay en la
 tabla de etiquetas y que no han sido referenciadas en el programa.
***********************************************************************/

/**********************************************************************/
 int buscar_etiqueta (char *etiqueta);
/**********************************************************************
 Busca etiqueta en la tabla de etiquetas.  Si la etiqueta existe,
 devuelve la instruccion a la que esta asociada, dlc, devuelve NULO.
***********************************************************************/

/**********************************************************************/
 void anadir_etiqueta (char *etiqueta, int instr);
/**********************************************************************
 Anade etiqueta, correspondiente a la instruccion instr, a la tabla
 de etiquetas.  Si la tabla esta llena, se escribe un error en stderr.
***********************************************************************/

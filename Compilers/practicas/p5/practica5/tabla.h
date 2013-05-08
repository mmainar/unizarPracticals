/**********************************************************************
 * fichero: tabla.h
 *          definiciones de una libreria de manejo de tablas de simbolos
 *
 * modificado por: Marcos Mainar Lalmolda
 * modificaciones realizadas:  - Permitir el tipo vector de una dimension 
 *                               con indices enteros y las componentes
 *                               pueden ser booleanos, enteros o caracteres.
 *                             - Añadir un campo referenciada en la T.S.
 *			         para indicar si una variable ha sido o no
 *				 referenciada. Cuando una variable se añade
 *				 a la T.S. se pone como no referenciada.
 *				 Procedimiento que muestra las variables no
 *				 referenciada.
 *
 * fecha ultima modificacion: 13 de mayo de 2009
 *
 *
 **********************************************************************/

/**********************************************************************/
/*                      D E F I N I C I O N E S                       */
/**********************************************************************/

#define TRUE            1
#define FALSE           0
#define TAMANO_TABLA    7    /* Numero de entradas en la tabla hash */

/**********************************************************************/
/*                              T I P O S                             */
/**********************************************************************/

typedef enum {
        PROGRAMA, 
        VARIABLE, 
        ACCION, 
        PARAMETRO, 
        } TIPO_SIMBOLO;

typedef enum {
        DESCONOCIDO,
        ENTERO,
        BOOLEANO,
        CHAR,
        CADENA,
	VECTOR /* Añadido */
        } TIPO_VARIABLE;

typedef enum {
        VAL,
        REF
        } CLASE_PARAMETRO;

typedef struct {
    char *nombre;
    int nivel;

    TIPO_SIMBOLO tipo;

    /* Variables */
    TIPO_VARIABLE variable;

    /* Si variable, direccion */
    int dir;

    /* Si accion, etiqueta primera instruccion */
    char etiq[50]; /* Lo aumento de 10 a 50 para permitir nombres de acciones mayores */

    /* Si es un parametro */
    CLASE_PARAMETRO parametro;
    int visible;
                 
    /* Si accion, lista de parametros */
    LISTA parametros;
    
    /* Añadidos estos campos que siguen para los vectores */
    
    /* Si vector, tipo de las componentes */
    TIPO_VARIABLE tipo_componentes; 
    /* Si vector, dimension e indices inicial y final del mismo */    
    int dimension; /*  = indiceSup - indiceInf + 1 */
    int indiceInf, indiceSup; 
    
    /* Para las variables, indica si ha sido o no referenciada */
    int referenciada; 
    
} SIMBOLO;

typedef LISTA TABLA_SIMBOLOS[TAMANO_TABLA];

/**********************************************************************/
/*                              M A C R O S                           */
/**********************************************************************/

#define ES_VARIABLE(e) ((e).tipo == VARIABLE)
#define ES_PARAMETRO(e) ((e).tipo == PARAMETRO)
#define ES_ACCION(e) ((e).tipo == ACCION)
#define ES_VALOR(e) (((e).tipo == PARAMETRO) && ((e).parametro == VAL))
#define ES_REFERENCIA(e) (((e).tipo == PARAMETRO) && ((e).parametro == REF))

/**********************************************************************/
/*                          F U N C I O N E S                         */
/**********************************************************************/

/**********************************************************************/
void inicializar_tabla (TABLA_SIMBOLOS tabla);
/**********************************************************************
Crea una tabla de simbolos vacia.  Este procedimiento debe invocarse 
antes de hacer ninguna operacion con la tabla de simbolos.
**********************************************************************/

/**********************************************************************/
SIMBOLO *buscar_simbolo (TABLA_SIMBOLOS tabla, 
                         char *nombre);
/**********************************************************************
Busca en la tabla el simbolo de mayor nivel cuyo nombre coincida
con el del parametro (se distinguen minusculas y mayusculas).  Si
existe, devuelve un puntero como resultado, de lo contrario devuelve
NULL.
**********************************************************************/

/**********************************************************************/
SIMBOLO *introducir_programa (TABLA_SIMBOLOS tabla, 
                              char *nombre, 
                              char* etiq);
/**********************************************************************
Introduce en la tabla un simbolo PROGRAMA,  con el nombre
del parametro, de nivel 0, con la direccion del parametro. Dado que debe
ser el primer simbolo a introducir, NO SE VERIFICA QUE EL SIMBOLO YA
EXISTA.
**********************************************************************/

/**********************************************************************/
SIMBOLO *introducir_variable (TABLA_SIMBOLOS tabla, 
                              char *nombre, 
                              TIPO_VARIABLE variable, 
                              int nivel, 
                              int dir);
/**********************************************************************
Si existe un simbolo en la tabla del mismo nivel y con el mismo
nombre, devuelve NULL.  De lo contrario, introduce un simbolo
VARIABLE (simple) con los datos de los argumentos.
**********************************************************************/

/**********************************************************************/
SIMBOLO *introducir_accion (TABLA_SIMBOLOS tabla, 
                            char *nombre, 
                            int nivel, 
                            char *etiq);
/**********************************************************************
Si existe un simbolo en la tabla del mismo nivel y con el mismo
nombre, devuelve NULL.  De lo contrario, introduce un simbolo
ACCION con los datos de los argumentos.
**********************************************************************/

/**********************************************************************/
SIMBOLO *introducir_parametro (TABLA_SIMBOLOS tabla, 
                               char *nombre, 
                               TIPO_VARIABLE variable, 
                               CLASE_PARAMETRO parametro, 
                               int nivel, 
                               int dir);
/**********************************************************************
Si existe un simbolo en la tabla del mismo nivel y con el mismo
nombre, devuelve NULL.  De lo contrario, introduce un simbolo
PARAMETRO con los datos de los argumentos. 
**********************************************************************/

/**********************************************************************/
void eliminar_programa (TABLA_SIMBOLOS tabla);
/**********************************************************************
Elimina de la tabla todos los simbolos PROGRAMA de nivel 0 (deberia 
haber uno solo).
**********************************************************************/

/**********************************************************************/
void eliminar_variables (TABLA_SIMBOLOS tabla, 
                         int nivel);
/**********************************************************************
Elimina de la tabla todas las variables (simples y vectores) que sean
del nivel del argumento. NO ELIMINA PARAMETROS.
**********************************************************************/

/**********************************************************************/
void ocultar_parametros (TABLA_SIMBOLOS tabla, 
                         int nivel);
/**********************************************************************
Marca todos los parametros de un nivel como ocultos para que no puedan
ser encontrados, pero se mantenga la definicion completa de la
accion donde estan declarados para verificacion de 
invocaciones a la accion.
**********************************************************************/

/**********************************************************************/
void eliminar_parametros_ocultos (TABLA_SIMBOLOS tabla, 
                                  int nivel);
/**********************************************************************
Elimina de la tabla todas los parametros que hayan sido ocultados
previamente.  LOS PROCEDIMIENTOS Y FUNCIONES DONDE ESTABAN DECLARADOS
DEBEN SER ELIMINAODS TAMBIEN PARA MANTENER LA COHERENCIA DE LA TABLA.
**********************************************************************/

/**********************************************************************/
void eliminar_acciones (TABLA_SIMBOLOS tabla, 
                        int nivel);
/**********************************************************************
Elimina de la tabla todas los proceidimientos de un nivel.  
LOS PARAMETROS DE ESTAS ACCIONES
DEBEN SER ELIMINADOS TAMBIEN PARA MANTENER LA COHERENCIA DE LA TABLA.
**********************************************************************/

/**********************************************************************/
void mostrar_variables_no_referenciadas (TABLA_SIMBOLOS tabla, int nivel);
/**********************************************************************
Muestra por pantalla las variables de la tabla de simbolos del nivel 
nivel que no han sido referenciadas.
**********************************************************************/

/**********************************************************************/
SIMBOLO *introducir_variable_vector (TABLA_SIMBOLOS tabla, char *nombre, 
                                     int nivel, int dir, TIPO_VARIABLE 
				     tipo_componentes, int indiceInf, 
				     int indiceSup, int dimension);
/**********************************************************************
Si existe un simbolo en la tabla del mismo nivel y con el mismo 
nombre, devuelve NULL. De lo contrario, introduce un simbolo 
VARIABLE de tipo vector con los datos de los argumentos.
**********************************************************************/

-- Tema: Fichero de especificación de un módulo para el trabajo con
--       ficheros indexados de cotizaciones de la práctica 3.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------
with ada.text_IO, ada. sequential_IO, fdircot;

use ada.text_IO, fdircot;

package FINDEXCOT is

 type tpFIndexCotizaciones is limited private;
 type tpClave is private;


 -- Operaciones básicas Organización Indexada.


 procedure asociar(f: in out tpFIndexCotizaciones; nomFich: in tpNomFich);
 -- Establece la conexión lógica o asociación con un fichero externo de
 -- nombre nomFich e inicia las estructuras de datos para el manejo del
 -- índice. Para los ficheros externos, se asumirá que el fichero de índice
 -- tendrá la extensión '.idx' y que la extensión '.dir' corresponderá al
 -- fichero directo con los datos de cotizaciones.

 procedure disociar(f: in out tpFIndexCotizaciones);
 -- Deshace el enlace establecido por la operación asociar.

 procedure leerCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                          cot: out cotizacion; exito: out boolean);
 -- Si existe en el fichero de datos una cotización donde la clave sea la
 -- misma que la suministrada, devuelve dicho dato en cot, y exito con valor
 -- Cierto, en caso contrario devuelve Falso en exito.

 procedure escribirCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                              cot: in cotizacion);
 -- Escribe en el fichero directo de datos la cotización dada en cot, y
 -- actualiza el índice de manera adecuada. Si existía en el fichero directo
 -- de datos previamente la cotización, se sustituye por los valores dados
 -- en cot.

 procedure eliminarCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                             exito: out boolean);
 -- Elimina del fichero de datos la cotización cuya clave es clave, y
 -- actualiza el índice de manera adecuada. Si la operación se realiza con
 -- éxito, devuelve Cierto, y en caso contrario Falso.

 procedure primeraClave(f: in out tpFIndexCotizaciones; clave: out tpClave;
                        exito: out boolean);
 -- Devuelve en clave la primera clave del fichero índice y Cierto en exito.
 -- Si no existen entradas en el fichero de índice, devuelve Falso en
 -- exito, y clave permanece inalterado.

 procedure siguienteClave(f: in out tpFIndexCotizaciones; clave: out tpClave;
                          exito: out boolean);
 -- Devuelve en clave la clave del índice que sigue a la última accedida, y
 -- Cierto en exito. Si no existen más entradas en el índice, devuelve
 -- Falso en éxito, y clave permanece inalterado.


 -- Operaciones mantenimiento de Organización Indexada.


 procedure generarIndice(f: in out tpFIndexCotizaciones);
 -- Reconstruye o genera el fichero de indice para la
 -- organizacion indexada de cotizaciones, f.

 procedure reestructurar(f: in out tpFIndexCotizaciones);
 -- Realiza operaciones de mantenimiento sobre la organización
 -- indexada, eliminando datos y entradas borradas o no válidas.


 -- Otras operaciones


 procedure borrarClave(f: in out tpFIndexCotizaciones; clave: in tpClave);
 -- Borra la clave del índice

 procedure borrarIndice(f: in out tpFIndexCotizaciones);
 -- Libera la memoria dinámica utilizada por el índice

 function creaClave (fecha: tpFecha; ticker: tpTicker) return tpClave;
 -- Devuelve la clave correspondiente a la fecha y ticker introducidos.

 procedure escribirClave (f: in out tpFIndexCotizaciones; clave: tpClave;
                          pos: tpPosicion);
 -- Escribe en el fichero de indice "f" el NRR y la clave relativos a un
 -- determinado dato.

 procedure crearFichIndice (f: in out tpFIndexCotizaciones; nombre: tpNomFich);
 -- Crea un fichero de indices, lo asocia a la variable "f" y le da nombre
 -- "nombre".

 procedure cerrarFichIndice (f: in out tpFIndexCotizaciones);
 -- Deshace la conexion entre el fichero de indice y la variable "f" que lo
 -- representa.

 procedure mostrarClave(clave: in tpClave);
 -- Muestra por pantalla la clave "clave"

 procedure primerElemtoIndice (f: in out tpFIndexCotizaciones;
                               cot: out cotizacion; exito: out boolean;
                               pos: out tpPosicion);
 -- Accede al primer elemento del indice y devuelve en "cot" la cotizacion
 -- almacenada en el fichero directo y referenciada por dicho elemento del
 -- indice. El valor de "exito" sera true en caso de completarse
 -- satisfactoriamente dicha operacion. En caso contrario, tendrá valor "false".

 procedure siguienteElemtoIndice (f: in out tpFIndexCotizaciones;
                                  cot: out cotizacion; exito: out boolean;
                                  pos: in out tpPosicion);
 -- Accede al elemento del indice que esta situado inmediatamente a continuacion
 -- del ultimo accedido y devuelve en "cot" la cotizacion almacenada en el
 -- fichero directo y referenciada por dicho elemento del indice. El valor de
 -- "exito" sera "true" en caso de completarse satisfactoriamente dicha
 -- operacion. En caso contrario, tendrá valor "false".

 function finIndice (f: tpFIndexCotizaciones) return boolean;
 -- Devuelve "true" si y solo si no quedan mas elementos por acceder en el
 -- indice.


private

 -- Clave de indexacion

 type tpClave is record
   fecha: tpFecha;
   ticker: tpTicker;
 end record;


 type tpIndice is record
   clave: tpClave;
   dirDato: tpPosicion; -- NRR en el fichero directo
 end record;

 -- Estructuras de datos para la carga en memoria dinamica del indice
 -- Utilizaremos una lista simple encadenada con punteros

 type nodo;
 type pNodo is access nodo;

 type nodo is record
   dato: tpIndice;
   sig: pNodo;
 end record;

 type lIndice is record
   primero: pNodo;
 end record;


 -- Fichero secuencial con el indice (con extension '.idx').


 package bibFichIndice is new ada.sequential_IO(tpIndice);
 use bibFichIndice;


 type tpFIndexCotizaciones is record
   fDir: tpFDirCotizaciones; -- Fichero directo con los datos
   fIndex: bibFichIndice.file_type; -- Fichero secuencial con el indice
   nombre: tpNomFich; -- Nombre del fichero sin extension
   indice: lIndice; -- Lista en memoria dinamica con el indice
   ultimaPos: tpPosicion; -- Ultima posicion accedida en el indice(ultimo NRR del fichero directo)
 end record;


end FINDEXCOT;
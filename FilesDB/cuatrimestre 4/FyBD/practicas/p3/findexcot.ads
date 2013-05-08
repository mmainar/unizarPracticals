-- Tema: Fichero de especificaci�n de un m�dulo para el trabajo con
--       ficheros indexados de cotizaciones de la pr�ctica 3.
-- Fecha de la �ltima revisi�n: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          Jos� Javier Colomer Vieitez. NIP: 550372
-- Versi�n: 1.0
--------------------------------------------------------------------------
with ada.text_IO, ada. sequential_IO, fdircot;

use ada.text_IO, fdircot;

package FINDEXCOT is

 type tpFIndexCotizaciones is limited private;
 type tpClave is private;


 -- Operaciones b�sicas Organizaci�n Indexada.


 procedure asociar(f: in out tpFIndexCotizaciones; nomFich: in tpNomFich);
 -- Establece la conexi�n l�gica o asociaci�n con un fichero externo de
 -- nombre nomFich e inicia las estructuras de datos para el manejo del
 -- �ndice. Para los ficheros externos, se asumir� que el fichero de �ndice
 -- tendr� la extensi�n '.idx' y que la extensi�n '.dir' corresponder� al
 -- fichero directo con los datos de cotizaciones.

 procedure disociar(f: in out tpFIndexCotizaciones);
 -- Deshace el enlace establecido por la operaci�n asociar.

 procedure leerCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                          cot: out cotizacion; exito: out boolean);
 -- Si existe en el fichero de datos una cotizaci�n donde la clave sea la
 -- misma que la suministrada, devuelve dicho dato en cot, y exito con valor
 -- Cierto, en caso contrario devuelve Falso en exito.

 procedure escribirCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                              cot: in cotizacion);
 -- Escribe en el fichero directo de datos la cotizaci�n dada en cot, y
 -- actualiza el �ndice de manera adecuada. Si exist�a en el fichero directo
 -- de datos previamente la cotizaci�n, se sustituye por los valores dados
 -- en cot.

 procedure eliminarCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                             exito: out boolean);
 -- Elimina del fichero de datos la cotizaci�n cuya clave es clave, y
 -- actualiza el �ndice de manera adecuada. Si la operaci�n se realiza con
 -- �xito, devuelve Cierto, y en caso contrario Falso.

 procedure primeraClave(f: in out tpFIndexCotizaciones; clave: out tpClave;
                        exito: out boolean);
 -- Devuelve en clave la primera clave del fichero �ndice y Cierto en exito.
 -- Si no existen entradas en el fichero de �ndice, devuelve Falso en
 -- exito, y clave permanece inalterado.

 procedure siguienteClave(f: in out tpFIndexCotizaciones; clave: out tpClave;
                          exito: out boolean);
 -- Devuelve en clave la clave del �ndice que sigue a la �ltima accedida, y
 -- Cierto en exito. Si no existen m�s entradas en el �ndice, devuelve
 -- Falso en �xito, y clave permanece inalterado.


 -- Operaciones mantenimiento de Organizaci�n Indexada.


 procedure generarIndice(f: in out tpFIndexCotizaciones);
 -- Reconstruye o genera el fichero de indice para la
 -- organizacion indexada de cotizaciones, f.

 procedure reestructurar(f: in out tpFIndexCotizaciones);
 -- Realiza operaciones de mantenimiento sobre la organizaci�n
 -- indexada, eliminando datos y entradas borradas o no v�lidas.


 -- Otras operaciones


 procedure borrarClave(f: in out tpFIndexCotizaciones; clave: in tpClave);
 -- Borra la clave del �ndice

 procedure borrarIndice(f: in out tpFIndexCotizaciones);
 -- Libera la memoria din�mica utilizada por el �ndice

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
 -- satisfactoriamente dicha operacion. En caso contrario, tendr� valor "false".

 procedure siguienteElemtoIndice (f: in out tpFIndexCotizaciones;
                                  cot: out cotizacion; exito: out boolean;
                                  pos: in out tpPosicion);
 -- Accede al elemento del indice que esta situado inmediatamente a continuacion
 -- del ultimo accedido y devuelve en "cot" la cotizacion almacenada en el
 -- fichero directo y referenciada por dicho elemento del indice. El valor de
 -- "exito" sera "true" en caso de completarse satisfactoriamente dicha
 -- operacion. En caso contrario, tendr� valor "false".

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
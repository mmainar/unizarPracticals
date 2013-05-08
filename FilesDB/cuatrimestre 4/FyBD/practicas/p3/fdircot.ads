-- Tema: Fichero de especificación de un módulo para el trabajo con
--       ficheros directos de cotizaciones de la práctica 3.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------
with ada.text_IO, ada.Direct_IO, fcotizaciones;

use ada.text_IO, fcotizaciones;

package FDIRCOT is

 subtype tpDia is integer range 0..31;
 subtype tpMes is integer range 0..12;
 subtype tpAnyo is integer range 0..99;

 type tpFecha is record
  dia: tpDia;
  mes: tpMes;
  anyo: tpAnyo;
 end record;

 type tpAccF is (L,E);

 type tpTicker is record
  nom: string(1..12);
  long: integer;
 end record;

 type tpNomFich is record
  nom: string(1..150);
  long: integer:=0;
 end record;


 type cotizacion is private;
 type tpFDirCotizaciones is limited private;
 type tpPosicion is private;


 -- Operaciones basicas de ficheros directos


 procedure asociar(f: in out tpFDirCotizaciones; nomFich: in tpNomFich);
 -- Establece la conexion logica o asociacion con un fichero externo
 -- de nombre nomFich.

 procedure disociar(f: in out tpFDirCotizaciones);
 -- Deshace el enlace establecido por la operacion asociar.

 function finFichero(f: in tpFDirCotizaciones) return boolean;
 -- Devuelve cierto si se ha alcanzado el final del fichero "f".

 procedure leerCotizacion(f: in out tpFDirCotizaciones; pos: in tpPosicion;
                          cot: out cotizacion; exito: out boolean);
 -- Lee del fichero directo "f" la cotizacion situada en la posicion "pos"
 -- Si se ha podido leer, exito=true y "cot" almacena la cotizacion leida.
 -- En casco contrario, exito=false y "cot" queda indefinido.

 procedure escribirCotizacion(f: in out tpFDirCotizaciones; pos: in tpPosicion;
                              cot: in cotizacion);
 -- Escribe en el fichero directo "f" la cotizacion "cot" en la posicion
 -- "pos".

 procedure nuevaPosicion(f: in out tpFDirCotizaciones; pos: out tpPosicion;
                         exito: out boolean);
 -- Crea una nueva posicion en el fichero directo "f" y la almacena en "pos".
 -- Si la operacion se ha podido realizar, exito=true, en caso contrario,
 -- exito=false.

 procedure eliminarPosicion(f: in out tpFDirCotizaciones; pos: in tpPosicion;
                            exito: out boolean);
 -- Elimina en el fichero directo "f" la cotizacion que ocupa la posicion
 -- "pos". Si la operacion se ha podido realizar, exito=true, en caso
 -- contrario, exito=false.

 procedure primeraCotizacion(f: in out tpFDirCotizaciones; cot: out cotizacion;
                             exito: out boolean);
 -- Lee la primera cotizacion del fichero directo "f" y la almacena en "cot".
 -- Si la operacion se realiza correctamente, exito=true, en caso contrario,
 -- exito=false.

 procedure siguienteCotizacion(f: in out tpFDirCotizaciones; cot: out cotizacion;
                               exito: out boolean);
 -- Lee la cotizacion del fichero directo "f" siguiente a la ultima cotizacion
 -- leida y la almacena en "cot".
 -- Si la operacion se realiza correctamente, exito=true, en caso contrario,
 -- exito=false.


 -- Otras operaciones


 procedure resetPos(pos: in out tpPosicion);
 -- Post: pos=0

 procedure setPos(pos: in out tpPosicion);
 -- Post: pos=1

 procedure incPos(pos: in out tpPosicion);
 -- Pre: pos=pos_0
 -- Post: pos=pos_0 + 1

 function fecha(cot: in cotizacion) return tpFecha;
 -- Devuelve la fecha de la cotizacion "cot".

 function ticker(cot: in cotizacion) return tpTicker;
 -- Devuelve el ticker de la cotizacion "cot".

 function crearCotizacion (pAper, pCier, pMaxSes, pMinSes, pVar: float;
                           sVar: integer; ticker: tpTicker; fecha: tpFecha)
                            return cotizacion;
 -- Devuelve una cotizacion cuyos campos tienen el valor de los argumentos
 -- suministrados. El valor del campo "valido" se inicializa a "true".

 procedure mostrarCotizacion (cot: cotizacion);
 -- Muestra por pantalla los valores de los campos de la cotizacion "cot"
 -- separados por caracteres de espaciado.

 procedure obtenerCotizacion (cot: out cotizacion);
 -- Solicita al usuario por pantalla que introduzca una cotizacion y la
 -- almacena en "cot".

 function transformarTicker(tick: fcotizaciones.tpTicker) return fdircot.tpTicker;
 -- Transforma el ticker definido en el modulo fcotizaciones a un ticker
 -- equivalente definido en este modulo.

 function transformarTicker(tick: fDirCot.tpTicker) return fCotizaciones.tpTicker;
 -- Transforma el ticker definido en este modulo a un ticker equivalente
 -- definido en el modulo fDirCot.

 procedure pideFecha(fecha: out tpFecha);
 -- Solicita al usuario por pantalla que introduzca una fecha y la
 -- almacena en "fecha".

 procedure ponerFecha (f: tpFecha);
 -- Escribe por pantalla la fecha "f".

 function pAper (cot: cotizacion) return float;
 -- Devuelve el precio de apertura de la cotizacion "cot".

 function pCier (cot: cotizacion) return float;
 -- Devuelve el precio de cierre de la cotizacion "cot".

 function pMaxSes (cot: cotizacion) return float;
 -- Devuelve el precio maximo de la sesion de la cotizacion "cot".

 function pMinSes (cot: cotizacion) return float;
 -- Devuelve el precio minimo de la sesion de la cotizacion "cot".

 function pVar (cot: cotizacion) return float;
 -- Devuelve el porcentaje de variacion de la cotizacion "cot".

 function sVar (cot: cotizacion) return integer;
 -- Devuelve el signo del porcentaje de variacion de la cotizacion "cot".

 function "<" (pos1, pos2: tpPosicion) return boolean;
 -- Devuelve "true" si y solo si la posicion "pos1" es anterior a la posicion
 -- "pos2".

 function "<=" (pos1, pos2: tpPosicion) return boolean;
 -- Devuelve "true" si y solo si la posicion "pos1" es anterior o igual a la
 -- posicion "pos2".

 function posActual(f: in tpFDirCotizaciones) return tpPosicion;
 -- Devuelve la posicion actual en el fichero directo de cotizaciones "f".

 procedure borraFichDirecto(f: in out tpFDirCotizaciones);
 -- Borra el fichero directo externo asociado con "f".

 function tamanyoDir(f: in tpFDirCotizaciones) return tpPosicion;
 -- Devuelve el tamaño actual del fichero externo asociado con "f".

 function heterogeneizar (cot: cotizacion) return cotizacion;
 -- Devuelve una cotizacion igual a "cot" salvo por el hecho de que su ticker
 -- tiene la longitud minima posible.




private

 type cotizacion is record
   fechaSesion: tpFecha;
   ticker: tpTicker;
   signoVariacion: integer;
   precioCierre, precioApertura, porcentajeVariacion: float;
   precioMaxSesion, precioMinSesion: float;
   valido: boolean:= true; -- Marca de borrado
 end record;


 -- Fichero directo de cotizaciones (extension '.dir').

 package bibFichDir is new ada.direct_IO(cotizacion);
 use bibFichDir;

 type tpPosicion is new bibFichDir.count;

 type tpFDirCotizaciones is record
   fich: bibFichDir.file_type;
 end record;


end FDIRCOT;
-- Tema: Fichero de especificación de un módulo para el trabajo con
--       ficheros secuenciales de cotizaciones de la práctica 3.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: El tratamiento del fichero se realiza byte a byte.
--------------------------------------------------------------------------
with ada.text_IO, ada.sequential_IO;

use ada.text_IO;

package FCOTIZACIONES is

 TAB: constant character:= character'Val(9);

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
  nom: string(1..20);
  long: integer:=0;
 end record;

 type tpNomFich is record
  nom: string(1..150);
  long: integer:=0;
 end record;


 type cotizacion is private;
 type tpFCotizaciones is limited private;


 function leerByte (f: in tpFCotizaciones) return integer;
 -- Devuelve el valor entero del byte que se esta leyendo
 -- en la posicion actual del fichero secuencial.
 function leerFecha (f: tpFCotizaciones) return tpFecha;
 -- Interpreta tres bytes del fichero secuencial como una fecha y devuelve
 -- un dato de dicho tipo.
 function creafecha(d,m,a: integer) return tpFecha;
 -- Devuelve la fecha con dia d, mes m y año a
 procedure pideFecha(fecha: out tpFecha);
 function comprobarFecha (f: tpFecha) return boolean;
 procedure asociar (f: in out tpFCotizaciones; nomFich: in tpNomFich;
                   modAccF: tpAccF; exito: out boolean);
 -- Establece la conexion logica o asociacion con un fichero externo
 -- de nombre nomFich. modAccF representa el modo de acceso al fichero
 -- (lectura L o escritura E). Devuelve Cierto si se ha podido
 -- realizar con exito y Falso en cualquier otro caso.
 procedure disociar (f: in out tpFCotizaciones);
 -- Deshace la asociacion establecida por la operacion asociar.
 procedure iniciarLectura (f: in out tpFCotizaciones);
 -- Prepara el fichero para comenzar a leer desde la primera posicion
 -- o dato del fichero.
 procedure iniciarEscritura (f: in out tpFCotizaciones);
 -- Prepara el fichero para comenzar a escribir en la primera cotizacion
 -- del fichero.
 function finFichero (f: tpFCotizaciones) return boolean;
 -- Informa de si no quedan mas datos por leer en el fichero.
 procedure leerCotizacion(f: in out tpFCotizaciones; cot: out cotizacion);
 -- Pre: modo(f)=Lec
 -- Post: Lee y devuelve en cot los datos de la siguiente cotizacion(si existe)
 -- almacenada en el fichero. Si esta era la ultima, finFichero devolvera
 -- verdad, y ventana de acceso indefinida. Si no, ventana sobre
 -- siguiente cotización.
 procedure escribirCotizacion (f: in out tpFCotizaciones;
                              cot: in cotizacion);
 -- Pre: modo(f)=Esc.
 -- Post: Escribe en el fichero f los datos de la cotizacion
 --       dada en cot.
 procedure tomar(f: in out tpFCotizaciones);
 -- Pre: modo(f)=Lec
 -- Post: Avanza una cotizacion en el fichero secuencial de
 --       cotizaciones f.
 procedure poner(f: in out tpFCotizaciones; cot: in cotizacion);
 -- Pre: modo(f)=Esc
 -- Post: Escribe en el fichero secuencial de cotizaciones f
 --       la cotizacion actual de la ventana de acceso.
 procedure mostrarCotizacion (cot: cotizacion);
 -- Muestra por pantalla los datos de la cotizacion cot.
 procedure escribirReal(f: in out tpFCotizaciones; num: in float);
 -- Pre: modo(f)=Esc
 -- Post: Escribe en el fichero secuencial de cotizaciones f
 --       el real num escribiendo los caracteres que lo forman.
 procedure escribirEntero(f: in out tpFCotizaciones; num: in integer);
 -- Pre: modo(f)=Esc
 -- Post: Escribe en el fichero secuencial de cotizaciones f
 --       el entero num escribiendo los caracteres que lo forman.
 function homogeneizar (cot: cotizacion) return cotizacion;
 -- Modifica la cotizacion "c" de tal manera que su ticker quede formado
 -- por 12 caracteres ( se añaden caracteres terminadores en caso
 -- necesario) y los campos corresopondientes al porcentaje de variación
 -- tengan siempre un valor asignado, sea este nulo o no.
 -- Se asume que todos los tickers están formados inicialmente por un
 -- numero de caracteres inferior a 12.
 procedure obtenerCotizacion (cot: out cotizacion);
 function fecha (cot: cotizacion) return tpFecha;
 -- Devuelve la fecha de la cotizacion "cot".
 function tick (cot: cotizacion) return tpTicker;
 -- Devuelve el ticker de la cotizacion "cot".
 procedure cotizacionVentana (f: in tpFCotizaciones;
                             cot: out cotizacion);
 -- Pre: modo(f)=Lec.
 -- Post: Devuelve la cotizacion de la ventana de acceso.
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
 function crearCotizacion (pAper, pCier, pMaxSes, pMinSes, pVar: float;
                          sVar: integer; ticker: tpTicker; fecha: tpFecha)
                            return cotizacion;


private

 type cotizacion is record
  fechaSesion: tpFecha;
  ticker: tpTicker;
  signoVariacion: integer;
  precioCierre, precioApertura, porcentajeVariacion: float;
  precioMaxSesion, precioMinSesion: float;
 end record;


 package bibFichSec is new ada.sequential_IO(character);
 use bibFichSec;

 type tpFCotizaciones is record
  fich: bibFichSec.file_type;
  ventana: cotizacion;
  fin: boolean:= false;
  fecha: tpFecha; -- Fecha en curso
  fechaEscrita: tpFecha:=(0,0,0);
 end record;

end FCOTIZACIONES;
-- Fichero: FCOTIZACIONES_P2.ads
-- Tema: Fichero de especificación de un módulo para el trabajo con
--       ficheros secuenciales de cotizaciones de la práctica 2.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: El tratamiento del fichero se realiza byte a byte.
--------------------------------------------------------------------------
with ada.text_IO, ada.sequential_IO;

use ada.text_IO;

package FCOTIZACIONES_p2 is

 TAB: constant character:= character'Val(9);
 n: constant integer:= 6; -- Numero de ficheros utilizados para la ordenacion
                         -- por mezcla polifasica

 subtype tpDia is integer range 0..31;
 subtype tpMes is integer range 0..12;
 subtype tpAnyo is integer range 0..99;
 subtype selFich is integer range 1..n; -- Para la mezcla polifasica
 subtype fTexto is ada.text_IO.file_type;

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
 type pFuncion is access function(c1, c2: cotizacion) return boolean;
 -- Puntero a la funcion de ordenacion de los datos que
 -- pasaremos como parametro en los metodos de ordenacion
 -- de ficheros secuenciales


 function leerByte (f: in tpFCotizaciones) return integer;
 -- Devuelve el valor entero del byte que se esta leyendo
 -- en la posicion actual del fichero secuencial.
 function leerFecha (f: tpFCotizaciones) return tpFecha;
 -- Interpreta tres bytes del fichero secuencial como una fecha y devuelve
 -- un dato de dicho tipo.
 function creafecha(d,m,a: integer) return tpFecha;
 -- Devuelve la fecha con dia d, mes m y año a
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
 function siguienteDato(f: in tpFCotizaciones) return cotizacion;
 -- Devuelve la siguiente cotizacion sin avanzar
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
 procedure escribirCotizacionT (t: in out fTexto; c: cotizacion);
 -- Pre: modo(t)=Esc
 -- Post: Escribe en el fichero de texto "t" la cotizacion "c"
 --       con el formato especificado en la practica 2.
 procedure leerCotizacionT (t: in out fTexto; c: out cotizacion);
 -- Pre: modo(t)=Lec
 -- Post: Lee del fichero de texto "t" una cotizacion y la devuelve en "c".
 procedure copiarFichero(fOrg, fDst: in out tpFCotizaciones);
 -- Post: fDst:= fOrg
 procedure Ord_MNatural(f: in out tpFCotizaciones; enOrden: in pFuncion);
 -- Realiza la ordenacion del fichero secuencial de cotizaciones "f"
 -- utilizando el metodo de ordenacion por mezcla natural y con la
 -- relacion de orden dada por la funcion "enOrden".
 procedure Ord_MPolifasica(f0: in out tpFCotizaciones; enOrden: in pFuncion);
 -- Realiza la ordenacion del fichero secuencial de cotizaciones "f"
 -- utilizando el metodo de ordenacion por mezcla polifasica y con la
 -- relacion de orden dada por la funcion "enOrden".

 -- Criterios de ordenacion de los datos de ficheros de cotizaciones

 function ordenPVariacion(c1, c2: cotizacion) return boolean;
 function ordenPrecioMaxSesion(c1, c2: cotizacion) return boolean;
 function ordenPrecioMinSesion(c1, c2: cotizacion) return boolean;
 function ordenPrecioCierre(c1, c2: cotizacion) return boolean;
 function ordenPrecioApertura(c1, c2: cotizacion) return boolean;
 function ordenFecha(c1, c2: cotizacion) return boolean;


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

end FCOTIZACIONES_p2;
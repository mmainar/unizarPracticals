
-- Tema: Fichero de especificación de un módulo para el trabajo con
--       ficheros secuenciales de cotizaciones de la práctica 1.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: El tratamiento del fichero se realiza utilizando bloques
--              de 512 bytes.
--------------------------------------------------------------------------
with ada.text_IO, ada.sequential_IO;

use ada.text_IO;

package FCOTIZACIONESPG is

 TAB: constant character:= character'Val(9);
 MAX: constant integer:= 512;

 subtype tpTexto is ada.text_IO.file_type;
 subtype longBloque is integer range 1..MAX;
 subtype longBloqueA is integer range 0..MAX;

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
  long: integer;
 end record;

 type tpNomFich is record
  nom: string(1..150);
  long: integer:=0;
 end record;

 type cotizacion is private;
 type tpFCotizacionesPG is limited private;
 type tpBuffer is private;


 -- Operaciones de lectura/escritura de bytes


 function leerByte (f: in tpFCotizacionesPG) return integer;
 -- Devuelve el valor entero del byte que se esta leyendo
 -- en la posicion actual del fichero secuencial.

 procedure escribirByte(f: in out tpFCotizacionesPG; c: in integer);
 -- Escribe el valor entero del byte c en la posicion
 -- actual del fichero secuencial f


 -- Operaciones con el buffer de bloques de 512 bytes


 procedure leerBloque (f: in out tpFCotizacionesPG);
 -- Pre: modo(f)=Lec
 -- Post: Lee un bloque de 512 bytes del fichero secuencial
 --       de cotizaciones f y lo guarda en un buffer.
 --       En caso de que queden menos de 512 bytes por leer
 --       en el fichero, lo lee hasta que se acabe.

 procedure escribirBloque(f: in out tpFCotizacionesPG);
 -- Escribe un bloque de 512 bytes en el fichero "f".

 procedure leerBuffer (f: in out tpFCotizacionesPG; dato: out integer);
 -- Devuelve el byte de la posicion actual de lectura del
 -- buffer

 procedure escribirBuffer(f: in out tpFCotizacionesPG; dato: in integer);
 -- Escribe dato en el buffer


 -- Operaciones de tratamiento de datos del tipo tpFecha


 function ">"(f1,f2:tpfecha) return boolean;
 -- devuelve cierto si f1 es posterior a f2

 function "<"(f1,f2:tpfecha) return boolean;
 -- devuelve cierto si f1 es anterior a f2

 function creafecha(d,m,a: integer) return tpFecha;
 -- devuelve la fecha con dia d, mes m y año a

 procedure leerFecha (f: in out tpFCotizacionesPG; fecha: out tpFecha);
 -- Interpreta tres bytes del fichero secuencial como una fecha y devuelve
 -- un dato de dicho tipo.

 procedure pideFecha(fecha: out tpFecha);
 -- Post: solicita al usuario que introduzca la fecha
 --       de una cotizacion y la almacena en "fecha".

 function esBisiesto (anyo: integer) return boolean;
 -- Post: Devuelve verdadero si el año introducido es bisiesto y
 --       falso en caso contrario.

 function comprobarFecha (f: tpFecha) return boolean;
 -- Devuelve cierto si y solo si la fecha "f" es coherente.


 -- Operaciones basicas de ficheros secuenciales de cotizaciones


 procedure Asociar (f: in out tpFCotizacionesPG; nomFich: in tpNomFich;
                   modAccF: tpAccF; exito: out boolean);
 -- Establece la conexion logica o asociacion con un fichero externo
 -- de nombre nomFich. modAccF representa el modo de acceso al fichero
 -- (lectura L o escritura E). Devuelve Cierto si se ha podido
 -- realizar con exito y Falso en cualquier otro caso.

 procedure Disociar (f: in out tpFCotizacionesPG);
 -- Deshace la asociacion establecida por la operacion asociar.

 procedure IniciarLectura (f: in out tpFCotizacionesPG);
 -- Prepara el fichero para comenzar a leer desde la primera posicion
 -- o dato del fichero.

 procedure IniciarEscritura (f: in out tpFCotizacionesPG);
 -- Prepara el fichero para comenzar a escribir en la primera cotizacion
 -- del fichero.

 function FinFichero (f: tpFCotizacionesPG) return boolean;
 -- Informa de si no quedan mas datos por leer en el fichero.

 function finBuffer(f: in tpFCotizacionesPG) return boolean;
 -- Devuelve cierto si y solo si se han leido todos los
 -- datos pendientes de leer en el buffer de lectura
 -- del fichero secuencial de cotizaciones f.

 procedure LeerCotizacion(f: in out tpFCotizacionesPG; cot: out cotizacion);
 -- Lee y devuelve en cot los datos de la siguiente cotizacion(si existe)
 -- almacenada en el fichero. Si esta era la ultima, finFichero devolvera
 -- verdad, y ventana de acceso indefinida. Si no, ventana sobre
 -- siguiente cotización.

 procedure escribirReal(f: in out tpFCotizacionesPG; num: in float);
 -- Pre: modo(f)=Esc
 -- Post: Escribe en el fichero secuencial de cotizaciones f
 --       el real num escribiendo los caracteres que lo forman.

 procedure escribirEntero(f: in out tpFCotizacionesPG; num: in integer);
 -- Pre: modo(f)=Esc
 -- Post: Escribe en el fichero secuencial de cotizaciones f
 --       el entero num escribiendo los caracteres que lo forman.

 procedure EscribirCotizacion (f: in out tpFCotizacionesPG;
                              cot: in cotizacion);
 -- Pre: modo(f)=Esc.
 -- Post: Escribe en el fichero f los datos de la cotizacion
 --       dada en cot.

 procedure EscribirCotizacionCliente(f: in out tpFCotizacionesPG;
                                    cot: in cotizacion);
 -- Escribe en f una cotizacion con el formato de la practica 0

 procedure CotizacionVentana (f: in out tpFCotizacionesPG;
                             cot: out cotizacion);
 -- Pre: modo(f)=Lec.
 -- Post: Devuelve la cotizacion de la ventana de acceso.

 procedure asignarVentana(f: in out tpFCotizacionesPG; cot: in cotizacion);
 -- Post: Pone en la ventana de acceso del fichero secuencial de
 --       cotizaciones f la cotizacion cot.

 procedure tomar(f: in out tpFCotizacionesPG);
 -- Pre: modo(f)=Lec
 -- Post: Avanza una cotizacion en el fichero secuencial de
 --       cotizaciones f.

 procedure poner(f: in out tpFCotizacionesPG);
 -- Pre: modo(f)=Esc
 -- Post: Escribe en el fichero secuencial de cotizaciones f
 --       la cotizacion actual de la ventana de acceso.


 -- Operaciones avanzadas de fichero secuenciales de cotizaciones


 procedure SiguienteCotizacionFecha (f: in out tpFCotizacionesPG;
                                    exito: out boolean);
 -- Pre: modo(f)=Lec.
 -- Post: Desde la posicion actual, recorre el fichero hasta alcanzar la
 -- primera cotizacion con fecha distinta a la fecha en curso, o fin
 -- de fichero. Devuelve Cierto si se ha podido encontrar dicha
 -- cotizacion, y Falso en cualquier otro caso.

 procedure SiguienteCotizacionTicker (f: in out tpFCotizacionesPG;
                                     t: tpTicker; exito: out boolean);
 -- Pre: Fichero f en modo lectura.
 -- Desde la posicion actual, recorre el fichero hasta alcanzar la siguiente
 -- cotizacion para el ticker dado. Devuelve Cierto en caso de encontrar
 -- dicha cotizacion y Falso en cualquier otro caso.

 procedure buscarCotizacion (f: in out tpFCotizacionesPG; fecha: in tpFecha;
                            t: in tpTicker; exito: out boolean; posicion: out integer);
 -- Busca en el fichero de cotizaciones f la cotizacion de ticker "t" y fecha "fecha".
 -- Si la cotizacion con dichos datos existe, exito=true y posicion es el numero
 -- de cotizacion dentro del fichero. Si no existe, exito= false y posicion queda
 -- indefinida.


 -- Operaciones propias de cotizaciones


 function fechaSes(cot: in cotizacion) return tpFecha;
 -- Devuelve la fecha de sesion de la cotizacion cot.

 function tick(cot: in cotizacion) return tpTicker;
 -- Devuelve el ticker de la cotizacion cot

 procedure ObtenerCotizacion (cot: out cotizacion);
 -- Solicita al usuario que introduzca los datos de una cotizacion bursátil
 -- y los devolverá en cot.

 procedure mostrarCotizacion (cot: cotizacion);
 -- Muestra por pantalla los datos de la cotizacion cot.

 procedure CompararCotizaciones (cot1, cot2: cotizacion;
                                igualdad: out integer);
 -- Pre: cot1 y cot2 deben corresponder al mismo valor bursátil
 -- Post: Devuelve en igualdad el resultado de la comparacion de cot1 y cot2.

private

 type tpDato is array(longBloque) of integer;

 type tpBuffer is record
  dato: tpDato;
  inf, sup: integer:=0;
  -- inf: dato que toca leer/escribir del buffer
  -- sup: datos que contiene el buffer
 end record;


 type cotizacion is record
  fechaSesion: tpFecha;
  ticker: tpTicker;
  signoVariacion: integer;
  precioCierre, precioApertura, porcentajeVariacion: float;
  precioMaxSesion, precioMinSesion: float;
 end record;


 package bibFichSec is new ada.sequential_IO(character);
 use bibFichSec;

 type tpFCotizacionesPG is record
  fich: bibFichSec.file_type;
  ventana: cotizacion;
  fin: boolean:= false;
  modo: tpAccF;
  buf: tpBuffer; -- Bloque en curso
  fecha, fechaEscrita, fechaAnt: tpFecha; -- Fechas relevantes
 end record;

end FCOTIZACIONESPG;
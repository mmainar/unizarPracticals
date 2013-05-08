-- Tema: Fichero de especificaci�n de un m�dulo para el trabajo con
--       los ficheros secuenciales de cotizaciones de la pr�ctica 0.
-- Fecha de la �ltima revisi�n: 24-3-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          Jos� Javier Colomer Vieitez. NIP: 550372
-- Versi�n: 1.0
-- Comentarios: Permite realizar funciones elementales con los ficheros
--              secuenciales de cotizaciones de la pr�ctica 0.
--------------------------------------------------------------------------
with ada.sequential_IO, ada.text_IO;

package herramientas_fich is

 TAB: constant character:= character'val(9);

 package bibFichRenta is new ada.sequential_IO(character);
 use bibFichRenta;
 subtype tpFichero is bibFichRenta.file_type;
 subtype tpTexto is ada.text_IO.file_type;
 type tpFecha is record
  dia, mes, anyo: integer;
 end record;

 type tpResumen is record
  ultPrecio, precioCierre, maxPrecio, minPrecio, variacion: float;
 end record;

 type tpCotizacion is private;


 function leerByte (f: in tpFichero) return integer;
 -- Post: Devuelve el valor del byte que se est� leyendo en la posici�n
 --       actual del fichero secuencial.
 function leerCotizacionDia (f: in tpFichero) return tpCotizacion;
 -- Post: Devuelve una estructura de datos que contiene toda la
 --       informaci�n referente a la cotizaci�n de un determinado d�a.
 procedure mostrarCotizacion (c: in tpCotizacion);
 -- Post: Muestra por pantalla una cotizaci�n "c".
 procedure obtenerUltimo (f: in tpFichero);
 -- Pre: (modo(f) = Lec) AND (numLeidos(f) = 0)
 -- Post: Escribe por pantalla el �ltimo precio de cierre en el
 --       trimestre anterior.
 function leerFecha (f: in tpFichero) return tpFecha;
 -- Post: Interpreta tres bytes del fichero secuencial "f" como una fecha
 --       y devuelve un dato de dicho tipo.
 procedure crearFTexto (f: in tpFichero; t: in out tpTexto);
 -- Post: Crea un archivo de texto "t" que contiene todas las cotizaciones
 --       del fichero "f" y un resumen de las mismas al final del fichero.
 procedure escribirCotizacion (c: tpCotizacion; t: in out tpTexto);
 -- Post: Rellena una l�nea de un fichero de texto "t" con una cotizaci�n
 --       "c".

private

 type tpCotizacion is record
  fechaSesion: tpFecha;
  precioCierre, precioApertura: float;
  signoVariacion: integer;
  porcentajeVariacion, precioMaxSesion, precioMinSesion: float;
 end record;

end herramientas_fich;
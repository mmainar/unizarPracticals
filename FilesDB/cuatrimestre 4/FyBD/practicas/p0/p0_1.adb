-- Fichero: p0_1.adb
-- Tema: Visor de ficheros secuenciales de cotizaciones.
-- Fecha de la última revisión: 24-3-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: Permite visualizar por pantalla el contenido de cualquier
--              fichero en el formato secuencial expuesto en la práctica,
--              cotización a cotización.
--              En cada línea muestra los datos de una cotización,
--              separando entre dato y dato por un espacio en blanco.
--              Se considera además que se utiliza el programa con
--              ficheros correctos, es decir, sin errores en los datos
--              almacenados.
--------------------------------------------------------------------------
with herramientas_fich, ada.text_IO;

use herramientas_fich, ada.text_IO;

procedure p0_1 is

 f: bibFichRenta.file_type;
 dato: tpCotizacion;
 nombre: string(1..150);
 longitud: integer;
 esCorrecto: boolean:= false;
begin
 while not esCorrecto loop
  begin
    put("Nombre del fichero de cotizaciones: "); get_line(nombre, longitud);
    bibFichRenta.open (f, bibFichRenta.in_file, nombre(1..longitud));
    esCorrecto:= true;
    exception
      when bibFichRenta.Name_Error =>
        put_line("El fichero introducido no existe, por favor, introduzca el nombre correcto");
        new_line;
  end;
 end loop;
 while not bibFichRenta.end_of_file(f) loop
   dato:= leerCotizacionDia(f);
   mostrarCotizacion(dato);
 end loop;
end p0_1;
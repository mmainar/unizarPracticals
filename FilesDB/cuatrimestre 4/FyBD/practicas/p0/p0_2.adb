-- Tema: A partir de un fichero secuencial de cotizaciones, genera un
--       nuevo fichero de texto que contiene los datos de las cotizaciones
--       del fichero original.
-- Fecha de la última revisión: 24-3-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: El nombre del fichero de texto deberá poder ser
--              especificado por el usuario.
--------------------------------------------------------------------------
with ada.text_IO, herramientas_fich;

use ada.text_IO, herramientas_fich;

procedure p0_2 is

 nombre: string(1..150);
 long: integer;
 f: bibFichRenta.file_type;
 t: tpTexto;
 esCorrecto: boolean:= false;
begin
 while not esCorrecto loop
   begin
     put("Introduzca el nombre del fichero de cotizaciones: ");
     get_line(nombre, long);
     bibFichRenta.open(f, bibFichRenta.in_file, nombre(1..long));
     esCorrecto:= true;
     exception
       when bibFichRenta.Name_Error =>
         put_line("El fichero introducido no existe, por favor, introduzca el nombre correcto");
         new_line;
   end;
 end loop;
 put("Introduzca el nombre del fichero de texto a crear: ");
 get_line(nombre,long);
 create(t, out_file, nombre(1..long));
 put_line(t, nombre(1..long-4));
 crearFTexto(f,t);
 bibFichRenta.close(f); close(t);
 put("El fichero "); put('"'); put(nombre(1..long)); put('"');
 put(" ha sido creado");
end p0_2;
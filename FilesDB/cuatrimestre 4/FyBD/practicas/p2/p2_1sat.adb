-- Tema: Programa que convierte un fichero secuencial de cotizaciones a
--       un formato de fichero de texto de cotizaciones.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------

with ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES_p2;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES_p2;


procedure p2_1sat is


 nomFich: tpNomFich;
 f: tpFCotizaciones;
 exito: boolean;
 t: fTexto;
 cot: cotizacion;
begin
 put("Introduzca el nombre del fichero secuencial de cotizaciones: ");
 get_line(nomFich.nom,nomFich.long);
 asociar(f,nomFich,tpAccF'first,exito);
 iniciarLectura(f);
 put("Nombre del fichero de texto a crear: ");
 get_line(nomFich.nom,nomFich.long);
 create(t,out_file,nomFich.nom(1..nomFich.long));
 while not finFichero(f) loop
   leerCotizacion(f,cot);
   escribirCotizacionT(t,cot);
 end loop;
 put("Fichero de texto creado correctamente"); new_Line;
 disociar(f); close(t);
end p2_1sat;
-- Tema: Programa que convierte un fichero de texto de cotizaciones a un
--       fichero secuencial de cotizaciones.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------

with ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES_p2;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES_p2;


procedure p2_1tas is


 nomFich: tpNomFich;
 f: tpFCotizaciones;
 exito: boolean;
 t: fTexto;
 cot: cotizacion;
begin
 put("Introduzca el nombre del fichero de texto de cotizaciones: ");
 get_line(nomFich.nom, nomFich.long);
 open(t, in_file, nomFich.nom(1..nomFich.long));
 put("Nombre del fichero secuencial de cotizaciones a crear: ");
 get_line(nomFich.nom, nomFich.long);
 asociar(f,nomFich,tpAccF'Last,exito);
 iniciarEscritura(f);
 while not end_of_file(t) loop
  leerCotizacionT(t, cot);
  escribirCotizacion(f, cot);
 end loop;
 put("Fichero creado."); new_line;
 disociar(f); close(t);
end p2_1tas;
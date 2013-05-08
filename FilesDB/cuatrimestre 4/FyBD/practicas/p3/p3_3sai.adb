-- Tema: Fichero de implementación de un conversor de ficheros secuenciales
--       de cotizaciones a ficheros de cotizaciones con organización
--       indexada.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------
with ada.text_IO, findexcot, fdircot, fcotizaciones;

use ada.text_IO, findexcot, fdircot, fcotizaciones;

procedure p3_3sai is


 posicDato: tpPosicion;
 cotizacionOrig: fcotizaciones.cotizacion;
 cotizacionDest: fdircot.cotizacion;
 exito: boolean:= false;
 fOrigen: tpFCotizaciones;
 fDestDir: tpFDirCotizaciones;
 fDestInd: tpFIndexCotizaciones;
 nombreFOrigen: fcotizaciones.tpNomFich;
 nombreFDest: fdircot.tpNomFich;
 tickerDest: fdircot.tpTicker;
 fechaDest: fdircot.tpFecha;
begin
 resetPos(posicDato);
 put("Introduzca el nombre del fichero secuencial de cotizaciones: ");
 get_line(nombreFOrigen.nom, nombreFOrigen.long);
 fcotizaciones.asociar(fOrigen, nombreFOrigen, L, exito);
 if not exito
  then put("No se ha encontrado el fichero de cotizaciones indicado.");
  else put("Nombre del fichero de cotizaciones con organizacion indexada");
       put(" (No introduzca la extension del archivo):  ");
       get_line(nombreFDest.nom, nombreFDest.long);
       -- Preparamos el nombre del fichero directo.
       nombreFDest.long:= nombreFDest.long+4;
       nombreFDest.nom(nombreFDest.long-3..nombreFDest.long):= ".dir";
       fdircot.asociar(fDestDir, nombreFDest);
       -- Preparamos el nombre del fichero de indice.
       nombreFDest.nom(nombreFDest.long-2..nombreFDest.long):= "idx";
       -- Creamos el fichero de indice.
       crearFichIndice(fDestInd, nombreFDest);
       -- Todos los ficheros asociados y preparados.
       -- Iniciamos la copia de datos.
       fcotizaciones.iniciarLectura(fOrigen);
       while not finFichero(fOrigen) loop
         fcotizaciones.leerCotizacion(fOrigen, cotizacionOrig);
         incPos(posicDato);
         -- Adaptamos la cotizacion leida para escribirla en el fichero directo.
         cotizacionOrig:= homogeneizar(cotizacionOrig);
         -- La transformamos en el tipo cotizacion empleado en el modulo fDirCot.
         tickerDest:= transformarTicker(tick(cotizacionOrig));
         fechaDest.dia:= fecha(cotizacionOrig).dia;
         fechaDest.mes:= fecha(cotizacionOrig).mes;
         fechaDest.anyo:= fecha(cotizacionOrig).anyo;
         cotizacionDest:= crearCotizacion (pAper(cotizacionOrig),
                                pCier(cotizacionOrig), pMaxSes(cotizacionOrig),
                                pMinSes(cotizacionOrig), pVar(cotizacionOrig),
                                sVar(cotizacionOrig), tickerDest, fechaDest);
         -- Fin de la transformacion. Escritura de la cotizacion.
         fDirCot.escribirCotizacion(fDestDir, posicDato, cotizacionDest);
         escribirClave(fDestInd, creaClave(fechaDest, tickerDest), posicDato);
       end loop;
       fcotizaciones.disociar(fOrigen);
       fdircot.disociar(fDestDir);
       cerrarFichIndice(fDestInd);
 end if;
 new_line; put("Fin de la ejecucion del programa." );
end p3_3sai;
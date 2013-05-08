-- Tema: Fichero de implementación de un conversor de ficheros de
--       cotizaciones con organización indexada a ficheros secuenciales de
--       cotizaciones.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------
with ada.text_IO, fIndexCot, fDirCot, fcotizaciones, ada.integer_text_io;

use ada.text_IO, fIndexCot, fDirCot, fCotizaciones, ada.integer_text_io;

procedure p3_3ias is


 exito: boolean:= false;
 fOrigen: tpFIndexCotizaciones;
 fDest: tpFCotizaciones;
 nombreFOrigen: fDirCot.tpNomFich;
 nombreFDest: fCotizaciones.tpNomFich;
 tickerDest: fCotizaciones.tpTicker;
 fechaDest: fCotizaciones.tpFecha;
 cotOrigen: fDirCot.cotizacion;
 cotDest: fCotizaciones.cotizacion;
 pos: tpPosicion;
begin
 put("Introduzca el nombre del fichero de cotizaciones con organizacion");
 put(" indexada (no introduzca la extension del archivo): ");
 get_line(nombreFOrigen.nom, nombreFOrigen.long);
 begin
  fIndexCot.asociar(fOrigen, nombreFOrigen);
  exception
    when NAME_ERROR => put("Nombre del fichero incorrecto.");
 end;
 put("Nombre del fichero destino: ");
 get_line(nombreFDest.nom, nombreFDest.long);
 -- Preparamos el nombre del fichero destino.
 nombreFDest.nom(nombreFDest.long-3..nombreFDest.long):= ".dat";
 fCotizaciones.asociar(fDest, nombreFDest, E, exito);
 if not exito
  then put("Ha habido un problema al asociar el fichero destino."); new_line;
       put("Conversion suspendida."); new_line;
  else put("Iniciando la copia..."); new_line;
       fCotizaciones.iniciarEscritura(fDest);
       if not finIndice(fOrigen)
         then primerElemtoIndice(fOrigen, cotOrigen, exito, pos);
              if exito
                then cotOrigen:= heterogeneizar(cotOrigen);
                     -- La transformamos en el tipo cotizacion empleado en el
                     -- modulo fCotizaciones.
                     tickerDest:= transformarTicker(ticker(cotOrigen));
                     fechaDest.dia:= fecha(cotOrigen).dia;
                     fechaDest.mes:= fecha(cotOrigen).mes;
                     fechaDest.anyo:= fecha(cotOrigen).anyo;
                     cotDest:= crearCotizacion (pAper(cotOrigen), pCier(cotOrigen),
                                         pMaxSes(cotOrigen), pMinSes(cotOrigen),
                                         pVar(cotOrigen), sVar(cotOrigen),
                                         tickerDest, fechaDest);
                     escribirCotizacion(fDest, cotDest);
              end if;
       end if;
       while not finIndice(fOrigen) loop
         siguienteElemtoIndice(fOrigen, cotOrigen, exito, pos);
         if exito
           then cotOrigen:= heterogeneizar(cotOrigen);
                -- La transformamos en el tipo cotizacion empleado en el
                -- modulo fCotizaciones.
                tickerDest:= transformarTicker(ticker(cotOrigen));
                fechaDest.dia:= fecha(cotOrigen).dia;
                fechaDest.mes:= fecha(cotOrigen).mes;
                fechaDest.anyo:= fecha(cotOrigen).anyo;
                cotDest:= crearCotizacion (pAper(cotOrigen), pCier(cotOrigen),
                                    pMaxSes(cotOrigen), pMinSes(cotOrigen),
                                    pVar(cotOrigen), sVar(cotOrigen),
                                    tickerDest, fechaDest);
                escribirCotizacion(fDest, cotDest);
         end if;
       end loop;
       siguienteElemtoIndice(fOrigen, cotOrigen, exito, pos);
       if exito
         then cotOrigen:= heterogeneizar(cotOrigen);
              -- La transformamos en el tipo cotizacion empleado en el
              -- modulo fCotizaciones.
              tickerDest:= transformarTicker(ticker(cotOrigen));
              fechaDest.dia:= fecha(cotOrigen).dia;
              fechaDest.mes:= fecha(cotOrigen).mes;
              fechaDest.anyo:= fecha(cotOrigen).anyo;
              cotDest:= crearCotizacion (pAper(cotOrigen), pCier(cotOrigen),
                                  pMaxSes(cotOrigen), pMinSes(cotOrigen),
                                  pVar(cotOrigen), sVar(cotOrigen),
                                  tickerDest, fechaDest);
              escribirCotizacion(fDest, cotDest);
       end if;
       put("Copia realizada."); new_line;
       disociar(fOrigen);
       disociar(fDest);
 end if;
 new_line; put("Fin de la ejecucion del programa." );
end p3_3ias;
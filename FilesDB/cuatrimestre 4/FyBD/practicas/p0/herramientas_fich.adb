-- Tema: Fichero de implementación de un módulo para el trabajo con
--       los ficheros de cotizaciones de la práctica 0.
-- Fecha de la última revisión: 24-3-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: Permite realizar funciones elementales con los ficheros
--              secuenciales de cotizaciones de la práctica 0.
--              Para ver con más detalle las funciones, consultar el
--              fichero de especificación del módulo: herramientas_fich.ads
--------------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

package body herramientas_fich is

 function leerByte (f: in tpFichero) return integer is

    c: character;
 begin
   read(f,c);
   return character'Pos(c);
 end leerByte;


 function leerFecha (f: tpFichero) return tpFecha is

   fecha: tpFecha;
   contador: integer:= 3;
 begin
   while contador/=0 and not end_of_file(f) loop
     case contador is
       when 3 => fecha.dia:= leerByte(f);
       when 2 => fecha.mes:= leerByte(f);
       when 1 => fecha.anyo:= leerByte(f);
       when others => null;
     end case;
     contador:= contador-1;
   end loop;
   return fecha;
 end leerFecha;


 function leerCotizacionDia (f: in tpFichero) return tpCotizacion is

   dato: tpCotizacion;
 begin
  if end_of_file(f) then
    put("Fichero terminado");
    return dato;
  else
    dato.fechaSesion:= leerFecha(f);
    dato.precioCierre:= float(leerByte(f))+float(leerByte(f))/100.0;
    dato.precioApertura:= float(leerByte(f))+float(leerByte(f))/100.0;
    dato.signoVariacion:= leerByte(f);
    case dato.signoVariacion is
      when 0 => dato.porcentajeVariacion:= 0.0;
      when others => dato.porcentajeVariacion:= float(leerByte(f))
                                                + float(leerByte(f))/100.0;
    end case;
    dato.precioMaxSesion:= float(leerByte(f))+float(leerByte(f))/100.0;
    dato.precioMinSesion:= float(leerByte(f))+float(leerByte(f))/100.0;
    return dato;
  end if;
 end leerCotizacionDia;


 procedure mostrarCotizacion (c: tpCotizacion) is

  procedure ponerFecha (f: tpFecha) is
  -- Post: Muestra por pantalla la fecha "f".
  begin
    if f.dia/10=0
      then put('0'); put(f.dia,0);
      else put(f.dia,0);
    end if;
    if f.mes/10=0
      then put('0'); put(f.mes,0);
      else put(f.mes,0);
    end if;
    if f.anyo/10=0
      then put('0'); put(f.anyo,0);
      else put(f.anyo,0);
    end if;
  end ponerFecha;

  aux: integer;
 begin  -- de mostrarCotizacion.
  ponerFecha(c.fechaSesion);
  aux:= integer(c.precioCierre*100.0);
  put(aux,5); aux:= integer(c.precioApertura*100.0);
  put(aux,5); put(c.signoVariacion,2); put(' ');
  aux:= integer(c.porcentajeVariacion*10.0);
  if aux<10 then put(aux/10,1); put(aux mod 10,1);
  else put(aux mod 100,0);
  end if;
  aux:= integer(c.precioMaxSesion*100.0); put(aux,5);
  aux:= integer(c.precioMinSesion*100.0); put(aux,5);
  new_line;
 end mostrarCotizacion;


 procedure escribirResumen (res: tpResumen; t: in out tpTexto) is
 -- Escribe, en una linea del fichero "t", el resumen de la cotizacion
 -- del trimestre.

 begin
  put(t,TAB); put(t,TAB);
  put(t, res.precioCierre,0,2,0); put(t, TAB);
  put(t, res.ultPrecio,0,2,0); put(t, TAB);
  if (res.variacion>0.0) then put(t,'+'); end if;
  put(t, res.variacion,0,1,0); put(t,'%'); put(t,TAB);
  put(t, res.maxPrecio,0,2,0); put(t, TAB);
  put(t, res.minPrecio,0,2,0);
 end escribirResumen;


 procedure escribirCotizacion (c: tpCotizacion; t: in out tpTexto) is

  procedure ponerFecha (f: tpFecha; t: in out tpTexto) is
  -- Post: Muestra por pantalla la fecha f.

  begin
    if f.dia/10=0
      then put(t, '0'); put(t, f.dia,0);
      else put(t, f.dia,0);
    end if;
    put(t,'/');
    if f.mes/10=0
      then put(t, '0'); put(t, f.mes,0);
      else put(t, f.mes,0);
    end if;
    put(t, '/');
    if f.anyo/10=0
      then put(t, '0'); put(t, f.anyo,0);
      else put(t, f.anyo,0);
    end if;
  end ponerFecha;

 begin  -- de escribirCotizacion.
  ponerFecha(c.fechaSesion, t); put(t,TAB);
  put(t, c.precioCierre,0,2,0); put(t,TAB);
  put(t, c.precioApertura,0,2,0); put(t,TAB);
  case c.signoVariacion is
    when 1 => put(t, '+');
    when 2 => put(t, '-');
    when others => null;
  end case;
  put(t, c.porcentajeVariacion,0,1,0); put(t,'%'); put(t,TAB);
  put(t, c.precioMaxSesion,0,2,0); put(t,TAB);
  put(t, c.precioMinSesion,0,2,0);
  new_line(t);
 end escribirCotizacion;


 procedure obtenerUltimo (f: in tpFichero) is

 begin
  for i in 1..12 loop put(" "); end loop;
  put(leerByte(f),0); put(leerByte(f),0);
  new_line;
 end obtenerUltimo;


 procedure crearFTexto (f: tpFichero; t: in out tpTexto) is

  procedure actualizarResumen (c: tpCotizacion; ppo: boolean;
                               final: in out tpResumen) is
  -- Actualiza el resumen del trimestre de la siguiente manera:
  -- Si ppo=true, asigna a todos los campos de "final" los valores de los
  -- campos correspondientes de "c" excepto al "campo final.variacion"
  -- para el cual calcula ya su valor definitivo.
  -- Si no, compara los campos de la cotizacion "c" con los campos del resumen
  -- "final" y, en caso de ser necesario, actualiza los valores de estos.

  begin
    if ppo
      then final.precioCierre:= c.precioCierre;
           final.maxPrecio:= c.precioCierre;
           final.minPrecio:= c.precioCierre;
           final.variacion:= (final.precioCierre-final.ultPrecio)*100.0/final.precioCierre;
      else
        if final.maxPrecio < c.precioCierre
          then final.maxPrecio:= c.precioCierre;
        end if;
        if final.minPrecio > c.precioCierre
          then final.minPrecio:= c.precioCierre;
        end if;
    end if;
  end actualizarResumen;


  c: tpCotizacion;
  resumen: tpResumen;
 begin  -- de crearFTexto.
  -- Damos valor al campo precioCierre del resumen "final".
  resumen.ultPrecio:= float(leerByte(f)) + float(leerByte(f))/100.0;
  -- Cabecera del fichero de texto.
  for i in 1..80 loop put(t, '='); end loop; new_line(t);
  put(t,"Fecha"); put(t,TAB); put(t,TAB);
  put(t, "Cierre"); put(t,TAB); put(t, "Aper.");
  put(t, TAB); put(t, "%Dif"); put(t,TAB);
  put(t, "Max"); put(t,TAB); put(t, "Min"); new_line(t);
  -- Comenzamos la escritura de datos en el fichero.
  if not end_of_file(f)
    then c:= leerCotizacionDia(f);
         actualizarResumen(c, true, resumen);
         escribirCotizacion(c, t);
  end if;
  while not end_of_file(f) loop
    c:= leerCotizacionDia(f);
    actualizarResumen(c, false, resumen);
    escribirCotizacion(c, t);
  end loop;
  escribirResumen(resumen, t);
 end crearFTexto;

end herramientas_fich;
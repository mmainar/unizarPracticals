-- Fichero: FDIRCOT.adb
-- Tema: Fichero de implementación de un módulo para el trabajo con
--       ficheros directos de cotizaciones de la práctica 3.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, ada.float_text_IO, ada.Direct_IO;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

package body FDIRCOT is


 procedure asociar(f: in out tpFDirCotizaciones; nomFich: in tpNomFich) is
 begin
   open(f.fich,Inout_file, nomFich.nom(1..nomFich.long));
   --put_line("Se ha abierto el fichero directo de cotizaciones"); new_Line;
   exception
     -- Si no existía un fichero externo de nombre "nomFich", lo creamos
     when bibFichDir.NAME_ERROR =>
            create(f.fich,Inout_file,nomFich.nom(1..nomFich.long));
            --put_line("Se ha creado el fichero"); new_Line;
     when bibFichDir.USE_ERROR => null;
            --put_line("El fichero directo de cotizaciones ya estaba abierto");
            --new_Line;
 end asociar;


 procedure disociar(f: in out tpFDirCotizaciones) is
 begin
   close(f.fich);
 end disociar;


 function finFichero(f: in tpFDirCotizaciones) return boolean is
 begin
   return end_of_file(f.fich);
 end finFichero;


 procedure leerCotizacion(f: in out tpFDirCotizaciones; pos: in tpPosicion;
                          cot: out cotizacion; exito: out boolean) is
 begin
   if pos<=size(f.fich) then
     read(f.fich,cot,pos);
     -- Comprobamos si la posición leida era válida
     exito:= cot.valido;
   else exito:= false;
   end if;
 end leerCotizacion;


 procedure escribirCotizacion(f: in out tpFDirCotizaciones; pos: in tpPosicion;
                              cot: in cotizacion) is
 begin
   write(f.fich,cot,pos);
 end escribirCotizacion;


 procedure nuevaPosicion(f: in out tpFDirCotizaciones; pos: out tpPosicion;
                         exito: out boolean) is
   cot: cotizacion;
 begin
   -- Generamos una nueva posicion al final del fichero
   pos:= size(f.fich)+1;
   -- Escribimos en la nueva posicion una cotizacion no valida
   cot.valido:= false;
   write(f.fich,cot,pos);
   exito:= true;
   -- Comprobamos si la capacidad del fichero externo se ha sobrepasado
   exception
     when bibFichDir.USE_ERROR => exito:= false;
 end nuevaPosicion;


 procedure eliminarPosicion(f: in out tpFDirCotizaciones; pos: in tpPosicion;
                            exito: out boolean) is
   cot: cotizacion;
 begin
   if pos<=size(f.fich) then
     cot.valido:= false;
     write(f.fich,cot,pos);
     exito:= true;
   else exito:= false;
   end if;
 end eliminarPosicion;


 procedure primeraCotizacion(f: in out tpFDirCotizaciones; cot: out cotizacion;
                             exito: out boolean) is
   pos: tpPosicion;
 begin
   setPos(pos);
   if size(f.fich)>=pos then
     leerCotizacion(f,1,cot,exito);
   else exito:= false;
   end if;
 end primeraCotizacion;


 procedure siguienteCotizacion(f: in out tpFDirCotizaciones; cot: out cotizacion;
                               exito: out boolean) is
   indice: tpPosicion;
 begin
   indice:= index(f.fich);
   set_index(f.fich,indice);
   if indice<=size(f.fich) then
     leerCotizacion(f,indice,cot,exito);
   else exito:= false;
   end if;
 end siguienteCotizacion;


 procedure resetPos(pos: in out tpPosicion) is
 begin
   pos:= 0;
 end resetPos;


 procedure setPos(pos: in out tpPosicion) is
 begin
   pos:= 1;
 end setPos;


 procedure incPos(pos: in out tpPosicion) is
 begin
   pos:= pos+1;
 end incPos;


 function fecha(cot: in cotizacion) return tpFecha is
 begin
   return cot.fechaSesion;
 end fecha;


 function ticker(cot: in cotizacion) return tpTicker is
 begin
   return cot.ticker;
 end ticker;


 function crearCotizacion (pAper, pCier, pMaxSes, pMinSes, pVar: float;
                           sVar: integer; ticker: tpTicker; fecha: tpFecha)
                            return cotizacion is
   cot: cotizacion;
 begin
   cot.precioApertura:= pAper; cot.precioCierre:= pCier;
   cot.precioMaxSesion:= pMaxSes; cot.precioMinSesion:= pMinSes;
   cot.porcentajeVariacion:= pVar; cot.signoVariacion:= sVar;
   cot.valido:= true; cot.ticker:= ticker; cot.fechaSesion:= fecha;
   return cot;
 end crearCotizacion;


 procedure ponerFecha (f: tpFecha) is
 -- Muestra por pantalla la fecha f.
 begin
   if f.dia/10=0
     then put('0'); put(f.dia,0);
     else put(f.dia,0);
   end if;
   put('/');
   if f.mes/10=0
     then put('0'); put(f.mes,0);
     else put(f.mes,0);
   end if;
   put('/');
   if f.anyo/10=0
     then put('0'); put(f.anyo,0);
     else put(f.anyo,0);
   end if;
 end ponerFecha;


 procedure mostrarCotizacion (cot: cotizacion) is

   procedure ponerCabecera is
   -- Pone una cabecera para indicar el significado
   -- de los datos de cotizaciones escritos
   begin
     put("Fecha"); put(TAB); put(TAB); put("Ticker");
     put(TAB); put("Cierre"); put(TAB);
     put("Aper."); put(TAB); put("%Var."); put(TAB);
     put("Max."); put(TAB); put("Min."); put(TAB);
     new_Line;
   end ponerCabecera;

   i: integer:= 1;
 begin  -- de mostrarCotizacion.
   ponerCabecera;
   ponerFecha(cot.fechaSesion); put(TAB); put(TAB);
   while (cot.ticker.nom(i) /= character'val(126)) loop
     put(cot.ticker.nom(i));
     i:= i+1;
   end loop;
   put(TAB);
   put(cot.precioCierre,0,2,0); put(TAB);
   put(cot.precioApertura,0,2,0); put(TAB);
   case cot.signoVariacion is
     when 1 => put('+');
     when 2 => put('-');
     when others => null;
   end case;
   put(cot.porcentajeVariacion,0,1,0); put('%'); put(TAB);
   put(cot.precioMaxSesion,0,2,0); put(TAB);
   put(cot.precioMinSesion,0,2,0);
   new_line(2);
 end mostrarCotizacion;


 function esBisiesto (anyo: integer) return boolean is
 begin
   return ((anyo mod 4=0) and (not (anyo mod 100=0))) or (anyo mod 400=0);
 end esBisiesto;


 function comprobarFecha (f: tpFecha) return boolean is
   exito: boolean:= false;
 begin
   case f.mes is
     when 1|3|5|7|8|10|12 => exito:= f.dia>=1 and f.dia<=31;
     when 4|6|9|11 => exito:= f.dia>=1 and f.dia<=31;
     when 2 => if not esBisiesto(f.anyo+2000) then
                 exito:= f.dia>=1 and f.dia<=28;
               else exito:= f.dia>=1 and f.dia<=29;
               end if;
     when others => null;
   end case;
   return exito;
 end comprobarFecha;


 function creafecha(d,m,a: integer) return tpFecha is
 -- devuelve la fecha con dia d, mes m y año a
   f: tpfecha;
 begin
   f.dia:=d; f.mes:=m; f.anyo:=a;
   return f;
 end creafecha;


 procedure pideFecha(fecha: out tpFecha) is
   d,m,a: integer;
   correcto: boolean:= false;
 begin
   while not correcto loop
     begin
       put("Introduzca la fecha de la cotizacion, dejando un espacio para");
       put(" separar el dia del mes y del anyo."); new_line;
       put("OBSERVACION: Introduzca el anyo relativo al 2.000 (unicamente");
       put(" decenas y unidades, no incluya las centenas ni los millares).");
       new_line; put("Introduzca la fecha (formato dd mm aa): ");
       get(d); get(m); get(a); skip_Line;
       fecha:= creafecha(d,m,a); correcto:= comprobarFecha(fecha);
       if not correcto then
         put("La fecha introducida es incorrecta"); new_Line;
       end if;
       exception
         when CONSTRAINT_ERROR | ada.text_IO.DATA_ERROR=>
           put("Los valores introducidos no son apropiados.");
           new_line; skip_line;
     end;
   end loop;
 end pideFecha;


 procedure obtenerCotizacion (cot: out cotizacion) is
   c: character:= character'Val(126);
 begin
   put("Introduzca los datos de una cotizacion bursatil"); new_Line;
   pideFecha(cot.fechaSesion); new_Line;
   loop
     begin
       put("Ticker del valor bursatil(maximo 12 caracteres): ");
       get_line(cot.ticker.nom,cot.ticker.long);
       new_line; exit;
       exception
         when CONSTRAINT_ERROR => put("Elija un ticker valido."); new_line;
     end;
   end loop;
   -- Normalizamos el ticker para que la comparacion sea correcta
   while cot.ticker.long < 12 loop
     cot.ticker.long:= cot.ticker.long+1;
     cot.ticker.nom(cot.ticker.long):= c;
   end loop;
   loop
     begin
       put("Precio de cierre: "); get(cot.precioCierre); skip_Line; new_line;
       exit;
       exception
         when CONSTRAINT_ERROR|ada.text_IO.DATA_ERROR =>
           put_line("dato incorrecto"); skip_Line;
     end;
   end loop;
   loop
     begin
       put("Precio de apertura: "); get(cot.precioApertura); skip_Line;
       new_line; exit;
       exception
         when CONSTRAINT_ERROR|ada.text_IO.DATA_ERROR =>
          put_line("dato incorrecto"); skip_Line;
     end;
   end loop;
   loop
     begin
       put("Porcentaje de variacion: "); get(cot.porcentajeVariacion); skip_Line;
       new_line; exit;
       exception
         when CONSTRAINT_ERROR|ada.text_IO.DATA_ERROR =>
          put_line("dato incorrecto"); skip_Line;
     end;
   end loop;
   if (cot.porcentajeVariacion=0.0)
     then cot.signoVariacion:= 0;
   elsif (cot.porcentajeVariacion>0.0)
     then cot.signoVariacion:= 1;
   else cot.signoVariacion:= 2;
   end if;
   cot.porcentajeVariacion:= abs(cot.porcentajeVariacion);
   -- El valor absoluto es para evitar problemas al escribir por pantalla
   loop
     begin
       put("Precio Max. de sesion: "); get(cot.precioMaxSesion); skip_Line;
       new_line; exit;
       exception
         when CONSTRAINT_ERROR|ada.text_IO.DATA_ERROR =>
          put_line("dato incorrecto"); skip_Line;
     end;
   end loop;
   loop
     begin
       put("Precio Min. de sesion: "); get(cot.precioMinSesion); new_Line;
       new_line; exit;
       exception
         when CONSTRAINT_ERROR|ada.text_IO.DATA_ERROR =>
           put_line("dato incorrecto"); skip_Line;
     end;
   end loop;
   cot.valido:= true;
 end obtenerCotizacion;


 function transformarTicker (tick: in fcotizaciones.tpTicker)
                              return fdircot.tpTicker is

   ticker: fDirCot.tpTicker;
 begin
   for i in 1..tick.long loop
     ticker.nom(i):= tick.nom(i);
   end loop;
   ticker.long:= tick.long;
   return ticker;
 end transformarTicker;


 function transformarTicker (tick: in fdircot.tpTicker)
                             return fcotizaciones.tpTicker is

   ticker: fcotizaciones.tpTicker;
 begin
   for i in 1..tick.long loop
     ticker.nom(i):= tick.nom(i);
   end loop;
   ticker.long:= tick.long;
   return ticker;
 end transformarTicker;


 function posActual(f: in tpFDirCotizaciones) return tpPosicion is
 begin
   return index(f.fich);
 end posActual;


 procedure borraFichDirecto(f: in out tpFDirCotizaciones) is
 begin
   delete(f.fich);
 end borraFichDirecto;


 function tamanyoDir(f: in tpFDirCotizaciones) return tpPosicion is
 begin
   return size(f.fich);
 end tamanyoDir;


 function heterogeneizar (cot: in cotizacion) return cotizacion is
   exito: boolean;
   aux: cotizacion;
   c: character:= character'Val(126);
 begin
   aux:= cot;
   exito:= cot.ticker.nom(cot.ticker.long) = c and
           cot.ticker.nom(cot.ticker.long-1) /= c;
   while exito loop
     aux.ticker.long:= aux.ticker.long-1;
     exito:= cot.ticker.nom(cot.ticker.long) = c and
              cot.ticker.nom(cot.ticker.long-1) /= c;
   end loop;
   return aux;
 end heterogeneizar;


 function pAper (cot: cotizacion) return float is
 begin
   return cot.precioApertura;
 end pAper;


 function pCier (cot: cotizacion) return float is
 begin
   return cot.precioCierre;
 end pCier;


 function pMaxSes (cot: cotizacion) return float is
 begin
   return cot.precioMaxSesion;
 end pMaxSes;


 function pMinSes (cot: cotizacion) return float is
 begin
   return cot.precioMinSesion;
 end pMinSes;


 function pVar (cot: cotizacion) return float is
 begin
   return cot.porcentajeVariacion;
 end pVar;


 function sVar (cot: cotizacion) return integer is
 begin
   return cot.signoVariacion;
 end sVar;


 function "<" (pos1, pos2: tpPosicion) return boolean is
 begin
   return integer(pos1) < integer(pos2);
 end  "<";


 function "<=" (pos1, pos2: tpPosicion) return boolean is
 begin
   return integer(pos1) <= integer(pos2);
 end "<=";



end FDIRCOT;
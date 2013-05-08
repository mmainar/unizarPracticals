-- Tema: Fichero de implementación de un módulo para el trabajo con
--       ficheros secuenciales de cotizaciones de la práctica 1.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: El tratamiento del fichero se realiza utilizando un buffer
--              de 512 bytes.
--------------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

package body FCOTIZACIONESPG is


 function leerByte (f: in tpFCotizacionesPG) return integer is
   c: character;
 begin
   read(f.fich,c);
   return character'Pos(c);
 end leerByte;


 procedure escribirByte(f: in out tpFCotizacionesPG; c: in integer) is
 begin
   write(f.fich,character'val(c));
 end escribirByte;


 procedure escribirBloque(f: in out tpFCotizacionesPG) is
 begin
   f.buf.inf:=0;
   while (f.buf.inf<f.buf.sup) and (f.buf.inf<MAX) loop
     f.buf.inf:= f.buf.inf+1;
     escribirByte(f,f.buf.dato(f.buf.inf));
   end loop;
 end escribirBloque;


 procedure escribirBuffer(f: in out tpFCotizacionesPG; dato: in integer) is
 begin
   f.buf.sup:= f.buf.sup+1;
   if (f.buf.sup<=MAX) then
     f.buf.dato(f.buf.sup):= dato;
   else -- Buffer lleno, volcamos en fichero
     escribirBloque(f); f.buf.sup:= 1;
     f.buf.dato(f.buf.sup):= dato;
   end if;
 end escribirBuffer;


 procedure leerBloque (f: in out tpFCotizacionesPG) is
 begin
   f.buf.sup:= 0; f.buf.inf:= 0;
   while (f.buf.sup<MAX) and not end_of_file(f.fich) loop
     f.buf.sup:= f.buf.sup+1;
     f.buf.dato(f.buf.sup):= leerByte(f);
   end loop;
 end leerBloque;


 procedure leerBuffer (f: in out tpFCotizacionesPG; dato: out integer) is
 -- Devuelve el valor del byte que se esta leyendo en la posicion actual
 -- del buffer.
 begin
   f.buf.inf:= f.buf.inf+1;
   if (f.buf.inf<=f.buf.sup) then
     dato:= f.buf.dato(f.buf.inf);
     if (f.buf.inf=f.buf.sup) then leerBloque(f); end if;
   else -- Buffer leido entero, rellenamos el buffer
     leerBloque(f); f.buf.inf:=1;
     dato:= f.buf.dato(f.buf.inf);
   end if;
 end leerBuffer;


 function ">"(f1,f2:tpfecha) return boolean is
 -- devuelve cierto si f1 es posterior a f2
 begin
   return (f1.anyo>f2.anyo) or ((f1.anyo=f2.anyo) and
          (f1.mes>f2.mes)) or ((f1.anyo=f2.anyo) and
          (f1.mes=f2.mes) and (f1.dia>f2.dia));
 end ">";


 function "<"(f1,f2:tpfecha) return boolean is
 -- devuelve cierto si f1 es anterior o igual a f2
 begin
   return not((f1>f2) or (f1=f2));
 end "<";


 function creafecha(d,m,a: integer) return tpFecha is
 -- devuelve la fecha con dia d, mes m y año a
   f: tpfecha;
 begin
   f.dia:=d; f.mes:=m; f.anyo:=a;
   return f;
 end creafecha;


 procedure leerFecha (f: in out tpFCotizacionesPG; fecha: out tpFecha) is
 -- Interpreta tres bytes del fichero secuencial como una fecha y devuelve
 -- un dato de dicho tipo.
   contador: integer:= 3;
 begin
   while contador/=0 loop
     case contador is
       when 3 => leerBuffer(f,fecha.dia);
       when 2 => leerBuffer(f,fecha.mes);
       when 1 => leerBuffer(f,fecha.anyo);
       when others => null;
     end case;
     contador:= contador-1;
   end loop;
   fecha:=creafecha(fecha.dia,fecha.mes,fecha.anyo);
 end leerFecha;


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


 -- Operaciones básicas de ficheros secuenciales de cotizaciones


 procedure Asociar (f: in out tpFCotizacionesPG; nomFich: in tpNomFich;
                    modAccF: tpAccF; exito: out boolean) is

 begin
   exito:= true;
   if (modAccF=L) then
     begin
       open(f.fich,in_file,nomFich.nom(1..nomFich.long));
       exception
         when bibFichSec.NAME_ERROR => exito:= false;
         when bibFichSec.STATUS_ERROR => exito:= false;
     end;
   else
     create(f.fich,out_file,nomFich.nom(1..nomFich.long));
   end if;
 end Asociar;


 procedure Disociar (f: in out tpFCotizacionesPG) is
 begin
   -- Escribimos en el fichero los datos que hubiera
   -- pendientes de escribir en el buffer
   if (f.modo=E) then escribirBloque(f); end if;
   -- Vaciamos el buffer
   f.buf.inf:= f.buf.sup+1;
   -- Disociamos el fichero
   close(f.fich);
 end Disociar;


 function finBuffer(f: in tpFCotizacionesPG) return boolean is
 begin
   return (f.fin and (f.buf.sup=f.buf.inf) and (f.buf.sup=0));
 end finBuffer;


 function FinFichero (f: tpFCotizacionesPG) return boolean is
 begin
   return finBuffer(f);
 end FinFichero;


 procedure IniciarLectura (f: in out tpFCotizacionesPG) is
   dato, i: integer;
   aux1, aux2: integer;
 begin
   f.modo:= L;
   reset(f.fich,in_file); f.buf.inf:= f.buf.sup+1; -- Vacia el buffer
   if not finBuffer(f) then
     if end_of_file(f.fich) then f.fin:= true; else f.fin:= false; end if;
     -- Ponemos la primera cotización en la ventana de acceso
     leerFecha(f, f.ventana.fechaSesion);
     -- Actualizamos la variable global de la última fecha leída
     f.fecha:= f.ventana.fechaSesion; f.fechaAnt:=(0,0,0);
     i:= 1; leerBuffer(f,dato);
     f.ventana.ticker.nom(i):= character'val(dato);
     while not (dato=126) loop
       leerBuffer(f,dato); i:= i+1;
       f.ventana.ticker.nom(i):= character'val(dato);
     end loop;
     f.ventana.ticker.long:= i;
     leerBuffer(f,aux1); leerBuffer(f,aux2);
     f.ventana.precioCierre:= float(aux1) + float(aux2)/100.0;
     leerBuffer(f,aux1); leerBuffer(f,aux2);
     f.ventana.precioApertura:= float(aux1) + float(aux2)/100.0;
     leerBuffer(f,dato);
     if dato=0 then
       f.ventana.signoVariacion:= 0; f.ventana.porcentajeVariacion:= 0.0;
     elsif dato=1 then
       f.ventana.signoVariacion:=1;
       leerBuffer(f,aux1); leerBuffer(f,aux2);
       f.ventana.porcentajeVariacion:= float(aux1) + float(aux2)/100.0;
     else -- dato=2
       f.ventana.signoVariacion:=2;
       leerBuffer(f,aux1); leerBuffer(f,aux2);
       f.ventana.porcentajeVariacion:= float(aux1) + float(aux2)/100.0;
     end if;
     leerBuffer(f,aux1); leerBuffer(f,aux2);
     f.ventana.precioMaxSesion:= float(aux1) + float(aux2)/100.0;
     leerBuffer(f,aux1); leerBuffer(f,aux2);
     f.ventana.precioMinSesion:= float(aux1) + float(aux2)/100.0;
   else
     if end_of_file(f.fich) then f.fin:= true; else f.fin:= false; end if;
   end if;
 end IniciarLectura;


 procedure iniciarEscritura (f: in out tpFCotizacionesPG) is

 begin
   reset(f.fich,out_file); f.fechaEscrita:=(0,0,0); f.modo:= E;
 end IniciarEscritura;


 procedure tomar(f: in out tpFCotizacionesPG) is
   i, dato: integer;
   aux1, aux2: integer;
   leido: boolean:= false;
 begin
   f.modo:= L;
   if not finBuffer(f) then
     if end_of_file(f.fich) then f.fin:= true; else f.fin:= false; end if;
     -- Hay alguna cotización más en el fichero
     -- SUPONEMOS que estamos leyendo inicialmente un ticker
     -- Leemos 3 bytes de la cotización actual
     leerBuffer(f,dato); f.ventana.ticker.nom(1):= character'val(dato);
     leerBuffer(f,dato); f.ventana.ticker.nom(2):= character'val(dato);
     leerBuffer(f,dato); f.ventana.ticker.nom(3):= character'val(dato);
     if character'pos(f.ventana.ticker.nom(1)) in 1..31
        and character'pos(f.ventana.ticker.nom(2)) in 1..12
        and character'pos(f.ventana.ticker.nom(3)) in 0..99
     then -- Es una fecha y no un ticker, rectificamos y leemos ticker
       f.ventana.fechaSesion.dia:= character'pos(f.ventana.ticker.nom(1));
       f.ventana.fechaSesion.mes:= character'pos(f.ventana.ticker.nom(2));
       f.ventana.fechaSesion.anyo:= character'pos(f.ventana.ticker.nom(3));
       f.fechaAnt:= f.fecha;
       f.fecha:= f.ventana.fechaSesion; -- Actualizamos la variable global
                                        -- con la última fecha leída
       i:= 1; leerBuffer(f, dato);
       while not (dato=126) loop
         f.ventana.ticker.nom(i):= character'val(dato);
         i:= i+1;
         leerBuffer(f, dato);
       end loop;
       f.ventana.ticker.long:= i;
       f.ventana.ticker.nom(i):= character'val(dato);
     elsif (character'pos(f.ventana.ticker.nom(2))=126) or
           (character'pos(f.ventana.ticker.nom(3))=126)
           then
             -- Hemos leido un ticker completo
             f.ventana.ticker.long:= 3;
             if (character'pos(f.ventana.ticker.nom(2))=126)
               then -- Hemos leido un byte que corresponde al
                    -- precio de cierre
                    f.ventana.ticker.long:= 2;
                    leerBuffer(f,aux2);
                    aux1:= (character'pos(f.ventana.ticker.nom(3)));
                    f.ventana.precioCierre:= float(aux1) + float(aux2)/100.0;
                    leido:= true;
              end if;
     else -- Es un ticker leido incompletamente
       f.ventana.fechaSesion:= f.fecha; -- Fecha en curso
       i:= 4; leerBuffer(f, dato);
       while not (dato=126) loop
         f.ventana.ticker.nom(i):= character'val(dato);
         i:= i+1;
         leerBuffer(f, dato);
       end loop;
       f.ventana.ticker.long:= i;
         f.ventana.ticker.nom(i):= character'val(dato);
     end if;
     if not leido then
       leerBuffer(f,aux1); leerBuffer(f,aux2);
       f.ventana.precioCierre:= float(aux1) + float(aux2)/100.0;
     end if;
     leerBuffer(f,aux1); leerBuffer(f,aux2);
     f.ventana.precioApertura:= float(aux1) + float(aux2)/100.0;
     leerBuffer(f,dato);
     if (dato=0) then
       f.ventana.signoVariacion:= 0; f.ventana.porcentajeVariacion:= 0.0;
     elsif (dato=1) then
       f.ventana.signoVariacion:=1;
       leerBuffer(f,aux1); leerBuffer(f,aux2);
       f.ventana.porcentajeVariacion:= float(aux1) + float(aux2)/100.0;
     else --dato=2
       f.ventana.signoVariacion:=2;
       leerBuffer(f,aux1); leerBuffer(f,aux2);
       f.ventana.porcentajeVariacion:= float(aux1) + float(aux2)/100.0;
     end if;
     leerBuffer(f,aux1); leerBuffer(f,aux2);
     f.ventana.precioMaxSesion:= float(aux1) + float(aux2)/100.0;
     leerBuffer(f,aux1); leerBuffer(f,aux2);
     f.ventana.precioMinSesion:= float(aux1) + float(aux2)/100.0;
     if end_of_file(f.fich) then f.fin:= true; else f.fin:= false; end if;
   else
     if end_of_file(f.fich) then f.fin:= true; else f.fin:= false; end if;
   end if;
 end tomar;


 procedure asignarVentana(f: in out tpFCotizacionesPG; cot: in cotizacion) is
 begin
   f.ventana:= cot;
 end asignarVentana;


 procedure LeerCotizacion (f: in out tpFCotizacionesPG; cot: out cotizacion) is
 begin
   cot:= f.ventana;
   tomar(f);
 end LeerCotizacion;


 function parteEntera(f:float) return integer is
 -- Devuelve la parte entera de un numero real
 begin
   return(integer(f-0.5));
 end parteEntera;


 function parteDecimal(f:float) return integer is
 -- Devuelve la parte decimal de un numero real
 begin
   return(integer((f-float(parteEntera(f)))*100.0));
 end parteDecimal;


 procedure escribirReal(f: in out tpFCotizacionesPG; num: in float) is
   dato: integer;
 begin
   dato:= parteEntera(num);
   escribirBuffer(f,dato);
   --write(f.fich,character'val(dato));
   dato:= parteDecimal(num);
   escribirBuffer(f,dato);
   --write(f.fich,character'val(dato));
 end escribirReal;


 procedure escribirEntero(f: in out tpFCotizacionesPG; num: in integer) is
 begin
   escribirBuffer(f,num);
 end escribirEntero;


 procedure poner(f: in out tpFCotizacionesPG) is
   i: integer;
 begin
   f.modo:= E;
   -- Escribimos la fecha de la cotización
   if (f.ventana.fechaSesion/=f.fechaEscrita) then
     escribirEntero(f,f.ventana.fechaSesion.dia);
     escribirEntero(f,f.ventana.fechaSesion.mes);
     escribirEntero(f,f.ventana.fechaSesion.anyo);
   end if;
   -- Escribimos el ticker
   i:= 1;
   while not (character'pos(f.ventana.ticker.nom(i))=126) loop
     escribirBuffer(f,character'pos(f.ventana.ticker.nom(i)));
     i:= i+1;
   end loop;
   -- Carácter de código ASCII 126
   escribirBuffer(f,character'pos(f.ventana.ticker.nom(i)));
   -- Escribimos el resto de datos de la cotización
   escribirReal(f,f.ventana.precioCierre);
   escribirReal(f,f.ventana.precioApertura);
   if (f.ventana.signoVariacion=0) then
     escribirEntero(f,f.ventana.signoVariacion);
   elsif (f.ventana.signoVariacion=1) then
     escribirEntero(f,f.ventana.signoVariacion);
     escribirReal(f,f.ventana.porcentajeVariacion);
   else --f.ventana.signoVariacion=2
     escribirEntero(f,f.ventana.signoVariacion);
     escribirReal(f,f.ventana.porcentajeVariacion);
   end if;
   escribirReal(f,f.ventana.precioMaxSesion);
   escribirReal(f,f.ventana.precioMinSesion);
 end poner;


 procedure ponerCotCliente(f: in out tpFCotizacionesPG) is
 begin
   -- Escribimos la fecha de la cotización
   escribirEntero(f,f.ventana.fechaSesion.dia);
   escribirEntero(f,f.ventana.fechaSesion.mes);
   escribirEntero(f,f.ventana.fechaSesion.anyo);
   -- Escribimos el resto de datos de la cotización
   escribirReal(f,f.ventana.precioCierre);
   escribirReal(f,f.ventana.precioApertura);
   if (f.ventana.signoVariacion=0) then
     escribirEntero(f,f.ventana.signoVariacion);
   else --f.ventana.signoVariacion=1 OR f.ventana.signoVariacion=2
     escribirEntero(f,f.ventana.signoVariacion);
     escribirReal(f,f.ventana.porcentajeVariacion);
   end if;
   escribirReal(f,f.ventana.precioMaxSesion);
   escribirReal(f,f.ventana.precioMinSesion);
 end ponerCotCliente;


 procedure EscribirCotizacion (f: in out tpFCotizacionesPG;
                               cot: in cotizacion) is

 begin
   asignarVentana(f,cot);
   poner(f);
 end escribirCotizacion;


 procedure EscribirCotizacionCliente(f: in out tpFCotizacionesPG;
                                     cot: in cotizacion) is
 begin
   asignarVentana(f,cot);
   ponerCotCliente(f);
 end escribirCotizacionCliente;


 procedure CotizacionVentana (f: in out tpFCotizacionesPG;
                              cot: out cotizacion) is

 begin
   cot:= f.ventana;
 end CotizacionVentana;


 -- Operaciones avanzadas de ficheros secuenciales de cotizaciones


 procedure SiguienteCotizacionFecha (f: in out tpFCotizacionesPG;
                                     exito: out boolean) is
   cot: cotizacion;
 begin
   cotizacionVentana(f,cot);
   exito:= (cot.fechaSesion/=f.fechaAnt);
   while not finFichero(f) and not exito loop
     leerCotizacion(f,cot);
     cotizacionVentana(f,cot);
     exito:= (cot.fechaSesion/=f.fechaAnt);
   end loop;
 end SiguienteCotizacionFecha;


 procedure SiguienteCotizacionTicker (f: in out tpFCotizacionesPG;
                                      t: tpTicker; exito: out boolean) is
   cot: cotizacion;
 begin
   cotizacionVentana(f,cot);
   exito:= (cot.ticker.long=t.long) and then
           (cot.ticker.nom(1..cot.ticker.long)=t.nom(1..t.long));
   while not finFichero(f) and not exito loop
     leerCotizacion(f,cot); cotizacionVentana(f,cot);
     exito:= (cot.ticker.long=t.long) and then
             (cot.ticker.nom(1..cot.ticker.long)=t.nom(1..t.long));
   end loop;
 end SiguienteCotizacionTicker;


 procedure buscarCotizacion (f: in out tpFCotizacionesPG; fecha: in tpFecha;
                             t: in tpTicker; exito: out boolean; posicion: out integer) is
   cot: cotizacion;
 begin
   iniciarLectura(f); posicion:= 1; cotizacionVentana(f,cot);
   exito:= (cot.fechaSesion=fecha);
   while not finFichero(f) and not exito loop
     leerCotizacion(f,cot); cotizacionVentana(f,cot);
     posicion:= posicion+1;
     exito:= (cot.fechaSesion=fecha);
   end loop;
   if exito then
     exito:= (cot.ticker.long=t.long) and then
             (cot.ticker.nom(1..cot.ticker.long)=t.nom(1..t.long));
     while not finFichero(f) and not exito loop
       leerCotizacion(f,cot); cotizacionVentana(f,cot);
       posicion:= posicion+1;
       exito:= (cot.ticker.long=t.long) and then
               (cot.ticker.nom(1..cot.ticker.long)=t.nom(1..t.long));
     end loop;
   end if;
 end buscarCotizacion;


 procedure pideFecha(fecha: out tpFecha) is
 -- Post: solicita al usuario que introduzca la fecha
 --       de una cotizacion y la almacena en "fecha".
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


 function fechaSes(cot: in cotizacion) return tpFecha is
 begin
   return cot.fechaSesion;
 end fechaSes;


 function tick(cot: in cotizacion) return tpTicker is
 begin
   return cot.ticker;
 end tick;


 procedure ObtenerCotizacion (cot: out cotizacion) is
 begin
   put("Introduzca los datos de una cotizacion bursatil"); new_Line;
   pideFecha(cot.fechaSesion); new_Line;
   loop
     begin
       put("Ticker del valor bursatil: ");
       get_line(cot.ticker.nom,cot.ticker.long);
       cot.ticker.long:= cot.ticker.long+1;
       -- Añadimos el caracter terminador de ticker.
       cot.ticker.nom(cot.ticker.long):= character'val(126);
       exit;
       exception
         when CONSTRAINT_ERROR => put("Elija un ticker valido."); new_line;
     end;
   end loop;
   new_line;
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
 end ObtenerCotizacion;


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


 procedure mostrarCotizacion(cot: in cotizacion) is


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


 begin  -- de mostrarCotizacion.
   ponerCabecera;
   ponerFecha(cot.fechaSesion); put(TAB);
   for i in 1..cot.ticker.long-1 loop
     put(cot.ticker.nom(i));
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


 procedure CompararCotizaciones (cot1, cot2: cotizacion;
                                 igualdad: out integer) is
 begin
   if (cot1.precioCierre=cot2.precioCierre) and
      (cot1.precioApertura=cot2.precioApertura) and
      (cot1.porcentajeVariacion=cot2.porcentajeVariacion) and
      (cot1.precioMaxSesion=cot2.precioMaxSesion) and
      (cot1.precioMinSesion=cot2.precioMinSesion)
        then igualdad:=1;
   else igualdad:=0;
   end if;
 end CompararCotizaciones;


end FCOTIZACIONESPG;
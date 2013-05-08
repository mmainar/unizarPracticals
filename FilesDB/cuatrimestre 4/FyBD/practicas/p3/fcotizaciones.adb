-- Tema: Fichero de implementación de un módulo para el trabajo con
--       ficheros secuenciales de cotizaciones de la práctica 3.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: El tratamiento del fichero se realiza byte a byte.
--------------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

package body FCOTIZACIONES is


 function leerByte (f: in tpFCotizaciones) return integer is
  c: character;
 begin
  read(f.fich,c);
  return character'Pos(c);
 end leerByte;


 function leerFecha (f: tpFCotizaciones) return tpFecha is
  fecha: tpFecha;
  contador: integer:= 3;
 begin
  while contador/=0 and not finFichero(f) loop
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


 function creafecha(d,m,a: integer) return tpFecha is
 -- devuelve la fecha con dia d, mes m y año a
  f: tpfecha;
 begin
  f.dia:=d; f.mes:=m; f.anyo:=a;
  return f;
 end creafecha;


 function ">"(f1,f2:tpfecha) return boolean is
 begin
   return (f1.anyo>f2.anyo) or ((f1.anyo=f2.anyo) and
          (f1.mes>f2.mes)) or ((f1.anyo=f2.anyo) and
          (f1.mes=f2.mes) and (f1.dia>f2.dia));
 end ">";


 function "<"(f1,f2:tpfecha) return boolean is
 begin
   return not((f1>f2) or (f1=f2));
 end "<";


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


 procedure asociar (f: in out tpFCotizaciones; nomFich: in tpNomFich;
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
 end asociar;


 procedure disociar (f: in out tpFCotizaciones) is
 begin
  close(f.fich);
 end disociar;


 function finFichero(f: tpFCotizaciones) return boolean is
 begin
  return f.fin;
 end finFichero;


 procedure iniciarLectura (f: in out tpFCotizaciones) is
  dato, i: integer;
 begin
  reset(f.fich,in_file);
  if not end_of_file(f.fich) then
    f.fin:= false;
   -- Ponemos la primera cotización en la ventana de acceso
    f.ventana.fechaSesion:= leerFecha(f);
   -- Actualizamos la variable global de la última fecha leída
    f.fecha:= f.ventana.fechaSesion;
    i:= 1; dato:= leerByte(f);
    f.ventana.ticker.nom(i):= character'val(dato);
    while not (dato=126) loop
      dato:= leerByte(f);
      i:= i+1;
      f.ventana.ticker.nom(i):= character'val(dato);
    end loop;
    f.ventana.ticker.long:= i;
    f.ventana.precioCierre:= float(leerByte(f)) + float(leerByte(f))/100.0;
    f.ventana.precioApertura:= float(leerByte(f)) + float(leerByte(f))/100.0;
    dato:= leerByte(f);
    if dato=0 then
      f.ventana.signoVariacion:= 0; f.ventana.porcentajeVariacion:= 0.0;
    elsif dato=1 then
      f.ventana.signoVariacion:=1;
      f.ventana.porcentajeVariacion:= float(leerByte(f)) +
                                       float(leerByte(f))/100.0;
    else --dato=2
      f.ventana.signoVariacion:=2;
      f.ventana.porcentajeVariacion:= float(leerByte(f)) +
                                       float(leerByte(f))/100.0;
      f.ventana.porcentajeVariacion:= f.ventana.porcentajeVariacion;
    end if;
    f.ventana.precioMaxSesion:= float(leerByte(f)) +
                                       float(leerByte(f))/100.0;
    f.ventana.precioMinSesion:= float(leerByte(f)) +
                                      float(leerByte(f))/100.0;
  else f.fin:= true;
  end if;
 end iniciarLectura;


 procedure iniciarEscritura (f: in out tpFCotizaciones) is
 begin
  reset(f.fich,out_file); f.fechaEscrita:=(0,0,0); f.fin:= true;
 end IniciarEscritura;


 procedure tomar(f: in out tpFCotizaciones) is
  i, dato: integer;
  aux: float;
 begin
  if not end_of_file(f.fich) then
    f.fin:= false;
    -- Hay alguna cotización más en el fichero
    -- SUPONEMOS que estamos leyendo inicialmente un ticker
    -- Leemos 3 bytes de la cotización actual
    f.ventana.ticker.nom(1):= character'val(leerByte(f));
    f.ventana.ticker.nom(2):= character'val(leerByte(f));
    f.ventana.ticker.nom(3):= character'val(leerByte(f));
    if character'pos(f.ventana.ticker.nom(1)) in 1..31
       and character'pos(f.ventana.ticker.nom(2)) in 1..12
       and character'pos(f.ventana.ticker.nom(3)) in 0..99
    then -- Es una fecha y no un ticker, rectificamos y leemos ticker
      f.ventana.fechaSesion.dia:= character'pos(f.ventana.ticker.nom(1));
      f.ventana.fechaSesion.mes:= character'pos(f.ventana.ticker.nom(2));
      f.ventana.fechaSesion.anyo:= character'pos(f.ventana.ticker.nom(3));
      f.fecha:= f.ventana.fechaSesion; -- Actualizamos la variable global
                                       -- con la última fecha leída
      i:= 1; dato:= leerByte(f);
      f.ventana.ticker.nom(i):= character'val(dato);
      while not (dato=126) loop
        dato:= leerByte(f);
        i:= i+1;
        f.ventana.ticker.nom(i):= character'val(dato);
      end loop;
      f.ventana.ticker.long:= i;
    elsif (character'pos(f.ventana.ticker.nom(2))=126) or
          (character'pos(f.ventana.ticker.nom(3))=126)
        then
          -- Hemos leido un ticker completo
          f.ventana.ticker.long:= 3;
          f.ventana.fechaSesion:= f.fecha; -- Añadido esto 13:39
          if (character'pos(f.ventana.ticker.nom(2))=126)
            then -- Hemos leido un byte que corresponde al
                 -- precio de cierre
                 f.ventana.ticker.long:= 2; -- Esto mal pero no hay tickers de longitud 1
                 aux:= float(character'pos(f.ventana.ticker.nom(3)));
                 f.ventana.precioCierre:= aux+float(leerByte(f))/100.0;
          end if;

   else -- Es un ticker leido incompletamente
     f.ventana.fechaSesion:= f.fecha; -- Fecha en curso
     i:= 4; dato:= leerByte(f);
     f.ventana.ticker.nom(i):= character'val(dato);
     while not (dato=126) loop
       dato:= leerByte(f);
       i:= i+1;
       f.ventana.ticker.nom(i):= character'val(dato);
     end loop;
     f.ventana.ticker.long:= i;
   end if;
   f.ventana.precioCierre:= float(leerByte(f)) +
                                float(leerByte(f))/100.0;
   f.ventana.precioApertura:= float(leerByte(f)) +
                                float(leerByte(f))/100.0;
   dato:= leerByte(f);
   if (dato=0) then
     f.ventana.signoVariacion:= 0; f.ventana.porcentajeVariacion:= 0.0;
   elsif (dato=1) then
     f.ventana.signoVariacion:=1;
     f.ventana.porcentajeVariacion:= float(leerByte(f)) +
                                      float(leerByte(f))/100.0;
   else --dato=2
     f.ventana.signoVariacion:=2;
     f.ventana.porcentajeVariacion:= float(leerByte(f)) +
                                      float(leerByte(f))/100.0;
     f.ventana.porcentajeVariacion:= f.ventana.porcentajeVariacion;
   end if;
   f.ventana.precioMaxSesion:= float(leerByte(f)) +
                                      float(leerByte(f))/100.0;
   f.ventana.precioMinSesion:= float(leerByte(f)) +
                                      float(leerByte(f))/100.0;
  else f.fin:= true;
  end if;
 end tomar;


 procedure asignarVentana(f: in out tpFCotizaciones; cot: in cotizacion) is
 begin
  f.ventana:= cot;
 end asignarVentana;


 procedure leerCotizacion (f: in out tpFCotizaciones; cot: out cotizacion) is
 begin
  cot:= f.ventana;
  tomar(f);
 end LeerCotizacion;


 function parteEntera(f:float) return integer is
 -- Devuelve la parte entera de un numero real
 begin
  return(integer((f)-0.5));
 end parteEntera;


 function parteDecimal(f:float) return integer is
 -- Devuelve la parte decimal de un numero real
 begin
  return(integer(((f)-float(parteEntera(f)))*100.0));
 end parteDecimal;


 procedure escribirReal(f: in out tpFCotizaciones; num: in float) is
  dato: integer;
 begin
  dato:= parteEntera(num);
  write(f.fich,character'val((dato mod 256)));
  dato:= parteDecimal(num);
  write(f.fich,character'val((dato mod 256)));
 end escribirReal;


 procedure escribirEntero(f: in out tpFCotizaciones; num: in integer) is
 begin
  write(f.fich,character'val((num mod 256)));
 end escribirEntero;


 procedure poner(f: in out tpFCotizaciones; cot: in cotizacion) is
  i: integer:=1;
 begin
  -- Escribimos la fecha de la cotización
  if (cot.fechaSesion/=f.fechaEscrita) then
    escribirEntero(f,cot.fechaSesion.dia);
    escribirEntero(f,cot.fechaSesion.mes);
    escribirEntero(f,cot.fechaSesion.anyo);
    f.fechaEscrita:= cot.fechaSesion;
  end if;
  -- Escribimos el ticker
  while not (character'pos(cot.ticker.nom(i))=126) loop
    write(f.fich,cot.ticker.nom(i));
    i:= i+1;
  end loop;
  -- Carácter de código ASCII 126
  write(f.fich,cot.ticker.nom(i));
  -- Escribimos el resto de datos de la cotización
  escribirReal(f,cot.precioCierre);
  escribirReal(f,cot.precioApertura);
  if (cot.porcentajeVariacion=0.0) then
    escribirEntero(f,0);
  elsif (cot.porcentajeVariacion>0.0) then
    escribirEntero(f,1);
    escribirReal(f,cot.porcentajeVariacion);
  else -- cot.porcentajeVariacion<0.0
    escribirEntero(f,2);
    -- Valor absoluto, no se escribe el signo
    escribirReal(f,abs(cot.porcentajeVariacion));
  end if;
  escribirReal(f,cot.precioMaxSesion);
  escribirReal(f,cot.precioMinSesion);
 end poner;


 procedure escribirCotizacion(f: in out tpFCotizaciones; cot: in cotizacion) is
 begin
 --asignarventana(f,cot);
  poner(f, cot);
 end escribirCotizacion;


 procedure cotizacionVentana(f: in tpFCotizaciones;cot: out cotizacion) is
 begin
  cot:= f.ventana;
 end Cotizacionventana;


 -- Operaciones avanzadas de ficheros secuenciales de cotizaciones


 procedure mostrarCotizacion (cot: cotizacion) is

  procedure ponerFecha (f: tpFecha) is
  -- Muestra por pantalla la fecha f.
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
  ponerFecha(cot.fechaSesion); put(' ');
  for i in 1..cot.ticker.long-1 loop
    put(cot.ticker.nom(i));
  end loop;
  put("     ");
  aux:= integer(cot.precioCierre*100.0);
  put(aux,5);
  aux:= integer(cot.precioApertura*100.0);
  put(aux,5); put(' ');
  put(cot.signoVariacion,2); put(' ');
  aux:= integer(cot.porcentajeVariacion*10.0);
  if aux<10
    then put(aux/10,0); put(aux mod 10,1);
    else put(aux mod 100,0);
  end if;
  aux:= integer(cot.precioMaxSesion*100.0); put(aux,5);
  aux:= integer(cot.precioMinSesion*100.0); put(aux,5);
  new_line;
 end mostrarCotizacion;


 function homogeneizar (cot: cotizacion) return cotizacion is
  aux: cotizacion;
  c: character:= character'Val(126);
 begin
  aux:= cot;
  while aux.ticker.long < 12 loop
    aux.ticker.long:= aux.ticker.long+1;
    aux.ticker.nom(aux.ticker.long):= c;
  end loop;
  if aux.signoVariacion = 0
    then aux.porcentajeVariacion:= 0.0;
  end if;
  return aux;
 end homogeneizar;


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



 function fecha (cot: cotizacion) return tpFecha is
 begin
  return cot.fechaSesion;
 end fecha;


 function tick (cot: cotizacion) return tpTicker is
 begin
  return cot.ticker;
 end tick;


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

 function crearCotizacion (pAper, pCier, pMaxSes, pMinSes, pVar: float;
                          sVar: integer; ticker: tpTicker; fecha: tpFecha)
                            return cotizacion is
   cot: cotizacion;
 begin
   cot.precioApertura:= pAper; cot.precioCierre:= pCier;
   cot.precioMaxSesion:= pMaxSes; cot.precioMinSesion:= pMinSes;
   cot.porcentajeVariacion:= pVar; cot.signoVariacion:= sVar;
   cot.ticker:= ticker; cot.fechaSesion:= fecha;
   return cot;
 end crearCotizacion;
 
 
 
end FCOTIZACIONES;
-- Tema: Fichero de implementación de un módulo para el trabajo con
--       ficheros secuenciales de cotizaciones de la práctica 2.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: El tratamiento del fichero se realiza byte a byte.
--------------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO;

package body FCOTIZACIONES_p2 is

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
      f.ventana.porcentajeVariacion:= - f.ventana.porcentajeVariacion;
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
     -- El menos es para la ordenacion por % Var.
     f.ventana.porcentajeVariacion:= float(leerByte(f)) +
                                      float(leerByte(f))/100.0;
     f.ventana.porcentajeVariacion:= - f.ventana.porcentajeVariacion;
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
  poner(f, cot);
 end escribirCotizacion;


 procedure Cotizacionventana(f: in tpFCotizaciones;cot: out cotizacion) is
 begin
  cot:= f.ventana;
 end Cotizacionventana;


 -- Operaciones avanzadas de ficheros secuenciales de cotizaciones


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


 procedure escribirCotizacionT (t: in out fTexto; c: cotizacion) is

 procedure ponerFecha (f: tpFecha; t: in out fTexto) is
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


 begin  -- de escribirCotizacionT.
  ponerFecha(c.fechaSesion, t); put(t,TAB);
  put(t, c.ticker.nom(1..c.ticker.long-1));
  put(t,TAB); put(t,TAB);
  put(t, c.precioCierre,0,2,0); put(t,TAB);
  put(t, c.precioApertura,0,2,0); put(t,TAB);
  put(t, c.porcentajeVariacion,0,1,0); put(t,'%'); put(t,TAB);
  put(t, c.precioMaxSesion,0,2,0); put(t,TAB);
  put(t, c.precioMinSesion,0,2,0);
  new_line(t);
 end escribirCotizacionT;


 procedure leerCotizacionT (t: in out fTexto; c: out cotizacion) is

  function obtenerNumero (c: character) return integer is
  -- Devuelve el entero asociado al ASCII leido.
  begin
    return character'Pos(c)-character'Pos('0');
  end obtenerNumero;


  c1, c2: character;
  d,m,a: integer;
 begin
  c.ticker.long:= 0;
  -- Leemos la fecha.
  get(t, c1); get(t, c2); d:= obtenerNumero(c1)*10 + obtenerNumero(c2);
  get(t, c1);  -- Leemos "/" separadora.
  get(t, c1); get(t, c2); m:= obtenerNumero(c1)*10 + obtenerNumero(c2);
  get(t, c1);  -- Leemos "/" separadora.
  get(t, c1); get(t, c2); a:= obtenerNumero(c1)*10 + obtenerNumero(c2);
  c.fechaSesion:= creaFecha(d,m,a); get(t, c1); -- Leemos tabulado separacion.
  get(t, c1);  -- 1º caracter ticker.
  while c1/=TAB loop
    c.ticker.long:= c.ticker.long+1; c.ticker.nom(c.ticker.long):= c1;
    get(t, c1);
  end loop;
  -- Agregamos caracter terminador de ticker.
  c.ticker.long:= c.ticker.long+1;
  c.ticker.nom(c.ticker.long):= character'Val(126);
  get(t, c.precioCierre); get(t, c.precioApertura);
  -- Leemos porcentaje variacion.
  get(t, c.porcentajeVariacion); get(t, c1);-- Leemos el caracter '%'.
  if c.porcentajeVariacion=0.0  then c.signoVariacion:= 0;
    elsif c.porcentajeVariacion>0.0  then c.signoVariacion:= 1;
    else c.signoVariacion:= 2;
  end if;
  get(t, c.precioMaxSesion); get(t, c.precioMinSesion); skip_line(t);
 end leerCotizacionT;


 function siguienteDato(f: in tpFCotizaciones) return cotizacion is
 begin
  return f.ventana;
 end siguienteDato;


 -- Criterios de ordenacion


 function ordenPrecioMaxSesion(c1, c2: cotizacion) return boolean is
 begin
  return (c1.precioMaxSesion>=c2.precioMaxSesion);
 end ordenPrecioMaxSesion;


 function ordenPrecioMinSesion(c1, c2: cotizacion) return boolean is
 begin
  return (c1.precioMinSesion>=c2.precioMinSesion);
 end ordenPrecioMinSesion;


 function ordenPrecioCierre(c1, c2: cotizacion) return boolean is
 begin
  return (c1.precioCierre>=c2.precioCierre);
 end ordenPrecioCierre;


 function ordenPrecioApertura(c1, c2: cotizacion) return boolean is
 begin
  return (c1.precioApertura>=c2.precioApertura);
 end ordenPrecioApertura;


 function ordenPVariacion(c1, c2: cotizacion) return boolean is
 begin
  return (c1.porcentajeVariacion>=c2.porcentajeVariacion);
 end ordenPVariacion;


 function ordenFecha(c1, c2: cotizacion) return boolean is
 begin
  return not(c1.fechaSesion<c2.fechaSesion);
 end ordenFecha;


 procedure copiarFichero(fOrg, fDst: in out tpFCotizaciones) is
  buf: cotizacion;
 begin
  iniciarLectura(fOrg); iniciarEscritura(fDst);
  while not finFichero(fOrg) loop
    leerCotizacion(fOrg, buf);
    escribirCotizacion(fDst, buf);
  end loop;
 end copiarFichero;


 procedure Ord_MNatural(f: in out tpFCotizaciones; enOrden: in pFuncion) is

  procedure CopiarDato(x,y: in out tpFCotizaciones; fin_Tramo: out boolean) is
    actual: cotizacion;
  begin
    leerCotizacion(x,actual); escribirCotizacion(y,actual);
    if finFichero(x)
      then fin_Tramo:= true;
      else fin_Tramo:= not(enOrden(actual, siguienteDato(x)));
    end if;
  end CopiarDato;


  procedure CopiarTramo(x,y: in out tpFCotizaciones) is
    fin_Tramo: boolean;
  begin
    loop
      copiarDato(x,y,fin_Tramo);
      exit when fin_Tramo;
    end loop;
  end copiarTramo;


  procedure MezclarTramo(a,b,f: in out tpFCotizaciones) is
    fin_Tramo: boolean;
  begin
    loop
      if enOrden(siguienteDato(a),siguienteDato(b))
        then CopiarDato(a,f,fin_Tramo);
             if fin_Tramo then CopiarTramo(b,f); end if;
        else CopiarDato(b,f,fin_Tramo);
             if fin_Tramo then copiarTramo(a,f); end if;
      end if;
      exit when fin_Tramo;
    end loop;
  end MezclarTramo;


  procedure Distribuir(f,a,b: in out tpFCotizaciones) is
  begin
    while not finFichero(f) loop
      copiarTramo(f,a);
      if not finFichero(f) then copiarTramo(f,b); end if;
    end loop;
  end Distribuir;


  procedure Mezclar(a,b,f: in out tpFCotizaciones; numTramos: out integer) is
  begin
    numTramos:= 0;
    while not finFichero(a) and not finFichero(b) loop
      MezclarTramo(a,b,f); numTramos:= numTramos+1;
    end loop;
    while not finFichero(a) loop
      copiarTramo(a,f); numTramos:= numTramos+1;
    end loop;
    while not finFichero(b) loop
      copiarTramo(b,f); numTramos:= numTramos+1;
    end loop;
  end Mezclar;


  numTramos: integer;
  a,b: tpFCotizaciones;
  aux, aux2: tpNomFich;
  exito: boolean;
  cot: cotizacion;
  pasada: integer:=0;
 begin -- de Ord_MNatural;
  asociar(a,aux,tpAccF'last,exito); asociar(b,aux2,tpAccF'last,exito);
  if exito then
    loop
      pasada:= pasada+1;
      iniciarLectura(f); iniciarEscritura(a); iniciarEscritura(b);
      Distribuir(f,a,b);
      iniciarEscritura(f); iniciarLectura(a); iniciarLectura(b);
      Mezclar(a,b,f,numTramos);
      if pasada=1 then
        new_Line; put("Numero de tramos: "); put(numTramos,0); new_Line;
      end if;
      exit when (numTramos = 1);
    end loop;
    disociar(a); disociar(b);
    new_Line; put("Numero de pasadas: "); put(pasada,0); new_Line;
  else put("Ha habido algun problema al asociar los ficheros"); new_Line;
  end if;
 end Ord_MNatural;


 procedure Ord_MPolifasica(f0: in out tpFCotizaciones; enOrden: in pFuncion) is
 -- Ordena segun la funcion "enOrden" los datos del fichero "f"

  aux: array(selFich) of tpNomFich; -- Nombres de los ficheros
  f: array(selFich) of tpFCotizaciones;
  j: selFich;
  z, nivel: integer; -- z = tramos a mezclar en un determinado nivel
  a: array(selFich) of integer; -- a(j) = num. ideal de tramos en el fich. j
  d: array(selFich) of integer; -- d(j) = num. tramos ficticios en el fich. j
  ultimo: array(selFich) of cotizacion; -- ultimo(j) = ultimo item escrito en
                                        --             el fichero j
  c: array(selFich) of selFich; -- Tablas de correspondencia de numeros de
                                -- fichero

  procedure RotarFicheros is
  -- Prepara ficheros y tablas para mezcla en nivel-1
    cn: SelFich;
    dn, z: integer;
  begin
    cn:= c(n); dn:= d(n); z:= a(n-1);
    for i in reverse 2..n loop
      c(i):= c(i-1);
      d(i):= d(i-1);
      a(i):= a(i-1) - z;
    end loop;
    c(1):= cn; d(1) := dn; a(1):= z;
  end rotarFicheros;


  procedure MezclarTramo is
  -- Mezcla de un tramo de c(1)..c(n-1) sobre c(n)
    i, mx: SelFich;
    k: integer; -- Numero de ficheros reales a mezclar
    cd: array(SelFich) of SelFich; -- Tabla de ficheros a mezclar
    buf, min: cotizacion;
    fdt: boolean;
  begin
    k:= 0;
    for i in 1..n-1 loop -- Seleccionar tramo ficticio o real a mezclar
      if d(i)>0 then d(i):= d(i) - 1; -- Mezclar tramo ficticio de c(i)
                else k:= k+1; cd(k):= c(i); -- Mezclar tramo real de c(i)
      end if;
    end loop;
    if (k=0)
      then d(n):= d(n) + 1; -- Solo se mezclan tramos ficticios
      else -- Mezclar un tramo real desde cd(1)..cd(k) sobre c(n)
        loop
          i:= 1; mx:= 1; min:= siguienteDato(f(cd(1)));
          while (i<k) loop
            i:= i+1;
            buf:= siguienteDato(f(cd(i)));
            if not enOrden(min,buf) then min:= buf; mx:= i; end if;
          end loop; -- cd(mx) contiene el elemento minimo; moverlo a c(n)
          leerCotizacion(f(cd(mx)), buf); escribirCotizacion(f(c(n)), buf);
          if finFichero(f(cd(mx)))
            then fdt:= true;
            else fdt:= not enOrden(buf,siguienteDato(f(cd(mx))));
          end if;
          if fdt then -- prescidindir de este fichero
            cd(mx):= cd(k); k:= k-1;
          end if;
          exit when (k=0);
        end loop;
    end if;
  end MezclarTramo;


  procedure copiarTramo is
  -- Copia un tramo de datos desde el fichero f0 al fichero j
    buf: cotizacion;
    fdt: boolean;
  begin
    loop
      leerCotizacion(f0,buf); escribirCotizacion(f(j), buf);
      if finFichero(f0)
        then fdt:= true;
        else fdt:= not enOrden(buf, siguienteDato(f0));
      end if;
      exit when fdt;
    end loop;
    ultimo(j):= buf;
  end copiarTramo;


  procedure seleccionarFichero is
  -- Selecciona fichero j sobre el que toca escribir
    z: integer;
  begin
    if d(j) < d(j+1)
      then j:= j+1;
      else
        if d(j)=0 then
          nivel:= nivel + 1; z:= a(1);
          for i in 1..n-1 loop
            d(i):= z + a(i+1) - a(i);
            a(i):= z + a(i+1);
          end loop;
        end if;
        j:= 1;
    end if;
    d(j):= d(j) - 1;
  end seleccionarFichero;


  procedure Distribucion_Inicial is
  -- Realiza la distribucion inicial de tramos
  begin
    iniciarLectura(f0);
    for i in 1..n-1 loop
      a(i):= 1; d(i):=1;
      iniciarEscritura(f(i));
    end loop;
    nivel:= 1; a(n):= 0; d(n):= 0; j:= 1;
    loop
      SeleccionarFichero;
      CopiarTramo;
      exit when (finFichero(f0) or (j = n-1));
    end loop;
    while not finFichero(f0) loop
      SeleccionarFichero;
      if enOrden(ultimo(j), siguienteDato(f0))
        then -- Continuar el tramo antiguo
          copiarTramo;
          if finFichero(f0)
            then d(j):= d(j) + 1;  -- Descontar el tramo (no se ha copiado)
            else copiarTramo;
          end if;
        else copiarTramo;
      end if;
    end loop;
  end Distribucion_Inicial;


  exito: boolean;
  contador: integer:=0;
 begin -- de Ord_MPolifasica
  for i in 1..n loop asociar(f(i),aux(i),tpAccF'last,exito); end loop;
  Distribucion_Inicial; -- Distribuir el fichero inicial en tramos
  for i in 1..n-1 loop iniciarLectura(f(i)); end loop;
  for i in 1..n loop c(i):= i; end loop;
  loop -- Mezclar z tramos desde c(1) .. c(n-1) hasta c(n)
    contador:= contador+1; -- Añadido, no es del algoritmo
    z:= a(n-1);
    d(n):= 0; -- Por defecto no habra tramos ficticios en el sig. nivel
    iniciarEscritura(f(c(n)));
    loop
      MezclarTramo;
      z:= z-1;
      exit when (z=0);
    end loop;
    iniciarLectura(f(c(n)));
    RotarFicheros;
    nivel:= nivel-1;
    exit when (nivel=0); -- nivel=pasada
  end loop;
  new_Line; put("Numero de pasadas: "); put(contador,0); new_Line;
  CopiarFichero(f(c(1)), f0);
  for i in 1..n loop disociar(f(i)); end loop;
 end Ord_MPolifasica;


end FCOTIZACIONES_p2;
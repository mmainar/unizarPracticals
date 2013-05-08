-- Tema: Fichero de implementación de un programa, dirigido por menu, para
--       permitir comprobar el correcto funcionamiento del modulo
--       FCOTIZACIONES para el trabajo con ficheros secuenciales de
--       cotizaciones de la práctica 1.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, FCOTIZACIONES;

use ada.text_IO, ada.integer_text_IO, FCOTIZACIONES;

procedure pmenu1 is

 type tpControlFich is record
  cotizacionDisponible, asociado, previamenteAsociado: boolean;
  recienAbierto: boolean;
  modo: tpAccF;
 end record;


 procedure asociarFichero(f: in out tpFCotizaciones;
                         control: in out tpControlFich) is
 -- Solicita interactivamente al usuario el nombre del fichero al que desea
 -- acceder o crear, el modo de trabajo con el mismo, e informa por pantalla
 -- de si la operacion se ha llevado a cabo con exito.

  procedure comprobarModo (cad: string; control: in out tpControlFich;
                           exito: in out boolean) is
  -- Comprueba si "cad" es igual a "Lect" o a "Escr" y en dichos casos:
  --    - Asigna a control.modo el valor "L" o "E", segun corresponda.
  --    - Asigna a "exito" valor verdadero.
  -- En caso contrario, no efectua ninguna accion.
  begin
    if cad(1)='L' and cad(2)='e' and cad(3)='c' and cad(4)='t'
      then control.modo:= L; exito:= true;
    elsif cad(1)='E' and cad(2)='s' and cad(3)='c' and cad(4)='r'
      then control.modo:= E; exito:= true;
    end if;
  end comprobarModo;

  repetir, nombreIntroducido, datosCorrectos: boolean;
  nombre: tpNomFich;
  cadena: string(1..80); modo: string(1..4);
  i, j, longCadena: integer;
 begin
  repetir:= true;
  while repetir loop
    begin
      put("Introduzca el nombre del fichero a abrir y el modo de acceso al ");
      put("mismo."); new_line; put("OBSERVACIONES: - El nombre del fichero ");
      put("no puede ser compuesto."); new_line; put("               - Modo ");
      put("Lectura = Lect; modo escritura = Escr."); new_line(2);
      put("Introduzca los datos solicitados (formato: nombre modo): ");
      get_line(cadena, longCadena);
      i:= 1; j:=1; nombreIntroducido:= false; datosCorrectos:= false;
      while cadena(i)=' ' loop
        i:= i+1;
      end loop;
      if i>longCadena
        then put("Ha introducido unicamente caracteres de espaciado.");
             new_line;
        else while not datosCorrectos and i<= longCadena loop
               if not nombreIntroducido
                 then -- Leemos nombre.
                   if cadena(i)=' '
                     then nombreIntroducido:= true;
                     else nombre.long:= i;
                          nombre.nom(nombre.long):= cadena(i);
                   end if;
                 else -- Leemos modo.
                   modo(j):= cadena(i);
                   if j=4
                    then comprobarModo(modo(1..4), control, datosCorrectos);
                         repetir:= not DatosCorrectos;
                   end if;
                   j:= j+1;
               end if; -- not nombreIntroducido.
               i:= i+1;
             end loop;  -- datosCorrectos and i<=longCadena.
             if not DatosCorrectos
               then put("Los datos introducidos no son validos o no respetan");
                    put(" el formato indicado."); new_line(2);
             end if;
      end if;   -- i>longCadena.
      exception
        when CONSTRAINT_ERROR|ada.text_IO.DATA_ERROR =>
          put("Introduzca datos del tipo apropiado y que respeten el ");
          put("formato indicado."); new_line(2);
    end;
  end loop; -- repetir
  Asociar (f, nombre, control.modo, control.asociado);
 end asociarFichero;


 procedure escribirCotizacionFichero (f: in out tpFCotizaciones;
                                     c: cotizacion) is
 -- Escribe en el fichero "f" la ultima cotizacion leida o introducida por
 -- el usuario.
 begin
  put("Esto escribira en el fichero la ultima cotizacion que ud. haya ");
  put("leido o introducido."); new_line;
  put("Escribiendo cotizacion..."); new_line;
  escribirCotizacion(f,c);
  put("La cotizacion escrita es : ");
  new_line;
  mostrarCotizacion(c); new_line;
 end escribirCotizacionFichero;


 procedure buscarFechaFichero (f: in out tpFCotizaciones;
                              cot: in out cotizacion;
                              exito: out boolean) is
 -- Solicita una fecha, la busca en el fichero y, en caso de estar, la devuelve
 -- en "cot".
 -- Se muestra, por la salida estandar, si la busqueda ha tenido exito o no.
  c: cotizacion;
  fecha: tpFecha;
 begin  -- de buscarFechaFichero.
  exito:= false; pideFecha(fecha);
  iniciarLectura(f);
  while not exito and not finFichero(f) loop
      siguienteCotizacionFecha(f,exito);
      cotizacionVentana(f,c);
      exito:= exito and (fechaSes(c)=fecha);
      if not exito then leerCotizacion(f,c); end if;
   end loop;
  if exito
    then put("Fecha encontrada."); new_line; cot:= c;
    else put("Fecha no alcanzada."); new_line;
  end if;
  new_line(2);
 end buscarFechaFichero;


 procedure buscarCotizacionFichero (f: in out tpFCotizaciones;
                                   c: out cotizacion;
                                   exito: out boolean) is
 -- El procedimiento solicita al usuario la introduccion de un ticker y de
 -- una fecha, y despues realiza una busqueda en base a dichos datos.
 -- Si la busqueda tiene exito, devuelve la cotizacion apropiada en "c", y
 -- "exitoBusq" tiene valor verdadero.
 -- En caso contrario no se asegura nada acerca del valor de "c" y ello queda
 -- reflejado en el valor "falso" del parametro de salida "exito".

  ticker: tpTicker;
  fecha: tpFecha;
 begin
  loop
    begin
      put("Ticker del valor bursatil: ");
      get_line(ticker.nom, ticker.long);
      ticker.long:=ticker.long+1;
      -- Añadimos el caracter terminador de ticker.
      ticker.nom(ticker.long):= character'val(126);
      new_line; exit;
    exception
      when CONSTRAINT_ERROR => put("Elija un ticker valido."); new_line;
    end;
  end loop;
  pideFecha(fecha); iniciarLectura(f); exito:= false;
  while not exito and not finFichero(f) loop
    siguienteCotizacionFecha(f,exito);
    cotizacionVentana(f,c);
    exito:= exito and (fechaSes(c)=fecha);
    if not exito then leerCotizacion(f,c); end if;
  end loop;
  if not exito and finFichero(f) then
    put_line("La fecha introducida no existe");
  else -- Hemos encontrado la fecha
    -- Buscamos el ticker dentro de esa fecha
    exito:= (tick(c).long=ticker.long) and then
             (tick(c).nom(1..tick(c).long)=ticker.nom(1..ticker.long));
    if exito then
      cotizacionVentana(f,c);
    else
      siguienteCotizacionTicker(f,ticker,exito);
      if exito then
        cotizacionVentana(f,c);
      else put("La cotizacion no se ha encontrado"); new_Line;
      end if;
    end if;
  end if;
 end buscarCotizacionFichero;


 procedure mostrarMenu (cad: out string) is
 -- Muestra por pantalla un menu con los operadores basicos para el trato
 -- de ficheros secuenciales de cotizaciones.

  function esOperador (cad: string) return boolean is
  -- Devuelve cierto si y solo si la cadena "cad" se corresponde con un
  -- operador valido.
  begin
    return cad="as" or cad="ds" or cad="il" or cad="ie" or cad="lc"
                    or cad="ec" or cad="ff" or cad="oc" or cad="mc"
                    or cad="bf" or cad="bc" or cad="cc" or cad="ss";
  end esOperador;

  valido: boolean:= false;
 begin
  put("MENU                         "); new_line;
  put("Asociar                    as"); new_line;
  put("Disociar                   ds"); new_line;
  put("Iniciar Lectura            il"); new_line;
  put("Iniciar Escritura          ie"); new_line;
  put("Leer Cotizacion            lc"); new_line;
  put("Escribir Cotizacion        ec"); new_line;
  put("Fin Fichero                ff"); new_line;
  put("Obtener Cotizacion         oc"); new_line;
  put("Mostrar Cotizacion         mc"); new_line;
  put("Buscar Fecha               bf"); new_line;
  put("Buscar Cotizacion          bc"); new_line;
  put("Comparar Cotizacion        cc"); new_line;
  put("Salir del menu             ss"); new_line;
  put("Elija una opcion: ");
  while not valido loop
    get(cad(1)); get(cad(2)); skip_line; new_line;
    valido:= esOperador(cad);
    while not valido loop
      put("Opcion incorrecta. Elija un operador valido.");
      new_line(2);
      put("Elija una opcion: "); get(cad(1)); get(cad(2)); skip_line; new_line;
      valido:= esOperador(cad);
    end loop;
  end loop;
 end mostrarMenu;


 procedure as (f: in out tpFCotizaciones; control: in out tpControlFich) is
 -- Gestiona la asociacion de un fichero.
 begin
  if control.asociado
    then put("Debe desasociar primero el fichero con el que trabaja.");
    else if control.previamenteAsociado
          then new_line;
               put("Tenga cuidado.Hasta que no lea nuevos datos de este ");
               put("fichero, si trata de mostrar una cotizacion, aparecera ");
               put("(en caso de existir) la ultima que haya introducido o ");
               put("leido del ultimo fichero.");
               new_line(2);
         end if;
         asociarFichero(f, control);
         if control.asociado
          then
            control.previamenteAsociado:= true;
            if control.modo=L then control.recienAbierto:= true; end if;
            put("Fichero ");
            if control.modo=L then put("abierto"); else put("creado"); end if;
             put(" satisfactoriamente.");
          else put("El fichero no ha podido ser ");
          if control.modo=L then put("abierto."); else put("creado."); end if;
      end if;
    new_line;
  end if;
 end as;


 procedure ds (f: in out tpFCotizaciones; control: in out tpControlFich) is
 -- Gestiona la disociacion de un fichero.
 begin
  control.asociado:= false;
  disociar(f);
  put("Fichero disociado."); new_line;
 end ds;


 procedure il (f: in out tpFCotizaciones; control: in out tpControlFich;
              c: out cotizacion) is
 -- Realiza las operaciones necesarias para iniciar la lectura de un fichero.
 begin
 put("Iniciando lectura..."); new_line;
 iniciarLectura(f);
 control.cotizacionDisponible:= true;
 control.recienAbierto:= false;
 cotizacionVentana(f,c);
 control.modo:= L;
 end il;


 procedure ie (f: in out tpFCotizaciones; control: in out tpControlFich) is
 -- Realiza las operaciones necesarias para iniciar la escritura de un fichero.
 begin
 put("Iniciando escritura..."); new_line;
 iniciarEscritura(f);
 control.modo:= E;
 end ie;


 procedure lc (f: in out tpFCotizaciones; control: in out tpControlFich;
              c: out cotizacion) is
 -- Realiza las operaciones necesarias para leer una cotizacion de un fichero.
 begin
  case control.modo is
   when E => put(" El modo de apertura del fichero imposibilita");
             put(" la lectura de datos del mismo."); new_line;
   when L => if finFichero(f)
                then put("No hay mas cotizaciones por leer.");
                else
                  put("Leyendo cotizacion..."); new_line;
                  if not control.cotizacionDisponible or control.recienAbierto
                    then control.recienAbierto:= false;
                         control.cotizacionDisponible:= true;
                         iniciarLectura(f); cotizacionVentana(f,c);
                     else leerCotizacion(f, c);
                  end if;
                  put("La cotizacion leida es: " );
                  new_line;
                  mostrarCotizacion(c);
                  new_line;
             end if;
    when others => null;
  end case;
 end lc;


 procedure ec (f: in out tpFCotizaciones; control: tpControlFich;
              c: cotizacion) is
 -- Realiza las operaciones necesarias para escribir una cotizacion en un
 -- fichero.
 begin
  case control.modo is
    when L => put(" El modo de apertura del fichero imposibilita");
              put(" la escritura de datos en el mismo."); new_line;
    when E => if not control.cotizacionDisponible
                then put("No hay cotizaciones que escribir."); new_line;
                else escribirCotizacionFichero(f, c);
              end if;
    when others => null;
  end case;
 end ec;


 procedure ff (f: in out tpFCotizaciones; control: tpControlFich) is
 -- Realiza las operaciones necesarias para determinar si el cursor del fichero
 -- esta al final del mismo o no, e informa del resultado por pantalla.

 begin
  new_line;
  case control.modo is
    when L => if finFichero(f)
                then put("Fin del fichero de cotizaciones.");
                else put("El fichero no ha terminado todavia.");
              end if;
    when others => put("El actual modo de trabajo con el fichero ");
                   put("hace que esta operacion no sea aplicable.");
  end case;
 end ff;


 procedure oc (control: in out tpControlFich; c: in out cotizacion) is
 -- Efectua las operaciones necesarias para permitir la introduccion interac-
 -- -tiva de una cotizacion.
 begin
  if not control.cotizacionDisponible
    then control.cotizacionDisponible:= true;
  end if;
  obtenerCotizacion(c);
 end oc;


 procedure mc (control: tpControlFich; c: cotizacion) is
 -- Efectua las comprobaciones necesarias para ver si puede mostrarse la
 -- cotizacion "c" y, en caso afirmativo, la muestra por pantalla.
 begin
  new_line;
  if not control.cotizacionDisponible
    then put("Todavia no se han leido cotizaciones."); new_line;
    else put("Mostrando cotizacion..."); new_line;
         mostrarCotizacion (c);
         new_line;
  end if;
 end mc;


 procedure bf (f: in out tpFCotizaciones; control: tpControlFich;
              c: out cotizacion) is
 -- Efectua las operaciones necesarias para buscar la proxima cotizacion
 -- con fecha distinta a la de la cotizacion actual, y devuelve dicha
 -- cotizacion en "c".
 exito: boolean;
 begin
  case control.modo is
    when L =>  buscarFechaFichero(f, c, exito);
               if exito
                 then put("La primera cotizacion con fecha igual a la ");
                      put("indicada es: "); new_line;
                      mostrarCotizacion(c);
               end if;
    when others => put("El modo de apertura del fichero imposibilita la ");
                   put("busqueda de cotizaciones en el mismo.");
                   new_line;
  end case;
 end bf;


 procedure bc (f: in out tpFCotizaciones; control: tpControlFich;
              c: out cotizacion) is
 -- Efectua las operaciones necesarias para buscar una determinada cotizacion
 -- en el fichero, y, en caso de hallarla, la devuelve en "c".
 -- En todo caso, informa por pantalla del resultado de la busqueda.
  exito: boolean:= false;
 begin
  case control.modo is
    when L =>  buscarCotizacionFichero(f, c, exito);
               if exito
                 then put("Cotizacion encontrada."); new_line;
                      put("Mostrando cotizacion..."); new_line;
                      mostrarCotizacion(c);
                 else put("Cotizacion no encontrada.");
               end if;
    when others => put("El modo de apertura del fichero imposibilita la ");
                   put("busqueda de cotizaciones en el mismo.");
                   new_line;
  end case;
 end bc;


 procedure cc (control: tpControlFich; c: cotizacion) is
 -- Compara una cotizacion introducida interactivamente con la ultima leida o
 -- introducida por el usuario.
 -- El resultado de la comparacion aparece por la salida estandar.

  igualdad: integer;
  c2: cotizacion;
 begin  -- de compararCotizacionMenu.
  if not control.cotizacionDisponible
    then put("Introduzca previamente una cotizacion mediante la operacion ");
         put('''); put('''); put("obtener cotizacion"); put('''); put(''');
         put(" o leyendola de un fichero."); new_line;
    else obtenerCotizacion(c2);
         compararCotizaciones(c, c2, igualdad);
         case igualdad is
           when 1 => put("Las cotizaciones coinciden.");
           when others => put("Las cotizaciones no coinciden.");
        end case;
        new_line(2);
  end if;
 end cc;


 procedure tratarOpcion (cad: in string; f: in out tpFCotizaciones;
                        control: in out tpControlFich; c: in out cotizacion;
                        fecha: in out tpFecha) is
 -- Elige, en funcion del operador deseado, la secuencia de instrucciones a
 -- ejecutar.
 begin
 -- Si todavia no hemos asociado ningun fichero y pretendemos
 -- realizar alguna operacion distinta de "Asociar".
  if not control.asociado and cad/="as"
    then put("Ha de asociar un fichero previamente.");
  else -- Hemos asociado algun fichero o tratamos de asociarlo.
    if cad="as"
      then as (f, control);
     elsif cad="ds"
       then ds (f, control);
     elsif cad="il"
       then il (f, control, c);
     elsif cad="ie"
       then ie (f, control);
     elsif cad="lc"
       then lc (f, control, c);
     elsif cad="ec"
       then ec (f, control, c);
     elsif cad="ff"
       then ff (f, control);
     elsif cad="oc"
       then oc (control, c);
     elsif cad="mc"
       then mc (control, c);
     elsif cad="bf"
       then bf (f, control, c);
     elsif cad="bc"
       then bc (f, control, c);
     elsif cad="cc"
       then cc (control, c);
    else put("Opcion no valida");
    end if;
 end if;
 new_line(2);
 end tratarOpcion;


 cad: string(1..2);
 cot: cotizacion;
 fecha: tpFecha;
 f: tpFCotizaciones;
 control: tpControlFich;
begin  -- de pmenu1.
 -- Inicializamos los campos de la variable "control".
 control.asociado:= false; control.previamenteAsociado:= false;
 control.cotizacionDisponible:= false; control.recienAbierto:= true;
 -- Comienza el programa dirigido por menu.
 mostrarMenu(cad);
 while cad(1..2)/="ss" loop
  tratarOpcion(cad, f, control, cot, fecha);
  mostrarMenu(cad);
 end loop;
 new_line(2);
 put("Fin de la ejecucion del programa.");
end pmenu1;
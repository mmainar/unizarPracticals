------------------------------------------------------------------------------
-- Fichero: simulador.adb
-- Tema:    programa de prueba del TAD simuladorprograma
-- Fecha:   17 de Octubre de 2007
-- Autor:   Basado en la solución de Santiago Marco Sola
-- Com.:    Ejercicio propuesto de MAC (Modelos abstractos de cálculo).
------------------------------------------------------------------------------ 


with ada.text_IO, ada.integer_text_IO, simuladorprograma;
use ada.text_IO, ada.integer_text_IO, simuladorprograma;

procedure simulador is

  procedure MostrarMenu is
  begin
    put("Menu Simulacion");new_line;
    put("1 - Simular programa ");new_line;
    put("2 - Simular programa con reloj ");new_line;
    put("3 - Salir ");new_line;
    put("Seleccione una opcion: ");
  end MostrarMenu;

  procedure CogerFichero(f: in out filetype; exito: out boolean) is
    nombreFichero : string(1..30);
    longitud : integer;
    opcion : integer;
  BEGIN
     Put("Tu fichero debe contener un procedimiento ADA correcto y ");New_Line;
     put("con un parámetro de entrada y otro de salida,");new_line;
     put("ambos de tipo programa"); new_line;
    put("1 - Leer programa de un fichero"); new_line;
    put("2 - Salir"); new_line;
    put("Seleccione una opcion: ");
    get(opcion); skip_line;
    if (opcion = 1) then
      put("Introduzca el nombre del fichero: ");
      get_line(nombreFichero, longitud);
      open(f,in_file,nombreFichero(1..longitud));
      exito := true;
    else
      exito := false;
    end if;
  end CogerFichero;

  procedure CogerEntrada(p : in programa; x : out cadena) is
    f : filetype;
     auxp: programa;
    entrada : string(1..512);
    longitud, opcion : integer;
  begin
    put("1 - Leer entrada de un fichero (de texto)"); new_line;
    put("2 - Leer entrada desde terminal"); new_line;
    put("3 - Usar como entrada el propio programa -Por defecto-"); new_line;
    put("Seleccione una opcion: ");
    get(opcion); skip_line;
    if (opcion = 1) then
      put("Introduzca el nombre del fichero: ");
      get_line(entrada, longitud); skip_line;
      open(f,in_file,entrada(1..longitud));
      leeDeFichero(f,auxp);
        Close(F); 
        programaacadena(auxp,x);
    elsif (opcion = 2) then
      put("Introduzca la entrada: "); get_line(entrada,longitud);
        Auxp := A_Programa(Entrada(1..Longitud));
        programaacadena(auxp,x);
     else
      programaacadena(p,x);
    end if;
  end CogerEntrada;

  procedure MenuSimular is
    f : filetype;
    p : programa;
    x : cadena;
    exito : boolean;
  begin
    CogerFichero(f,exito);
    if exito then
      leeDeFichero(f,p);
      close(f);
      CogerEntrada(p,x);
      simular(p,x,exito);
      new_line; put("--> La simulacion ha finalizado con exito.");
      new_line; put("Observaciones:");
      new_line; put("  -->  El resultado de salida (si hubiera)");
      new_line; put("       se halla en el fichero 'SalidaEjecutar' ");
      new_line; put("  -->  El informe de la compilacion se halla");
      new_line; put("       en el fichero 'InformeCompilacion.inf' ");
      new_line(2);
    end if;
  end MenuSimular;

  procedure MenuSimularConReloj is
    f : filetype;
    p : programa;
    x : cadena;
    exito : boolean;
    t : integer;
  begin
    CogerFichero(f,exito);
    if exito then
      leeDeFichero(f,p);
      close(f);
      CogerEntrada(p,x);
      put("Durante cuantos segundos quiere simular: ");
      get(t);
      simularConReloj(p,x,t,exito);
      if exito then
        new_line; put("--> La simulacion ha finalizado con exito.");
        new_line; put("Observaciones:");
        new_line; put("  -->  El resultado de salida (si hubiera)");
        new_line; put("       se halla en el fichero 'SalidaEjecutar' ");
        new_line; put("  -->  El informe de la compilacion se halla");
        new_line; put("       en el fichero 'InformeCompilacion.inf' ");
        new_line(2);
      else
        new_line; put("--> La simulacion no ha conseguido terminar en ");
        put(t,3); put(" segundos o menos."); new_line(2);
      end if;
    end if;
  end MenuSimularConReloj;

  opcion : integer;
begin
  MostrarMenu;
  get(opcion); skip_line;
  while opcion /= 3 loop
    if opcion = 1 then
      MenuSimular;
    elsif opcion = 2 then
      MenuSimularConReloj;
    end if;
    MostrarMenu;
    get(opcion); skip_line;
  end loop;
end simulador;
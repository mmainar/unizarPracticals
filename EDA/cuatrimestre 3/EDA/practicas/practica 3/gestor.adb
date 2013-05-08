-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: programa de gestion del TAD listaexitos
--           para la práctica 3 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: gestor.adb
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de éxitos formada por canciones con un título, un
--              intérprete, una fecha de grabación y un número de
--              ventas.
with interfaces.c,fecha, Ada.Strings.Unbounded, ustrings, listaexitos, ada.text_IO, ada.integer_text_IO;
use fecha, Ada.Strings.Unbounded , ustrings, listaexitos, ada.text_IO, ada.integer_text_IO;

procedure gestor is

package c renames interfaces.c;
function system (command: c.char_array) return c.int;
pragma import(C,system,"system");


  procedure escribirMenu is
  -- Post: escribe por pantalla el menu inicial
  begin
    put("                         GESTION DE LISTAS DE EXITOS"); new_Line(2);
    put("(a) Elegir una lista de exitos."); new_line;
    put("(b) Agregar una cancion a la lista de exitos."); new_line;
    put("(c) Listar en pantalla todas las canciones de la lista de exitos."); new_line;
    put("(d) Eliminar una cancion de la lista de exitos."); new_line;
    put("(e) Ver todas las canciones de fecha posterior a una dada en la lista de exitos."); 
    put("(f) Ver las cuarenta canciones mas vendidas de la lista de exitos"); new_line;
    put("(g) Guardar cambios en la lista de exitos"); new_Line;
    put("(h) Terminar"); new_line(2);
    put("Elige una opcion... ");
  end escribirMenu;


  procedure pideFecha(fecha: out tpfecha) is
  -- Post: solicita al usuario que introduzca la fecha
  --       de una canción y la almacena en "fecha".
    d,m,a: natural;
  begin
    put("Introduzca la fecha de la cancion: "); new_Line;
    put("Introduzca el dia: "); get(d); skip_Line;
    put("Introduzca el mes: "); get(m); skip_Line;
    put("Introduzca el anyo: "); get(a); skip_Line;
    fecha:= creafecha(d,m,a);
  end pideFecha;


  procedure cogerCancion(can: out cancion) is
  -- Post: solicita al usuario que introduzca los datos de una
  --       canción y los almacena en "can".
  begin
    new_Line;
    put("Introduzca los datos de la nueva lista de exitos: "); new_Line;
    put("Introduzca el titulo de la cancion: "); get_line(can.titulo);
    if not (can.titulo=null_unbounded_string) then
      put("Introduzca el interprete de la cancion: "); get_line(can.interprete);
      pideFecha(can.tiempo);
      put("Introduzca las ventas: "); get(can.ventas); skip_Line;
    end if;
  end cogerCancion;


  procedure menuEleccionLista is
  -- Post: Escribe por pantalla el menú secundario de elección de una
  --       lista de éxitos.
  begin
    new_Line(2);
    put("(1) Leer las canciones desde un fichero ya existente.");
    new_Line;
    put("(2) Leer las canciones desde teclado."); new_Line;
    put("(3) Leer las canciones desde 2 ficheros ya existentes "); new_line;
    put("    y considerar la union de los mismos."); new_Line;
    put("(4) Leer las canciones desde 2 ficheros ya existentes "); new_line;
    put("    y considerar la interseccion de los mismos."); new_Line(2);
    put("Elige una opcion... ");
  end menuEleccionLista;


  procedure leerDeFichero(l: out lista) is
  -- Post: Solicita al usuario el nombre de un fichero de
  --       texto que contenga las canciones de una lista
  --       de éxitos y las almacena en la lista "l".
    f: texto;
    nombre: string(1..100);
    longitud,d, m, a: natural;
    c: cancion;
  begin
    put("Introduzca el nombre del fichero de texto: ");
    get_line(nombre,longitud);
    open(f,in_file,nombre(1..longitud));
    vacia(l);
    while not end_of_file(f) loop
      get_line(f,c.titulo);
      get_line(f,c.interprete);
      get(f,d); get(f,m); get(f,a);
      c.tiempo:= creafecha(d,m,a); skip_Line(f);
      get(f,c.ventas);
      if not end_of_file(f) then skip_Line(f); end if;
      if not end_of_file(f) then skip_line(f); end if;
      anyadir(l,c);
    end loop;
    close(f);
  end leerDeFichero;


  procedure mostrarError is
  -- Post: Informa al usuario de que se ha producido un error
  --       al no haber elegido todavía una lista de éxitos con
  --       la que trabajar.
  begin
    new_Line;
    put("Antes debes elegir una lista de exitos");
    new_Line;
  end mostrarError;


  procedure borrarCancion(l: in out lista) is
  -- Post: Solicita al usuario los datos de una canción a
  --       borrar y la elimina de la lista "l".
    can: cancion;
  begin
    put("Introduzca los datos de la cancion a borrar: "); new_line;
    put("Introduzca el titulo de la cancion: "); get_line(can.titulo);
    put("Introduzca el interprete de la cancion: "); get_line(can.interprete);
    pideFecha(can.tiempo); borrar(l,can);
  end borrarCancion;


  procedure opcionA(opcion: in character; l: in out lista) is
  -- Post: Realiza las diferentes acciones asociadas a la 
  --       opción A del menú principal.
    can: cancion;
    l1,l2,lnueva: lista;
  begin
    if opcion='1' then leerDeFichero(l);
    elsif opcion='2' then
      cogerCancion(can);
      while not(can.titulo=null_unbounded_string) loop
        anyadir(l,can); cogerCancion(can);
      end loop;
    elsif opcion='3' then
      leerDeFichero(l1); leerDeFichero(l2);
      union(l1,l2,lnueva); asignar(lnueva,l);
    elsif opcion='4' then
      leerDeFichero(l1); leerDeFichero(l2);
      interseccion(l1,l2,lnueva); asignar(lnueva,l);
    end if;
  end opcionA;


  procedure opcionCualquiera(opcion: in character; l: in out lista) is
  -- Post: Gestiona las acciones a realizar en función de la opción
  --       elegida en el menú principal.
    can: cancion;
    fecha: tpfecha;
    lnueva: lista;
    nombre: string(1..100);
    longitud: integer;
    f: texto;
  begin
    case opcion is
      when 'b' => cogerCancion(can); anyadir(l,can);
      when 'c' => listado(l);
      when 'd' => borrarCancion(l);
      when 'e' => pideFecha(fecha); actualizada(l,lnueva,fecha);
                  listado(lnueva);
      when 'f' => loscuarenta(l,lnueva); listado(lnueva);
      when 'g' => put("Introduzca el nombre de un fichero de texto: ");
                  get_line(nombre,longitud);
                  create(f,out_file,nombre(1..longitud));
                  grabacion(f,l);
      when others => new_line; put("Opcion incorrecta"); new_line;
      end case;
  end opcionCualquiera;


  rc: c.int;
  l: lista;
  opcion, opcionAux, car: character;
  elegida: boolean:= false;
begin
  escribirMenu; get(opcion); skip_Line; 
  while not (opcion='h') loop
    if opcion='a' then
      vacia(l); menuEleccionLista; get(opcionAux); skip_Line;
      if (opcionAux>='1') and (opcionAux<='4') then
        opcionA(opcionAux,l); elegida:= true;
      else
        new_line; put("Opcion incorrecta"); new_line;
      end if;
    else
      if not elegida then mostrarError;
      else opcionCualquiera(opcion,l); end if;
    end if;
    new_line(2);
    put("Pulsa una tecla para continuar...");
    get_immediate(car);
    rc:=system(c.to_c("gnat"));
    escribirMenu; get(opcion); skip_Line;
  end loop;
end gestor;
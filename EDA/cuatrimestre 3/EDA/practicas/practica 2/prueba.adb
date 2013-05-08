-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: programa de prueba del TAD listaexitos
--           para la práctica 2 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: prueba.adb
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de éxitos formada por canciones con un título, un
--              intérprete, una fecha de grabación y un número de
--              ventas.
with interfaces.c,fecha, Ada.Strings.Unbounded, ustrings, listaexitos, ada.text_IO, ada.integer_text_IO; 
use fecha, Ada.Strings.Unbounded, ustrings, listaexitos, ada.text_IO, ada.integer_text_IO;

procedure principal is

  package c renames interfaces.c;
  function system (command: c.char_array) return c.int;
  pragma import(C,system,"system");

  
  procedure escribirMenu is
  begin
    put("1 - Crea una lista de exitos vacia "); new_line;
    put("2 - Agregar una cancion a la lista de exitos "); new_line;
    put("3 - Borrar una cancion de la lista de exitos "); new_line;
    put("4 - Ver si hay alguna cancion que supere las ventas "); new_line;
    put("5 - Ver si la lista es vacia "); new_line;
    put("6 - Crear una nueva lista con las canciones (y trabajar con ella) de fecha posterior a una dada "); new_line;
    put("7 - Mostrar la lista de exitos"); new_Line;
    put("8 - Borrar una lista"); new_line;
    put("9 - Crear una lista (y trabajar con ella) con los 40 exitos mas vendidos"); new_line;
    put("0 - Salir"); new_line;
    put("Elige una opcion: "); 
  end escribirMenu;
  
  rc: c.int;
  car:character;
  l, lnueva: lista;
  can: cancion;
  titulo, interprete: ustring;
  fecha: tpfecha;
  d,m,a, ventas, opcion: integer;
begin
  escribirMenu; get(opcion); skip_Line;
  while not (opcion=0) loop
    if opcion=1 then vacia(l);
    elsif opcion=2 then
      put("Introduzca los datos de la nueva lista de exitos: "); new_Line; 
      put("Introduzca el titulo de la cancion: "); get_line(titulo);
      put("Introduzca el interprete de la cancion: "); get_line(interprete);
      put("Introduzca la fecha de la cancion: "); new_Line;
      put("Introduzca el dia: "); get(d); skip_Line;
      put("Introduzca el mes: "); get(m); skip_Line;
      put("Introduzca el anyo: "); get(a); skip_Line;
      fecha:= creafecha(d,m,a);
      put("Introduzca las ventas: "); get(ventas); skip_Line;
      can.titulo:= titulo; can.interprete:= interprete;
      can.tiempo:= fecha; can.ventas:= ventas;
      anyadir(l,can);
    elsif opcion=3 then
      put("Introduzca los datos de la cancion a borrar: "); new_Line; 
      put("Introduzca el titulo de la cancion: "); get_line(titulo);
      put("Introduzca el interprete de la cancion: "); get_line(interprete);
      put("Introduzca la fecha de la cancion: "); new_Line;
      put("Introduzca el dia: "); get(d); skip_Line;
      put("Introduzca el mes: "); get(m); skip_Line;
      put("Introduzca el anyo: "); get(a); skip_Line;
      can.titulo:= titulo; can.interprete:= interprete;
      can.tiempo:= fecha; borrar(l,can);
    elsif opcion=4 then
      put("Introduzca el numero de ventas de cota: "); get(ventas); skip_Line;
      if superacota(l,ventas) then put("Hay alguna cancion en la lista que supera la cota");
      else put("No hay ninguna cancion en la lista que supere la cota"); end if;
      new_Line;
    elsif opcion=5 then
      if esvacia(l) then put("La lista esta vacia"); 
      else put("La lista no esta vacia"); end if; new_Line;
    elsif opcion=6 then
      put("Introduzca la fecha de la cancion: "); new_Line;
      put("Introduzca el dia: "); get(d); skip_Line;
      put("Introduzca el mes: "); get(m); skip_Line;
      put("Introduzca el anyo: "); get(a); skip_Line;
      fecha:= creafecha(d,m,a);
      actualizada(l,lnueva,fecha);
      asignar(lnueva,l);
      put("La nueva lista ha sido creada"); new_Line;
    elsif opcion=7 then
      mostrar(l);
    elsif opcion=8 then
      liberar(l);
    elsif opcion=9 then
      losCuarenta(l,lnueva);
      asignar(lnueva,l);
    end if;
    new_line(2);
    put("Pulsa una tecla para continuar...");
    get_immediate(car);
    rc:=system(c.to_c("cls"));
    escribirMenu; get(opcion); skip_Line;
  end loop;  
end principal;

-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: módulo de implementación del TAD listaexitos
--           para la práctica 4 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: nacionalidades.adb
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de nacionalidades.
with ada.text_IO, ada.strings.unbounded, ada.integer_text_IO, unchecked_deallocation;
use ada.text_IO, ada.strings.unbounded, ada.integer_text_IO;
package body nacionalidades is

 procedure disponer is new unchecked_deallocation(unDato,ptDato);


 procedure cargarNacionalidades(ln: in out listaNac) is
 -- Post: Carga la lista de nacionalidades ln desde un fichero de texto externo
 --       llamado "nacionalidades.txt"
   f: ada.text_IO.file_type;
   n: nacionalidad;
   c: character;
 begin
   open(f,in_file,"nacionalidades.txt");
   while not end_of_file(f) loop
     get(f,n.codigo); get(f,c); get_line(f,n.descripcion);
     agregarNacionalidad(ln,n);
   end loop;
   close(f);
 end cargarNacionalidades;


 procedure agregarNacionalidad(ln: in out listaNac; n: in nacionalidad) is
 -- Pre: ln=ln0
 -- Post: ln=AÑADIR(l0,n.codigo,n.descripcion)
   aux: ptDato;
   exito: boolean:= false;
 begin
   aux:= ptDato(ln);
   while (aux/=null) and not exito loop
     exito:=(aux.dato.codigo=n.codigo);
     aux:=aux.sig;
   end loop;
   if not exito then -- Agregamos al principio de la lista dinamica
     aux:= new unDato;
     aux.dato:= n;
     aux.sig:= ptDato(ln);
     ln:= listaNac(aux);
   end if;
 end agregarNacionalidad;


 procedure modificarDescripcion(ln: in out listaNac; c: natural; d: ustring) is
 -- Pre: ln=ln0
 -- Post: ln=MODIFICAR(ln0,c,d)
   aux: ptDato;
   exito: boolean;
 begin
   aux:= ptDato(ln); exito:= false;
   -- Buscamos la nacionalidad en la lista
   while (aux/=null) and not exito loop
     exito:= (aux.dato.codigo=c);
     if exito then
       -- Modificamos la descripción de la nacionalidad
       aux.dato.descripcion:= d;
     else aux:= aux.sig;
     end if;
   end loop;
 end modificarDescripcion;


 procedure borrarNacionalidad(ln: in out listaNac; c: natural) is
 -- Pre: ln=ln0
 -- Post: si ESTÁ(ln,c) entonces ln=BORRAR(ln0,c)
 --       sino ln=ln0
   aux, ant: ptDato;
   exito: boolean;
 begin
   aux:= ptDato(ln); ant:= ptDato(ln);
   exito:= (aux.dato.codigo=c);
   if exito then
     ln:= listaNac(aux.sig);
     disponer(aux);
   end if;
   -- Buscamos la nacionalidad en la lista
   while (aux/=null) and not exito loop
     exito:= (aux.dato.codigo=c);
     if exito then
       -- Borramos la nacionalidad de la lista
       ant.sig:= aux.sig;
       disponer(aux);
     else ant:= aux; aux:= aux.sig;
     end if;
   end loop;
 end borrarNacionalidad;


 procedure guardarNacionalidades(ln: in listaNac; f: in out texto) is
 -- Post: Guarda en el fichero de texto f la lista de nacionalidades
 --       ln en su estado actual.
   aux: ptDato;
 begin
   aux:= ptDato(ln);
   while (aux/=null) loop
     put(f,aux.dato.codigo,0); put(f,' ');
     put(f,aux.dato.descripcion);
     new_Line(f);
     aux:= aux.sig;
   end loop;
   put("Las nacionalidades se han guardado correctamente"); new_Line;
 end guardarNacionalidades;


 procedure listarNacionalidades(ln: in listaNac)is
 -- Post: Muestra por pantalla la lista de nacionalidades con su código
 --       y su descripción asociada.
   aux: ptDato;
 begin
   put("Listando las nacionalidades..."); new_Line;
   put("Codigo"); put("  "); put("Descripcion"); new_Line;
   aux:= ptDato(ln);
   while (aux/=null) loop
     put(aux.dato.codigo,5); put("   ");
     put(aux.dato.descripcion);
     new_Line;
     aux:= aux.sig;
   end loop;
 end listarNacionalidades;


 function comprobarNacionalidad(ln: listaNac; n: natural) return boolean is
 -- Post: Devuelve cierto si y solo si existe una nacionalidad en la lista
 --       de nacionalidades ln cuyo código de nacionalidad es "n".
   aux: ptDato;
   exito: boolean:= false;
 begin
   aux:= ptDato(ln);
   while (aux/=null) and not exito loop
     exito:= (aux.dato.codigo=n);
     if not exito then aux:= aux.sig; end if;
   end loop;
   return exito;
 end comprobarNacionalidad;

end nacionalidades;
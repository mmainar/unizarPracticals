-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: módulo de implementación del TAD listaexitos
--           para la práctica 3 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: listaexitos.adb
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de éxitos formada por canciones con un título, un
--              intérprete, una fecha de grabación y un número de
--              ventas.
with fecha, ada.strings.unbounded, unchecked_deallocation, ada.text_IO, ada.integer_text_IO;
use fecha, ada.strings.unbounded, ada.text_IO, ada.integer_text_IO;
package body listaexitos is

 procedure disponer is new unchecked_deallocation(unDato,ptDato);


 procedure vacia(l:out lista) is
 -- crea una lista de exitos vacía
 begin
   l:=null;
 end vacia;


 procedure anyadir(l:in out lista; c:in cancion) is
 -- modifica l de la siguiente forma: si ya había una canción
 -- en l con el mismo intérprete y título que c actualiza el
 -- número de ventas, en otro caso añade c
   exito: boolean:=false;
   aux, nuevo: ptDato;
 begin
   if l=null then -- lista vacía
     l:=new unDato; l.dato:=c; l.sig:=null;
   else
     aux:=ptDato(l);
     while (aux/=null) and not exito loop
       exito:= (aux.dato.interprete=c.interprete) and
                (aux.dato.titulo=c.titulo) and
                ( aux.dato.tiempo=c.tiempo);
       if exito then aux.dato.ventas:= c.ventas;
       else aux:=aux.sig; end if;
     end loop;
     if not exito then -- la canción no ha sido encontrada
       aux:=ptDato(l);
       if (c.ventas>aux.dato.ventas) then -- Añadimos al principio
         aux:=new unDato; aux.dato:= c;
         aux.sig:= ptDato(l); l:= lista(aux);
       else -- Buscamos el punto de inserción
         aux:= ptDato(l);
         while (aux.sig/=null) and (c.ventas<aux.dato.ventas) loop
           aux:=aux.sig;
         end loop;
         if c.ventas>=aux.dato.ventas then
           -- Inserción entre 2 registros
           nuevo:= new unDato; nuevo.all:= aux.all;
           nuevo.sig:= aux.sig; aux.dato:= c;
           aux.sig:= nuevo;
         else -- Inserción al final
           aux.sig:= new unDato; aux:= aux.sig;
           aux.dato:= c; aux.sig:= null;
         end if;
       end if;
     end if;
   end if;
 end anyadir;


 procedure borrar(l:in out lista; c:in cancion) is
 -- modifica l eliminando la canción c si esta estaba en l
   exito: boolean:=false;
   aux, ant: ptDato;
 begin
   if not esvacia(l) then
     aux:=ptDato(l);
     if (aux.dato.interprete=c.interprete) and
          (aux.dato.titulo=c.titulo) and
          (aux.dato.tiempo=c.tiempo) then
        l:=lista(aux.sig); disponer(aux);
     else
       ant:=aux; aux:=aux.sig;
       while (aux/=null) and not exito loop
           exito:= (aux.dato.interprete=c.interprete) and
                     (aux.dato.titulo=c.titulo) and
                     (aux.dato.tiempo=c.tiempo);
         if not exito then
           ant:=aux; aux:=aux.sig;
         end if;
       end loop;
       if exito then
         ant.sig:=aux.sig; disponer(aux);
       end if;
     end if;
   end if;
 end borrar;


 function superacota(l:lista; cota:integer) return boolean is
 -- devuelve cierto si existe una canción en l con número de
 -- ventas mayor que cota
 begin
   if esvacia(l) then
     return false;
   else
     return (l.dato.ventas>cota);
   end if;
 end superacota;


 procedure actualizada(l:in lista; lact:out lista; f:in tpfecha) is
 -- calcula lact una lista con las canciones de l que tienen
 -- fecha de grabación posterior a f
   ptaux: ptDato;
 begin
   ptaux:= ptDato(l); vacia(lact);
   while not (ptaux=null) loop
     if (ptaux.dato.tiempo >f) then anyadir(lact,ptaux.dato); end if;
     ptaux:= ptaux.sig;
   end loop;
 end actualizada;


 function esvacia(l:lista) return boolean is
 -- devuelve cierto si l está vacía
 begin
   return (l=null);
 end esvacia;


 procedure loscuarenta(l:in lista; lhits: out lista) is
 -- Post: si l tiene menos de 40 canciones lhits=l, si no lhits
 -- es una lista con las 40 canciones de l que tienen mayor
 -- número de ventas
   numCanciones: natural:=0;
   aux: ptDato;
 begin
   vacia(lhits);
   if not esvacia(l) then
     aux:=ptDato(l);
     while (aux/=null) and not(numCanciones=40) loop
       anyadir(lhits,aux.dato );
       aux:=aux.sig;
       numCanciones:=numCanciones+1;
     end loop;
   end if;
 end loscuarenta;


 procedure asignar(lin: in lista; lout: out lista) is
 -- Post: lout=lin, duplicando la representación en memoria
   ptin,ptout: ptDato;
 begin
   if esvacia(lin) then
     vacia(lout);
   else
     ptin:= ptDato(lin);
     ptout:= new unDato;
     lout:= lista(ptout);
     ptout.dato:= ptin.dato;
     ptin:= ptin.sig;
     while not (ptin=null) loop
       ptout.sig:= new unDato;
       ptout:= ptout.sig;
       ptout.dato:= ptin.dato;
       ptin:= ptin.sig;
     end loop;
     ptout.sig:= null;
   end if;
 end asignar;


 procedure liberar(l: in out lista) is
 -- Post: l=VACIA y además libera la memoria previamente utilizada por l
   ant,aux: ptDato;
 begin
   if esvacia(l) then
     vacia(l);
   else
     aux:= ptDato(l);
     while not (aux=null) loop
       ant:= aux;
       aux:= aux.sig;
       disponer(ant);
     end loop;
     l:= null;
   end if;
 end liberar;
 
 
 procedure escribirCadenaCota(cad: in ustring; cota: in integer) is
 begin
   if length(cad) > cota then
     for i in 1..cota loop
       put(to_string(cad)(i));
     end loop;
   else
     put(cad);
     for i in 1..cota-length(cad) loop
       put(' ');
     end loop;
   end if;
 end escribirCadenaCota;
   
 

 procedure escribirCancion(c: in cancion) is
 begin
   escribirCadenaCota(c.titulo,25);
   put(' ');
   escribirCadenaCota(c.interprete,25);      
   put(' ');
   put(eldia(c.tiempo),2); put('/');
   put(elmes(c.tiempo),2); put('/');
   put(elanyo(c.tiempo),4); put("  ");
   put(c.ventas,8);
   put("   ");
   put(c.nacionalidad,3); 
   new_line;
 end escribirCancion;


 procedure listado(l: in lista; c: in natural) is
 -- Post: lista en pantalla las canciones almacenadas en la lista l
   aux: ptDato;
 begin
   new_line; aux:= ptDato(l);
   put("Titulo                    Interprete                Fecha       Ventas    Nac."); new_line;
   put("------------------------------------------------------------------------------"); new_line;
   while (aux/=null) loop
     if c=0 then -- Listamos todas las canciones
       escribirCancion(aux.dato);
     else -- Listamos las canciones con codigo de nacionalidad c
       if c=aux.dato.nacionalidad then
         escribirCancion(aux.dato);
       end if;
     end if;
     aux:=aux.sig;
   end loop;
 end listado;


 procedure union(l1,l2: in lista; lout: out lista) is
 -- Post: lout es la unión de las listas l1 y l2
   aux: ptDato;
 begin
   vacia(lout);
   aux:=ptDato(l1);
   while (aux/=null) loop
     anyadir(lout,aux.dato);
     aux:=aux.sig;
   end loop;
   aux:=ptDato(l2);
   while (aux/=null) loop
     anyadir(lout,aux.dato);
     aux:=aux.sig ;
   end loop;
 end union;


 procedure interseccion(l1,l2: in lista; lout: out lista) is
 -- Post: lout es la intersección de las listas l1 y l2
   aux1, aux2: ptDato;
   exito: boolean;
 begin
   vacia(lout); aux1:=ptDato(l1);
   while (aux1/=null) loop
     aux2:=ptDato(l2); exito:=false;
     while (aux2/=null) and not exito loop
       exito:=(aux1.dato.titulo=aux2.dato.titulo)
               and (aux1.dato.interprete=aux2.dato.interprete)
               and (aux1.dato.tiempo=aux2.dato.tiempo);
       aux2:=aux2.sig;
     end loop;
     if exito then anyadir(lout,aux1.dato); end if;
     aux1:=aux1.sig;
   end loop;
 end interseccion;


 procedure grabacion(f: in out texto; l: in lista) is
 -- Post: almacena en el fichero de texto externo "nacionalidades.txt" 
 -- la lista de éxitos l en su estado actual
   aux: ptDato;
 begin
   reset(f,out_file); aux:= ptDato(l);
   while (aux/=null) loop
     put_line(f,aux.dato.titulo);
     put_line(f,aux.dato.interprete);
     put(f,eldia(aux.dato.tiempo),0); put(f,' ');
     put(f,elmes(aux.dato.tiempo),0); put(f,' ');
     put(f,elanyo(aux.dato.tiempo),0); new_line(f);
     put(f,aux.dato.ventas,0); new_line(f);
     new_line(f);
     aux:= aux.sig;
   end loop;
   close(f);
 end grabacion;


 function estaNacionalidad(l: in lista; n: natural) return boolean is
 -- Post: Devuelve cierto si y solo si en l hay alguna canción cuyo
 -- código de nacionalidad sea igual a n y falso en caso contrario.
   aux: ptDato;
   exito: boolean;
 begin
   aux:= ptDato(l); exito:= false;
   while (aux/=null) and not exito loop
     exito:= aux.dato.nacionalidad=n;
     aux:= aux.sig;
   end loop;
   return exito;
 end estaNacionalidad;

end listaexitos;
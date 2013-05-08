-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: módulo de definición del TAD listaexitos
--           para la práctica 2 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: listaexitos.ads
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de éxitos formada por canciones con un título, un
--              intérprete, una fecha de grabación y un número de
--              ventas.

with fecha, unchecked_deallocation, ada.text_IO, ada.integer_text_IO, ada.strings.unbounded, ustrings; 
use fecha, ada.text_IO, ada.integer_text_IO, ada.strings.unbounded, ustrings;
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
      l:=new unDato;
      l.dato:=c;
      l.sig:=null;
    else 
      aux:=ptDato(l);
      while (aux/=null) and not exito loop
        exito:= (aux.dato.interprete=c.interprete) and
                 (aux.dato.titulo=c.titulo) and
		 (aux.dato.tiempo=c.tiempo);
	if exito then aux.dato.ventas:= c.ventas; 	 
	else aux:=aux.sig; 
	end if;	 
      end loop;
      if not exito then -- la canción no ha sido encontrada
        aux:=ptDato(l);
        if (c.ventas>aux.dato.ventas) then -- Añadimos al principio
          aux:=new unDato;
	  aux.dato:= c;
	  aux.sig:= ptDato(l);
	  l:= lista(aux);
        else -- Buscamos el punto de inserción
	  aux:= ptDato(l);
          while (aux.sig/=null) and (c.ventas<aux.dato.ventas) loop
	    aux:=aux.sig;
          end loop;
	  if c.ventas>=aux.dato.ventas then
	    -- Insercion entre 2 registros
	    nuevo:= new unDato;
	    nuevo.all:= aux.all;
	    nuevo.sig:= aux.sig;
	    aux.dato:= c;
	    aux.sig:= nuevo;
	  else -- Insercion al final
	    aux.sig:= new unDato;
	    aux:= aux.sig;
	    aux.dato:= c;
	    aux.sig:= null;
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
         l:=lista(aux.sig);
         disponer(aux);
      else
         ant:= aux;
         aux:= aux.sig;
        while (aux/=null) and not(exito) loop          
	    exito:= (aux.dato.interprete=c.interprete) and
                  (aux.dato.titulo=c.titulo) and
	            (aux.dato.tiempo=c.tiempo);
          if not(exito) then
            ant:= aux;
            aux:=aux.sig;
          end if;
        end loop;
        if exito then
          ant.sig:=aux.sig;
          disponer(aux);
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
      if (ptaux.dato.tiempo>f) then anyadir(lact,ptaux.dato); end if;
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
        anyadir(lhits,aux.dato);
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
  
  
  procedure mostrar(l: in out lista) is
    aux: ptDato;
  begin
    put("Mostrando la lista de canciones"); new_Line;
    aux:= ptDato(l);
    while (aux/=null) loop
      put("Titulo de la cancion: "); put(aux.dato.titulo); new_Line;
      put("Interprete de la cancion: "); put(aux.dato.interprete); new_Line;
      put("Ventas de la cancion: "); put(aux.dato.ventas); new_Line;
      aux:= aux.sig;
    end loop;
  end mostrar;


end listaexitos;

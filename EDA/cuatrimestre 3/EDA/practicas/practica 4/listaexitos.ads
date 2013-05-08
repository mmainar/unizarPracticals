-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: módulo de declaración del TAD listaexitos
--           para la práctica 4 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: listaexitos.ads
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de éxitos formada por canciones con un título, un
--              intérprete, una fecha de grabación y un número de
--              ventas.
with fecha, ustrings, ada.text_IO;
use fecha, ustrings, ada.text_IO;
package listaexitos is

 subtype texto is ada.text_IO.file_type;

 type cancion is record
  titulo, interprete: ustring;
  tiempo: tpfecha;
  ventas: natural;
  nacionalidad: natural;
 end record;

 type lista is limited private;
 -- permite almacenar en memoria dinámica una lista de éxitos


--|
--| Resumen:
--|
--| El módulo 'listaexitos' exporta el tipo abstracto de
--| datos lista.
--|
--| La especificación algebraica del TAD es la siguiente:
--|
--| espec listaexitos
--|   usa booleanos, cadenas, enteros, canción, fecha, nacionalidades
--|   género lista
--|   operaciones
--|            VACÍA:       -> lista                  { operaciones constructoras generadoras:
--|            AÑADIR:      lista canción -> lista          VACÍA, AÑADIR      }
--|            BORRAR:      lista canción -> lista    { operación constructora modificadora }
--|            SUPERACOTA:  lista ent -> booleano     { operación observadora  }
--|            ACTUALIZADA: lista fecha -> lista      { operación constructora modificadora }
--|            ESVACÍA?:    lista -> booleano         { operación observadora }
--|            ESTÁ:        lista canción -> booleano { operación auxiliar observadora para INTERSECCIÓN}
--|            UNIÓN:       lista lista -> lista      { operación constructora modificadora}
--|            INTERSECCIÓN: lista lista -> lista     { operación constructora modificadora}
--|            ESTÁNACIONALIDAD: lista natural -> booleano { operación observadora}
--|
--|   ecuaciones c,c1,c2: canción; l: lista; f:fecha; cot: cota; ln: listaNac; n,n1,n2: natural
--|      (c1=c2) <-> (titulo(c1)=titulo(c2)) ^ (interprete(c1)=interprete(c2))
--|                 ^ (tiempo(c1)=tiempo(c2)) ^ (nacionalidad(c1)=nacionalidad(c2))
--|      c1/=c2 AND ESTÁ(ln,nacionalidad(c1)) AND ESTÁ(ln,nacionalidad(n2)) -> 
--|            AÑADIR(AÑADIR(l,c1),c2) = AÑADIR(AÑADIR(l,c2),c1)
--|      c1=c2  AND ESTA(ln,nacionalidad(c1)) -> AÑADIR(AÑADIR(l,c1),c2) = AÑADIR(l,c2)
--|      ESTÁNACIONALIDAD(VACÍA,n) = falso
--|      ESTÁNACIONALIDAD(AÑADIR(l,c),n)= (nacionalidad(c)=n) OR ESTÁNACIONALIDAD(l,n)
--|      BORRAR(VACÍA,c1) = VACÍA
--|      c1=c2 -> BORRAR(AÑADIR(l,c1),c2) = BORRAR(l,c2)
--|      c1/=c2 -> BORRAR(AÑADIR(l,c1),c2) = AÑADIR(BORRAR(l,c2),c1)
--|      ACTUALIZADA(VACÍA,f) = VACÍA
--|      fecha(c1)>f -> ACTUALIZADA(AÑADIR(l,c1),f) = AÑADIR(actualizada(l,f),c1)
--|      fecha(c1)<=f -> ACTUALIZADA(AÑADIR(l,c1),f) = ACTUALIZADA(l,f)
--|      SUPERACOTA(VACÍA,cot) = FALSO
--|      SUPERACOTA(AÑADIR(l,c1),cot) = (ventas(c1) > cot) OR (superacota(l,cot))
--|      ESVACÍA?(VACÍA) = CIERTO
--|      ESVACÍA?(AÑADIR(l,c1)) = FALSO
--|      ESTÁ(VACÍA,c) = FALSO
--|      ESTÁ(AÑADIR(l,c1),c2) = (c1=c2) OR (ESTÁ(l,c2))
--|      UNIÓN(l,VACÍA) = l
--|      UNIÓN(l1,AÑADIR(l2,c)) = AÑADIR(UNIÓN(l1,l2),c)
--|      INTERSECCIÓN(l,VACÍA) = VACÍA
--|      INTERSECCIÓN(l1,AÑADIR(l2,c)) = si ESTÁ(c,l1)
--|                                        ent AÑADIR(INTERSECCIÓN(l1,l2),c)
--|                                      sino INTERSECCIÓN(l1,l2)
--|
--|
--| fespec
--|
--| El módulo listaexitos exporta el nombre del tipo, las operaciones
--| especificadas anteriormente y:
--|
--|  * una operación de asignación ('asignar'),
--|  * una operación de liberación de memoria dinámica ocupada
--|    por una lista ('liberar').
--|
--|
 procedure vacia(l:out lista);
 -- crea una lista de exitos vacía
 procedure anyadir(l:in out lista; c:in cancion);
 -- modifica l de la siguiente forma: si ya había una canción
 -- en l con el mismo intérprete y título que c actualiza el
 -- número de ventas, en otro caso añade c
 procedure borrar(l:in out lista; c:in cancion);
 -- modifica l eliminando la canción c si esta estaba en l
 function superacota(l:lista; cota:integer) return boolean;
 -- devuelve cierto si existe una canción en l con número de
 -- ventas mayor que cota
 procedure actualizada(l:in lista; lact:out lista; f:in tpfecha);
 -- calcula lact una lista con las canciones de l que tienen
 -- fecha de grabación posterior a f
 function esvacia(l:lista) return boolean;
 -- devuelve cierto si l está vacía
 procedure loscuarenta(l:in lista; lhits: out lista);
 -- Post: si l tiene menos de 40 canciones lhits=l, si no lhits
 -- es una lista con las 40 canciones de l que tienen mayor
 -- número de ventas
 procedure asignar(lin: in lista; lout: out lista);
 -- Post: lout=lin, duplicando la representación en memoria
 procedure liberar(l: in out lista);
 -- Post: l=VACIA y además libera la memoria previamente utilizada por l
 procedure listado(l: in lista; c: in natural);
 -- lista en pantalla las canciones almacenadas en la lista de éxitos l
 procedure union(l1,l2: in lista; lout: out lista);
 -- Post: lout es la unión de las listas l1 y l2
 procedure interseccion(l1,l2: in lista; lout: out lista);
 -- Post: lout es la intersección de las listas l1 y l2
 procedure grabacion(f: in out texto; l: in lista);
 -- Post: almacena en el fichero de texto externo "nacionalidades.txt" 
 -- la lista de éxitos l en su estado actual
 function estaNacionalidad(l: in lista; n: natural) return boolean;
 -- Post: Devuelve cierto si y solo si en l hay alguna canción cuyo
 -- código de nacionalidad sea igual a n y falso en caso contrario.
private
 type unDato;
 type ptDato is access unDato;
 type unDato is record
                dato: cancion;
                sig: ptDato;
              end record;
 type lista is new ptDato;
end listaexitos;
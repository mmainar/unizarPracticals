-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: módulo de declaración del TAD listaexitos
--           para la práctica 2 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: listaexitos.adb
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de éxitos formada por canciones con un título, un
--              intérprete, una fecha de grabación y un número de
--              ventas.
with fecha, Ada.Strings.Unbounded, ustrings; 
use fecha, Ada.Strings.Unbounded, ustrings;
package listaexitos is

  type cancion is record
    titulo, interprete: ustring;
    tiempo: tpfecha;
    ventas: integer;
  end record;
  
  type lista is limited private;
  -- permite almacenar en memoria dinámica una lista de éxitos 


--| 
--| Resumen:
--| 
--| El módulo 'listaexitos" exporta el tipo abstracto de  
--| datos canción. Consideramos predefinida la igualdad entre 2 datos
--| de tipo canción de la siguiente forma:
--|   c1, c2: canción
--|   (c1=c2) <-> (titulo(c1)=titulo(c2)) ^ (interprete(c1)=interprete(c2)) 
--|                ^ (tiempo(c1)=tiempo(c2))
--|
--| La especificacion algebraica del TAD es la siguiente:
--|
--| espec listaexitos
--|   usa booleanos, cadenas, enteros, canción, fecha
--|   género lista
--|   operaciones
--|            VACÍA:       -> lista                  { operaciones constructuras generadoras:
--|            AÑADIR:      lista canción -> lista          VACÍA, AÑADIR      }
--|            BORRAR:      lista canción -> lista    { operación constructora modificadora }
--|            SUPERACOTA:  lista ent -> booleano     { operación observadora  }
--|            ACTUALIZADA: lista fecha -> lista      { operación constructura modificadora }
--|            ESVACÍA?:    lista -> booleano         { operación obseravadora }
--|
--|   ecuaciones c1,c2: canción; l: lista; f:fecha; cot: cota;
--|      c1/=c2 -> AÑADIR(AÑADIR(l,c1),c2) = AÑADIR(AÑADIR(l,c2),c2)
--|       c1=c2 -> AÑADIR(AÑADIR(l,c1),c2) = AÑADIR(c2,l)
--|     BORRAR(VACÍA,c1) = VACÍA
--|       c1=c2 -> BORRAR(AÑADIR(l,c1),c2) = BORRAR(l,c2)
--|      c1/=c2 -> BORRAR(AÑADIR(l,c1),c2) = AÑADIR(BORRAR(l,c1),c2)
--|      ACTUALIZADA(VACÍA,f) = VACÍA
--|      fecha(c1)>f -> ACTUALIZADA(AÑADIR(l,c1),f) = AÑADIR(actualizada(l,f),c1)
--|      fecha(c2)<=f -> ACTUALIZADA(AÑADIR(l,c1),f) = ACTUALIZADA(l,f)
--|      SUPERACOTA(VACÍA,cot) = FALSO
--|      SUPERACOTA(AÑADIR(l,c1),cot) = (ventas(c1) > cot)
--|      ESVACÍA?(VACÍA) = CIERTO
--|      ESVACÍA?(AÑADIR(l,c1)) = FALSO
--| fspec
--|
--| El modulo listaexitos exporta el nombre del tipo, las operaciones 
--| especificadas anteriormente y:
--|
--|  * una operacion de asignación ('asignar'),
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
  procedure mostrar(l: in out lista);
 
private
  type unDato;
  type ptDato is access unDato;
  type unDato is record
                  dato: cancion;
                  sig: ptDato;
                end record;
  type lista is new ptDato;
end listaexitos;

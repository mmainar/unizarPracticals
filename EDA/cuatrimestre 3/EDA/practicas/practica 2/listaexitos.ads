-- AUTORES: Ismael Saad Garc�a. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: m�dulo de declaraci�n del TAD listaexitos
--           para la pr�ctica 2 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: listaexitos.adb
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de �xitos formada por canciones con un t�tulo, un
--              int�rprete, una fecha de grabaci�n y un n�mero de
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
  -- permite almacenar en memoria din�mica una lista de �xitos 


--| 
--| Resumen:
--| 
--| El m�dulo 'listaexitos" exporta el tipo abstracto de  
--| datos canci�n. Consideramos predefinida la igualdad entre 2 datos
--| de tipo canci�n de la siguiente forma:
--|   c1, c2: canci�n
--|   (c1=c2) <-> (titulo(c1)=titulo(c2)) ^ (interprete(c1)=interprete(c2)) 
--|                ^ (tiempo(c1)=tiempo(c2))
--|
--| La especificacion algebraica del TAD es la siguiente:
--|
--| espec listaexitos
--|   usa booleanos, cadenas, enteros, canci�n, fecha
--|   g�nero lista
--|   operaciones
--|            VAC�A:       -> lista                  { operaciones constructuras generadoras:
--|            A�ADIR:      lista canci�n -> lista          VAC�A, A�ADIR      }
--|            BORRAR:      lista canci�n -> lista    { operaci�n constructora modificadora }
--|            SUPERACOTA:  lista ent -> booleano     { operaci�n observadora  }
--|            ACTUALIZADA: lista fecha -> lista      { operaci�n constructura modificadora }
--|            ESVAC�A?:    lista -> booleano         { operaci�n obseravadora }
--|
--|   ecuaciones c1,c2: canci�n; l: lista; f:fecha; cot: cota;
--|      c1/=c2 -> A�ADIR(A�ADIR(l,c1),c2) = A�ADIR(A�ADIR(l,c2),c2)
--|       c1=c2 -> A�ADIR(A�ADIR(l,c1),c2) = A�ADIR(c2,l)
--|     BORRAR(VAC�A,c1) = VAC�A
--|       c1=c2 -> BORRAR(A�ADIR(l,c1),c2) = BORRAR(l,c2)
--|      c1/=c2 -> BORRAR(A�ADIR(l,c1),c2) = A�ADIR(BORRAR(l,c1),c2)
--|      ACTUALIZADA(VAC�A,f) = VAC�A
--|      fecha(c1)>f -> ACTUALIZADA(A�ADIR(l,c1),f) = A�ADIR(actualizada(l,f),c1)
--|      fecha(c2)<=f -> ACTUALIZADA(A�ADIR(l,c1),f) = ACTUALIZADA(l,f)
--|      SUPERACOTA(VAC�A,cot) = FALSO
--|      SUPERACOTA(A�ADIR(l,c1),cot) = (ventas(c1) > cot)
--|      ESVAC�A?(VAC�A) = CIERTO
--|      ESVAC�A?(A�ADIR(l,c1)) = FALSO
--| fspec
--|
--| El modulo listaexitos exporta el nombre del tipo, las operaciones 
--| especificadas anteriormente y:
--|
--|  * una operacion de asignaci�n ('asignar'),
--|  * una operaci�n de liberaci�n de memoria din�mica ocupada
--|    por una lista ('liberar').
--|
--|
  procedure vacia(l:out lista);
  -- crea una lista de exitos vac�a
  procedure anyadir(l:in out lista; c:in cancion);
  -- modifica l de la siguiente forma: si ya hab�a una canci�n
  -- en l con el mismo int�rprete y t�tulo que c actualiza el
  -- n�mero de ventas, en otro caso a�ade c
  procedure borrar(l:in out lista; c:in cancion);
  -- modifica l eliminando la canci�n c si esta estaba en l
  function superacota(l:lista; cota:integer) return boolean;
  -- devuelve cierto si existe una canci�n en l con n�mero de
  -- ventas mayor que cota
  procedure actualizada(l:in lista; lact:out lista; f:in tpfecha);
  -- calcula lact una lista con las canciones de l que tienen
  -- fecha de grabaci�n posterior a f
  function esvacia(l:lista) return boolean;
  -- devuelve cierto si l est� vac�a
  procedure loscuarenta(l:in lista; lhits: out lista);
  -- Post: si l tiene menos de 40 canciones lhits=l, si no lhits
  -- es una lista con las 40 canciones de l que tienen mayor
  -- n�mero de ventas
  procedure asignar(lin: in lista; lout: out lista);
  -- Post: lout=lin, duplicando la representaci�n en memoria
  procedure liberar(l: in out lista);
  -- Post: l=VACIA y adem�s libera la memoria previamente utilizada por l
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

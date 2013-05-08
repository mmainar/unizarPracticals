---------------------------------------------------------------------
-- Fichero:   listas.ads
-- Autor:     J.D.Tardos
-- Version:   v1.1 7-4-2000
-- Proposito: Paquete generico de manejo de listas
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 6-4-2000
--   - Eliminada copy. Agnadida Memory_reset y comentarios de pop
---------------------------------------------------------------------

generic
  type Item is private;
  Max_Items: Natural := 0 ;       
  -- Si se fija Max_Items, se usa memoria estatica (un vector)
  -- Si no, se reserva memoria dinamicamente mediante new
package Listas is
  type Cell is private ;
  type List is access all Cell ;

  End_Of_List: exception; -- Si intentamos pasar del final de una lista
  Space_Full:  exception; -- Si max_items/=0 y lo sobrepasamos
				     
  procedure memory_reset ;
  -- Si max_items/=0, recupera el espacio de memoria utilizado.
  -- Todas las listas creadas quedan destruidas
  
  function endp (L: List) return Boolean ;
  function more (L: List) return Boolean ; -- equivale a: (not endp(L)) 
  function first(L: List) return Item ;
  function rest (L: List) return List ;
  function length(L: list)return Natural ;

  function cons  (I:  Item; L:  List) return List ;
  function append(L1: List; L2: List) return List ;
  -- Pega dos listas. No es destructiva. Copia L1, pero no copia L2 
  function nconc (L1: List; L2: List) return List ;
  -- Pega dos listas. Destruye L1, pero no destruye L2
  -- Es mas eficiente que append, ya que no copia L1

  function "&"(I:  Item; L:  List) return List renames cons ;
  function "&"(I1: Item; I2: Item) return List ;
  function "&"(L1: List; L2: List) return List renames append ;
  function "&"(L:  List; I:  Item) return List ;
  -- Si L vacia, devuelve lista con I. 
  -- Si no, modifica L pegando I al final y devuelve L
  
  procedure push(I: in  Item; L: in out List) ;
  -- Agnade un elemento al principio de la lista
  procedure pop (I: out Item; L: in out List) ;
  -- Obtiene el primer elemento y avanza el puntero
  -- Equivale a:  I:=first(L); L:=rest(L);
  
  generic
    with function equal(I1, I2: Item) return boolean ;
  procedure delete(I: item; L: in out List) ;
  -- Borra de L todos los elementos que son "equal" a I
  -- Es una operacion destructiva

  generic
    with function less(I1, I2: Item) return boolean ;
  function sort(L: List) return List ;
  -- Ordena la lista L utilizando "less" como predicado de ordenacion
  -- Es una operacion destructiva
  
  generic
    with function less(I1, I2: Item) return boolean ;
  function merge(L1, L2: List) return List ;
  -- Mezcla dos listas ya ordenadas, utilizando "less" como predicado de ordenacion
  -- Es una operacion destructiva
  
-------------------------------------------------------------------------------------  
private 

  type Cell is record
    This: Item;
    Next: List;
  end record;

end Listas;

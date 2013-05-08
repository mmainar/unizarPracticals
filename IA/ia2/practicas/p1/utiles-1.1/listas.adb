---------------------------------------------------------------------
-- Fichero:   listas.adb
-- Autor:     J.D.Tardos
-- Version:   v1.1 7-4-2000
-- Proposito: Paquete generico de manejo de listas
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 6-4-2000
--   - Eliminada copy. Agnadida Memory_reset y comentarios de pop
---------------------------------------------------------------------

with Text_IO ; use Text_IO ; 

package body Listas is

  package IIO is new Integer_IO(Integer) ; use IIO ;
  
  memory: array (0..Max_Items) of aliased Cell ;
  n : Natural range 0..Max_Items := 0 ;

  procedure memory_reset is
  begin
    n:= 0 ;
  end ;

  procedure Error(Donde: string) is
  begin
    Put_line("Error en "&donde&": La lista esta vacia");
  end ;
  

  function cons(I: Item; L: List) return List is
  begin
    if Max_Items = 0 then
      return new Cell'(I, L) ;
    else
      n:= n+1 ;
      memory(n):=(I,L) ;
      return  memory(n)'Access ;
    end if ;
  exception
    when others => 
      Put_Line("Error reservando memoria para un elemento de una lista");
      if Max_Items /= 0 then
        Put_Line("Solo hay espacio para: "& Natural'Image(Max_Items)) ;
      end if ;
      raise Space_Full;
  end ;


  function endp (L: List) return Boolean is
  begin
    return L = null ;
  end ;
  
  function more (L: List) return Boolean is
  begin
    return L /= null ;
  end ;
  
  function first(L: List) return Item is
  begin
    return L.This ;
  exception  
    when others => Error("first") ; raise End_Of_List ; 
  end ;
  
  function rest (L: List) return List is
  begin
    return L.next ;
  exception  
    when others => Error("rest") ; raise End_Of_List ;
  end ;

  function length(L: list) return natural is 
    n: natural := 0 ;
    I: list:= L ;
  begin
    while I /= null loop
      n:= n+1 ;
      I:= I.next ;
    end loop ;
    return n ;
  end ;


  function last(L: List) return List is
    R: List ;
  begin
    R:= L ;
    while R.next /= null loop
      R:= R.next ;
    end loop ;
    return R ;
  end ;      

    

  function "&" (I1, I2: Item) return List is
  begin
    return cons(I1, cons(I2, null)) ;
  end ;


  function copy(L: List) return List is
  begin
    if L = null then
      return null ;
    else
      return cons(L.this, copy(L.next)) ;
    end if ;
  end ;


  function append(L1: List; L2: List) return List is
  -- Pega dos listas. No es destructiva. Copia L1, pero no copia L2 
    L: List ;
  begin
    return nconc(copy(L1), L2) ;
  end ;
  

  function nconc (L1: List; L2: List) return List is
  -- Pega dos listas. Destruye L1, pero no destruye L2
  -- Es mas eficiente que append, ya que no copia L1
  begin
    if L1 = null then
      return L2 ;
    else
      last(L1).next:= L2 ;
      return L1 ;
    end if ;
  end ;


  function "&" (L: List; I: Item) return List is
  -- Si L vacia, devuelve lista con I. 
  -- Si no, modifica L pegando I al final y devuelve L
    N: list ;
  begin
    N:= cons(I, null) ;
    if L = null then
      return N ;
    else
      last(L).next:= N ;
      return L ;
    end if ;
  end ;

    
  procedure push(I: in  Item; L: in out List) is
  begin
    L:= cons(I,L) ;
  end ;
  
  procedure pop (I: out Item; L: in out List) is
  begin
    I:= L.this ;
    L:= L.next ;
  exception  
    when others => Error("Pop") ; raise End_Of_List ;
  end ;
  


  --generic
  --  with function equal(I1, I2: Item) return boolean ;
  procedure delete(I: item; L: in out List) is
       Place_In_L       :List;     --| Current place in L.
       Last_Place_In_L  :List;     --| Last place in L.
       Temp_Place_In_L  :List;     --| Holds a place in L to be removed.

   --| Walk over the list removing all elements with the value I.

   begin
       Place_In_L := L;
       Last_Place_In_L := null;
       while (Place_In_L /= null) loop
           --| Found an element equal to I
           if Equal(Place_In_L.this, I) then
                --| If Last_Place_In_L is null then we are at first element in L.
                if Last_Place_In_L = null then
                     Temp_Place_In_L := Place_In_L;
                     L := Place_In_L.Next;
                else
                     Temp_Place_In_L := Place_In_L;
               
                     --| Relink the list Last's Next gets Place's Next

                     Last_Place_In_L.Next := Place_In_L.Next;
                end if;

                --| Move Place_In_L to the next position in the list.
                --| Free the element.
                --| Do not update the last element in the list it remains the
                --| same. 

                Place_In_L := Place_In_L.Next;                       
                --Free (Temp_Place_In_L);
           else
                --| Update the last place in L and the place in L.

                Last_Place_In_L := Place_In_L;
                Place_In_L := Place_In_L.Next;                       
           end if;    
       end loop;
  exception
    when others => 
      Put("Error en Delete:") ; Put(Length(L)); new_line ;
  end delete;



  --generic
  --  with function less(I1, I2: Item) return boolean ;
  function sort(L: List) return List is
  -- Ordena la lista L utilizando "less" como predicado de ordenacion
  -- Es una operacion destructiva
  
      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
      --++ The following code is extracted as-is from the Ada Software ++--
      --++ Repository on SIMTEL20.  Modifications are identified by    ++--
      --++ comments beginning with "--++"                              ++--
      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
      -- Unit name    : generic procedure SORT
      -- Version      : 1.0
      -- Author       : John A. Anderson
      generic
         type ITEM is private;
         type INDEX is (<>);
         type ROW is array (INDEX range <>) of ITEM;
         with function "<" (X, Y : ITEM) return BOOLEAN is <>;
      procedure GENERIC_QSORT (A : in out ROW);
      --++ with TEXT_IO;
      procedure GENERIC_QSORT (A : in out ROW) is
         
         procedure QSORT (L, R : INDEX) is
            I, J : INDEX;
            X    : ITEM;
            
            procedure EXCHANGE (A, B : in out ITEM) is
               TEMP : ITEM;
            begin
               TEMP := A;
               A    := B;
               B    := TEMP;
            end EXCHANGE;
            
         begin
            I := L;
            J := R;
            X := A (INDEX'VAL ((INDEX'POS (L) + INDEX'POS (R)) / 2));
         MAIN:
            loop
               while A (I) < X loop
                  I := INDEX'SUCC (I);
               end loop;               
               while X < A (J) loop
                  J := INDEX'PRED (J);
               end loop;               
               if I <= J then
                  EXCHANGE (A (I), A (J));
                  begin
                     I := INDEX'SUCC (I);
                     J := INDEX'PRED (J);
                  exception
                     when CONSTRAINT_ERROR    =>
                        null; -- necessary to avoid exception raising
                  end;
               end if;
               exit  when I > J;
            end loop MAIN;            
            if L < J then
               QSORT (L, J);
            end if;            
            if I < R then
               QSORT (I, R);
            end if;            
         end QSORT;
         
      begin
         QSORT (A'FIRST, A'LAST);
         --++ exception
         --++     when others =>
         --++         TEXT_IO.PUT_LINE ("Exception raised in Generic Sort");
         --++         raise;
      end GENERIC_QSORT;
      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
      --++ End of code extracted from the Ada Software Repository on   ++--
      --++ SIMTEL20.                                                   ++--
      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
      
   type ItemArray is array (integer range <>) of Item ;   
   procedure QSORT is new 
        GENERIC_QSORT (Item, INTEGER, ItemArray, less);

   N: integer := Length(L) ;
      
   begin --Sort(L)
      if L = null then
         return L;
      else
         declare
            V : ItemArray(1..N);
            iter: List ;
         begin
            iter:= L ;
            for i in 1..N loop
              V(i):= Iter.this ;
	      iter:= iter.next ;
            end loop;
            QSORT (V);
	    iter:= L ;
            for i in 1..N loop
	      iter.this:= V(i) ;
              iter:= iter.next ;
	    end loop ;
	  end ;
      end if ;
      Return L ;
   end Sort;
   

  --generic
  --  with function less(I1, I2: Item) return boolean ;
  function merge(L1, L2: List) return List is
  -- Mezcla dos listas ya ordenadas, utilizando "less" como predicado de ordenacion
  -- Es una operacion destructiva
  
    P1, P2, Last_merged, Result: List ;
  begin
    if L1 = null then   -- Descarta los casos triviales
      return L2 ;
    end if ;
    if L2 = null then
      return L1 ;
    end if ;
    P1:= L1 ;         -- Las dos listas contienen algo 
    P2:= L2 ;
    if less(P2.this, P1.this) then -- Mezclo el primero
      Result:= P2 ;
      Last_merged:= P2 ;
      P2:= P2.next ;
    else
      Result:= P1 ;
      Last_merged:= P1 ;
      P1:= P1.next ;
    end if ;
    while (P1 /= null) and (P2 /= null) loop  -- Mezclo el resto
      if less(P2.this, P1.this) then
        Last_Merged.next:= P2 ;
	P2:= P2.next ;
      else  
        Last_Merged.next:= P1 ;
	P1:= P1.next ;
      end if ;
      Last_Merged:= Last_Merged.next ;
    end loop ;
    if P1 = null then
      Last_Merged.next:= P2 ;
    else
      Last_Merged.next:= P1 ;
    end if ;
    return Result ;
  end ;

end Listas;

--------------------------------------------------------------------------


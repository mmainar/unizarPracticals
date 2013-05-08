---------------------------------------------------------------------
-- Fichero:   prueba_listas.adb
-- Autor:     J.D.Tardos
-- Version:   v1.0 23-3-2000
-- Proposito: Programa para probar el paquete Listas
---------------------------------------------------------------------

with Listas ;
with Text_IO ; use Text_IO ;

Procedure Prueba_Listas is

  package IIO is new Integer_IO(integer); use IIO ;
  package LI is new Listas(integer, "enteros", 100) ; use LI ;
  L1, L2, L3, L4: List ;
  procedure quitar is new LI.delete("=") ;
  function ordenar_asc is new LI.sort("<") ;
  function ordenar_des is new LI.sort(">") ;
  
  function MergeKKi is new LI.MergeKK("<") ;
  function Mergei is new LI.Merge("<") ;
  

  procedure put(L: list) is
    i: integer ;
    N: List:= L ;
  begin
    while More(N) loop
      pop(i,N) ;
      put(i,3) ; 
    end loop ;
    new_line(2);
  end ;

begin
  L1:= 1 & 2 & 3 & 4 & 5 ;
  L2:=21 &22 &23 &24 ;
  Put_Line("L1") ; put(L1); 
  Put_Line("L2") ; put(L2); 
  L3:= L1 & L1 & L1 & L2;
  Put_Line("L3 := L1&L1&L1&L2") ; put(L3); 
  Put_Line("L1") ; put(L1); 
  Put_Line("L2") ; put(L2); 
  L4:= L3 & rest(L3) ;
  Put_Line("L4 := L3 & rest(L3)") ; put(L4); 
  
  Put_Line("Pruebo a ordenar la lista:") ; put(L3); 
  Put_Line("En orden descendente:") ; put(ordenar_des(L3)) ; 
  Put_Line("En orden ascendente:") ;  put(ordenar_asc(L3)) ; 
  
  Put_Line("Pruebo a quitar los 2 de:"); put(L3) ; 
  quitar(2, L3) ;
  Put_Line("Queda:") ; put(L3) ; 
  
  Put_Line("Pruebo a quitar los 1 de:") ; put(L4) ; 
  quitar(1, L4) ;
  Put_Line("Queda:") ; put(L4) ; 
  Put(L1) ; put(L3) ;
  Put(MergeKKi(copy(L1), copy(L3))) ;
  Put(Mergei(copy(L1), copy(L3))) ;
end ;

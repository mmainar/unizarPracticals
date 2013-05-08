---------------------------------------------------------------------
-- Fichero:   vectores.ads
-- Autor:     J.D.Tardos
-- Version:   v1.0 27-3-2000
-- Proposito: Paquete generico de vectores parcialmente ocupados
---------------------------------------------------------------------

with Text_IO ; use Text_IO ;

generic
  type Elemento is private;
package Vectores is

  type Vector is array (Positive range <>) of Elemento ;

  type Vector_Limitado(max: Positive) is record
    n: Natural := 0;        -- Numero de elementos ocupados
    elem: Vector(1..max);  -- Los elementos
  end record;

  Vector_Lleno: exception; -- Si intentamos n > max
				     
  procedure Anadir(F: in out Vector_Limitado; E: Elemento);
  -- Agnade un elemento al final del vector
  -- Si F.n = F.max, se produce la excepcion vector_lleno
  
  generic
    with function leer(fich: File_Type) return Elemento ;
  procedure leer(F: in out Vector_Limitado; fich: string) ;
   
end Vectores;

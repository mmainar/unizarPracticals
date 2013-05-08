---------------------------------------------------------------------
-- Fichero:   vectores.adb
-- Autor:     J.D.Tardos
-- Version:   v1.0 27-3-2000
-- Proposito: Paquete generico de vectores parcialmente ocupados
---------------------------------------------------------------------

--generic
--  type Elemento is private;
package body Vectores is
				     
  procedure Anadir(F: in out Vector_Limitado; E: Elemento) is
  begin
    F.n:= F.n+1 ;
    F.elem(F.n):= E ;
  exception  
    when others => 
      Put_Line("Error al anadir un elemento a un vector: solo caben "
                &Integer'Image(F.max)) ;
      raise Vector_Lleno ;
  end ;
  


  procedure Abrir_fichero(f: in out File_Type; nombre: string) is
  begin
    Open(f, In_File, nombre) ;
    Put_Line("Leyendo fichero: "&nombre) ; 
  exception
    when Others =>
      Put("Error: No encuentro el fichero "); Put_line(nombre) ;
      raise ;
  end ;


  
  --generic
  --  with function leer(fich: File_Type) return Elemento ;
  procedure leer(F: in out Vector_Limitado; fich: string) is
    fichero: File_Type ;
  begin
    F.n:= 0 ;
    Abrir_Fichero(fichero, fich) ;
    while not End_Of_File(fichero) loop
      Anadir(F, Leer(fichero));    
    end loop ;
    Close(fichero) ;
    Put_Line("Leido fichero con "&integer'Image(F.n)&" elementos" ) ;
  exception 
    when others =>
      Put_Line("Error leyendo fichero");
      Put_Line("Solo se han leido: " & integer'Image(F.n)&" elementos");
  end ;
  
end Vectores;

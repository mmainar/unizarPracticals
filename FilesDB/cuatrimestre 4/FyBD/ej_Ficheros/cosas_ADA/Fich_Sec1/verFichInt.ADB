with Text_IO, Tpfsec; use Text_IO;

with text_io, 
     Ada.Strings.Bounded, bstrings;
use  text_io, 
     Ada.Strings.Bounded;

procedure VerFichInt is
-- Declaracion de bibliotecas.
   package pCad255 is new Ada.Strings.Bounded.Generic_Bounded_Length (255);
   use pCad255;
   package pCad255_ES is new bstrings (pCad255);
   use pCad255_ES;

   package Fich_Ent   is new Tpfsec(Integer);      use Fich_Ent;
   package Integer_ES is new Integer_IO(Integer);  use Integer_ES;
 
   Undato, I : Integer;
   nombreFich : pCad255.Bounded_String;

   FDat : Fich_Ent.Fsec;

begin
   put ("nombre del fichero de enteros a visualizar ?  ");   get_line (nombreFich);
   Asociar(FDat, To_String (nombreFich), Lect);

   Put ("Lista de enteros del fichero: '" & nombreFich & "'"); New_Line;
   I:=0;
   Iniciarlectura(FDat);
   while not FinFichero(FDat) loop
      Leerdato(FDat, Undato);
      Put (Undato); New_Line;
      I:=I+1;
   end loop;
   Put ("total de enteros guardados: "); Put (I); New_Line;
   Disociar(Fdat);
   
   Put ("Pulsar <CR> para terminar "); Skip_Line;

end VerFichInt;
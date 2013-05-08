with ada.text_IO, ada.Integer_Text_IO, ada.sequential_IO, TpFsec;

use ada.text_IO, ada.Integer_Text_IO;


procedure prueba is

  
  package Fich_Ent is new Tpfsec(Integer,"<="); -- Relación de orden <=
  use Fich_Ent;
  Undato, I : Integer;
  Fich1 : Fich_Ent.Fsec;
  

begin
  Asociar(Fich1,"fent.dat",Escr);
  Iniciarescritura(Fich1);

  Put ("introduzca una secuencia de enteros terminada en 0: "); New_Line;
  I:=0;
  loop
     Get(Undato);
     exit when Undato=0;
     Escribirdato(Fich1, Undato);
     I:=I+1;
  end loop;
  New_Line(2);
 
  mezclaDirecta(Fich1);

end prueba;
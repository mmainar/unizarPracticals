with ada.text_IO, ada.Integer_Text_IO, ada.sequential_IO, TpFsec;

use ada.text_IO, ada.Integer_Text_IO;


procedure prueba is

  
  package Fich_Ent is new Tpfsec(Integer,"<="); -- Relación de orden <=
  use Fich_Ent;
  Undato, I : Integer;
  Fich1 : Fich_Ent.Fsec;
  

begin
  Asociar(Fich1,"fent.dat",Escr);
  IniciarEscritura(Fich1);

  Put ("introduzca una secuencia de enteros terminada en 0: "); New_Line;
  I:=0;
  loop
     Get(Undato);
     exit when Undato=0;
     EscribirDato(Fich1, Undato);
     I:=I+1;
  end loop;
  New_Line(2);
  Put ("total de enteros introducidos: "); Put (I,0); New_Line;
  
  IniciarLectura(Fich1); mezclaDirecta(Fich1); 
  
  Put ("Secuencia de enteros introducida: "); New_Line;
  I:=0;
  Iniciarlectura(Fich1);
  while not FinFichero(Fich1) loop
     LeerDato(Fich1, Undato);
     Put(Undato,4); 
     I:=I+1;
  end loop;
  new_Line;
  Put ("total de enteros guardados: "); Put (I,0); New_Line;
  Disociar(Fich1);

end prueba;
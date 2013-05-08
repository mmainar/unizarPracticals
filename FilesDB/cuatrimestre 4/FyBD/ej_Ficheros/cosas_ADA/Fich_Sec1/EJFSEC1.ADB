with Text_Io, Tpfsec; use Text_Io;

procedure Ejfsec1 is
   package Mi_Integer_Io is new Integer_Io(Integer); use Mi_Integer_Io;
   package Mi_Float_Io   is new Float_Io(Float);     use Mi_Float_Io;
   package Fich_Ent      is new Tpfsec(Integer);     use Fich_Ent;
   package Fich_Real     is new Tpfsec(Float);       use Fich_Real;
   Undato, I : Integer;
   X : Float;
   Fich1 : Fich_Ent.Fsec;
   Fich2 : Fich_Real.Fsec;

begin
   Asociar(Fich1,"fent.dat",Escr);
   Iniciarescritura(Fich1);

   Asociar(Fich2,"freal.dat",Escr);
   Iniciarescritura(Fich2);

   Put ("introduzca una secuencia de enteros terminada en 0: "); New_Line;
   I:=0;
   loop
      Get(Undato);
      exit when Undato=0;
      Escribirdato(Fich1, Undato);
      Escribirdato(Fich2, Float(Undato));
      I:=I+1;
   end loop;
   New_Line(2);
   Put ("total de enteros introducidos: "); Put (I); New_Line;

   Put ("Secuencia de enteros introducida: "); New_Line;
   I:=0;
   Iniciarlectura(Fich1);
   while not Fin(Fich1) loop
      Leerdato(Fich1, Undato);
      Put (Undato); New_Line;
      I:=I+1;
   end loop;
   Put ("total de enteros guardados: "); Put (I); New_Line;

   Put ("Secuencia de enteros introducida: "); New_Line;
   I:=0;
   Iniciarlectura(Fich2);
   while not Fin(Fich2) loop
      Leerdato(Fich2, X);
      Put (X); New_Line;
      I:=I+1;
   end loop;
   Disociar(Fich1);
   Disociar(Fich2);

end Ejfsec1;
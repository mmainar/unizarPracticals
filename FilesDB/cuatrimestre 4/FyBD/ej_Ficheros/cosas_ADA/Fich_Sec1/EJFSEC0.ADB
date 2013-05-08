with Text_Io, Tpfsec; use Text_Io;

procedure Ejfsec0 is
   package Mi_Integer_Io is new Integer_Io(Integer); use Mi_Integer_Io;
   package Mi_Float_Io is new Float_Io(Float); use Mi_Float_Io;
   package Fich_Ent is new Tpfsec(Integer); use Fich_Ent;
   package Fich_Real is new Tpfsec(Float); use Fich_Real;
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
   Put ("total de enteros introducidos: "); Put (I); New_Line;
   Disociar(Fich1);

   Put ("Secuencia de enteros introducida: "); New_Line;
   I:=0;
   Asociar(Fich1,"fent.dat",Lect);
   Iniciarlectura(Fich1);
   while not FinFichero(Fich1) loop
      Leerdato(Fich1, Undato);
      Put (Undato); New_Line;
      I:=I+1;
   end loop;
   Put ("total de enteros guardados: "); Put (I); New_Line;
   Disociar(Fich1);

end Ejfsec0;
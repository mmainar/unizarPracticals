with Ada.Sequential_Io;

package body Tpfsec is

   procedure Asociar         (F:in out Fsec; Nomfich:in String; Modaccf:in Tpaccf) is
   begin
      if (Modaccf=Lect) then
         Open(F.Fich, In_File, Nomfich);
      else
         Create(F.Fich, Out_File, Nomfich);
      end if;
   end Asociar;

   procedure Disociar        (F:in out Fsec) is
   begin
      Close(F.Fich);
   end Disociar;

   procedure IniciarLectura  (F:in out Fsec) is
   begin
      Reset(F.Fich,In_File);
      if not End_Of_File(F.Fich) then
         Read(F.Fich,F.Ventana);
         F.Finf:=False;
      else
         F.Finf:=True;
      end if;
   end IniciarLectura;

   procedure IniciarEscritura(F:in out Fsec) is
   begin
      Reset(F.Fich,Out_File);
      F.Finf:=True;
   end IniciarEscritura;

   procedure LeerDato        (F:in out Fsec; D: out tpDato) is
   begin
      D:=F.Ventana;
      Tomar(F);
   end LeerDato;

   procedure EscribirDato    (F:in out Fsec; D: in tpDato) is
   begin
      AsignarVentana(F,D);
      Poner(F);
   end EscribirDato;

   function  FinFichero      (F:       Fsec) return Boolean is
   begin
      return(F.Finf);
   end FinFichero;

   function  DatoVentana     (F:       Fsec) return tpDato is
   begin
      return(F.Ventana);
   end DatoVentana;

   procedure AsignarVentana  (F:in out Fsec; D: in tpDato) is
   begin
      F.Ventana:=D;
   end AsignarVentana;

   procedure Tomar           (F:in out Fsec) is
   begin
      if End_Of_File(F.Fich) then
         F.Finf:=True;
      else
         Read(F.Fich, F.Ventana);
      end if;
   end Tomar;

   procedure Poner           (F:in out Fsec) is
   begin
      Write(F.Fich, F.Ventana);
   end Poner;
   

   function SiguienteDato    (F:       FSec) return tpDato is
   begin
     return DatoVentana(F);
   end SiguienteDato;
   

   procedure Avanzar         (F:in out FSec) is
   begin
     Tomar(F);
   end Avanzar;
   

  procedure mezclaFSec(f,f1,f2: in out FSec) is 
  -- 
  -- Post: Crea el fichero ordenado f a partir de la mezcla de todos los
  --       datos de los ficheros secuenciales ordenados f1 y f2.
    d: tpDato;
  begin
    while not finFichero(f1) and not finFichero(f2) loop
      if enOrden(SiguienteDato(f1),SiguienteDato(f2))
        then LeerDato(f1,d); -- Copiar dato de f1
        else LeerDato(f2,d); -- Copiar dato de f2
      end if;
      EscribirDato(f,d);
    end loop;
    while not FinFichero(f1) loop -- copiar resto f1
      LeerDato(f1,d); EscribirDato(f,d);
    end loop;
    while not FinFichero(f2) loop -- copiar resto f2
      LeerDato(f2,d); EscribirDato(f,d);
    end loop;
  end mezclaFSec;
  
  
  procedure numDatos(f: in out FSec; num: out natural) is 
    cuenta: natural;
    d: tpDato;
  begin
    cuenta:=0; IniciarLectura(f);
    while not FinFichero(f) loop
      LeerDato(f,d); cuenta:= cuenta+1;
    end loop;
    num:= cuenta;
  end numDatos;
  
 
  procedure numOrdenados(f: in out FSec; num: out natural) is 
    cuenta: natural;
    d1, d2: tpDato;
  begin
    cuenta:=0; IniciarLectura(f);
    if not Finfichero(f) then LeerDato(f,d1); end if;
    while not FinFichero(f) loop
      LeerDato(f,d2); 
      if enOrden(d1,d2) then cuenta:= cuenta+1; end if;
      if not Finfichero(f) then LeerDato(f,d1); end if;
      if enOrden(d2,d1) then cuenta:= cuenta+1; end if;
    end loop;
    num:= cuenta+1;
  end numOrdenados;
  

  procedure mezclaDirecta(f: in out FSec) is
    f1, f2: FSec;
    d: tpDato;
    dat,n: natural;
  begin
    numDatos(f,dat); asociar(f1,"a.tmp",escr); asociar(f2,"b.tmp",escr); 
    n:= dat;
    while not finFichero(f1) and not finFichero(f2) loop
      if enOrden(SiguienteDato(f1),SiguienteDato(f2))
        then EscribirDato(f,d); -- Copiar dato de f1
        else EscribirDato(f2,d); -- Copiar dato de f2
      end if;
      EscribirDato(f,d);
    end loop;
    while not FinFichero(f1) loop -- copiar resto f1
      LeerDato(f1,d); EscribirDato(f,d);
    end loop;
    while not FinFichero(f2) loop -- copiar resto f2
      LeerDato(f2,d); EscribirDato(f,d);
    end loop;

    loop
      -- Preparamos los ficheros
      IniciarLectura(f); IniciarEscritura(f1); IniciarEscritura(f2);
      -- División del fichero en otros 2
      while not finFichero(f) loop
        LeerDato(f,d); EscribirDato(f1,d);
        if not finFichero(f) then LeerDato(f,d); EscribirDato(f2,d); end if;
      end loop;
      -- Mezcla de las secuencias de los ficheros sobre el original
      IniciarEscritura(f);  IniciarLectura(f1); IniciarLectura(f2);
      mezclaFSec(f,f1,f2); n:= n/2;
      exit when (n=1);
    end loop;
  end mezclaDirecta;


 	
end Tpfsec;
          

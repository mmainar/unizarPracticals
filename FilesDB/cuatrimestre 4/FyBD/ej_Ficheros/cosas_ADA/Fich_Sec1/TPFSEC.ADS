with Ada.Sequential_Io;

generic

  type tpDato is private;
  with function enOrden(d1,d2: tpDato) return boolean;

package Tpfsec is
   type Fsec is limited private;
   type Tpaccf is (Lect,Escr);
   procedure Asociar         (F:in out Fsec; Nomfich:in String; Modaccf:in Tpaccf);
   procedure Disociar        (F:in out Fsec);
   procedure IniciarLectura  (F:in out Fsec);
   procedure IniciarEscritura(F:in out Fsec);
   procedure LeerDato        (F:in out Fsec; D: out tpDato);
   procedure EscribirDato    (F:in out Fsec; D: in tpDato);
   function  FinFichero      (F:       Fsec) return Boolean;
   function  DatoVentana     (F:        Fsec) return tpDato;
   procedure AsignarVentana  (F:in out Fsec; D: in tpDato);
   procedure Tomar           (F:in out Fsec);
   procedure Poner           (F:in out Fsec);
   function  SiguienteDato   (F:       FSec) return tpDato;
   procedure Avanzar         (F:in out FSec);
   procedure mezclaFSec      (F,F1,F2:in out FSec);
   procedure mezclaDirecta   (F:in out FSec);

private
   package Unfich is new Ada.Sequential_Io (tpDato); use Unfich;
   type Fsec is 
   record
      Fich:Unfich.File_Type;
      Ventana:tpDato;
      Finf:Boolean;
   end record;
end Tpfsec;

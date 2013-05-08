---------------------------------------------------------------------
-- Fichero:   geometria.ads
-- Autor:     J.D.Tardos
-- Version:   v1.2 26-6-2000
-- Proposito: Paquete de manejo de puntos, rectas y objetos
---------------------------------------------------------------------
-- Modificaciones:
-- v1.0, J.D.Tardos, 27-3-2000
--   - Version original
-- v1.1, J.D.Tardos, 11-4-2000
--   - Agnadido el producto vectorial
-- v1.2, J.D.Tardos, 26-6-2000
--   - Agnadido opcion de signo en la distancia punto-recta
---------------------------------------------------------------------

with Vectores ;
with Text_IO ; use Text_IO ;
package geometria is
---------------------------------------------------------------
-- Vector, punto y recta del plano, y sus operaciones
---------------------------------------------------------------
  type Vector is record
    x, y: float ;
  end record ;

  subtype Punto is Vector ;

  type Recta is record
    p1, p2: Punto ;  -- Puntos inicial y final
    u: Vector ;      -- Vector unitario de p1 a p2
    lon, ori: float ; -- Longitud y orientacion
    a,b,c: float ;    -- Parametros de su ecuacion
  end record ;

  function Pun(x, y: float) return Punto ;
  function Rec(p1, p2: Punto) return Recta ;
  function Rec(x1, y1, x2, y2: float) return Recta ;

  function "+"(v1, v2: Vector) return Vector ;
  function "-"(v1, v2: Vector) return Vector ;
  function "-"(v1    : Vector) return Vector ;
  function "*"(v1, v2: Vector) return float ;
  function "*"(f: float; v: Vector) return Vector ;
  function "*"(v: Vector; f: float) return Vector ;
  function "/"(v: Vector; f: float) return Vector ;

  function distancia(p1, p2: Punto) return float ;
  function distancia(p: Punto; r: Recta; signo: boolean := false) return float ;
  -- Si signo = true, el resultado es >0 si el punto esta a la izquierda de la recta
  -- (es decir, en el lado de fuera) y <0 si esta a la derecha (dentro)

  function Leer_Punto(F: File_Type) return Punto ;
  function Leer_Recta(F: File_Type) return Recta ;

  procedure put(P: punto) ;
  procedure put(R: Recta) ;

---------------------------------------------------------------
-- Vector y Vector_Limitado de Puntos y de Rectas
---------------------------------------------------------------

  package Vectores_rectas is new Vectores(Recta) ; 
  package Vectores_Puntos is new Vectores(Punto) ; 

  subtype Vpuntos is Vectores_Puntos.Vector ;  
  subtype Puntos  is Vectores_Puntos.Vector_Limitado ;
  subtype Vrectas is Vectores_Rectas.Vector ;  
  subtype Rectas  is Vectores_Rectas.Vector_Limitado ;
  
  procedure Anadir(P: in out Puntos; nuevo: in Punto) renames Vectores_Puntos.anadir ;
  procedure Anadir(R: in out Rectas; nuevo: in Recta) renames Vectores_Rectas.anadir ;

  procedure Leer is new Vectores_Puntos.Leer(Leer_Punto) ;
  --procedure Leer(P: in out Puntos; fichero: string);
  
  procedure Leer is new Vectores_Rectas.Leer(Leer_Recta) ;
  --procedure Leer(R: in out Rectas; fichero: string);

---------------------------------------------------------------
-- Objeto y sus operaciones
---------------------------------------------------------------

  type Objeto(max: integer) is record
    n: integer := 0 ;
    puntos: Vpuntos(1..max) ;
    rectas: Vrectas(1..max) ;
  end record ;
  
  function  Crear_Objeto(P: Puntos) return Objeto ; 

  subtype Objeto4 is Objeto(max=>4) ;
  function Leer_Objeto4(F: File_Type) return Objeto4 ;

---------------------------------------------------------------
-- Fila de Objetos de un maximo de 4 vertices cada uno
---------------------------------------------------------------

  package Vectores_Obj4 is new Vectores(Objeto4) ; 
  subtype Objetos4 is Vectores_Obj4.Vector_Limitado ;
  procedure Anadir(Obj: in out Objetos4; nuevo: in Objeto4) renames Vectores_Obj4.anadir ;

  --procedure Anadir(Objs: in out Objetos4; Obj: in Objeto4);
  procedure Leer is new Vectores_Obj4.Leer(Leer_Objeto4) ;

end Geometria;

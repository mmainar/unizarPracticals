---------------------------------------------------------------------
-- Fichero:   geometria.adb
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

with Ada.Numerics.Elementary_Functions, Text_IO ;
use  Ada.Numerics.Elementary_Functions, Text_IO ;

package body Geometria is

 package FIO is new Float_IO(float) ; use FIO ;
 package IIO is new Integer_IO(integer) ; use IIO ;

---------------------------------------------------------------
-- Vector, punto y recta del plano, y sus operaciones
---------------------------------------------------------------
    
  function Pun(x, y: float) return Punto is
  begin
    return (x,y) ;
  end Pun ;

  function Rec(p1, p2: Punto) return Recta is
    dx, dy, lon: float ;
    u: vector ;
  begin
    dx := p2.x - p1.x ;
    dy := p2.y - p1.y ;
    lon:= sqrt(dx*dx+dy*dy);
    u.x := dx/lon ;
    u.y := dy/lon ;
    return (p1=>p1, p2=>p2, u=>u, lon=>lon, ori => arctan(u.y,u.x),
           a=> -u.y, b=>u.x, c=> u.y*p1.x-u.x*p1.y) ;
  exception
    when others =>
      Put_Line("Cuidado: recta singular") ;
      return (p1=>p1, p2=>p2, u=>(0.0, 0.0), lon=>0.0, ori => 0.0,
             a=> 0.0, b=>0.0, c=> 0.0) ;
  end Rec ;
    
  function Rec(x1, y1, x2, y2: float) return Recta is
  begin
    return Rec(Pun(x1,y1), Pun(x2,y2)) ;
  end Rec ;

  
  function "+"(v1, v2: Vector) return Vector is
  begin
    return(v1.x+v2.x, v1.y+v2.y) ;
  end;

  function "-"(v1, v2: Vector) return Vector is
  begin
    return(v1.x-v2.x, v1.y-v2.y) ;
  end;

  function "-"(v1: Vector) return Vector is
  begin
    return(-v1.x, -v1.y) ;
  end;

  function "*"(v1, v2: Vector) return float is
  begin
    return(v1.x * v2.x + v1.y * v2.y) ;
  end;

  function "*"(f: float; v: Vector) return Vector is
  begin
    return(f*v.x, f*v.y) ;
  end ;

  function "*"(v: Vector; f: float) return Vector is
  begin
    return(f*v.x, f*v.y) ;
  end;
  
  function "/"(v: Vector; f: float) return Vector is
  begin
    return(v.x/f, v.y/f) ;
  end;

  function distancia(p1, p2: Punto) return float is
    dx, dy: float ;
  begin
    dx := p2.x - p1.x ;
    dy := p2.y - p1.y ;
    return sqrt(dx*dx + dy*dy) ;
  end ;
  
  function distancia(p: Punto; r: Recta; signo: boolean := false) return float is
  -- Si signo = true, el resultado es >0 si el punto esta a la izquierda de la recta
  -- (es decir, en el lado de fuera) y <0 si esta a la derecha (dentro)
  begin
    if signo then
      return r.a*p.x + r.b*p.y + r.c ;
    else
      return abs( r.a*p.x + r.b*p.y + r.c ) ;
    end if ;
  end ;
  

  function Leer_Punto(F: File_Type) return Punto is
    P: Punto ;
  begin
    get(f, P.x) ;
    get(f, P.y) ;
    Skip_Line(f) ;
    Return P/1000.0 ; -- Lo pasa a metros
  end ;


  function Leer_Recta(F: File_Type) return Recta is
    P1, P2: Punto ;
  begin
    get(f, P1.x) ;
    get(f, P1.y) ;
    get(f, P2.x) ;
    get(f, P2.y) ;
    Skip_Line(f) ;
    Return Rec(P1/1000.0, P2/1000.0) ; -- Lo pasa a metros
  end ;
  
  procedure put(P: Punto) is
  begin
    Put("Punto: ") ;
    Put(P.x,4,3,0); Put(","); Put(P.y,4,3,0); 
    new_line ;
  end ; 

  procedure put(R: Recta) is
  begin
    Put("Recta: ") ;
    Put(R.P1.x,4,3,0); Put(","); Put(R.P1.y,4,3,0); Put("--->") ;
    Put(R.P2.x,4,3,0); Put(","); Put(R.P2.y,4,3,0);
    new_line ;
  end ; 


---------------------------------------------------------------
-- Objeto y sus operaciones
---------------------------------------------------------------
  
  function Crear_Objeto(P: Puntos) return Objeto is
    Obj: Objeto(max=>P.max) ;
  begin
    Obj.n:=P.n ;
    Obj.puntos(1..P.n):= P.elem(1..P.n) ;
    for i in 1..P.n loop
      Obj.rectas(i):= Rec(P.elem(i),P.elem((i mod P.n)+1)) ;
    end loop ;
    return Obj ;
  end ;
  

  function Leer_Objeto4(F: File_Type) return Objeto4 is
    P: Puntos(max=>4) ;
  begin
    get(f, P.n) ; Skip_line(f) ;
    for i in 1..P.n loop
      get(f, P.elem(i).x) ;
      get(f, P.elem(i).y) ;
      Skip_Line(f) ;
    end loop ;
    Return Crear_Objeto(P) ;
  end ;

end Geometria;

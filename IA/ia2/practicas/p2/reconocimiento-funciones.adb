--------------------------------------------------------------------------------
-- Fichero:   reconocimiento-funciones.adb
-- Autor:     J.D.Tardos
-- Version:   v1.1 10-5-2000
-- Proposito: Funciones para el calculo de restricciones para el reconocimiento
--------------------------------------------------------------------------------
-- Modificaciones:
-- v1.0, J.D.Tardos, 9-5-2000
--   - Version original. Localizacion con la media
-- v1.1, J.D.Tardos, 10-5-2000
--   - Localizacion con dos Filtros de Kalman
--   - Añadida verificacion de la consistencia al localizar
---------------------------------------------------------------------

with Ada.Numerics, Ada.Numerics.Elementary_Functions, Text_IO;
use  Ada.Numerics, Ada.Numerics.Elementary_Functions, Text_IO;
with Ada.Strings.Fixed, Ada.Command_Line;
use  Ada.Strings.Fixed, Ada.Command_Line;

with Graficas, Textos ;
use  Graficas, Textos ;

package body reconocimiento.funciones is

  package IIO is new Integer_IO(integer); use IIO ;
  package FIO is new Float_IO(float); use FIO ;

-----------------------------------------------------------------------------
-- Funciones para la rectriccion de angulo
-----------------------------------------------------------------------------

  function normalizado(tita: float) return float is
  -- Devuelve el angulo normalizado entre -Pi y Pi
    Resul: float:= tita ;
  begin
    while Resul > Pi loop
      Resul:= Resul - 2.0 * Pi;
    end loop;
    while Resul <= -Pi loop
      Resul:= Resul + 2.0 * Pi;
    end loop;
    return Resul;
  end;

  function diferencia(tita1, tita2: float) return float is
  -- Calcula el valor absoluto de la diferencia entre dos angulos, de 0 a Pi
  begin
    return abs normalizado(tita1-tita2) ;
  end;

  function angulo(R1, R2: Recta; orientadas: boolean := true) return float is
  -- Calcula el angulo entre dos rectas. 
  -- Si estan orientadas, el angulo va de -Pi a Pi.
  -- Si NO estan orientadas, va de 0 a Pi/2
  begin
    if orientadas then
      return normalizado(R2.ori - R1.ori);
    else
      return arccos(abs cos(R2.ori - R1.ori)); 
    end if;
  end;

-----------------------------------------------------------------------------
-- Funciones para la rectriccion de distancias
-----------------------------------------------------------------------------

  function min(a, b: float) return float is
  begin
    if a <= b then  return a;
    else return b;
    end if;
  end;
  
  function min(a, b, c, d: float) return float is
  begin
    return min(min(a,b), min(c,d)) ;
  end;

  function max(a, b: float) return float is
  begin
    if a >= b then return a;
    else return b;
    end if;
  end;

  function max(a, b, c, d: float) return float is
  begin
    return max(max(a,b), max(c,d)) ;
  end;

  function distancias_extremos(R1, R2: recta) return intervalo is
    d11, d12, d21, d22: float ;
  begin
    d11 := distancia(R1.p1, R2.p1);
    d12 := distancia(R1.p1, R2.p2);
    d21 := distancia(R1.p2, R2.p1);
    d22 := distancia(R1.p2, R2.p2);
    return (min(d11, d12, d21, d22), max(d11, d12, d21, d22));
  end;

  function distancia_perp(P: Punto; R: recta) return float is
    -- Calcula la proyecccion del punto sobre la recta.
    -- Si cae dentro del segmento, devuelve la distancia perpendicular
    -- Si cae fuera, devuelve un valor grande 1e10 ;
    proy: float ;
    P1_P, v: geometria.vector ;
  begin
    P1_P := P - R.p1 ;
    proy := R.u * P1_P ;
    if proy >= 0.0 and proy <= R.lon then
      v := (-R.u.y, R.u.x);
      return abs(v * P1_P);
    else
      return 1.0e10 ;
    end if ;
  end;

  function minima_distancia_perp(R1, R2: Recta) return float is
  begin
    return min(distancia_perp(R1.P1, R2), distancia_perp(R1.P2, R2),
              distancia_perp(R2.P1, R1), distancia_perp(R2.P2, R1));  
  end ;
  
  function distancias(R1, R2: recta) return intervalo is
  -- Calcula las distancias minima y maxima entre dos puntos cualesquiera
  -- de los dos segmentos
    extremos : intervalo;
  begin
    extremos := distancias_extremos(R1, R2) ;
    return ( min(extremos.min, minima_distancia_perp(R1,R2)), 
            extremos.max ) ;
  end ;


-----------------------------------------------------------------------------
-- Funciones para calcular la localizacion
-----------------------------------------------------------------------------


  function "*"(T: Trans; P: Punto) return Punto is
    s: float:= sin(T.tita) ;
    c: float:= cos(T.tita) ;
  begin
    return (c*P.x - s*P.y + T.x,
           s*P.x + c*P.y + T.y);
  end;
  

  function "*"(T: Trans; R: Rectas) return Rectas is
    resul: Rectas(R.max) ;
  begin
    resul.n:= 0 ;
    for i in 1..R.n loop
      anadir(resul, rec(T*R.elem(i).p1, T*R.elem(i).p2)) ;
    end loop;
    return resul;
  end;

  type matriz2x2 is array (1..2,1..2) of float;
  subtype vector2 is geometria.vector; 

  Ident: constant matriz2x2:= ((1.0, 0.0), (0.0, 1.0));
  
  function "+"(A, B: matriz2x2) return matriz2x2 is
  begin
    return ((A(1,1)+B(1,1), A(1,2)+B(1,2)),
           (A(2,1)+B(2,1), A(2,2)+B(2,2)));
  end;
  
  function "-"(A, B: matriz2x2) return matriz2x2 is
  begin
    return ((A(1,1)-B(1,1), A(1,2)-B(1,2)),
           (A(2,1)-B(2,1), A(2,2)-B(2,2)));
  end;
  
  function "*"(A, B: matriz2x2) return matriz2x2 is
  begin
    return ((A(1,1)*B(1,1)+A(1,2)*B(2,1), A(1,1)*B(1,2)+A(1,2)*B(2,2)),
           (A(2,1)*B(1,1)+A(2,2)*B(2,1), A(2,1)*B(1,2)+A(2,2)*B(2,2)));
  end;

  function "*"(M: matriz2x2; V: Vector2) return Vector2 is
  begin
    return (M(1,1)*V.x + M(1,2)*V.y, 
           M(2,1)*V.x + M(2,2)*V.y) ;
  end;
  
  function inv(M: Matriz2x2) return Matriz2x2 is
    det: float;
  begin
    det := M(1,1)*M(2,2) - M(1,2)*M(2,1);
    return (( M(2,2)/det, -M(2,1)/det), 
           (-M(1,2)/det,  M(1,1)/det));
  end ;

  function tr(M: Matriz2x2) return Matriz2x2 is
  begin
    return ((M(1,1), M(2,1)), 
           (M(1,2), M(2,2)));
  end ;

  function rot(tita: float) return Matriz2x2 is
    c: float:= cos(tita);
    s: float:= sin(tita);
  begin
    return ((c, -s), 
           (s,  c));
  end ;

  function centro (R:recta) return Punto is
  begin
    return (R.p1 + R.p2) / 2.0 ;
  end;
  
  
  procedure Localizar(Obser, Modelo: Rectas; P: Pares; ep: float;
                    T: out Trans; consistente: out boolean) is
    Pa, Ra, Ka, xa, ia: float;
    Px, Rx, Kx, Jac, invCi: matriz2x2;
    xx, ix: Punto;
    sx, sy, D2: float;
  begin
    consistente:= true ;
    -- Calculo del angulo
    Pa:= 50.0**2.0;
    xa:= 0.0;
    for j in 1..P.n loop
      Ra:= (ep/Obser.elem(P.elem(j).Recta_observada).lon)**2.0;
      Ka:= Pa/(Pa+Ra);
      ia:= normalizado( Modelo.elem(P.elem(j).Recta_modelo   ).ori 
                       -Obser.elem (P.elem(j).Recta_observada).ori - xa);
      xa:= normalizado(xa + Ka*ia) ;
      Pa:= (1.0 - Ka) * Pa ;
      --put("  Ka:"); put(Ka); put("  ia:"); put(ia);
      --put("  xa:"); put(xa); put("  Pa:"); put(Pa); new_line;
    end loop; 
    T:= (0.0, 0.0, xa);
    
    -- Calculo de la posicion
    Px:= ((1.0e4, 0.0),(0.0, 1.0e4));
    xx:= (0.0, 0.0) ;
    for j in 1..P.n loop
      Jac:= rot(Modelo.elem(P.elem(j).Recta_modelo).ori);
      sx:= (abs(Modelo.elem(P.elem(j).Recta_modelo   ).lon - 
               Obser.elem (P.elem(j).Recta_observada).lon)+2.0*ep)/4.0 ;
      sy:= ep/2.0 ;
      Rx:= Jac * matriz2x2'((sx*sx, 0.0),(0.0, sy*sy)) * tr(Jac) ;
      invCi:= inv(Px+Rx);
      Kx:= Px * invCi ; 
      ix:= centro(Modelo.elem(P.elem(j).Recta_modelo)) -
           T * centro(Obser.elem(P.elem(j).Recta_observada)) - xx;
      xx:= xx + Kx * ix;
      Px:= (Ident-Kx) * Px;
      
      -- Verificacion de la consistencia
      D2:= ix*(invCi*ix) ;
      --put("Dist2: "); Put(D2); new_line;
      if D2 > 9.21  then  -- Chi2 con 2 g.l. al 99 %
        consistente := false ;
      end if;
    end loop;
    T.x := xx.x;
    T.y := xx.y;
  end; 

-----------------------------------------------------------------------------
-- Funciones para dibujar el resultado
-----------------------------------------------------------------------------

  procedure Dibujar(Obser, Modelo: Rectas; Solu: Soluciones; ep: float:= 0.1) is
  -- Dibuja varias ventanas, con:
  --  - Las observaciones
  --  - El modelo a reconocer
  --  - Las soluciones de mayor numero de emparejamientos obtenidas

    T: Trans;
    G: Grafica ;
    E: ejes ;
    i: integer;
    Los_Pares: Pares;
    iter: soluciones;
    consistente: boolean;
  begin
    E:= Calcular_ejes(Obser) ;
    G:= Crear_Grafica("Observaciones", E.xmin, E.xmax, E.ymin, E.ymax);
    Dibujar(G, Obser, extremos=> true) ;
    Dejar_Grafica(G);    
    E:= Calcular_ejes(Modelo) ;
    G:= Crear_Grafica("Modelo",  E.xmin, E.xmax, E.ymin, E.ymax);
    Dibujar(G, Modelo) ;
    Dejar_Grafica(G);    
    i:= 1 ;
    iter:= Solu ;
    while More(iter) loop
      pop(Los_Pares, iter) ;
      exit when Los_Pares.n < first(Solu).n or i > 10 ;
      put_line("Dibujando");
      put("Sol. "); put(i,3); Put(", con "); 
      Put(Los_pares.n, 2); Put(" pares: ") ;
      for j in 1..Los_pares.n loop
        Put("("); Put(Los_pares.elem(j).Recta_observada, 2); Put(",");
	Put(Los_pares.elem(j).Recta_modelo, 2); Put(") ");
      end loop; 
      new_line;
      Localizar(Obser, Modelo, Los_Pares, ep, T, consistente);
      if consistente then
        put_line("CONSISTENTE");
      else
        put_line("NO ES CONSISTENTE");
      end if;
      G:= Crear_Grafica("Solucion "&texto(i), E.xmin, E.xmax, E.ymin, E.ymax);
      Colores(G, "white") ;
      Dibujar(G, Modelo) ;
      Colores(G, "yellow") ;
      Dibujar(G, T * Obser) ;
      Dejar_Grafica(G);    
      i:= i + 1;
    end loop;
  end;

  Procedure Put(Solu: Soluciones; todas: boolean := false) is
    iter: Soluciones ;
    i: integer ;
    Los_Pares: Pares ;
  begin
    put_line("-----------------------------------------") ;
    Put("SOLUCIONES ENCONTRADAS:"); Put(Length(Solu), 3); new_line;
    put_line("-----------------------------------------") ;
    i:= 1 ;
    iter := Solu ;
    while More(iter) loop
      if not todas and i > 30 then
        put_line("......");
        exit;
      end if;
      pop(Los_Pares, iter) ;
      put("Sol. "); put(i,3); Put(", con "); 
      Put(Los_pares.n, 2); Put(" pares: ") ;
      for j in 1..Los_pares.n loop
        Put("("); Put(Los_pares.elem(j).Recta_observada, 2); Put(",");
	Put(Los_pares.elem(j).Recta_modelo, 2); Put(") "); 
      end loop;
      new_line ;
      i:= i + 1;
    end loop;
  end ;

end reconocimiento.funciones;

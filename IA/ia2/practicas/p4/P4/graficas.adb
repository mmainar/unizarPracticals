---------------------------------------------------------------------
-- Fichero:   Graficas.adb
-- Autor:     J.D.Tardos
-- Version:   v1.2 3-5-2000
-- Proposito: Paquete para dibujar en una X-Window
---------------------------------------------------------------------
-- Utiliza el software de dominio publico ada-plotutil-2.3 de GNU
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 11-4-2000
--   - Agnadidas opciones al dibujar Puntos y Rectas
--   - Evitado el bug de merlin al dibujar la primera recta
-- v1.2, J.D.Tardos, 9-5-2000
--   - Eliminado el "flash" blanco al abrir las ventanas
--   - Agnadidas funciones para calcular los ejes automaticamente
--   - Agnadida funcion texto
---------------------------------------------------------------------

with GNU.plotutil.Device.Direct, GNU.plotutil.fplot;
use  GNU.plotutil.Device, GNU.plotutil ;
with Text_IO, Ada.Strings.Fixed; 
use  Text_IO, Ada.Strings.Fixed;

package body Graficas is

  package FIO is new Float_IO(float); use FIO ;
  package IIO is new Integer_IO(integer); use IIO ;
  package X_Plotter is new GNU.plotutil.Device.Direct (X_Device_Type);
  package FP is new GNU.plotutil.fplot(Float); use FP ;

  Xwins: array(Grafica) of Plotter ;
  sizes: array(Grafica) of float ;
  nwins: integer range 0..max_graficas:= 0 ;


  type rango is record
    min, max: float ;
  end record ;

  function min(a, b: float) return float is
  begin
    if a <= b then  return a;
    else return b;
    end if;
  end;
  
  function max(a, b: float) return float is
  begin
    if a >= b then return a;
    else return b;
    end if;
  end;

  procedure ampliar(Rx, Ry: in out rango; P: Punto) is
  begin
    Rx.min:= min(Rx.min, P.x);
    Rx.max:= max(Rx.max, P.x);
    Ry.min:= min(Ry.min, P.y);
    Ry.max:= max(Ry.max, P.y);
  end;

  procedure redondear(R: in out rango) is
    d: float;
  begin
    d:= R.max - R.min ;
    R.min:= R.min - 0.05 * d ;
    R.max:= R.max + 0.05 * d ;
  end ;

  function Calcular_Ejes(R: Rectas) return ejes is
    Rx, Ry: rango := (1.0e5, -1.0e5) ;
  begin
    for i in 1..R.n loop
      ampliar(Rx, Ry, R.elem(i).p1) ;
      ampliar(Rx, Ry, R.elem(i).p2) ;
    end loop;
    redondear(Rx);
    redondear(Ry);
    return ejes'(Rx.min, Rx.max, Ry.min, Ry.max);
  end;

  function Calcular_Ejes(P: Puntos) return ejes is
    Rx, Ry: rango := (1.0e5, -1.0e5) ;
  begin
    for i in 1..P.n loop
      ampliar(Rx, Ry, P.elem(i)) ;
    end loop;
    redondear(Rx);
    redondear(Ry);
    return ejes'(Rx.min, Rx.max, Ry.min, Ry.max);
  end;


  function Texto(f: float) return string is
    str: string(1..10) ;
  begin
    put(str, f, 1, 0) ;
    return Trim(str,Ada.Strings.Both) ;
  end ;

  function Texto(n: integer) return string is
  begin
    return Trim(integer'image(n),Ada.Strings.Both) ;
  end ;


  function Ultima_Grafica return Grafica is
  -- Devuelve la ultima grafica creada 
  begin
    return Grafica(nwins) ;
  end ;


  function Crear_Grafica(titulo: string; xmin, xmax, ymin, ymax: float;
                        cuadrada: boolean := true ;
                        xmarcas, ymarcas: integer := 10 ;
			geometry: string:= "" ) return Grafica is
  -- Si se crean ventanas no cuadradas, a veces se enloquece al escribir texto
    Xwin: Plotter ;
    Param: Plotter_Parameter ;
    bx, by, x, y, lado, xmax2, ymax2: float ;
    fs: float ;
    G: Grafica ;
  begin
    if nwins = max_graficas then
      put("Solo pueden crearse "); put(max_graficas); put_line(" graficas");
      raise Constraint_Error ;
    end if ;
    Param := Create ;
    if geometry /= "" then
      Set(Param, "BITMAPSIZE", geometry) ;
    else
      Set(Param, "BITMAPSIZE", "700x700") ;
    end if ;
    Set(Param, "BG_COLOR", "black") ;
    Xwin := X_Plotter.Create(Param);
    Open (Xwin);
    --Background_ColorName (Xwin, "black");
    ColorName (Xwin, "white");
    Erase (Xwin);
    if cuadrada then
      lado:= max(xmax-xmin,ymax-ymin) ;
      xmax2:= xmin+lado ;
      ymax2:= ymin+lado ;
    else
      xmax2:= xmax ;
      ymax2:= ymax ;      
    end if ;
    bx := 0.1*(xmax2-xmin) ;
    by := 0.1*(ymax2-ymin) ;
    Space (Xwin, xmin-bx,ymin-by,xmax2+bx,ymax2+by);
    fs := Font_Size(Xwin) ;
    Box(Xwin, xmin,ymin,xmax2,ymax2) ;
    Move (Xwin, (xmin+xmax2)/2.0 , ymax2);
    Label (Xwin, Text => titulo, H_Justify=> Center, V_Justify=>Bottom);
    for i in 0..xmarcas loop
      x := xmin+float(i)*(xmax2-xmin)/float(xmarcas) ;
      Marker (Xwin, x, ymin, Plus, fs);
      Move (Xwin, x, ymin-0.5*fs);
      Label(Xwin, Center, Top, Texto(x));
    end loop ;
    for i in 0..ymarcas loop
      y := ymin+float(i)*(ymax2-ymin)/float(ymarcas) ;
      Marker (Xwin, xmin, y, Plus, fs);
      Move (Xwin, xmin-0.5*fs, y);
      Label(Xwin, Right, Center, Texto(y));
    end loop ;
    Flush(Xwin) ;
    nwins:= nwins+1 ;
    G:= Grafica(nwins) ;
    Xwins(G):=Xwin ;
    sizes(G):=fs ;
    return G ;
  exception
    when others=>
      Put_line("Error creando una nueva grafica") ;
      raise ; 
  end Crear_Grafica ;

  procedure Dejar_Grafica(G: in Grafica) is
  begin
    Close (Xwins(G));
    Delete(Xwins(G));
  end ;
  
  procedure Borrar_Grafica(G: in Grafica) is
  begin
    Erase (Xwins(G));
  end ;


  procedure Dibujar(G: Grafica; P: punto; gordo: boolean := false) is
  begin
    if gordo then
      Marker (Xwins(G), P.x, P.y, Circle, 0.5*sizes(G));
    else
      Point(Xwins(G), P.x, P.y) ;
    end if;
  end ;


  procedure Dibujar(G: Grafica; P: Puntos; gordo: boolean := false) is
  begin
    for i in 1..P.n loop
      Dibujar(G, P.elem(i), gordo);
    end loop ;
  end Dibujar ;


  procedure Dibujar(G: Grafica; P1, P2: Punto; Extremos: boolean:=false) is
  begin
    Line(Xwins(G), p1.x, p1.y, p2.x, p2.y) ;
    if extremos then
      --Dibujar(G, p1, gordo=> true) ;
      --Dibujar(G, p2, gordo=> true) ;
      Marker (Xwins(G), P1.x, P1.y, Cross, 0.7*sizes(G));
      Marker (Xwins(G), P2.x, P2.y, Cross, 0.7*sizes(G));
    end if ;
  end ;


  procedure Dibujar(G: Grafica; R: Recta; Extremos: boolean := false) is
  begin
    Dibujar(G, R.p1, R.p2, Extremos) ;
  end ;
  
  
  procedure Rectangulo(G: Grafica; xmin,xmax,ymin,ymax: float) is
  begin
    Box(Xwins(G), xmin, ymin, xmax, ymax) ;
  end ;


  procedure Poligonal(G: Grafica; P: Puntos; 
 		     con_puntos: boolean:= false ;
                     cerrada: boolean:= false) is
  begin 
    Poligonal(G, P.elem, P.n, con_puntos, cerrada) ; 
  end ;


  procedure Poligonal(G: Grafica; P: VPuntos; n: integer; 
                     con_puntos: boolean:= false ;
                     cerrada: boolean:=false) is
  begin 
   if n > 0 then
    Move(Xwins(G), P(1).x, P(1).y) ;
    if con_puntos then
      Dibujar(G, P(1), gordo=> true );
    end if ;
    for i in 2..n loop
      Continue(Xwins(G), P(i).x, P(i).y);
      if con_puntos then
        Dibujar(G, P(i), gordo=> true );
      end if ;
    end loop ;     
    if cerrada then
      Continue(Xwins(G), P(1).x, P(1).y) ;
    end if ;
   end if ;
  end ;


  procedure Dibujar(G: Grafica; R: Rectas; extremos: boolean:=true;
                   numeradas: boolean := true) is
    P: punto ;
    v: vector ;
    kk: float ;
  begin
	
	-- Linea introducida para sortear un bug al dibujar rectas en merlin
    Line(Xwins(G), -100.0, -100.0, -100.0, -100.0 );
	
    kk:=font_size(Xwins(G), 0.8*sizes(G)) ;
    for i in 1..R.n loop
      --put("Dibujando") ; Put(R.elem(i));
      Dibujar(G, R.elem(i), extremos) ;
      if numeradas then
        v:= (-R.elem(i).u.y, R.elem(i).u.x) ;
		P:= (R.elem(i).P1 + R.elem(i).P2)/2.0  - 0.5*sizes(G)*v ;
        Move (Xwins(G), P.x, P.y);
        Label(Xwins(G), Center, Center, Texto(i));        
      end if ;
    end loop ;
    kk:=font_size(Xwins(G), sizes(G)) ;    
  end Dibujar ;


  procedure Dibujar(G: Grafica; Obj: Objeto) is
  begin
     Poligonal(G, Obj.puntos, Obj.n, cerrada=> true) ;   
  end ;


  procedure Dibujar(G: Grafica; Objs: Objetos4) is
  begin
    Filltype(Xwins(G), 1);
    for i in 1..Objs.n loop
      Dibujar(G, Objs.elem(i)) ;
    end loop ;
  end ;
  
  procedure Colores(G: Grafica; Lapiz: String; Relleno: String := "") is
  begin
    Pen_ColorName (Xwins(G), Lapiz);
    If Relleno = "" then
      Filltype(Xwins(G), 0);
      Fill_ColorName (Xwins(G), "blue");
    else
      Filltype(Xwins(G), 1);
      Fill_ColorName (Xwins(G), Relleno);
    end if ;   
  end ;

end Graficas;

---------------------------------------------------------------------
-- Fichero:   cespacio.adb
-- Autor:     J.D.Tardos
-- Version:   v1.2 26-6-2000
-- Proposito: Paquete para busqueda de trayectorias sin colision
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 6-4-2000
--   - Añadidos comentarios en algunas funciones
-- v1.2, J.D.Tardos, 26-6-2000
--   - Anadido signo al calcular distancias
---------------------------------------------------------------------

with Text_IO ; use Text_IO ;
package body Cespacio is

  package IIO is new Integer_IO(integer); use IIO ;
  package FIO is new Float_IO(float); use FIO ;
  
---------------------------------------------------------------
-- Operaciones para obtener los obstaculos del C-Espacio
---------------------------------------------------------------

  function Engordar(R: Recta;  radio: float) return Objeto4 is
    P: Puntos(4) ;
    v: Vector ;
  begin
    P.n:= 4 ;
    v:= (-R.u.y, R.u.x) ;
    P.elem(1):= R.p1 + radio*(-R.u - v) ;
    P.elem(2):= R.p1 + radio*(-R.u + v) ;
    P.elem(3):= R.p2 + radio*( R.u + v) ;
    P.elem(4):= R.p2 + radio*( R.u - v) ;    
    return Crear_objeto(P) ;
  end Engordar ;
  
  procedure Engordar(R: Rectas; radio: float; Objetos: in out Objetos4) is
  begin
    CESP.Objetos.n:= 0 ;
    for i in 1..R.n loop
      Anadir(CESP.Objetos, Engordar(R.elem(i), radio)) ;
    end loop ;
  end Engordar ;

---------------------------------------------------------------
-- CESP.Celdas del C-espacio y sus operaciones 
---------------------------------------------------------------

  procedure inicializar(C: in out Celda; xmin, xmax, ymin, ymax: float) is 
  begin
    C.xmin:= xmin; C.xmax:= xmax; C.ymin:= ymin; C.ymax:= ymax;
    C.vertices:= ((xmin,ymax),(xmax,ymax),(xmax,ymin),(xmin,ymin)) ;
    C.centro:= ((xmin+xmax)/2.0, (ymin+ymax)/2.0) ;
  end ;
	 
  procedure crear_celda_inicial(xmin, xmax, ymin, ymax: float) is
  -- Crea la celda global como MIXTA, y le asocia las restricciones de
  -- todas las rectas de todos los objetos
    C: Celda renames CESP.Celdas.elem(1) ;
    R: Rest_Obj ;
  begin
    CESP.Celdas.n:= 1 ;
    Inicializar(C, xmin, xmax, ymin, ymax) ;
    C.etiqueta:= MIXTA ;
    for i in 1..CESP.Objetos.n loop
      R:= (Objeto=> i, Restric=>(others => false)) ;
      R.Restric(1..CESP.Objetos.elem(i).n):= (others=>true) ;
      Push(R, C.restric) ;
    end loop ;
  end ;

---------------------------------------------------------------
-- Funciones para etiquetar las celdas hijas de mixtas 
---------------------------------------------------------------

  function Esta_dentro(N: num_celda; R: recta) return boolean is
  begin
    for i in 1..4 loop
      if distancia(CESP.Celdas.elem(N).vertices(i), R, signo=> true) > 0.0 then 
        return false ;
      end if ;
    end loop ;
    return true ;
  end ;
  
  function Esta_fuera (N: num_celda; R: recta) return boolean is
  begin
    for i in 1..4 loop
      if distancia(CESP.Celdas.elem(N).vertices(i), R, signo=> true) < 0.0 then 
        return false ;
      end if ;
    end loop ;
    return true ;
  end ;


  procedure Etiquetar(N: num_celda) is
  -- Etiqueta una celda, partiendo de las restric de su madre
  -- Asocia a la celda las restric que son problematicas para ella
    C: Celda renames CESP.Celdas.elem(N) ;
    M: Celda renames CESP.Celdas.elem(C.Madre) ;
    RM: lista_restric ;
    Ei: Rest_Obj ; --restriciones del objeto i
    Oi: Objeto4  ; --Objeto i
    Fuera_de_Oi: boolean ;
    todo_falso: constant Vrestric:= (others=>false) ;
  begin
    -- Se recorren las restricciones de su madre, 
    -- y se van añadiendo a la celda actual las que le afectan
    C.restric:= null ;
    RM:= M.restric ;
    while(More(RM)) loop
      Pop(Ei, RM) ;
      Oi:= CESP.Objetos.elem(Ei.Objeto) ;
      Fuera_de_Oi:= false ;
      for j in 1..Oi.n loop
 	if Ei.Restric(j) then
   	  if Esta_Dentro(N, Oi.rectas(j)) then
     	    Ei.Restric(j):= false ;
   	  elsif Esta_Fuera(N, Oi.rectas(j)) then
	    Ei.Restric:= Todo_Falso ;
	    Fuera_de_Oi:= true ;
	    exit ;
   	  end if ;
 	end if ;
      end loop ;
      If not Fuera_de_Oi then
        Push(Ei, C.restric) ;
        if Ei.Restric = Todo_Falso then
          C.etiqueta:= LLENA ;  --Ninguna recta la parte
	  return ;
	end if ;
      end if ;
    end loop ; --Fin del objeto
    if endp(C.restric) then
      C.etiqueta:= VACIA ;
    else
      C.etiqueta:= MIXTA ;
    end if ; 
  end ;    


  function crear_celda(Madre: num_Celda; 
                       xmin, xmax, ymin, ymax: float) return num_celda is
    M: Celda renames CESP.Celdas.elem(Madre) ;
    C: Celda renames CESP.Celdas.elem(CESP.Celdas.n+1) ;
  begin
    CESP.Celdas.n:= CESP.Celdas.n+1 ;
    Inicializar(C, xmin, xmax, ymin, ymax) ;
    C.madre:= Madre;
    C.etiqueta:= M.etiqueta;
    If C.etiqueta = MIXTA then
      Etiquetar(CESP.Celdas.n) ;
    end if ;
    return CESP.Celdas.n ;
  end ;

  procedure Contar_Celdas is
    n: array(tipo_etiqueta) of integer := (others=>0) ; 
  begin
    for i in 1..CESP.Celdas.n loop 
      n(CESP.Celdas.elem(i).etiqueta) := n(CESP.Celdas.elem(i).etiqueta)+1 ; 
    end loop ;  
    put("Partidas: "); put(n(PARTIDA),7); new_line ;    
    put("Llenas:   "); put(n(LLENA),7); new_line ;
    put("Vacias:   "); put(n(VACIA),7); new_line ;
    put("Mixtas:   "); put(n(MIXTA),7); new_line ; 
    put("Total:    "); put(integer(CESP.Celdas.n),7); new_line; 
    new_line;
  end ;

  procedure partir(N: num_celda) is
    C: Celda renames CESP.Celdas.elem(N) ;
  begin
    C.hijas(1):=Crear_celda(N, C.xmin, C.centro.x, C.centro.y, C.ymax) ;
    C.hijas(2):=Crear_celda(N, C.centro.x, C.xmax, C.centro.y, C.ymax) ;
    C.hijas(3):=Crear_celda(N, C.xmin, C.centro.x, C.ymin, C.centro.y) ;
    C.hijas(4):=Crear_celda(N, C.centro.x, C.xmax, C.ymin, C.centro.y) ;
    C.etiqueta:= PARTIDA ;
  end ;


  procedure partir_Mixtas is
  -- Parte todas las celdas Mixtas, y etiqueta las cuatro hijas
  -- utilizando el algoritmo estudiado en clase
  begin
    for i in 1..CESP.Celdas.n loop
      if CESP.Celdas.elem(i).etiqueta = MIXTA then
        Partir(i) ;
      end if;
    end loop ;
    Contar_Celdas ;
  end ;

---------------------------------------------------------------
-- Funciones para obtener el grafo de conectividad 
---------------------------------------------------------------

  function son_vecinas(C1, C2: celda) return boolean is
  -- Verifica si dos Celdas son vecinas

    function tocan(min1, max1, min2, max2: float) return boolean is
    -- Verifica si dos intervalos se tocan
    begin
      return (max1=min2) or else (min1=max2) ;
    end ;

    function solapan(min1, max1, min2, max2: float) return boolean is
    -- Verifica si dos intervalos se solapan
    begin
      return (min2<max1) and then (max2>min1) ;
    end ;

  begin
    return (tocan  (c1.xmin, c1.xmax, c2.xmin, c2.xmax) and then
           solapan(c1.ymin, c1.ymax, c2.ymin, c2.ymax) )
	   or else
          (tocan  (c1.ymin, c1.ymax, c2.ymin, c2.ymax) and then
           solapan(c1.xmin, c1.xmax, c2.xmin, c2.xmax));     	   
  end son_vecinas ;
  Pragma Inline(son_vecinas) ;
  

  procedure Buscar_vecinas(N: num_celda) is
    C: Celda renames CESP.Celdas.elem(N) ;
    M: Celda renames CESP.Celdas.elem(C.Madre) ;
    i: Lista_num_celdas ;
    nv: num_celda ;

    procedure anadir_descencientes(nv: num_celda) is
      V: Celda renames CESP.Celdas.elem(nv) ;
    begin
      case V.etiqueta is
        when VACIA | MIXTA =>
          if son_vecinas(C, V) then
            Push(nv, C.vecinas) ;
          end if ;
        when PARTIDA =>
	  if son_vecinas(C,V) then
            for i in 1..4 loop
              anadir_descencientes(V.hijas(i)) ;
            end loop ;
	  end if ;
        when others => null ;
      end case ;
    end ;

  begin
    C.vecinas:= null ;
    for i in 1..4 loop    --Comprueba la descendencia de sus hermanas
      if M.hijas(i)/=N then
        anadir_descencientes(M.hijas(i)) ;
      end if ;
    end loop ;
    i:=M.vecinas ;
    while(More(i)) loop   --Comprueba la descendencia de las vecinas de su madre
      Pop(nv, i) ;
      anadir_descencientes(nv) ;  
    end loop ;    
  end ;    


  procedure Crear_Grafo is
  -- Construye el grafo de conectividad de las celdas Vacias y Mixtas
  -- Como resultado, se actualizan las vecinas de cada celda
  begin
    for i in 1..CESP.Celdas.n loop
      if CESP.Celdas.elem(i).etiqueta = VACIA or CESP.Celdas.elem(i).etiqueta = MIXTA then
        Buscar_Vecinas(i) ;
      end if;
    end loop ;
  end ;
  

---------------------------------------------------------------
-- Funcioneds auxiliares 
---------------------------------------------------------------
  
  function Celda_que_contiene(P: Punto) return num_Celda is
  -- Busca en las celdas no partidas la que contiene el punto deseado
  -- Si no hay ninguna, devuelve 0. Es una operacion costosa.
  begin
    for i in 1..CESP.Celdas.n loop
      if CESP.Celdas.elem(i).etiqueta /= PARTIDA then
        if (P.x >= CESP.Celdas.elem(i).xmin) and (P.x <= CESP.Celdas.elem(i).xmax) and
           (P.y >= CESP.Celdas.elem(i).ymin) and (P.y <= CESP.Celdas.elem(i).ymax) then
	   return i ;
        end if ;
      end if ;
    end loop ;
    return 0 ;
  end ;

  procedure Dibujar_Grafo is
    j: num_celda ;
    iter: Lista_num_celdas ;
  begin
    Colores(G, Lapiz=>"orange") ; 
    for i in 1..CESP.Celdas.n loop
      if CESP.Celdas.elem(i).etiqueta /= PARTIDA then        
        iter:=CESP.Celdas.elem(i).vecinas ;
        while(More(iter)) loop
          Pop(j, iter) ;
	  Dibujar(G, CESP.Celdas.elem(i).centro, CESP.Celdas.elem(j).centro) ;
        end loop ;
      end if ;
    end loop ;  
  end ;

  procedure Dibujar_Celdas is
    procedure Dibujar(E: tipo_etiqueta) is
    begin
      for i in 1..CESP.Celdas.n loop    
        if CESP.Celdas.elem(i).etiqueta = E then
	  Rectangulo(G, CESP.Celdas.elem(i).xmin, CESP.Celdas.elem(i).xmax,
	                CESP.Celdas.elem(i).ymin, CESP.Celdas.elem(i).ymax) ;
	end if ;
      end loop ;
    end ;
    Pragma Inline(Dibujar) ;
  begin
    Colores(G, Lapiz=>"yellow", Relleno=>"green") ; 
    Dibujar(VACIA) ;
    Colores(G, Lapiz=>"yellow", Relleno=>"red") ;
    Dibujar(LLENA) ;
    Colores(G, Lapiz=>"yellow") ;
    Dibujar(MIXTA) ;
    Dibujar_Grafo ;
  end ;

  procedure dibujar_cespacio(Particion: integer := 0;
			    Grafo: boolean := false) is
  -- Crea una nueva ventana y dibuja los objetos las celdas y 
  -- el grafo de conectividad del cespacio
    C1: celda renames CESP.celdas.elem(1) ;
  begin
    G:= Crear_Grafica("Particion: "&Particion'Img, 
                      C1.xmin, C1.xmax, C1.ymin, C1.ymax) ; 
    Dibujar(G, CESP.Objetos) ;
    Dibujar_Celdas ;
    If Grafo then
      Dibujar_Grafo ;
    end if ;
  end ;


  procedure Recorrer_Camino(Camino: in out Puntos; n: num_celda; 
                        Origen, Destino: Punto) is
  -- Recorre el camino hacia atras desde la celda n, lo guarda en Camino
  -- y lo escribe por la pantalla

    procedure Recorrer_recursivo(m: num_celda) is
    begin
      if CESP.Celdas.elem(m).anterior /= 0 then
        Recorrer_recursivo(CESP.Celdas.elem(m).anterior) ;
      end if ;
      anadir(Camino, CESP.Celdas.elem(m).centro) ;
      Put(CESP.Celdas.elem(m).centro) ;
    end Recorrer_recursivo ;

  begin
    Camino.n := 0 ;
    Put_line("Camino encontrado") ;
    Anadir(Camino, Origen) ;
    Put(Origen) ;
    Recorrer_recursivo(n) ;
    Anadir(Camino, Destino) ;
    Put(Destino) ;
    Put("Longitud Total: ") ;
    Put(CESP.Celdas.elem(n).recorrido + CESP.Celdas.elem(n).distancia, 6, 3, 0) ;
    New_line ;
  end Recorrer_Camino ;

    

end Cespacio ;

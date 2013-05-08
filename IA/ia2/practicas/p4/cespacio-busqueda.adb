---------------------------------------------------------------------
-- Fichero:   cespacio-busqueda.adb
-- Autor:     Marcos Mainar Lalmolda
-- Fecha:     11 de Mayo de 2009
-- Proposito: Solucion de la practica 2
---------------------------------------------------------------------

with Text_IO, ada.integer_text_IO, ada.float_text_IO;
use  Text_IO, ada.integer_text_IO, ada.float_text_IO;

Package body Cespacio.Busqueda is

  celda_fin: integer; -- Indice de la celda final
  nodos_totales, nodos_expandidos: integer := 0;

  
  function crear_nodo (celda: num_celda; coste: float) return Nodo is
  -- Crea un nodo
    n: Nodo;
  begin
    n.celda := celda;
    n.coste := coste;
    return n;
  end;
  
  
  function menor(N1, N2: Nodo) return boolean is
  -- Funcion de ordenacion para la lista de nodos
  -- Ordena por heuristica creciente
  begin
    return (N1.coste < N2.coste);
  end;
  
  
  function igual(N1, N2: Nodo) return boolean is
  -- Funcion de igualdad para la lista de nodos
  -- 2 nodos son iguales si se corresponden con la misma celda
  begin
    return (N1.celda = N2.celda);
  end;
 
 
  function ordenar_asc is new Listas_Nodos.sort(menor);
  function mezclar_asc is new Listas_Nodos.merge(menor);
  procedure eliminar_iguales is new Listas_Nodos.delete(igual);
  

  procedure expandir_nodo(N: nodo; Nodos: in out Lista_nodos;
                        Nuevos: out lista_nodos; Destino: Punto ;
			etiqueta_max: tipo_etiqueta:= VACIA) is
  -- Expandir el nodo teniendo en cuenta las celdas vecinas de 
  -- la celda que corresponde al nodo N. Nuevos son la lista de
  -- nodos expandidos.
    nuevo: nodo;
    c: num_celda;
    celda_a_expandir: Celda renames CESP.Celdas.elem(N.celda);	
    recorrido: float;		
    vecinas: lista_num_celdas;
  begin
    Nuevos:= null ;
    celda_a_expandir.expandida := true;
    vecinas := celda_a_expandir.vecinas; -- Para no sobreescribir las vecinas, las copiamos

    while (More(vecinas)) loop
      Pop(c, vecinas);
      if (CESP.Celdas.elem(c).etiqueta <= etiqueta_max) then
	if (CESP.Celdas.elem(c).expandida) then
          null; -- La celda ya estaba expandida, luego no se crea un nuevo nodo a expandir
	elsif (CESP.Celdas.elem(c).visitada) then
          -- La celda ya habia sido visitaba pero no expandida (estaba en Nodos)
          recorrido := CESP.Celdas.elem(N.celda).recorrido + distancia(CESP.Celdas.elem(N.celda).centro, CESP.Celdas.elem(c).centro);
	  if (recorrido < CESP.Celdas.elem(c).recorrido) then
	    CESP.Celdas.elem(c).anterior := N.celda;
	    CESP.Celdas.elem(c).recorrido := recorrido;
	    -- Creamos nodo nuevo con el camino mejor que el original
	    nuevo := crear_nodo(c, CESP.Celdas.elem(c).distancia + CESP.Celdas.elem(c).recorrido);
	    -- Eliminar el nodo antiguo de la lista de nodos a expandir (lista de Nodos)
	    eliminar_iguales(nuevo, Nodos);
	    -- Introducir el nodo con el camino mejor que el original en la lista de nodos a expandir (lista de Nodos)
	    push(nuevo, Nodos);
	  else -- Si el coste no es menor, no se hace nada
	    null;
	  end if;       
	else -- La celda no habia sido visitada ni expandida (no estaba en Nodos)
          CESP.Celdas.elem(c).visitada  := true;
	  CESP.Celdas.elem(c).expandida := false;
          CESP.Celdas.elem(c).anterior  := N.celda;
          CESP.Celdas.elem(c).distancia := distancia(CESP.Celdas.elem(c).centro, Destino);
	  CESP.Celdas.elem(c).recorrido := CESP.Celdas.elem(N.celda).recorrido + distancia(CESP.Celdas.elem(N.celda).centro, CESP.Celdas.elem(c).centro);
	  -- Creamos el nodo nuevo
          nuevo := crear_nodo(c, CESP.Celdas.elem(c).distancia + CESP.Celdas.elem(c).recorrido);
	  -- Introducir el nodo nuevo en la lista de nuevos nodos
	  push(nuevo, Nuevos);
	end if;
      end if;
    end loop;
  end;



  procedure reorganizar_nodos(Nodos: in out Lista_nodos; Nuevos: Lista_nodos) is
  -- Implementa una estrategia de busqueda de minima distancia
  begin
    -- Ordenar Nodos por minima distancia
    Nodos := mezclar_asc(Nodos, ordenar_asc(Nuevos));
  end reorganizar_nodos;


  procedure escribe_camino(n: in num_celda; Camino: in out Puntos) is
  -- Guarda en Camino los centros de las celdas que forman el camino solucion
  -- encontradas en la busqueda en orden inverso
  begin
    if (CESP.Celdas.elem(n).anterior /= 0) then
      Anadir(Camino, CESP.Celdas.elem(n).centro);
      escribe_camino(CESP.Celdas.elem(n).anterior, Camino); 
    else -- Añadir el centro de la celda inicial
      Anadir(Camino, CESP.Celdas.elem(n).centro); 
    end if;
  end;


  Procedure Buscar_Nivel(Origen, Destino: in Punto; Camino: in out Puntos;
			etiqueta_max: tipo_etiqueta:= VACIA) is
  -- Busca camino en la particion actual, considerando celdas VACIA..etiqueta_max

    Nodos, Nuevos: lista_nodos; -- Dadas de inicio (Nodos es la lista de Nodos)
    nodo_inicial, nodo_actual: Nodo;
    resuelto: boolean := false;
    estado_actual: Celda;
    ini: integer; -- Indice de la celda origen (que contiene el punto origen).
    dest: integer; -- Indice de la celda destino (que contiene el punto destino)  
  begin
    Camino.n := 0;
    Nodos:= null;   
    ini := celda_que_contiene(Origen);  -- Celda inicial (que contiene el punto origen o de inicio)
    dest := celda_que_contiene(Destino); -- Celda final (que contiene el punto destino)
    -- Creamos nodo inicial
    CESP.Celdas.elem(ini).anterior := 0; -- No tiene padre
    CESP.Celdas.elem(ini).recorrido := distancia(Origen, CESP.Celdas.elem(ini).centro); 
    CESP.Celdas.elem(ini).expandida := true;
    CESP.Celdas.elem(ini).visitada := true;
    CESP.Celdas.elem(ini).distancia := distancia(Origen, Destino);
    nodo_inicial := crear_nodo(ini, CESP.Celdas.elem(ini).recorrido + CESP.Celdas.elem(ini).distancia);
    push(nodo_inicial, Nodos);
    if ((CESP.Celdas.elem(ini).etiqueta <= etiqueta_max) and then
       (CESP.Celdas.elem(dest).etiqueta <= etiqueta_max)) then
              
      while (more(Nodos) and then not resuelto) loop
	-- Quitar primer elemento de la lista de Nodos
	pop(nodo_actual, Nodos);
	estado_actual := CESP.Celdas.elem(nodo_actual.celda);
	if ((dest = nodo_actual.celda) and 
            (CESP.celdas.elem(nodo_actual.celda).etiqueta <= etiqueta_max)) then
          resuelto := true;
	else
	  -- Aplicar los operadores para obtener nuevos nodos
          expandir_nodo(nodo_actual, Nodos, nuevos, Destino, etiqueta_max);
	  nodos_expandidos := nodos_expandidos + 1;
	  reorganizar_nodos(Nodos, nuevos);	
	end if;
      end loop;
    end if;
    
    put("Nodos totales: "); put(nodos_expandidos + length(Nodos), 0); new_line;
    if resuelto then
      -- Devolver el camino solucion
      escribe_camino(nodo_actual.celda, Camino);
      celda_fin := nodo_actual.celda;
    end if;
  end ;



  Procedure Buscar_Camino(Origen, Destino: in Punto; Camino: in out Puntos;
                          N_particion: in integer) is
  -- Busca un camino sin colision desde el Origen hasta el Destino, hasta el
  -- nivel de particion N_particion.
  -- Previamente debe haberse inicializado la variable global CESP para 
  -- que contenga los Objetos ya engordados (Obstaculos del C-Espacio),
  -- y debe haberse creado la celda inicial con  Crear_Celda_Inicial
  -- El Camino se devuelve en Camino. Si no se ha encontrado: Camino.n = 0
 
  begin
    Dibujar_Cespacio(0); -- Dibujamos el Cespacio inicial
    Dejar_Grafica(G); -- Para que no se bloquee
    -- Para Cespacio1 basta con N_particion = 3
    -- Para Cespacio2 no hay solucion (hay que llegar a N_particion = 3 para saberlo)
    -- Para mapaseg N_particion = 7 encuentra solucion en mis puntos elegidos
    for Particion in 1..N_particion loop      
      put("Nivel de particion: "); put(Particion, 0); new_line;
      -- Parte todas las celdas mixtas y etiqueta las 4 hijas
      Partir_Mixtas;
      -- Construye el grafo de conectividad o adyacencia de las celdas
      -- vacias y mixtas
      Crear_Grafo;   
      -- Dibujamos los objetos, las celdas y el grafo
      Dibujar_Cespacio(Particion, Grafo=> true);  
    
      -- Borramos el historial de otras busquedas de celdas expandidas y visitadas.
      for i in 1..CESP.Celdas.N loop 
        CESP.Celdas.elem(i).expandida := false;
        CESP.Celdas.elem(i).visitada  := false;
      end loop;
     
      -- Buscar un camino en el grafo con celdas libres optimizando
      -- la longitud de la trayectoria
      Buscar_nivel(Origen, Destino, Camino, VACIA);
      
      put("Nodos expandidos: "); put(nodos_expandidos, 0); new_line;
      nodos_totales := 0; nodos_expandidos := 0;
      
      if (Camino.n > 0) then
        put_line("Resuelto con celdas libres!!!!!!");
        Colores(G, "blue");
        put("Longitud del camino: "); put(Camino.n, 0); new_line;
	Recorrer_Camino(Camino, celda_fin, Origen, Destino);
        Poligonal(G, Camino, Cerrada=> false, Con_Puntos=> true);        
        Dejar_Grafica(G);
        exit;
      else
        Put_line("No se ha encontrado camino con celdas libres (VACIAS)");
        Put_line("Buscando camino con celdas libres y mixtas"); 
	-- Borramos el historial de otras busquedas de celdas expandidas y visitadas.
        for i in 1..CESP.Celdas.N loop 
          CESP.Celdas.elem(i).expandida := false;
	  CESP.Celdas.elem(i).visitada  := false;
        end loop;   
	-- Buscar un camino en el grafo con celdas libres y mixtas 
        -- optimizando la longitud de la trayectoria
        -- Sirve para ver si puede que haya esperanza de alcanzar camino
	-- o no sera posible.     
        Buscar_nivel(Origen, Destino, Camino, MIXTA);
	put("Nodos expandidos: "); put(nodos_expandidos, 0); new_line;
        nodos_totales := 0; nodos_expandidos := 0;
        Dejar_Grafica(G); -- Para que no se bloquee
        if (Camino.n = 0) then
	  put_line("El problema no tiene solucion");
	  exit;
        else 
	  put_line("Hay camino con celdas libres y mixtas");
        end if;
      end if;
    end loop;
  end;
  
end;

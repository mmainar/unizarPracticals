---------------------------------------------------------------------
-- Fichero:   cespacio-busqueda.adb
-- Autor:     Marcos Mainar Lalmolda
-- Fecha:     13 de Mayo de 2009
-- Proposito: Solucion de la practica 2
---------------------------------------------------------------------

with Text_IO, ada.integer_text_IO, ada.float_text_IO;
use  Text_IO, ada.integer_text_IO, ada.float_text_IO;

Package body Cespacio.Busqueda is

  ini: integer; -- Indice de la celda origen (que contiene el punto origen).
  celda_sig_ini: integer; -- Indice de la celda siguiente a la inicial
  celda_ant_fin: integer; -- Indice de la celda anterior a la final

  
  function crear_nodo (celda: num_celda; coste: float) return Nodo is
  -- Crea un nodo
    n: Nodo;
  begin
    n.celda := celda;
    n.coste := coste;
    return n;
  end;
  
  
  function mayor(N1, N2: Nodo) return boolean is
  -- Funcion de ordenacion para la lista de nodos
  -- Ordena por f creciente
  begin
    return N1.coste < N2.coste;
  end;
  
  
  function igual(N1, N2: Nodo) return boolean is
  -- Funcion de igualdad para la lista de nodos
  -- 2 nodos son iguales si se corresponden con la misma celda
  begin
    return N1.celda = N2.celda;
  end;
 
 
  --function ordenar_asc is new Listas_Nodos.sort(mayor);
  function ordenar_asc is new Listas_Nodos.merge(mayor);
  procedure eliminar_iguales is new Listas_Nodos.delete(igual);
  

  procedure expandir_nodo(N: nodo; Nodos: in out Lista_nodos;
                        Nuevos: out lista_nodos; Destino: Punto ;
			etiqueta_max: tipo_etiqueta:= VACIA) is
    nuevo: nodo;
    c: num_celda;
    celda_a_expandir: Celda renames CESP.Celdas.elem(N.celda);	
    dist, recorrido: float;		
  begin
    put_line("Expandiendo nodo");
    Nuevos:= null ;
    celda_a_expandir.expandida := true;
    celda_a_expandir.visitada := true;

    -- Expandir el nodo teniendo en cuenta las celdas vecinas de la celda que corresponde al nodo N
    if (endp(celda_a_expandir.vecinas)) then put_line("La celda no tiene vecinas"); end if;
    while (More(celda_a_expandir.vecinas)) loop
      Pop(c, celda_a_expandir.vecinas);
      if ((CESP.Celdas.elem(c).etiqueta = etiqueta_max) or else (CESP.Celdas.elem(c).etiqueta = VACIA)) then
	if (CESP.Celdas.elem(c).expandida) then
          null; -- La celda ya estaba expandida, luego no se crea un nuevo nodo a expandir
	elsif (CESP.Celdas.elem(c).visitada) then
          -- La celda ya habia sido visitaba pero no expandida (estaba en Nodos)
	  put("La celda "); put(c, 0); put(" ya habia sido visitada"); new_line;
	  dist := distancia(CESP.Celdas.elem(c).centro, Destino);
          recorrido := CESP.Celdas.elem(N.celda).recorrido + distancia(CESP.Celdas.elem(N.celda).centro, CESP.Celdas.elem(c).centro);
	  if (dist + recorrido) < (CESP.Celdas.elem(c).distancia + CESP.Celdas.elem(c).recorrido) then
	    CESP.Celdas.elem(c).anterior := N.celda;
	    CESP.Celdas.elem(c).distancia := dist;
	    CESP.Celdas.elem(c).recorrido := recorrido;
	    -- Creamos nodo nuevo con el camino mejor que el original
	    nuevo := crear_nodo(c, CESP.Celdas.elem(c).distancia + CESP.Celdas.elem(c).recorrido);
	    -- Eliminar el nodo antiguo de la lista de nodos a expandir (lista de Nodos)
	    eliminar_iguales(nuevo, Nodos);
	    put("Borrado nodo: "); put(nuevo.celda,0); new_line;
	    -- Introducir el nodo con el camino mejor que el original en la lista de nodos a expandir (lista de Nodos)
	    push(nuevo, Nodos);
	  else -- Si el coste no es menor, no se hace nada
	    null;
	  end if;       
	else -- La celda no habia sido visitada ni expandida (no estaba en Nodos ni en cerrados)
          CESP.Celdas.elem(c).visitada := true;
          CESP.Celdas.elem(c).anterior := N.celda;
          CESP.Celdas.elem(c).distancia := distancia(CESP.Celdas.elem(c).centro, Destino);
	  put("Distancia celda actual al destino: "); put(CESP.Celdas.elem(c).distancia, 0, 3, 0); new_line;
	  put("Distancia recorrida hasta mi celda padre "); put(CESP.Celdas.elem(N.celda).recorrido); new_line;
	  CESP.Celdas.elem(c).recorrido := CESP.Celdas.elem(N.celda).recorrido + distancia(CESP.Celdas.elem(N.celda).centro, CESP.Celdas.elem(c).centro);
	  put("Distancia recorrida celda actual: "); put(CESP.Celdas.elem(c).recorrido, 0, 3, 0); new_line;
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
    -- Creo que aqui se podra usar merge en lugar de sort
    Nodos := ordenar_asc(Nodos, Nuevos);
    --Nodos := append(Nodos, Nuevos);
    -- Ordenar Nodos por minima distancia
   -- Nodos := ordenar_asc(Nodos);
  end reorganizar_nodos;


  procedure escribe_camino(n: in num_celda; Camino: in out Puntos) is
  -- Guarda en Camino los centros de las celdas que forman el camino solucion
  -- encontradas en la busqueda en orden inverso
  begin
    if (n /= CESP.Celdas.elem(ini).anterior) then
      Anadir(Camino, CESP.Celdas.elem(n).centro);
      escribe_camino(CESP.Celdas.elem(n).anterior, Camino); 
    end if;
  end;


  Procedure Buscar_Nivel(Origen, Destino: in Punto; Camino: in out Puntos;
			etiqueta_max: tipo_etiqueta:= VACIA) is
  -- Busca camino en la particion actual, considerando celdas VACIA..etiqueta_max

    Nodos, Nuevos: lista_nodos; -- Dadas de inicio (Nodos es la lista de Nodos)
    nodo_inicial, nodo_actual: Nodo;
    resuelto: boolean := false;
    estado_actual: Celda;
    nodos_totales, nodos_expandidos: integer := 0;
    -- Depuracion a partir de aqui
    nodo_depuracion: Nodo;
    aux: lista_nodos; 
    aux2: lista_num_celdas;
    lala: num_celda;
  begin
    ini:=1; -- Celda inicial (que contiene el punto origen o de inicio)
    Camino.n := 0;
    Nodos:= null;
    -- Creamos nodo inicial
    -- El nodo que ocupa la posicion 1 es la celda inicial global y por tanto no tiene vecinas
    -- Hay que empezar con el de la posicion 2
    ini := celda_que_contiene(Origen);
    put_line("Mostrando celdas vecinas de la celda inicial");
    aux2 := CESP.Celdas.elem(ini).vecinas;
    while (more(aux2)) loop
        pop(lala, aux2);
	put("Celda numero: "); put(lala, 0); new_line;
    end loop;
    put("ini vale: "); put(ini,0); new_line;
    CESP.Celdas.elem(ini).anterior := 0;
    CESP.Celdas.elem(ini).recorrido := 0.0; -- fr
    put("Centro celda ini: "); put(CESP.Celdas.elem(ini).centro); new_line;
    CESP.Celdas.elem(ini).distancia := distancia(Origen, Destino);
    put("Distancia al destino desde celda ini: "); put(CESP.Celdas.elem(ini).distancia, 0, 3, 0); new_line;
    nodo_inicial := crear_nodo(ini, CESP.Celdas.elem(ini).recorrido + CESP.Celdas.elem(ini).distancia);
    push(nodo_inicial, Nodos);
    while (more(Nodos) and not resuelto) loop
      -- Quitar primer elemento de Nodos
      pop(nodo_actual, Nodos);
      put("Nodo actual: "); put(nodo_actual.celda, 0); new_line;
      put("Coste: "); put(nodo_actual.coste, 0, 3, 0); new_line;
      estado_actual := CESP.Celdas.elem(nodo_actual.celda);
      if ((celda_que_contiene(Destino) = nodo_actual.celda) and 
          ((CESP.celdas.elem(nodo_actual.celda).etiqueta = etiqueta_max)
	   or else (CESP.Celdas.elem(nodo_actual.celda).etiqueta = VACIA))) then
        resuelto := true;
      else
	-- Aplicar los operadores
	put("Antes de expandir nodo: "); new_line;
	put("Lista de Nodos: "); new_line;
	put("Longitud lista de Nodos: "); put(length(Nodos),0); new_line;
	put("-------------------"); new_line;
	aux := Nodos; 	
	while (more(aux)) loop
	  pop(nodo_depuracion, aux);
	  put("Nodo: "); put(nodo_depuracion.celda, 0); new_line;
	  put("Coste: "); put(nodo_depuracion.coste, 0, 3, 0); new_line;
	end loop;
	put_line("------------------");
        expandir_nodo(nodo_actual, Nodos, nuevos, Destino, etiqueta_max);
	nodos_expandidos := nodos_expandidos + 1;
	put("Nodos expandidos: "); put(nodos_expandidos, 0); new_line;
	put("Despues de expandir nodo: "); new_line;
	put("Lista de nuevos: "); new_line;
	put("Longitud lista de nuevos: "); put(length(nuevos),0); new_line;
	aux := nuevos;
	while (more(aux)) loop
	  pop(nodo_depuracion, aux);
	  put("Nodo: "); put(nodo_depuracion.celda, 0); new_line;
	  put("Coste: "); put(nodo_depuracion.coste, 0, 3, 0); new_line;
	end loop;
	put_line("------------------------");
	reorganizar_nodos(Nodos, nuevos);	
	put("Despues de reorganizar nodos"); new_line;
	put("Lista de Nodos: "); new_line;
	put("Longitud lista de Nodos: "); put(length(Nodos),0); new_line;
	aux := Nodos;
	while (more(aux)) loop
	  pop(nodo_depuracion, aux);
	  put("Nodo: "); put(nodo_depuracion.celda, 0); new_line;
	  put("Coste: "); put(nodo_depuracion.coste, 0, 3, 0); new_line;
	end loop;
	put_line("----------------------");
      end if;
    end loop;
    put("Nodos totales: "); put(nodos_expandidos + length(Nodos), 0); new_line;
    if resuelto then
      -- Devolver el camino, estado_actual es el estado solucion
      put_line("Resuelto (en buscar_nivel)!!"); 
      escribe_camino(nodo_actual.celda, Camino);
      celda_ant_fin := CESP.Celdas.elem(nodo_actual.celda).anterior;
    else -- No se ha encontrado solucion
      put_line("No encontrada solucion en buscar_nivel"); 
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
    Dibujar_Cespacio(0) ;
    -- Para Cespacio1 basta con N_particion = 3
    -- Para Cespacio2 no hay solucion (hay que llegar a N_particion = 3 para saberlo)
    -- Para mapaseg N_particion = 
    for Particion in 1..N_particion loop
      put("Nivel de particion: "); put(Particion, 0); new_line;
      -- Parte todas las celdas mixtas y etiqueta las 4 hijas
      Partir_Mixtas;
      -- Construye el grafo de conectividad o adyacencia de las celdas
      -- vacias y mixtas
      Crear_Grafo;
    end loop;    
    -- Dibujamos los objetos, las celdas y el grafo
    Dibujar_Cespacio(N_particion, Grafo=> true);  
    -- Buscar un camino en el grafo con celdas libres optimizando
    -- la longitud de la trayectoria
    Buscar_nivel(Origen, Destino, Camino, VACIA);
  
    if Camino.n > 0 then
      put_line("Resuelto con celdas libres!!!!!!");
      Colores(G, "blue");
      -- Errorcillo: Sale repetido el punto inicial, quitarlo de Camino
      -- porque Recorrer_Camino lo pone
      put("Longitud del camino: "); put(Camino.n, 0); new_line;
      Poligonal(G, Camino, Cerrada=> false, Con_Puntos=> true);
      Recorrer_Camino(Camino, celda_ant_fin, Origen, Destino);
    else
      Put_line("No se ha encontrado camino con celdas libres (VACIAS)");
      Put_line("Buscando camino con celdas libres y mixtas");
      -- Buscar un camino en el grafo con celdas libres y mixtas 
      -- optimizando la longitud de la trayectoria
      -- Sirve para ver si hay esperanza de alcanzar camino, para saber
      -- si encontraremos solucion en sucesivas particiones o no sera posible.  
      -- Tenemos que hacer el bucle siguiente y volver a crear el grafo de 
      -- conectividad de las celdas vacias y mixtas para que esto funcione
      for i in 1..CESP.Celdas.N loop 
        CESP.Celdas.elem(i).expandida := false;
	CESP.Celdas.elem(i).visitada := false;
      end loop;
      Crear_Grafo;
      
      Buscar_nivel(Origen, Destino, Camino, MIXTA);
      if (Camino.n = 0) then
	put_line("El problema no tiene solucion");
      else put_line("Hay camino con celdas libres y mixtas");
      end if;
    end if;
  end;
  
end;

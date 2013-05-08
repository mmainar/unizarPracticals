---------------------------------------------------------------------
-- Fichero:   cespacio.ads
-- Autor:     J.D.Tardos
-- Version:   v1.1 7-4-2000
-- Proposito: Paquete para busqueda de trayectorias sin colision
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 6-4-2000
--   - Añadidos comentarios en algunas funciones
---------------------------------------------------------------------

with Geometria, Graficas, Listas, Vectores ;
use  Geometria, Graficas ;
Package cespacio is 

---------------------------------------------------------------
-- Operaciones para obtener los obstaculos del C-Espacio
---------------------------------------------------------------

  function  Engordar(R: Recta;  radio: float) return Objeto4 ;
  procedure Engordar(R: Rectas; radio: float; Objetos: in out Objetos4) ;

---------------------------------------------------------------
-- una Lista_restric representa que restricciones
-- de que objetos afectan (parten) a una Celda del C-espacio
---------------------------------------------------------------

  subtype num_Objeto is Natural ;

  type Vrestric is array (1..4) of boolean ;
  type Rest_obj is record  
    Objeto:  num_objeto ;
    Restric: Vrestric   ;
  end record ;

  Package Listas_Restric is new Listas(Rest_obj) ; use Listas_Restric ;
  subtype lista_restric is Listas_Restric.list ;

---------------------------------------------------------------
-- Celdas del C-espacio y sus operaciones 
---------------------------------------------------------------

  type tipo_etiqueta is (VACIA, MIXTA, LLENA, PARTIDA);
  
  subtype num_celda is Natural ;
  Package Listas_num_celdas is new Listas(num_celda, 400_000) ; 
  use Listas_num_celdas ;
  subtype lista_num_celdas is Listas_num_celdas.list ;
  type V4_celdas is array (1..4) of num_celda ;

  type Celda is record
    ----------------------------Datos obtenidos al partir las celdas
    xmin, xmax, ymin, ymax: float ;
    vertices: VPuntos(1..4) ;
    centro: Punto ;
    madre: num_celda ;
    hijas: V4_celdas ;
    ----------------------------Datos sobre la ocupacion de la celda
    etiqueta: tipo_etiqueta; -- Resultado del etiquetado
    restric: lista_restric ; -- Rest. que afectan a la celda
    ----------------------------Datos sobre el grafo de conectividad
    vecinas: lista_num_celdas; -- Vecinas Vacias y Mixtas
    ----------------------------Datos para la busqueda del camino
    anterior: num_celda ;    -- Celda desde la que he llegado a esta
    recorrido: float ;        -- Distancia ya recorrida
    distancia: float ;        -- Distancia en linea recta al destino
    visitada:  boolean ;      -- Ha sido ya visitada ?
    expandida: boolean ;      -- Ha sido ya expandida ?
  end record ;

  procedure crear_celda_inicial(xmin, xmax, ymin, ymax: float) ;
  -- Crea la celda global como MIXTA, y le asocia las restricciones de
  -- todas las rectas de todos los objetos

  function  Celda_que_contiene(P: Punto) return num_celda ;
  -- Busca en las celdas no partidas la que contiene el punto deseado
  -- Si no hay ninguna, devuelve 0. Es una operacion costosa.
  
  procedure Partir_Mixtas ;
  -- Parte todas las celdas Mixtas, y etiqueta las cuatro hijas
  -- utilizando el algoritmo estudiado en clase

  procedure Crear_Grafo ;
  -- Construye el grafo de conectividad de las celdas Vacias y Mixtas
  -- Como resultado, se actualizan las vecinas de cada celda
  
  procedure dibujar_cespacio(Particion: Integer := 0;
                            Grafo: boolean := false) ;
  -- Crea una nueva ventana y dibuja los objetos las celdas y 
  -- opcionalmente el grafo de conectividad del cespacio

  procedure Recorrer_Camino(Camino: in out Puntos; n: num_celda; 
                           Origen, Destino: Punto) ;
  -- Recorre el camino hacia atras desde la celda n, lo guarda en Camino
  -- y lo escribe por la pantalla

---------------------------------------------------------------
-- Nodos para la busqueda del camino 
---------------------------------------------------------------

  type Nodo is record
    Celda: num_celda ;
    coste: float ;
  end record ;

  Package Listas_Nodos is new Listas(Nodo) ; use Listas_Nodos ;
  subtype lista_nodos is Listas_Nodos.list ;


---------------------------------------------------------------
-- Variables globales 
---------------------------------------------------------------
  max_objetos: constant := 400 ;
  max_celdas: constant := 100_000 ;
  
  package Vectores_Celdas is new Vectores(Celda) ;
  subtype VCeldas  is Vectores_Celdas.Vector ;
  Subtype VLCeldas is Vectores_Celdas.Vector_Limitado ;


  type CESP_type is record
    Celdas:  VLCeldas(max_celdas) ;
    Objetos: Objetos4(max_objetos) ;
  end record ;
  
  CESP: CESP_type ;
  
  G: Grafica ;
 

end cespacio ;

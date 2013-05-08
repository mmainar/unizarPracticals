---------------------------------------------------------------------
-- Fichero:   cespacio-busqueda.ads
-- Autor:     J.D.Tardos, Luis Montano
-- Version:   v1.0 27-3-2000
-- Modificada: 15-4-2009
-- Proposito: Procedimiento de busqueda de trayectorias sin colision
--            Este fichero no debe modificarse
--            El fichero cespacio-busqueda.adb debe completarlo cada alumno
---------------------------------------------------------------------

Package Cespacio.Busqueda is

  Procedure Buscar_Camino(Origen, Destino: in Punto; Camino: in out
  Puntos; N_particion: in integer);
  -- Busca un camino sin colision desde el Origen hasta el Destino, hasta el
  -- nivel de partición N_particion
  -- Previamente debe haberse inicializado la variable global CESP para 
  -- que contenga los Objetos ya engordados (Obstaculos del C-Espacio),
  -- y debe haberse creado la celda inicial con  Crear_Celda_Inicial
  -- El Camino se devuelve en Camino. Si no se ha encontrado: Camino.n = 0

end ;

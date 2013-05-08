---------------------------------------------------------------------
-- Fichero:   p2test.adb
-- Autor:     J.D.Tardos
-- Version:   v1.2 11-5-2000
-- Proposito: Programa para probar la busqueda de trayectorias
---------------------------------------------------------------------
-- Uso:  p2test numero_test
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 7-4-2000
--   - Añadidas las opciones para linkar en merlin, solaris y Linux
-- v1.2, J.D.Tardos, 11-5-2000
--   - Sustituidas las opciones por el paquete externo configuracion
---------------------------------------------------------------------

with Cespacio, Cespacio.busqueda, Geometria, Graficas, Ada.Command_Line;
use  Cespacio, Cespacio.busqueda, Geometria, Graficas, Ada.Command_Line;
with Text_IO ; use Text_io ;
with Configuracion; use Configuracion;

Procedure p2test is

  package IIO is new Integer_IO(integer); use IIO ;

  P: Puntos(1000) ;
  R: Rectas(1000) ;
  Camino: Puntos(500) ;
  G1, G2: Grafica ;
  num_test: integer ;
  
  function leer_numero return integer is
    n, last: integer ;
  begin
    if Argument_count = 0 then
      return 0 ;
    else
      get(argument(1), n, last) ;
      return n ;
    end if ;
  end ;

begin
  num_test:= 3 ;
  case Leer_Numero is
  when 1 =>  -- Caso del Cespacio1  
    Leer(CESP.Objetos, PATH&"Cespacio1.dat");
    Crear_Celda_inicial(0.0, 8.0, 0.0, 8.0) ;
    Buscar_camino(Pun(3.0,1.0), Pun(3.0,7.0), Camino) ;
  when 2 =>  -- Caso del Cespacio1
    Leer(CESP.Objetos, PATH&"Cespacio2.dat");
    Crear_Celda_inicial(0.0, 8.0, 0.0, 8.0) ;
    Buscar_camino(Pun(1.0,1.0), Pun(7.0,7.0), Camino) ;
  when 3 =>  -- Caso del pasillo del CPS 
    Leer(R, PATH&"mapaseg.dat") ;
    G1:= Crear_Grafica("Mapa previo", -15.0, 10.0, -5.0, 20.0) ;
    Dibujar(G1, R) ;
    Engordar(R, 0.3, CESP.Objetos) ;
    Crear_Celda_inicial(-15.0, 10.0, -5.0, 20.0) ;
    Buscar_camino(Pun(-10.0, 0.0), Pun(5.0, 5.0), Camino) ;
  when others =>
    Leer(P, PATH&"laser23.dat") ;
    G1:= Crear_Grafica("Laser", -6.0, 6.0, -6.0, 6.0) ;
    Dibujar(G1, P) ;
    Dejar_Grafica(G1) ;
    Leer(R, PATH&"mapaseg.dat") ;
    G2:= Crear_Grafica("Mapa previo", -15.0, 10.0, -5.0, 15.0) ;
    Dibujar(G2, R) ;
    Dejar_Grafica(G2) ;
    return ;
  end case ;
  Put("pulse return"); skip_line; 
end ;

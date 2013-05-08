---------------------------------------------------------------------
-- Fichero:   trayecto.adb
-- Autores:   J.D.Tardos, L. Montano
-- Version:   v1.3 1-3-2002
-- Proposito: Programa para probar la busqueda de trayectorias
---------------------------------------------------------------------
-- Uso:  trayecto numero_test {x_ini y_ini x_fin y_fin N_particion}
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 7-4-2000
--   - Añadidas las opciones para linkar en merlin, solaris y Linux
-- v1.2, J.D.Tardos, 11-5-2000
--   - Sustituidas las opciones por el paquete externo configuracion
-- v1.3, J.D.Tardos, 1-3-2002
--   - Uso del paquete Textos
-- v1.4 L. Montano, 16-4-2009
--   - Añadidos argumentos de entrada de puntos inicial y final y nivel de
--     partición máxima
---------------------------------------------------------------------

with Cespacio, Cespacio.busqueda, Geometria, Graficas, Textos, Configuracion, 
     Text_IO, Ada.Integer_Text_IO;
use  Cespacio, Cespacio.busqueda, Geometria, Graficas, Textos, Configuracion, 
     Text_IO, Ada.Integer_Text_IO;

Procedure trayecto is

  P: Puntos(1000) ;
  R: Rectas(1000) ;
  Camino: Puntos(500) ;
  G1, G2: Grafica ;
  num_test: integer ;
  x_ini, y_ini, x_fin, y_fin:float;
  N_particion:integer;
  
begin
  num_test:= Argumento(1);
  x_ini:=Argumento(2); -- coordenadas de los puntos inicial y final
  y_ini:=Argumento(3);
  x_fin:=Argumento(4);
  y_fin:=Argumento(5);
  N_particion:=Argumento(6);
  
  case num_test is
  when 1 =>  -- Caso del Cespacio1  
    Leer(CESP.Objetos, PATH&"Cespacio1.dat");
    Crear_Celda_inicial(0.0, 8.0, 0.0, 8.0) ;
    Buscar_camino(Pun(3.0,1.0), Pun(3.0,7.0), Camino,5) ;
  when 2 =>  -- Caso del Cespacio1
    Leer(CESP.Objetos, PATH&"Cespacio2.dat");
    Crear_Celda_inicial(0.0, 8.0, 0.0, 8.0) ;
    Buscar_camino(Pun(1.0,1.0), Pun(7.0,7.0), Camino,5) ;
  when 3 =>  -- Caso del pasillo del CPS 
    Leer(R, PATH&"mapaseg.dat") ;
    G1:= Crear_Grafica("Mapa previo", -15.0, 10.0, -5.0, 20.0) ;
    Dibujar(G1, R) ;
    Engordar(R, 0.3, CESP.Objetos) ;
    Crear_Celda_inicial(-15.0, 10.0, -5.0, 20.0) ;
    Buscar_camino(Pun(x_ini, y_ini), Pun(x_fin, y_fin), Camino, N_particion) ;
  when others =>
    put_line("Uso:  trayecto numero_test (del 1 al 3)");
  end case ;
  Put("pulse return"); skip_line; 
end ;

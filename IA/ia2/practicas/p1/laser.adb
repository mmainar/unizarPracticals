---------------------------------------------------------------------
-- Fichero:   laser.adb
-- Autor:     Marcos Mainar Lalmolda
-- Version:   v1.0 11-3-2009
-- Proposito: Programa principal para realizar la segmentacion de 
--            rectas.
---------------------------------------------------------------------
-- Uso:  laser n
---------------------------------------------------------------------

with Geometria, Graficas, Textos, Configuracion, Text_IO, Segmentacion;
use  Geometria, Graficas, Textos, Configuracion, Text_IO, Segmentacion;

Procedure laser is

  n: integer;
  P: Puntos(500);
  R: Rectas(500);
  G1: Grafica;
  ejesP: ejes;
begin
  n := Argumento(1);
  if n > 0 and n <= 54 then
    Leer(P, PATH & "laser" & Texto(n) & ".dat");
    split_and_merge(P, R, 0.1, 0.06, 0.1);
    ejesP := Calcular_Ejes(P);
    G1:= Crear_Grafica("Laser"&Texto(n), ejesP.xmin, ejesP.xmax, ejesP.ymin, ejesP.ymax);
    Dibujar(G1, P);
    Dibujar(G1, R);
    Dejar_Grafica(G1);
  else -- Procesar todos los ficheros de datos proporcionados
    ejesP := Calcular_Ejes(P);
    G1:= Crear_Grafica("Laser"&Texto(n), ejesP.xmin, ejesP.xmax, ejesP.ymin, ejesP.ymax);
    for i in 1..54 loop
      Leer(P, PATH & "laser" & Texto(i) & ".dat");
      split_and_merge(P, R, 0.3, 0.055, 0.1);      
      Dibujar(G1, P);
      Dibujar(G1, R);
      Dejar_Grafica(G1);
    end loop;
  end if;
  put("pulse return"); skip_line; 
end;

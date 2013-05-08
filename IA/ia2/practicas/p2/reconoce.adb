---------------------------------------------------------------------
-- Fichero:   reconoce.adb
-- Autor:     Marcos Mainar Lalmolda
-- Version:   v1.0 25-3-2009
-- Proposito: Programa principal para realizar el reconocimiento con
--            rectas en 2D.
---------------------------------------------------------------------
-- Uso:  reconoce n
---------------------------------------------------------------------

with Textos, Configuracion, Text_IO, Segmentacion,
     Reconocimiento, reconocimiento.funciones, Geometria, Graficas;
use  Textos, Configuracion, Text_IO, Segmentacion,
     Reconocimiento, reconocimiento.funciones, Geometria, Graficas;

Procedure reconoce is

  n: integer;
  O, M: Rectas(1000);  -- Rectas de las observaciones y el modelo
  resul: Soluciones; -- Lista de soluciones
  ep: float := 0.1; -- Error
  ejesP: ejes;
  P: Puntos(500);
  G, G1, G2: Grafica;
begin
  n := Argumento(1);
  if (n > 0) and (n < 55) then    
    -- Cargar el fichero laser<n>.dat
    Leer(P, PATH & "laser" & Texto(n) & ".dat");
    -- Realizar la segmentacion en rectas de la practica anterior
    split_and_merge(P, O, 0.1, 0.06, 0.1);
    --ejesP := Calcular_Ejes(P);
    --G1:= Crear_Grafica("Laser"&Texto(n), ejesP.xmin, ejesP.xmax, ejesP.ymin, ejesP.ymax);
    --Dibujar(G1, P);
    --Dibujar(G1, O);
    --Dejar_Grafica(G1);
    -- Cargar como modelo el mapa contenido en el fichero mapaseg.dat
    Leer(M, PATH & "mapaseg.dat");
    --G2:= Crear_Grafica("Mapa previo", -15.0, 10.0, -5.0, 15.0);
    --Dibujar(G2, M);
    --Dejar_Grafica(G2);
    -- Intentar reconocer el objeto con las observaciones O y el modelo M
    --Reconocer(O, M, resul, ep);
    -- Mostrar los resultados del reconocimiento por pantalla
    Dibujar(O, M, resul, ep);
    put(resul, true);
  elsif ((n = -2) or (n = -4) or (n = -6)) then
    -- Cargar el fichero imagen<-n>.dat
    Leer(O, PATH & "imagen" & Texto(abs(n)) & ".dat");
    -- Cargo el fichero ele.dat que contiene el modelo
    Leer(M, PATH & "ele" & ".dat");
    --ejesP := Calcular_Ejes(M);
    --G1 := Crear_Grafica("Modelo", 0.0, 5.0, 0.0, 6.0);
    --Dibujar(G1, M);    
    --Dejar_Grafica(G1);
    --ejesP := Calcular_Ejes(O);
    --G2 := Crear_Grafica("Obser", 0.0, 5.0, 3.0, 6.0);
    --G2 := Crear_Grafica("Obser", ejesP.xmin, ejesP.xmax, ejesP.ymin, ejesP.ymax);
    --Dibujar(G2, O);
    --Dejar_Grafica(G2);
    -- Intentar reconocer el objeto con las observaciones O y el modelo M
    --Dibujar(O, M, resul, ep);
    Reconocer(O, M, resul, ep);
    -- Mostrar los resultados del reconocimiento por pantalla
    put (resul, true);
    Dibujar(O, M, resul, ep);
  else
    put("no existe el fichero"); new_line;
  end if;
  put("pulse return"); skip_line; 
end;

---------------------------------------------------------------------
-- Fichero:   segmentacion.adb
-- Autor:     Marcos Mainar Lalmolda
-- Version:   v1.0 11-3-2009
-- Proposito: Obtencion de rectas en un barrido del sensor laser
---------------------------------------------------------------------

with Graficas, Geometria, ada.float_text_IO, ada.text_IO, ada.integer_text_IO;
use  Graficas, Geometria, ada.float_text_IO, ada.text_IO, ada.integer_text_IO;


Package body Segmentacion is

 procedure split_and_merge(P: in Puntos; R: out Rectas;
                          salto_max, error_max, long_min: in float;
                          ajustando: boolean := false ) is
 -- Realiza la segmentacion de un barrido de puntos P del sensor laser
 -- obteniendo como resultado un conjunto de rectas R
 -- Parametros para el algoritmo de split_and_merge:
 --   salto_max: Si la distancia entre dos puntos consecutivos es mayor,
 --              se considera que pertenecen a rectas diferentes
 --   error_max: Distancia maxima de cada punto a su recta
 --   long_min:  Las rectas que no alcancen esta longitud, se descartan
 -- Si ajustando, las rectas se ajustaran por minimos cuadrados
 -- Si no, se calcularan a partir de los dos puntos extremos


   procedure split(p1, p2: integer) is
   -- Division recursiva de una cadena
   -- p1 y p2 son los indices en el vector de puntos P
   -- de los puntos inicial y final de un grupo o conjunto de puntos.
     dist, maxDist: float := 0.0;
     indiceP: integer;
     rs: recta;
   begin
     -- Recta que une los extremos de la cadena
     rs := Rec(P.elem(p1), P.elem(p2));
     -- Calculamos el punto que mas se separa de la recta rs
     for i in p1..p2 loop
       -- Distancia perpendicular del punto de indice i a la recta rs
       dist := distancia(P.elem(i), rs);
       if (dist > maxDist) then
         -- Actualizar maxDist y guardar indice del punto
         -- con maxima distancia
         indiceP := i; maxDist := dist;
       end if;
     end loop;
     if (maxDist > error_max) then
       -- Partimos la cadena por el punto que ocupa la posicion
       -- indice del vector de puntos P
       -- Chequeamos que no tengamos un solo punto
       if (p1 /= indiceP) then split(p1, indiceP); end if;
       if (indiceP /= p2) then split(indiceP, p2); end if;
     else -- No dividir
       -- Añadir la recta rs al vector de Rectas R
       Anadir(R, rs);
       --put("Recta "); put(R.n, 0); put(" desde punto "); put(p1, 0); 
       --put(" hasta "); put(p2, 0); new_line;
     end if;
   end;


   procedure merge(indiceRecta: integer) is
   -- Fusion de segmentos
   -- indiceRecta es el indice de la recta a chequear si se puede 
   -- fusionar con la recta adyacente de indice indiceRecta + 1.
     dist, dist2: float := 0.0;
     rf: Recta;
   begin
       -- Posible recta fusionada, rf
       rf := Rec(R.elem(indiceRecta).p1, R.elem(indiceRecta+1).p2);
       -- Calculamos la distancia dist entre la recta rf
       -- y el punto intermedio o comun a las rectas a chequear
       -- si se pueden fusionar.
       dist := distancia(R.elem(indiceRecta+1).p1, rf);
       -- Distancia entre el punto final de la primera recta y
       -- el punto inicial de la segunda recta.
       -- Sera = 0 si ambas rectas pertecenen al mismo grupo, cadena o contorno de puntos
       dist2 := distancia(R.elem(indiceRecta).p2, R.elem(indiceRecta+1).p1);
       -- Si la desviacion del punto mas alejado es menor que error_max
       -- entonces fusionar (comprobando que sean rectas del mismo grupo).
       if (dist < error_max) and (dist2 = 0.0) then
         put("Fusionando recta "); put(indiceRecta, 0); put(" con recta "); 
	 put(indiceRecta+1, 0); new_line;
         -- Modificamos la recta actual en el vector de Rectas R
         R.elem(indiceRecta) := rf;
         -- Movemos el resto de segmentos en el vector de Rectas
         for j in indiceRecta+1..R.n-1 loop
           R.elem(j) := R.elem(j+1);
         end loop;
         -- Hemos fusionado 2 rectas luego tenemos una recta menos de las que
         -- teniamos inicialmente en el vector de Rectas R
         R.n := R.n - 1;
         -- Si fusionamos comparo la recta fusionada con la siguiente.
         merge(indiceRecta);
       end if;
   end;


   procedure filtrar(indiceRecta: integer) is
   -- Eliminar segmentos muy cortos o con gradiente pequeño
   -- (las rectas de longitud inferior a long_min se deben eliminar).
   -- Filtramos si procede la recta de indice indiceRecta en el vector
   -- de rectas R.
   begin     
     if (indiceRecta in 1..R.n) then
       -- Comprobamos si la recta de indice indiceRecta debe 
       -- eliminarse por ser demasiado corta
       if (R.elem(indiceRecta).lon < long_min) then
         -- Eliminamos la recta de indice indiceRecta
         put("Eliminando recta de indice "); put(indiceRecta, 0); new_line;
         for j in indiceRecta..R.n-1 loop
           R.elem(j) := R.elem(j+1);
         end loop;
         -- Actualizamos el numero de rectas en el vector de rectas R
         if (R.n > 0) then R.n := R.n - 1 ; end if;
         -- La recta indiceRecta ahora sera la siguiente que habia
         -- en el vector de rectas R original.
         if (indiceRecta in 1..R.n) then filtrar(indiceRecta); end if;
       end if;
     end if;
   end;


   iniGrupo: integer := 1; -- Indice del punto inicial en el vector de puntos P
   G1, G2: Grafica; -- Graficas para mostrar los pasos intermedios de la segmentacion.
   longMin: float := 100.0;
   numGrupos: integer := 0;
   ejesR: ejes;
 begin
   -- Agrupar conjuntos de puntos vecinos
   for i in 1..P.n-1 loop
     if ((distancia(P.elem(i), P.elem(i+1))) > salto_max) then
       -- Los puntos i e i+1 pertenecen a rectas diferentes.
       -- No se admiten grupos de un solo punto
       if (iniGrupo /= i) then
         split(iniGrupo, i);
         iniGrupo := i+1;
         numGrupos := numGrupos + 1;
       else -- Ignorar ese punto para el futuro grupo
         iniGrupo := iniGrupo + 1;
       end if;
     end if;
   end loop;
   -- No se admiten grupos de un solo punto
   if (iniGrupo /= P.n) then
     split(iniGrupo, P.n);
     numGrupos := numGrupos + 1;
   else -- Ignorar ese punto para el futuro grupo
     iniGrupo := iniGrupo + 1;
   end if;
   put("Numero de grupos o conjuntos de puntos: "); put(numGrupos, 0); new_line;
   put("Numero de segmentos tras split: "); put(R.n, 0); new_line;

   -- Dibujamos paso intermedio split
   --ejesR := Calcular_Ejes(P);	 
   --G1 := Crear_Grafica("Split", ejesR.xmin, ejesR.xmax, ejesR.ymin, ejesR.ymax);
   --Dibujar(G1, P);
   --Dibujar(G1, R);
   --Dejar_Grafica(G1);

   -- Recorremos el vector de Rectas generado por Split
   -- Fusion de segmentos
   for i in 1..R.n-1 loop
     merge(i);
   end loop;
   put("Numero de segmentos tras merge: "); put(R.n,0); new_line;

   -- Dibujamos paso intermedio Merge
   --G2 := Crear_Grafica("Merge", ejesR.xmin, ejesR.xmax, ejesR.ymin, ejesR.ymax);
   --Dibujar(G2, P);
   --Dibujar(G2, R);
   --Dejar_Grafica(G2);

   -- Eliminamos segmentos muy cortos
   for i in 1..R.n loop
     filtrar(i);
   end loop;
   put("Numero de segmentos tras filtrar: "); put(R.n,0); new_line;
   -- Desde laser se dibujara la grafica del resultado final
 end;
end;
 

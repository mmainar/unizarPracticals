---------------------------------------------------------------------
-- Fichero:   reconocimiento.adb
-- Autor:     Marcos Mainar Lalmolda
-- Version:   v1.0 25-3-2009
-- Proposito: Reconocimiento de objetos 2D a partir de rectas
---------------------------------------------------------------------

with Geometria, Segmentacion, reconocimiento.funciones, ada.text_IO,
     ada.integer_text_IO;
use  Geometria, Segmentacion, reconocimiento.funciones, ada.text_IO,
     ada.integer_text_IO;

Package body reconocimiento is

  maxEmparejamientos: integer := 0;

  procedure Reconocer(Obser, Modelo: Rectas; Resul: out Soluciones; ep: float) is
  -- Procedimiento que reconoce un Modelo a partir de las rectas observadas,
  -- utilizando el algoritmo de busqueda de emparejamientos de Grimson
  -- Devuelve todas las soluciones posibles, ordenadas por numero de pares creciente    
  
    function mayor(L1, L2: Pares) return boolean is
    begin
      return L1.N > L2.N;
    end;
 
 
    function ordenar_des is new Listas_Soluciones.sort(mayor);
  
  
    function restr_unarias(p: Par) return boolean is
    -- p es un par de posible emparejamiento.
    -- Devuelve true si y solo si se cumple la restriccion
    -- unitaria de longitud.
    begin 
      if (Obser.elem(p.recta_observada).lon <= 
           (Modelo.elem(p.recta_modelo).lon + 2.0*ep))
        then return true;
        else return false;
      end if;	
    end;
    
    
    function restr_binarias(pp: integer; p: par; Sh: Pares) return boolean is
    -- pp es un indice del vector de Pares Sh
    -- p es un par de posible emparejamiento
    -- Devuelve true si y solo si se cumplen las restricciones binarias
    -- de angulo y distancias.
      ea1, ea2, titaObs, titaMod: float;
      angulo, distancias: boolean;
      distObs, distMod: intervalo;
    begin 
      -- Restriccion de angulo
      ea1 := (2.0 * ep) / Obser.elem(Sh.elem(pp).recta_observada).lon;
      ea2 := (2.0 * ep) / Obser.elem(p.recta_observada).lon;
      titaObs := reconocimiento.funciones.angulo(Obser.elem(Sh.elem(pp).recta_observada), 
      						  Obser.elem(p.recta_observada));
      titaMod := reconocimiento.funciones.angulo(Modelo.elem(Sh.elem(pp).recta_modelo),
                                                  Modelo.elem(p.recta_modelo));
      if ((diferencia(titaObs, titaMod)) <= (ea1 + ea2)) then
        angulo := true;
      else
        angulo := false;   
      end if;
            
      -- Restriccion de distancias
      distObs := reconocimiento.funciones.distancias(Obser.elem(Sh.elem(pp).recta_observada),
                                                      Obser.elem(p.recta_observada));
      distMod := reconocimiento.funciones.distancias(Modelo.elem(Sh.elem(pp).recta_modelo),
                                                      Modelo.elem(p.recta_modelo));	
      distancias := (distObs.min >= (distMod.min - 2.0 * ep)) and
      	            (distObs.min <= (distMod.max + 2.0 * ep)) and
		    (distObs.max >= (distMod.min - 2.0 * ep)) and
		    (distObs.max <= (distMod.max + 2.0 * ep));     		     
      	     
      return angulo and distancias;
      --return angulo;
      --return true;
    end;
  
    procedure busca_pares(Sh: Pares; indiceObser: integer) is
    -- indiceObser: indice de la observacion actual
    -- E: Observaciones que quedan por emparejar
    -- M: Caracteristicas del modelo a emparejar
    -- h: Hipotesis actual
    -- H: Hipotesis consistentes encontradas
    -- Sh: Emparejamientos actuales
      consistente, aceptar: boolean;
      T: Trans; -- Localizacion de las observaciones en el modelo
      p: Par;   -- Par actual
      Sh2: Pares; -- Variable para emparejamientos
    begin
      if (indiceObser <= Obser.n) then -- Buscar mas emparejamientos
        for m in 1..Modelo.n loop
	  p := (indiceObser, m);
	  if (restr_unarias(p)) then
	    aceptar := true;
	    for pp in 1..Sh.n loop
	      aceptar := restr_binarias(pp, p, Sh);
              exit when not aceptar;	      
	    end loop;
	    if aceptar then
	      Sh2 := Sh;
	      Anadir(Sh2, p);
              busca_pares(Sh2, indiceObser+1);
	    end if;
	  end if;    
        end loop;
	-- Optativo: Encontrar solo soluciones con el mayor numero posible
	-- de emparejamientos, recorriendo el menor numero de nodos posible.
	if ((Sh.n + Obser.n - indiceObser) >= maxEmparejamientos) then
	  busca_pares(Sh, indiceObser+1); -- Prueba con (e, *)
	end if;
      else -- Localiza y verifica la hipotesis
        if (Sh.n > 0) then -- Para evitar añadir "soluciones" sin pares
	                   -- ya que localizar las devuelve como consistentes
          localizar(Obser, Modelo, Sh, 0.1, T, consistente);
	  if consistente then
	    -- Añadir Sh a la lista de hipotesis consistentes encontradas Resul
	    maxEmparejamientos := Sh.n;
	    push(Sh, Resul); -- Con push se añade al principio de la lista
	    -- Pensar cuando ordenar la lista, si al final o insertar ya en la posicion
	    -- que le corresponda
	    -- Creo que mejor al final utilizando la funcion sort del modulo
	    -- de listas
	  end if;
	end if;
      end if;
    end;
    
    Sh: pares;
  begin -- de Reconocer
    busca_pares(Sh, 1);   
    -- Ordenar la lista de Resul    
    Resul := ordenar_des(Resul);
  end;
  
  
end;

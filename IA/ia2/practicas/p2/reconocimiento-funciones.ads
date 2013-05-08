--------------------------------------------------------------------------------
-- Fichero:   reconocimiento-funciones.adb
-- Autor:     J.D.Tardos
-- Version:   v1.1 10-5-2000
-- Proposito: Funciones para el calculo de restricciones para el reconocimiento
--------------------------------------------------------------------------------
-- Modificaciones:
-- v1.0, J.D.Tardos, 9-5-2000
--   - Version original. Localizacion con la media
-- v1.1, J.D.Tardos, 10-5-2000
--   - Localizacion con dos Filtros de Kalman
--   - Añadida verificacion de la consistencia al localizar
---------------------------------------------------------------------

package reconocimiento.funciones is

  type intervalo is record
    min, max: float;
  end record;

  function diferencia(tita1, tita2: float) return float;
  -- Calcula el valor absoluto de la diferencia entre dos angulos, de 0 a Pi
 
  function angulo(R1, R2: Recta; orientadas: boolean := true) return float ;
  -- Calcula el angulo entre dos rectas. 
  -- Si estan orientadas, el angulo va de -Pi a Pi.
  -- Si NO estan orientadas, va de 0 a Pi/2
  
  function distancias(R1, R2: recta) return intervalo ;
  -- Calcula las distancias minima y maxima entre dos puntos cualesquiera
  -- de los dos segmentos

  type Trans is record
    x, y, tita: float ;
  end record ;

  procedure Localizar(Obser, Modelo: Rectas; P: Pares; ep: float;
                    T: out Trans; consistente: out boolean);
  -- Calcula la localizacion de las observaciones en el modelo, y 
  -- verifica la consistencia conjunta de los pares


  procedure Dibujar(Obser, Modelo: Rectas; Solu: Soluciones; ep: float:= 0.1);
  -- Dibuja varias ventanas, con:
  --  - Las observaciones
  --  - El modelo a reconocer
  --  - Las soluciones de mayor numero de emparejamientos obtenidas

  Procedure Put(Solu: Soluciones; todas: boolean := false) ;
  -- Escribe las soluciones por pantalla
  
end reconocimiento.funciones;

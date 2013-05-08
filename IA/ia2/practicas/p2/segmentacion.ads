---------------------------------------------------------------------
-- Fichero:   segmentacion.ads
-- Autor:     J.D.Tardos
-- Version:   v1.0 5-4-2000
-- Proposito: Obtencion de rectas en un barrido del sensor laser
---------------------------------------------------------------------

with Geometria ;
use  Geometria ;
Package Segmentacion is

  procedure split_and_merge(P: in Puntos; R: out Rectas; 
  		           salto_max, error_max, long_min: in float;
		           ajustando: boolean := false ) ;
  -- Realiza la segmentacion de un barrido de puntos P del sensor laser
  -- obteniendo como resultado un conjunto de rectas R
  -- Parametros para el algoritmo de split_and_merge:
  --   salto_max: Si la distancia entre dos puntos consecutivos es mayor,
  --              se considera que pertenecen a rectas diferentes
  --   error_max: Distancia maxima de cada punto a su recta
  --   long_min:  Las rectas que no alcancen esta longitud, se descartan
  -- Si ajustando, las rectas se ajustaran por minimos cuadrados
  -- Si no, se calcularan a partir de los dos puntos extremos

end ;

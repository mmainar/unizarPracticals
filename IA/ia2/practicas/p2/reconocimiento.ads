---------------------------------------------------------------------
-- Fichero:   reconocimiento.ads
-- Autor:     J.D.Tardos
-- Version:   v1.0 4-5-2000
-- Proposito: Reconocimiento de objetos 2D a partir de rectas
---------------------------------------------------------------------

with Geometria, Vectores, Listas;
use  Geometria ;

package reconocimiento is

  type par is record
    recta_observada: positive ;
    recta_modelo   : positive ;
  end record ;  

  package Vectores_Pares is new Vectores(Par) ; use Vectores_Pares ;
  subtype Pares  is Vectores_Pares.Vector_Limitado(20) ;

  package Listas_Soluciones is new Listas(Pares); use Listas_Soluciones;
  subtype Soluciones is Listas_Soluciones.list;


  procedure Reconocer(Obser, Modelo: Rectas; Resul: out Soluciones; ep: float) ;
  -- Procedimiento que reconoce un Modelo a partir de las rectas observadas,
  -- utilizando el algoritmo de busqueda de emparejamientos de Grimson
  -- Devuelve todas las soluciones posibles, ordenadas por numero de pares creciente
  
end reconocimiento;

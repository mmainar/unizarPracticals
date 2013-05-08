-- Módulo de definición del tipo genérico "monticulo".
-- Sus valores son las colas de elementos con prioridad o montículos (heaps).
--
-- Versión: 2.0
-- Fecha: 19-XI-99
-- Autor: Javier Campos Laclaustra (jcampos@posta.unizar.es)
--
-- Las operaciones son (la especificación algebraica puede
-- encontrarse en la lección 19 de los apuntes):
--  (1) creaVacio: crea el montículo vacío;
--  (2) encola: añade un elemento al montículo;
--  (3) menor: observa el valor del menor elemento del montículo;
--  (4) decola: elimina el menor elemento del montículo;
--  (5) esVacio: detecta si el montículo es o no vacío;
--  (6) longitud: devuelve el número de elementos en el montículo.
--
-- Los parámetros del tipo genérico son:
--  (A) maxNum: máxima longitud prevista para el montículo;
--  (B) elemento: el tipo de los elementos del montículo;
--  (C) "<": función de comparación entre elementos.
--
generic
  maxNum: positive;
  with function "<"(e1,e2: in integer) return boolean;
package monticulos is
  type monticulo is limited private;
  type monticuloDinamico is limited private;
  procedure creaVacio(c:out monticulo);
  procedure encola(c:in out monticulo; e: in integer);
  function menor(c:monticulo) return integer;
  procedure decola(c:in out monticulo);
  function esVacio(c:monticulo) return boolean;
  function longitud(c:monticulo) return natural;
  procedure de_estatica_a_dinamica(me: in monticulo; md: out monticuloDinamico);
  procedure preOrden(d:monticuloDinamico);
  procedure pintar_arbol(d:in monticuloDinamico);
  procedure pintar_monticulo(c: in monticulo);
private
  type datos is array(1..maxNum) of integer;
  type monticulo is record
                      dato: datos;
                      num: integer range 0..maxNum;
                    end record;
  type nodo;
  type monticuloDinamico is access nodo;
  type nodo is record
                 dato: integer;
                 izq,der,padre: monticuloDinamico;
               end record;
end monticulos;

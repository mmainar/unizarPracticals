-- M�dulo de definici�n del tipo gen�rico "monticulo".
-- Sus valores son las colas de elementos con prioridad o mont�culos (heaps).
--
-- Versi�n: 2.0
-- Fecha: 19-XI-99
-- Autor: Javier Campos Laclaustra (jcampos@posta.unizar.es)
--
-- Las operaciones son (la especificaci�n algebraica puede
-- encontrarse en la lecci�n 19 de los apuntes):
--  (1) creaVacio: crea el mont�culo vac�o;
--  (2) encola: a�ade un elemento al mont�culo;
--  (3) menor: observa el valor del menor elemento del mont�culo;
--  (4) decola: elimina el menor elemento del mont�culo;
--  (5) esVacio: detecta si el mont�culo es o no vac�o;
--  (6) longitud: devuelve el n�mero de elementos en el mont�culo.
--
-- Los par�metros del tipo gen�rico son:
--  (A) maxNum: m�xima longitud prevista para el mont�culo;
--  (B) elemento: el tipo de los elementos del mont�culo;
--  (C) "<": funci�n de comparaci�n entre elementos.
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

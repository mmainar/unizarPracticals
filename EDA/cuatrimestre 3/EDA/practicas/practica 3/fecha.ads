-- AUTOR: Javier Campos Laclaustra
-- PROYECTO: m�dulo de declaraci�n del TAD fechas para la 
--           pr�ctica 2 del 06/07 de la asignatura de
--	         Estructuras de Datos y Algoritmos
-- FICHERO: /users2/EDA/salidas/fecha.ads
-- DESCRIPCION: Este TAD sirve para guardar fechas y tiene una
--		operaci�n generadora creafecha, tres operaciones
--		para obtener dia, mes y a�o de una fecha, y dos 
--		operaciones de comparaci�n, > y <

package fecha is
  type tpfecha is private;
  function creafecha(d,m,a: integer) return tpfecha;
  -- devuelve la fecha con dia d, mes m y a�o a
  function eldia(f:tpfecha) return integer;
  -- devuelve el dia de f
  function elmes(f:tpfecha) return integer;
  -- devuelve el mes de f
  function elanyo(f:tpfecha) return integer;
  -- devuelve el a�o de f
  function ">"(f1,f2:tpfecha) return boolean;
  -- devuelve cierto si f1 es posterior a f2
  function "<"(f1,f2:tpfecha) return boolean;
  -- devuelve cierto si f1 es anterior a f2
private
  type tpfecha is record
		  dia, mes, anyo:integer;
		end record;
end fecha;

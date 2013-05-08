-- AUTOR: Javier Campos Laclaustra
-- PROYECTO: módulo de declaración del TAD fechas para la 
--           práctica 2 del 06/07 de la asignatura de
--	         Estructuras de Datos y Algoritmos
-- FICHERO: /users2/EDA/salidas/fecha.ads
-- DESCRIPCION: Este TAD sirve para guardar fechas y tiene una
--		operación generadora creafecha, tres operaciones
--		para obtener dia, mes y año de una fecha, y dos 
--		operaciones de comparación, > y <

package fecha is
  type tpfecha is private;
  function creafecha(d,m,a: integer) return tpfecha;
  -- devuelve la fecha con dia d, mes m y año a
  function eldia(f:tpfecha) return integer;
  -- devuelve el dia de f
  function elmes(f:tpfecha) return integer;
  -- devuelve el mes de f
  function elanyo(f:tpfecha) return integer;
  -- devuelve el año de f
  function ">"(f1,f2:tpfecha) return boolean;
  -- devuelve cierto si f1 es posterior a f2
  function "<"(f1,f2:tpfecha) return boolean;
  -- devuelve cierto si f1 es anterior a f2
private
  type tpfecha is record
		  dia, mes, anyo:integer;
		end record;
end fecha;

-- AUTOR: Javier Campos Laclaustra
-- PROYECTO: módulo de implementación del TAD fechas para la 
--           práctica 2 del 06/07 de la asignatura de
--	         Estructuras de Datos y Algoritmos
-- FICHERO: /users2/EDA/salidas/fecha.adb
-- DESCRIPCION: Este TAD sirve para guardar fechas y tiene una
--		operación generadora creafecha, tres operaciones
--		para obtener dia, mes y año de una fecha, y dos 
--		operaciones de comparación, > y <

package body fecha is

  function creafecha(d,m,a: integer) return tpfecha is
  -- devuelve la fecha con dia d, mes m y año a
  f: tpfecha;
  begin
    f.dia:=d;
    f.mes:=m;
    f.anyo:=a;
    return f;
  end creafecha;

  function eldia(f:tpfecha) return integer is
  -- devuelve el dia de f
  begin
    return f.dia;
  end eldia;
  function elmes(f:tpfecha) return integer is
  -- devuelve el mes de f
  begin
    return f.mes;
  end elmes;
  function elanyo(f:tpfecha) return integer is
  -- devuelve el año de f
  begin
    return f.anyo;
  end elanyo;
    
  function ">"(f1,f2:tpfecha) return boolean is
  -- devuelve cierto si f1 es posterior a f2
  begin
    return (f1.anyo>f2.anyo) or ((f1.anyo=f2.anyo) and
(f1.mes>f2.mes)) or ((f1.anyo=f2.anyo) and (f1.mes=f2.mes) and
(f1.dia>f2.dia));
  end ">";

  function "<"(f1,f2:tpfecha) return boolean is
  -- devuelve cierto si f1 es anterior a f2
  begin
    return not((f1>f2) or (f1=f2));
  end "<";

end fecha;

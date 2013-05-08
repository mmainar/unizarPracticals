-- AUTOR: Javier Campos
-- PROYECTO: m�dulo de declaraci�n del TAD �rbolesDeDirectorios para la 
-- pr�ctica 5 de Estructuras de Datos y Algoritmos, curso 06/07

-- espec arbolesDeDirectorios
-- 	usa booleanos, cadenas, glistas(cadenas)
-- 	g�nero arbolDeDir
-- 	operaciones	
-- 		crearEstructura: cadena natural -> arbolDeDir
--		 	est�?: arbolDeDir cadena -> booleano
--		 	a�adeDirectorio: arbolDeDir cadena natural -> arbolDeDir
--		 	pwd: arbolDeDir -> cadena
--		 	cd: arbolDeDir cadena -> arbolDeDir
--		 	tienePadre: arbolDeDir -> booleano
--		 	cd..: arbolDeDir -> arbolDeDir
--		 	listado: arbolDeDir -> lista
--		 	tama�o: arbolDeDir -> natural
--		ecuaciones
--		...
-- fespec

with Ada.Strings.Unbounded, ustrings, glistas;
use Ada.Strings.Unbounded, ustrings;

package arbolesdedir is
	type arbolDeDir is private;
	
	package mislistas is new glistas(ustring);
	use mislistas;
	
	procedure crearEstructura(nombre:in ustring; tamano:in natural; d:out arbolDeDir);
	-- Post: d=crearEstructura(nombre,tamano) 

	function esta(d:arbolDeDir; nombre:ustring) return boolean;
	-- Post: devuelve est�?(d,nombre) 
	
	procedure anadeDirectorio(d:in out arbolDeDir; nombre:in ustring; tamano:in natural);
	-- Pre: not est�?(d,nombre) AND d=d0
	-- Post: d=a�adeDirectorio(d0,nombre,tamano) 
	
	procedure pwd(d:in arbolDeDir; path:out ustring);
	-- Post: path=pwd(d)
	
	procedure cd(d:in out arbolDeDir; nombre:in ustring);
	-- Pre: est�?(d,nombre) AND d=d0
	-- Post: d=cd(d0,nombre) 

	function tienePadre(d:arbolDeDir) return boolean;
	-- Post: devuelve tienePadre(d)
	
	procedure cdpp(d:in out arbolDeDir);
	-- Pre: tienePadre(d) AND d=d0
	-- Post: d=cd..(d0) 
	 
	procedure listado(d:in arbolDeDir; l:out lista);
	-- Post: l=listado(d)
	
	function tamano(d:arbolDeDir) return natural;
	-- Post: devuelve tama�o(d)
	
private

	type nodo;
	type ptnodo is access nodo;
	type arbolDeDir is 
		record
			raiz,posicion:ptnodo;
		end record;	
	type nodo is
		record
			valor:ustring;
			tamano:natural;
			primogenito,sighermano,padre:ptnodo;
		end record;	
end arbolesdedir;

-- AUTOR: AUTOR: Javier Campos
-- PROYECTO: módulo de declaración (por completar) del TAD árbolesDeDirectorios
-- para la práctica 6 de Estructuras de Datos y Algoritmos, curso 2006/07
-- FICHERO: /users2/EDA/entradas/arbolesDeDir2.ads

with Ada.Strings.Unbounded, ustrings, glistas;
use Ada.Strings.Unbounded, ustrings;

package arbolesdedir2 is
	type arbolDeDir is private;
	
	package mislistas is new glistas(ustring);
	use mislistas;
	
	procedure crearEstructura(nombre:in ustring; tamano:in natural; d:out arbolDeDir);
	-- Post: d=crearEstructura(nombre,tamano) 

	function esta(d:arbolDeDir; nombre:ustring) return boolean;
	-- Post: devuelve está?(d,nombre) 
	
	procedure anadeDirectorio(d:in out arbolDeDir; nombre:in ustring; tamano:in natural);
	-- Pre: not está?(d,nombre) AND d=d0
	-- Post: d=añadeDirectorio(d0,nombre,tamano) 
	
	procedure pwd(d:in arbolDeDir; path:out ustring);
	-- Post: path=pwd(d)
	
	procedure cd(d:in out arbolDeDir; nombre:in ustring);
	-- Pre: está?(d,nombre) AND d=d0
	-- Post: d=cd(d0,nombre) 

	function tienePadre(d:arbolDeDir) return boolean;
	-- Post: devuelve tienePadre(d)
	
	procedure cdpp(d:in out arbolDeDir);
	-- Pre: tienePadre(d) AND d=d0
	-- Post: d=cdpp(d0) 
	 
	procedure listado(d:in arbolDeDir; l:out lista);
	-- Post: l=listado(d)
	
	function tamano(d:arbolDeDir) return natural;
	-- Post: devuelve tamaño(d)
	
	function estaFichero(d:arbolDeDir; nombre:ustring) return boolean;
	-- Post: devuelve estáFichero?(d,nombre) 
	
	procedure anadeFichero(d:in out arbolDeDir; nombre:in ustring; tamano:in natural);
	-- Pre: (not estáFichero?(d,nombre)) AND (not está?(d,nombre)) AND d=d0
	-- Post: d=añadeFichero(d0,nombre,tamano) 

	procedure buscaFichero(d:arbolDeDir; nombre:ustring; path:out ustring);
	-- Post: path=buscaFichero(d,nombre)
	
	procedure borraFichero(d:in out arbolDeDir; nombre:in ustring);
	-- Post: d=borraFichero(d0,nombre) 

	procedure borraDirectorio(d:in out arbolDeDir; nombre:in ustring);
	-- Post: d=borraDirectorio(d0,nombre) 

	private
	...

end arbolesdedir2;



-- AUTORES: Ismael Saad García. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: módulo de implementacion del TAD árbolesDeDirectorios para la
--           práctica 5 de Estructuras de Datos y Algoritmos, curso 06/07
-- FICHERO: arbolesdedir.adb
-- DESCRIPCIÓN: Este TAD permite representar la estructura de todos los
--              subdirectorios de un disco y una posición dentro de esta
--              estructura. Presenta operaciones que permiten moverse dentro
--              de la estructura, modificarla y consultarla.
--
with Ada.Strings.Unbounded, ustrings, glistas;
use Ada.Strings.Unbounded, ustrings;

package body arbolesdedir is

  procedure crearEstructura(nombre:in ustring; tamano:in natural; d:out arbolDeDir) is
  -- Post: d=crearEstructura(nombre,tamano)
  begin
    d.raiz:=new nodo'(nombre,tamano,null,null,null);
    d.posicion:=d.raiz;
  end crearEstructura;


  function esta(d:arbolDeDir; nombre:ustring) return boolean is
  -- Post: devuelve está?(d,nombre)
    exito: boolean;
    aux: ptnodo;
  begin
    exito:=false;
    aux:=d.posicion.primogenito;
    while not exito and (aux/=null) loop
      exito:=(nombre=aux.valor);
      aux:=aux.sighermano;
    end loop;
    return exito;
  end esta;


  procedure anadeDirectorio(d:in out arbolDeDir; nombre:in ustring; tamano:in natural) is
  -- Pre: not está?(d,nombre) AND d=d0
  -- Post: d=añadeDirectorio(d0,nombre,tamano)
    aux: ptnodo;
  begin
    if (d.posicion.primogenito=null) then
      d.posicion.primogenito:=new nodo'(nombre,tamano,null,null,d.posicion);
    else
      aux:=d.posicion.primogenito;
      d.posicion.primogenito:=new nodo'(nombre,tamano,null,aux,d.posicion);
    end if;
  end anadeDirectorio;


  procedure pwd(d:in arbolDeDir; path:out ustring) is
  -- Post: path=pwd(d)
    aux: ptnodo;
  begin
    aux:=d.posicion; path:= null_unbounded_string;
    while (aux/=null) loop
      path:=aux.valor & path; -- &: concatenación de cadenas
      path:='/' & path;
      aux:=aux.padre;
    end loop;
  end pwd;


  procedure cd(d:in out arbolDeDir; nombre:in ustring) is
  -- Pre: está?(d,nombre) AND d=d0
  -- Post: d=cd(d0,nombre)
    aux: ptnodo;
  begin
    aux:=d.posicion.primogenito;
    while (aux.valor/=nombre) loop
      aux:=aux.sighermano;
    end loop;
    d.posicion:=aux;
  end cd;


  function tienePadre(d:arbolDeDir) return boolean is
  -- Post: devuelve tienePadre(d)
  begin
    return (d.posicion.padre/=null);
  end tienePadre;


  procedure cdpp(d:in out arbolDeDir) is
  -- Pre: tienePadre(d) AND d=d0
  -- Post: d=cd..(d0)
  begin
    d.posicion:=d.posicion.padre;
  end cdpp;


  procedure listado(d:in arbolDeDir; l:out lista) is
  -- Post: l=listado(d)
  
    procedure listadoBis(aux: in ptnodo; l: out lista) is
    --
      laux: lista;
    begin
      if (aux.sighermano=null) and (aux.primogenito=null) then 
        aniadeDch(l,aux.valor);
      elsif (aux.sighermano/=null) and (aux.primogenito=null) then 
        aniadeDch(l,aux.valor);
        listadoBis(aux.sighermano,laux);
        concatena(l,laux);
      elsif (aux.sighermano=null) and (aux.primogenito/=null) then
        aniadeDch(l,aux.valor);
        listadoBis(aux.primogenito,laux);        concatena(l,laux);
      elsif (aux.sighermano/=null) and (aux.primogenito/=null) then
        aniadeDch(l,aux.valor);      
        listadoBis(aux.primogenito,l); listadoBis(aux.sighermano,laux);
        concatena(l,laux);   
      end if;
    end listadoBis;
    
  begin
    creaVacia(l); aniadeDch(l,d.posicion.valor);
    if (d.posicion.primogenito/=null) then
      listadoBis(d.posicion.primogenito,l);
    end if;
  end listado;


  function tamano(d:arbolDeDir) return natural is
  -- Post: devuelve tamaño(d)
  
    function tamanoBis(aux: ptnodo) return natural is
    -- Post: devuelve el tamaño de un directorio
    begin
      if aux=null then return 0;      else return (aux.tamano+tamanoBis(aux.sighermano)+tamanoBis(aux.primogenito));
      end if;
    end tamanoBis;
    
  begin
    return (tamanoBis(d.posicion.primogenito)+d.posicion.tamano);
  end tamano;

end arbolesdedir;

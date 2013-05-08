--|:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE DECLARACION DEL TAD 'lista generica con acceso por posicion'
--|:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 31-X-96
--| Autor: Javier Campos

generic
  type elemento is private;
package glistas is

  type lista is limited private;

--| La especificacion puede encontrarse en el libro de la asignatura
--| ("Estructuras de Datos y Algoritmos", J. Campos, Ed. Prensas 
--|   Universitarias de Zaragoza, 1995.)
  
  procedure creaVacia(l:out lista);
  procedure aniadeIzq(e:in elemento; l:in out lista);
  procedure concatena(l1:in out lista; l2:in lista);
  procedure creaUnitaria(e:in elemento; l:out lista);
  procedure aniadeDch(l:in out lista; e:in elemento);
  procedure eliminaIzq(l:in out lista);
  procedure eliminaDch(l:in out lista);
  function observaIzq(l:in lista) return elemento;
  function observaDch(l:in lista) return elemento;
  function long(l:in lista) return natural;
  function esta(e:in elemento; l:in lista) return boolean;
  function esVacia(l:in lista) return boolean;
  procedure inser(l:in out lista; i:in positive; e:in elemento);
  procedure borra(l:in out lista; i:in positive);
  procedure modif(l:in out lista; i:in positive; e:in elemento);
  function observa(l:in lista; i:in positive) return elemento;
  function pos(e:in elemento; l:in lista) return positive;
  procedure asignar(nueva:out lista; vieja:in lista);
  procedure liberar(l:in out lista);

private

  type unDato;
  type ptUnDato is access unDato;
  type unDato is record
                   dato:elemento;
                   sig:ptUnDato;
                 end record;
  type lista is record
                  prim,ult:ptUnDato;
                  n:natural;
                end record;
end glistas;

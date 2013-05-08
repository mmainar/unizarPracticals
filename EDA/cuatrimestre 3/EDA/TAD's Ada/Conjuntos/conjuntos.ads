--|:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE DECLARACION DEL TAD 'conjunto generico'
--|:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 31-X-96
--| Autor: Javier Campos

generic
  type elemento is (<>);
package conjuntos is

  type conjunto is private;
  
--| La especificacion puede encontrarse en el libro de la asignatura
--| ("Estructuras de Datos y Algoritmos", J. Campos, Ed. Prensas 
--|   Universitarias de Zaragoza, 1995.)

  procedure vacio (A:out conjunto);
  function  esVacio (A:in conjunto) return boolean;
  procedure poner (e:in elemento; A:in out conjunto);
  procedure quitar (e:in elemento; A:in out conjunto);
  function  pertenece (e:in elemento; A:in conjunto) return boolean;
  procedure union (A,B:in conjunto; C:out conjunto);
  procedure interseccion (A,B:in conjunto; C:out conjunto);
  function  cardinal (A:in conjunto) return integer;
  
private

  type elementos is array(elemento) of boolean;
  type conjunto is
    record
      elmto:elementos;
      card:integer;
    end record;
	
end conjuntos;

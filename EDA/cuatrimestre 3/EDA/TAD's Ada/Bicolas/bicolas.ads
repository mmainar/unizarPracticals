--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE DECLARACION DEL TAD 'BICOLA GENERICA'
--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 31-X-96
--| Autor: Javier Campos


generic
  type elemto is private;
package bicolas is

  type bicola is limited private;

--| La especificacion es un subconjunto de la de las listas (lección 12 de apuntes)
  
  procedure creaVacia(b:out bicola);
  procedure agnadeIzq(e:in elemto; b:in out bicola);
  procedure agnadeDer(b:in out bicola; e:in elemto);
  procedure eliminaIzq(b:in out bicola);
  procedure eliminaDer(b:in out bicola);
  function observaIzq(b:in bicola) return elemto;
  function observaDer(b:in bicola) return elemto;
  function esVacia(b:in bicola) return boolean;
  function long(b:in bicola) return natural;
  procedure asigna(bout:out bicola; bin:in bicola);
  procedure libera(b:in out bicola);
  function "="(b1,b2:in bicola) return boolean;
  
private

  type unDato;
  type ptUnDato is access unDato;
  type unDato is record dato:elemto; sig,ant:ptUnDato; end record;
  type bicola is record izq,der:ptUnDato; n:natural; end record;
  
end bicolas;

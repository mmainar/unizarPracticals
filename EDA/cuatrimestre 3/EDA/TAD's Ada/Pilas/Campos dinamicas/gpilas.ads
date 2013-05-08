--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE DECLARACION DEL TAD 'PILA GENERICA'
--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 17-X-2005
--| Autor: Javier Campos
--| Modificación de la versión anterior: desapilar es ahora operación "total"

generic
  type elemto is private;
package gpilas is

  type pila is limited private;

--| Resumen:
--| 
--| El modulo 'gpilas' exporta el tipo abstracto de datos generico
--| "pila de datos de tipo 'elemto'", llamado 'pila'.
--| El tipo 'elemto' es uno cualquiera.
--|
--| La especificacion algebraica del TAD es la siguiente: 
--| 
--| espec gpilas
--|   usa booleanos, naturales
--|   parametro formal
--|     genero elemto
--|   fpf
--|   genero pila
--|   operaciones
--|             VACIA:     -> pila
--|             APILAR:    pila elemto -> pila
--|             DESAPILAR: pila -> pila
--|     parcial CIMA:      pila -> elemto
--|             VACIA?:    pila -> bool
--|             ALTURA:    pila -> nat
--|   dominios de definicion p:pila; e:elemto
--|     CIMA(APILAR(p,e))
--|   ecuaciones p:pila, e:elemto
--|     DESAPILAR(VACIA) = VACIA
--|     DESAPILAR(APILAR(p,e)) = p
--|     CIMA(APILAR(p,e)) = e
--|     VACIA?(VACIA) = VERDAD
--|     VACIA?(APILAR(p,e)) = FALSO
--|     ALTURA(VACIA) = 0
--|     ALTURA(APILAR(p,e)) = SUC(ALTURA(p))
--| fespec
--|
--| El modulo gpilas exporta el nombre del tipo, las operaciones especificadas
--| anteriormente y ademas:
--|
--|  * una operacion de asignacion ('asignar'),
--|  * sendas operaciones de comparacion de igualdad ('=') y 
--|    desigualdad ('/=') (esta ultima se crea implicitamente
--|    al crear la de igualdad),
--|  * una operacion de liberacion de memoria dinamica ocupada
--|    por una pila ('liberar').

  procedure crearVacia(p:out pila);
  --post: p=VACIA
  procedure apilar(p:in out pila; e:in elemto);
  --pre: p=p0
  --post: p=APILAR(p,e)
  procedure desapilar(p:in out pila);
  --pre: (p=p0)
  --post: p=DESAPILAR(p0)
  function cima(p:in pila) return elemto;
  --pre: (p=p0) and (p0/=VACIA)
  --post: cima(p0)=CIMA(p0)
  function esVacia(p:in pila) return boolean;
  --post: esVacia(p)=VACIA?(p)
  function altura(p:in pila) return natural;
  --post: altura(p)=ALTURA(p)
  procedure asignar(pout:out pila; pin:in pila);
  --post: pout=pin, duplicando la representacion en memoria
  function "="(p1,p2:in pila) return boolean;
  --post: p1=p2 si y solo si son iguales sus representaciones en memoria
  procedure liberar(p:in out pila);
  --post: p=VACIA, y ademas libera la memoria utilizada previamente por p

private

  type unDato;
  type ptDato is access unDato;
  type unDato is record
                   dato:elemto;
                   sig:ptDato;
                 end record;
  type pila is record
                 cim:ptDato;
                 alt:natural;
               end record;
end gpilas;

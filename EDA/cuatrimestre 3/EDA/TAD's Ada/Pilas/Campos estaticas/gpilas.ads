--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE DECLARACION DEL TAD 'PILA GENERICA' DE ALTURA LIMITADA
--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 07-X-2005
--| Autor: Javier Campos

generic
  maxaltura:positive;
  type elemto is private;
package gpilas is

  type pila is limited private;

--| Resumen:
--| 
--| El modulo 'gpilas' exporta el tipo abstracto de datos generico
--| "pila de datos de tipo 'elemto'", llamado 'pila'.
--| El tipo 'elemto' es uno cualquiera.
--| Como la representación de los valores es estática (basada en
--| un vector) la altura máxima de la pila está limitada por 'maxaltura'
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
--|             ESVACIA?:    pila -> bool
--|             ALTURA:    pila -> nat
--|   dominios de definicion p:pila; e:elemto
--|     CIMA(APILAR(p,e))
--|   ecuaciones p:pila, e:elemto
--|     DESAPILAR(VACIA) = VACIA
--|     DESAPILAR(APILAR(p,e)) = p
--|     CIMA(APILAR(p,e)) = e
--|     ESVACIA?(VACIA) = VERDAD
--|     ESVACIA?(APILAR(p,e)) = FALSO
--|     ALTURA(VACIA) = 0
--|     ALTURA(APILAR(p,e)) = SUC(ALTURA(p))
--| fespec
--|
--| El modulo gpilas exporta el nombre del tipo, las operaciones especificadas
--| anteriormente (con la limitación obvia de 'apilar' dada por 'maxaltura') y:
--|
--|  * una operacion de asignacion ('asignar'),
--|  * sendas operaciones de comparacion de igualdad ('=') y 
--|    desigualdad ('/=') (esta ultima se crea implicitamente
--|    al crear la de igualdad),

  procedure vacia(p:out pila);
  --post: p=VACIA
  procedure apilar(p:in out pila; e:in elemto; error:out boolean);
  --pre: p=p0
  --post: si ALTURA(p0)<maxaltura entonces p=APILAR(p0,e) y error=falso
  --      si no p queda igual y error=verdad
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
  --post: p1=p2 si y solo si son iguales las dos pilas almacenadas

private
  type tpDatos is array(1..maxaltura) of elemto;
  type pila is record
                 datos:tpDatos;
                 lacima:natural;
               end record;
end gpilas;

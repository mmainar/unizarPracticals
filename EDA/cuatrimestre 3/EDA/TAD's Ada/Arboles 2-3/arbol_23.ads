-- MODULO DE DECLARACION DEL TAD 'diccionario',
-- ALMACENADO EN UN ARBOL 2-3 (ARBOL B DE GRADO 3)
--
-- Version: 2.0
-- Fecha: 17-XI-99
-- Autor: Javier Campos Laclaustra (jcampos@posta.unizar.es)
--
-- Este módulo genérico implementa el TAD "tabla" (o "diccionario")
-- tal como está especificado en la lección 23 de los apuntes de
-- "Estructuras de Datos y Algoritmos". Por tanto, no se incluye aquí
-- su especificación algebraica.
--
-- En esencia, permite almacenar un conjunto de parejas formadas por
-- una "clave" y un "valor" (cuyos tipos son parámetros del módulo),
-- y realizar las operaciones básicas de inserción (teniendo en cuenta
-- que, puesto que la "clave" es única, la inserción de una "clave" ya
-- existente supone la modificación del "valor" asociado a la "clave";
-- borrado y búsqueda del "valor" asociado a una "clave".
--
-- La estructura de datos utilizada para almacenar el diccionario es
-- un árbol 2-3 (es decir, un árbol B de grado 3).
--
generic
  type tp_clave is private; --tipo de la "clave"
  type tp_valor is private; --tipo del "valor"
  with function "<"(izq,dch:tp_clave) return boolean; --rel. de orden
  with procedure put_clave(clave:in tp_clave); --escribe una "clave"
  with procedure put_valor(valor:in tp_valor); --escribe un "valor"
package arbol_23 is
  type a23 is limited private;
  -- permite almacenar en un árbol 2-3 en memoria dinamica un  
  -- diccionario de palabras junto con sus definiciones
  procedure vacio(a:out a23);
  -- devuelve un diccionario vacío
  procedure modificar(a:in out a23; 
                      clave:in tp_clave; valor:in tp_valor);
  -- inserta una nueva "clave" con su "valor" en el diccionario;
  -- si la "clave" ya estaba, actualiza su "valor";
  procedure borrar(a:in out a23; clave:in tp_clave);
  -- borra la "clave" (y su "valor") del diccionario;
  -- si la "clave" no estaba en el diccionario, lo deja igual
  procedure buscar(a:in a23; clave:in tp_clave; 
                   exito:out boolean; valor:out tp_valor);
  -- si la "clave" está en el diccionario devuelve su "valor" 
  -- (y "exito" es true);
  -- en caso contrario, "exito" toma el valor false
  function es_vacio(a:a23) return boolean;
  -- devuelve verdad si y sólo si el diccionario está vacío
  procedure asignar(aout:out a23; ain:in a23);
  function "="(a1,a2:in a23) return boolean;
  procedure liberar(a:in out a23);
  procedure listado(a:in a23);
private
  type tipoNodo is (hoja,interior);
  type nodo;
  type ptNodo is access nodo;
  type nodo(tipo:tipoNodo) is record
                                case tipo is
                                  when hoja => 
                                    clave:tp_clave; 
                                    valor:tp_valor;
                                  when interior => 
                                    pri,seg,ter:ptNodo;
                                    minseg,minter:tp_clave;
                                end case;
                              end record;
  type a23 is record
                numclaves:integer;
                nodos:ptNodo;
              end record;
end arbol_23;

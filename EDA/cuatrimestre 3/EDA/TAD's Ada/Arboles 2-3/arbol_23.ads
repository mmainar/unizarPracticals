-- MODULO DE DECLARACION DEL TAD 'diccionario',
-- ALMACENADO EN UN ARBOL 2-3 (ARBOL B DE GRADO 3)
--
-- Version: 2.0
-- Fecha: 17-XI-99
-- Autor: Javier Campos Laclaustra (jcampos@posta.unizar.es)
--
-- Este m�dulo gen�rico implementa el TAD "tabla" (o "diccionario")
-- tal como est� especificado en la lecci�n 23 de los apuntes de
-- "Estructuras de Datos y Algoritmos". Por tanto, no se incluye aqu�
-- su especificaci�n algebraica.
--
-- En esencia, permite almacenar un conjunto de parejas formadas por
-- una "clave" y un "valor" (cuyos tipos son par�metros del m�dulo),
-- y realizar las operaciones b�sicas de inserci�n (teniendo en cuenta
-- que, puesto que la "clave" es �nica, la inserci�n de una "clave" ya
-- existente supone la modificaci�n del "valor" asociado a la "clave";
-- borrado y b�squeda del "valor" asociado a una "clave".
--
-- La estructura de datos utilizada para almacenar el diccionario es
-- un �rbol 2-3 (es decir, un �rbol B de grado 3).
--
generic
  type tp_clave is private; --tipo de la "clave"
  type tp_valor is private; --tipo del "valor"
  with function "<"(izq,dch:tp_clave) return boolean; --rel. de orden
  with procedure put_clave(clave:in tp_clave); --escribe una "clave"
  with procedure put_valor(valor:in tp_valor); --escribe un "valor"
package arbol_23 is
  type a23 is limited private;
  -- permite almacenar en un �rbol 2-3 en memoria dinamica un  
  -- diccionario de palabras junto con sus definiciones
  procedure vacio(a:out a23);
  -- devuelve un diccionario vac�o
  procedure modificar(a:in out a23; 
                      clave:in tp_clave; valor:in tp_valor);
  -- inserta una nueva "clave" con su "valor" en el diccionario;
  -- si la "clave" ya estaba, actualiza su "valor";
  procedure borrar(a:in out a23; clave:in tp_clave);
  -- borra la "clave" (y su "valor") del diccionario;
  -- si la "clave" no estaba en el diccionario, lo deja igual
  procedure buscar(a:in a23; clave:in tp_clave; 
                   exito:out boolean; valor:out tp_valor);
  -- si la "clave" est� en el diccionario devuelve su "valor" 
  -- (y "exito" es true);
  -- en caso contrario, "exito" toma el valor false
  function es_vacio(a:a23) return boolean;
  -- devuelve verdad si y s�lo si el diccionario est� vac�o
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

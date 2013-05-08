-- MODULO DE DECLARACION DEL TAD 'diccionario',
-- ALMACENADO EN UN ARBOL BINARIO DE BUSQUEDA
--
-- Version: 1.0
-- Fecha: 16-XI-98
-- Autor: Javier Campos Laclaustra (jcampos@unizar.es)

with ada.strings.unbounded, ustrings;
use ada.strings.unbounded, ustrings;
package dicc is

  type diccionario is limited private;
  -- permite almacenar en memoria din�mica un diccionario de palabras junto con
  -- sus definiciones

  procedure vacio(d:out diccionario);
  procedure busca(d:in diccionario; palabra:in ustring; definicion:out ustring);
  procedure inserta(d:in out diccionario; palabra,definicion:in ustring);
  procedure borra(d:in out diccionario; palabra:in ustring);
  procedure asignar(dout:out diccionario; din:in diccionario);
  function "="(d1,d2:in diccionario) return boolean;
  procedure liberar(d:in out diccionario);
  -- las mismas operaciones que en la Pr�ctica 2

  procedure listado(d:in diccionario);
  -- Lista en pantalla, en orden alfab�tico, todas las palabras del diccionario
  -- junto con sus definiciones (dos l�neas por palabra: en la primera la propia
  -- palabra y en la segunda su definici�n)
  
  function esDic(a: diccionario) return boolean;

private
  type unDato;
  type ptDato is access unDato;
  type unDato is record
                   clave:ustring;
                   info:ustring;
                   izq,der:ptDato;
                 end record;
  type diccionario is record
                        numpal:integer;
                        datos:ptDato;
                      end record;

  -- el tipo diccionario se representar� en memoria din�mica como un �rbol
  -- binario de b�squeda utilizando la palabra como clave de b�squeda
end dicc;

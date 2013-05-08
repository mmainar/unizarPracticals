-- MODULO DE DECLARACION DEL TAD 'árbol binario',
-- con elementos de tipo entero en sus nodos.
-- Version: 1.0
-- Fecha: 10-XII-2006
-- Autor: Marcos Mainar Lalmolda 

package arbolesBinarios is

  type arbin is limited private;
  -- permite almacenar en memoria dinámica un diccionario de palabras junto con
  -- sus definiciones
  type colores is (rojo,negro);
  
  procedure vacio(a: out arbin);
  procedure plantar(n: in integer; c: in colores; ai, ad: in arbin; a: out arbin);
  function raiz(a: arbin) return integer;
  procedure subIzq(a: in arbin; ai: out arbin);
  procedure subDer(a: in arbin; ad: out arbin);
  function esVacio(a: arbin) return boolean;
  function esMonoDistante(N:integer; a: arbin) return boolean;
  function esRojinegro(a: in arbin) return boolean;

private
  type nodo;
  type arbin is access nodo;
  type nodo is record
                   dato: integer;
                   color: colores;
                   izq,der:arbin;
                 end record;
end arbolesBinarios;

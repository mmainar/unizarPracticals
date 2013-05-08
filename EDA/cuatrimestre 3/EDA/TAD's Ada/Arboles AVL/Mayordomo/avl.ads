-- AUTOR: Elvira Mayordomo Cámara
-- PROYECTO: módulo de declaración del
-- TAD arboles AVL (árboles binarios de búsqueda
-- casi equilibrados)
-- FICHERO: avl.ads
-- FECHA: 14-11-03
-- Especificación avl en fichero aparte

generic
    type elemento is private;
    with function "<="(Left, Right: elemento) return Boolean;
   with procedure put(e: elemento);
package avl is
type arbin is limited private;
-- coste en memoria: un árbol de n nodos ocupa O(n)

-- Los dos procedimientos que modifican el árbol,
-- insertar y borrar, mantienen siempre el factor
-- de equilibrio entre -1 y 1. Por tanto la altura
-- de un árbol de n nodos es O(log n)

procedure creaVacio(a:out arbin);
-- Post: a=aVacío
-- coste en tiempo O(1)
procedure insertar(a:in out arbin; e:in
elemento);
-- Pre: a=a0
-- Post: a=insertar(a0,e)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
function esta(a:arbin; e:elemento) return
boolean;
-- Post: esta(a,e)= está?(a,e)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
function min(a:arbin) return elemento;
-- Pre: not(esvacío(a))
-- Post: min(a)= min(a)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
function max(a:arbin) return elemento;
-- Pre: not(esvacío(a))
-- Post: max(a)= max(a)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
procedure borrar(a:in out arbin; e:in
elemento);
-- Pre: a=a0
-- Post: a=borrar(a0,e)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
procedure mostrar(a:in arbin);
-- Muestra por pantalla preorden y postorden
-- coste en tiempo: para un árbol de n nodos tarda
-- O(n)
private
type nodo;
type arbin is access nodo;
type nodo is
    record
        dato:elemento;
        izq,der,padre:arbin;
        altura:integer; -- es más fácil guardar la
        -- altura que el factor de equilibrio
    end record;
end avl; 

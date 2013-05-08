-- AUTOR: Elvira Mayordomo C�mara
-- PROYECTO: m�dulo de declaraci�n del
-- TAD arboles AVL (�rboles binarios de b�squeda
-- casi equilibrados)
-- FICHERO: avl.ads
-- FECHA: 14-11-03
-- Especificaci�n avl en fichero aparte

generic
    type elemento is private;
    with function "<="(Left, Right: elemento) return Boolean;
   with procedure put(e: elemento);
package avl is
type arbin is limited private;
-- coste en memoria: un �rbol de n nodos ocupa O(n)

-- Los dos procedimientos que modifican el �rbol,
-- insertar y borrar, mantienen siempre el factor
-- de equilibrio entre -1 y 1. Por tanto la altura
-- de un �rbol de n nodos es O(log n)

procedure creaVacio(a:out arbin);
-- Post: a=aVac�o
-- coste en tiempo O(1)
procedure insertar(a:in out arbin; e:in
elemento);
-- Pre: a=a0
-- Post: a=insertar(a0,e)
-- coste en tiempo: para un �rbol de n nodos tarda
-- O(log n)
function esta(a:arbin; e:elemento) return
boolean;
-- Post: esta(a,e)= est�?(a,e)
-- coste en tiempo: para un �rbol de n nodos tarda
-- O(log n)
function min(a:arbin) return elemento;
-- Pre: not(esvac�o(a))
-- Post: min(a)= min(a)
-- coste en tiempo: para un �rbol de n nodos tarda
-- O(log n)
function max(a:arbin) return elemento;
-- Pre: not(esvac�o(a))
-- Post: max(a)= max(a)
-- coste en tiempo: para un �rbol de n nodos tarda
-- O(log n)
procedure borrar(a:in out arbin; e:in
elemento);
-- Pre: a=a0
-- Post: a=borrar(a0,e)
-- coste en tiempo: para un �rbol de n nodos tarda
-- O(log n)
procedure mostrar(a:in arbin);
-- Muestra por pantalla preorden y postorden
-- coste en tiempo: para un �rbol de n nodos tarda
-- O(n)
private
type nodo;
type arbin is access nodo;
type nodo is
    record
        dato:elemento;
        izq,der,padre:arbin;
        altura:integer; -- es m�s f�cil guardar la
        -- altura que el factor de equilibrio
    end record;
end avl; 

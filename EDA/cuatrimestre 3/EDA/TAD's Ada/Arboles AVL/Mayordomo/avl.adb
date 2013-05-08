-- AUTOR: Elvira Mayordomo Cámara
-- PROYECTO: módulo de implementación del
-- TAD arboles AVL (árboles binarios de búsqueda
-- casi equilibrados)
-- FICHERO: avl.adb
-- FECHA: 14-11-03

with unchecked_deallocation;
with text_io;
use text_io;

package body avl is

procedure disponer is new unchecked_deallocation(nodo,arbin);

procedure reequilibrar(a:in arbin);
-- Pre: partiendo de un árbol AVL, 
-- uno de los hijos de la raiz a ha cambiado en altura
-- (sumando ó restando 1)
-- por lo que las alturas de a hacia arriba
-- deben ser recalculadas y posiblemente el árbol
-- reequilibrado.
-- Post: a tiene los mismos nodos y es
-- un AVL
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)

procedure creaVacio(a:out arbin) is
-- Post: a=aVacío
-- coste en tiempo O(1)
begin
a:=null;
end creaVacio;

procedure insertarrec(a,nuevodato:in out arbin) is
-- Pre: a=a0
-- Post: a=insertar(a0,e) pero sin reequilibrado
-- resultado devuelve el punto de inserción del
-- nuevo nodo.
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
begin
    if a=null then 
        a:=nuevodato;
    elsif (nuevodato.dato<=a.dato) then
        nuevodato.padre:=a;
        insertarrec(a.izq,nuevodato);
    else
        nuevodato.padre:=a; 
        insertarrec(a.der,nuevodato);
    end if;
end insertarrec;

procedure insertar(a:in out arbin; e:in elemento) is
-- Pre: a=a0
-- Post: a=insertar(a0,e)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
nuevodato: arbin;
begin
    nuevodato:=new nodo'(e,null,null,null,0);
    insertarrec(a,nuevodato);
    reequilibrar(nuevodato.padre);
end insertar;

function esta(a:arbin; e:elemento) return
boolean is
-- Post: esta(a,e)= está?(a,e)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
resultado: boolean;
begin
    resultado:=false;
    if a/=null then 
        if (a.dato = e) then resultado:=true;
        elsif (e<=a.dato) then
        resultado:=esta(a.izq,e);
        else resultado:=esta(a.der,e);
        end if;
    end if;
    return resultado;   
end esta;

function min(a:arbin) return elemento is
-- Pre: not(esvacío(a))
-- Post: min(a)= min(a)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
begin
    if a.izq=null then return a.dato;
    else return min(a.izq);
    end if;
end min;

function max(a:arbin) return elemento is
-- Pre: not(esvacío(a))
-- Post: max(a)= max(a)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
begin
    if a.der=null then return a.dato;
    else return max(a.der);
    end if;
end max;

procedure borrarrec(a:in out arbin; e:in
elemento; lugar:out arbin) is
-- Pre: a=a0
-- Post: a=borrar(a0,e) sin reequilibrar
-- lugar tiene al padre del borrado
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
aux:arbin; 
nuevaraiz:elemento;
begin
    if a/=null then 
        if (a.dato = e) then 
            if a.der=null and a.izq=null then
                aux:=a;
                lugar:=a.padre;                     
                a:=null;
                disponer(aux);
            elsif a.izq/=null then
                nuevaraiz:=max(a.izq);
                a.dato:=nuevaraiz;
                borrarrec(a.izq,nuevaraiz,lugar);
            else
                nuevaraiz:=min(a.der);
                a.dato:=nuevaraiz;
                borrarrec(a.der,nuevaraiz,lugar);   
            end if;
        elsif (e<=a.dato) then
            borrarrec(a.izq,e,lugar);
        else borrarrec(a.der,e,lugar);
        end if;
    end if;
end borrarrec;

procedure borrar(a:in out arbin; e:in
elemento) is
-- Pre: a=a0
-- Post: a=borrar(a0,e)
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
lugar:arbin; 
begin
    borrarrec(a,e,lugar);
    if lugar/=null then 
        reequilibrar(lugar);
    end if; 
end borrar;

function altura(a:arbin) return integer is
-- calcula la altura de a a partir de las de
-- a.izq y a.der
-- coste en tiempo O(1)
altizq,altder: integer;
begin
    if a=null then 
        return -1; 
    else
        if a.der/=null then
            altder:=a.der.altura;
        else
            altder:=-1;
        end if;
        if a.izq/=null then
            altizq:=a.izq.altura;
        else
            altizq:=-1;
        end if;
        return(1+integer'Max(altizq,altder));
    end if;
end altura;

function factorequilibrio(a:arbin) return integer is
-- calcula el factor de equilibrio de a 
-- coste en tiempo O(1)
begin
    if a=null then 
        return 0; 
    else
        return altura(a.der)-altura(a.izq);
    end if;
end factorequilibrio;

procedure rotacionSder(a:in out arbin) is
-- Pre: a/=null y a.izq/=null
-- Post: realiza una rotación simple a dcha
-- sobre a
-- coste en tiempo O(1)
NA, NB: nodo;
begin
    NA:=a.all;
    NB:=a.izq.all;
    a.dato:=NB.dato;
    a.der:=a.izq;
    a.der.padre:=a;
    a.izq:=NB.izq;
    if a.izq/=null then a.izq.padre:=a; end if;
    a.der.dato:=NA.dato;
    a.der.izq:=NB.der;
    if a.der.izq/=null then
        a.der.izq.padre:=a.der; 
    end if;
    a.der.der:=NA.der;
    if a.der.der/=null then
        a.der.der.padre:=a.der; 
    end if;
    a.der.altura:=altura(a.der);
    a.altura:=altura(a);
end rotacionSder;

procedure rotacionSizq(a:in out arbin) is
-- Pre: a/=null y a.der/=null
-- Post: realiza una rotación simple a izda
-- sobre a
-- coste en tiempo O(1)
NA, NB: nodo;
begin
    NA:=a.all;
    NB:=a.der.all;
    a.dato:=NB.dato;
    a.izq:=a.der;
    a.izq.padre:=a;
    a.der:=NB.der;
    if a.der/=null then a.der.padre:=a; end if;
    a.izq.dato:=NA.dato;
    a.izq.der:=NB.izq;
    if a.izq.der/=null then
        a.izq.der.padre:=a.izq; 
    end if;
    a.izq.izq:=NA.izq;
    if a.izq.izq/=null then
        a.izq.izq.padre:=a.izq; 
    end if;
    a.izq.altura:=altura(a.izq);
    a.altura:=altura(a);
end rotacionSizq;

procedure rotacionDder(a:in out arbin) is
-- Pre: a/=null, a.izq/=null y a.izq.der/=null
-- Post: realiza una rotación doble a dcha
-- sobre a
-- coste en tiempo O(1)
NA, NB, NC: nodo;
begin
    NA:=a.all;
    NC:=a.der.all;
    NB:=NC.izq.all;
    a.dato:=NB.dato;
    a.izq:=NC.izq;
    a.izq.padre:=a;
    a.izq.dato:=NA.dato;
    a.izq.izq:=NA.izq;
    if a.izq.izq/=null then
        a.izq.izq.padre:=a.izq; 
    end if;
    a.izq.der:=NB.izq;
    if a.izq.der/=null then
        a.izq.der.padre:=a.izq; 
    end if;
    a.der.izq:=NB.der;
    if a.der.izq/=null then
        a.der.izq.padre:=a.der; 
    end if;
    a.izq.altura:=altura(a.izq);
    a.der.altura:=altura(a.der);
    a.altura:=altura(a);
end rotacionDder;

procedure rotacionDizq(a:in out arbin) is
-- Pre: a/=null, a.der/=null y a.der.izq/=null
-- Post: realiza una rotación doble a izda
-- sobre a
-- coste en tiempo O(1)
NA, NB, NC: nodo;
begin
    NC:=a.all;
    NA:=a.izq.all;
    NB:=NA.der.all;
    a.dato:=NB.dato;
    a.der:=NA.der;
    a.der.padre:=a;
    a.der.dato:=NC.dato;
    a.der.izq:=NB.der;
    if a.der.izq/=null then
        a.der.izq.padre:=a.der; 
    end if;
    a.der.der:=NC.der;
    if a.der.der/=null then
        a.der.der.padre:=a.der; 
    end if;
    a.izq.der:=NB.izq;
    if a.izq.der/=null then
        a.izq.der.padre:=a.izq; 
    end if;
    a.izq.altura:=altura(a.izq);
    a.der.altura:=altura(a.der);
    a.altura:=altura(a);
end rotacionDizq;

procedure rotar(a:in out arbin) is
-- Pre: a=a0 es un árbol en el que la raiz tiene factor de
-- equilibrio +2 ó -2 y el resto de los nodos entre -1 y +1.
-- Post: a es un árbol AVL con los mismos
-- valores que a0 y altura(a)=altura(a0)-1
-- coste en tiempo O(1)
begin
    if factorequilibrio (a)=-2 then
        if factorequilibrio (a.izq)= 1 then
            rotacionDizq(a);
        else 
            rotacionSder(a);
        end if;
    else
        if factorequilibrio (a.der)= -1 then
            rotacionDder(a);
        else 
            rotacionSizq(a);
        end if;
    end if;                 
end rotar;

procedure reequilibrar(a:in arbin) is
-- uno de los hijos de a ha cambiado en altura
-- por lo que las alturas de a hacia arriba
-- deben ser recalculadas y posiblemente el árbol
-- reequilibrado.
-- coste en tiempo: para un árbol de n nodos tarda
-- O(log n)
aux: arbin;
fe: integer;
desequilibrado:boolean;
begin
    -- actualización de alturas
    aux:=a;
    desequilibrado:=false;  
    while aux/=null and not desequilibrado loop
        aux.altura:=altura(aux);
        fe:=factorequilibrio(aux);
        desequilibrado:=(fe=2) or(fe=-2);
        if not desequilibrado then aux:=aux.padre; end if;
    end loop;   
    if desequilibrado then rotar(aux); end if;
end reequilibrar;

procedure preOrden(a:in arbin) is
-- muestra por pantalla el preorden de a
begin 
    if a/=null then
        put(a.dato);
        preOrden(a.izq);
        preOrden(a.der);
    end if;
end preOrden;

procedure postOrden(a:in arbin) is
-- muestra por pantalla el preorden de a
begin 
    if a/=null then
        postOrden(a.izq);
        postOrden(a.der);
        put(a.dato);
    end if;
end postOrden;

procedure mostrar(a:in arbin) is
-- Muestra por pantalla preorden y postorden
begin
    put_line("El preorden es:");
    preOrden(a);
    put_line("");
    put_line("El postorden es:");
    postOrden(a);
    put_line("");
end mostrar;    

end avl; 

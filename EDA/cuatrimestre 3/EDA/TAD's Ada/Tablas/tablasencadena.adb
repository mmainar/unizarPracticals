-- AUTOR: Elvira Mayordomo C�mara
-- PROYECTO: m�dulo de implementaci�n del
-- TAD tablas hash encadenadas
-- FICHERO: tablasencadena.adb
-- FECHA: 14-12-02

with unchecked_deallocation;
package body tablasencadena is

procedure dispose is new unchecked_deallocation(nodo,ptNodo);

function localizar(t:tabla;c:tpClave) return ptNodo is
-- Est� funci�n devuelve un puntero a la posici�n de c en la tabla.
-- Si c no est�, devuelve null.
-- coste en tiempo O(1) en media
pos:integer;
aux:ptNodo;
begin
    pos:=h(c,max);
    aux:=t(pos);
-- El coste en tiempo de todas las operaciones depende de este while
    while (aux/=null and then aux.laClave/=c) loop
        aux:=aux.sig;
    end loop;   
    return aux;
end localizar;
 
procedure tablavacia(t:out tabla) is
-- Post: t=crearVac�a
-- coste en tiempo O(max)
begin
    for i in 0..max-1 loop
        t(i):=null;
    end loop;
end tablavacia;

 
function esta(t:tabla; c:tpClave) return boolean is
-- Post: esta(t,c)=est�(t,c)
-- coste en tiempo O(1) en media
aux: ptNodo;
begin
    aux:=localizar(t,c);
    return (aux/=null);
end esta;
        
 
procedure modificar(t:in out tabla; c:in tpClave; v: in tpValor) is
-- Pre: t=t0
-- Post: t=a�adir(t0,c,v)
-- coste en tiempo O(1) en media
aux: ptNodo;
pos : integer;
begin
    aux:=localizar(t,c);
    pos:=h(c,max) ;
    if  aux=null then
        -- a�ado un dato nuevo
        t(pos):=new nodo'(c,v,t(pos));          
    else 
        -- si ya estaba c modifico v
        aux.elValor:=v; 
    end if;
end modificar;

 
function consultar(t:tabla; c:tpClave) return tpValor is
-- Pre: est�(t,c)
-- Post: consulta(t,c)=elValor(t,c)
-- coste en tiempo O(1) en media
aux: ptNodo;
begin
    aux:=localizar(t,c);
    return aux.elValor;
end consultar;

 
procedure borrar(t:in out tabla; c:in tpClave) is
-- Pre: t=t0
-- Post: t=borrar(t0,c,v)
-- coste en tiempo O(1) en media
pos:integer;
aux,ant:ptNodo;
begin
    pos:=h(c,max);
    aux:=t(pos);
    if aux/=null and then aux.laClave=c then
    -- est� en la primera posici�n de una lista
        t(pos):=t(pos).sig;
        dispose(aux) ;
    else
        while (aux/=null and then aux.laClave/=c) loop
            ant:=aux;
            aux:=aux.sig;
        end loop;   
        if aux/=null then
        -- est� en aux
            ant.sig:=aux.sig;
            dispose(aux) ;
        end if;
    end if;
end borrar;
end tablasencadena;

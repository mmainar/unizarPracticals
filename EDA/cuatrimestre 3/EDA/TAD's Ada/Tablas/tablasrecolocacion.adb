-- AUTOR: Elvira Mayordomo Cámara
-- PROYECTO: módulo de implementación del
-- TAD tablas hash por recolocación
-- cuadrática
-- FICHERO: tablasrecolocacion.adb
-- FECHA: 14-12-02

package body tablasrecolocacion is

function localizar(t:tabla;c:tpClave) return integer is
-- recordad que 2n<= max y max primo. Si no no
-- se puede garantizar el funcionamiento
-- correcto de localizar

-- Está función devuelve la posición de c en la tabla t.
-- Si c no está, devuelve la posición donde se colocaría c por 
-- recolocación cuadrática.
-- Reaprovecha las posiciones borradas.

-- coste en tiempo O(1) en media
inicial,pos,i,libre:integer;
hayborradas:boolean;
 
begin
    inicial:=h(c,max);
    pos:=inicial;
    hayborradas:=false;
    i:=0;
-- El coste de todas las operaciones depende de este while
    while (((not t(pos).vacio) and t(pos).laclave/=c) 
    or t(pos).borrado) loop
        if t(pos).borrado then 
            hayborradas:=true;
            libre:=pos; 
        end if;
        i:= i+1;
        pos:=(inicial + i*i) mod max;
    end loop;
    
    -- Si no ha encontrado c, aprovecha las posiciones borradas 
    if (t(pos).laclave/=c or t(pos).vacio) and hayborradas then
        pos:=libre;
    end if; 
    return pos;
end localizar;
 
procedure tablavacia(t:out tabla) is
-- Post: t=crearVacía
-- coste en tiempo O(max)
begin
    for i in 0..max-1 loop
        t(i).vacio:=true;
        t(i).borrado:=false;
    end loop;
end tablavacia;

 
function esta(t:tabla; c:tpClave) return boolean is
-- Post: esta(t,c)=está(t,c)
-- coste en tiempo O(1) en media
pos: integer;
begin
    pos:=localizar(t,c);
    return (t(pos).laclave=c and (NOT t(pos).vacio));
end esta;
        
 
procedure modificar(t:in out tabla; c:in tpClave; v: in tpValor) is
-- Pre: t=t0
-- Post: t=añadir(t0,c,v)
-- coste en tiempo O(1) en media
pos: integer;
begin
    pos:=localizar(t,c);
    if  t(pos).vacio then
        -- añado un dato nuevo
        t(pos):=(c,v,false,false);          
    -- si ya estaba c modifico v
    elsif t(pos).laclave=c then 
            t(pos).elvalor:=v; 
    end if;
end modificar;

 
function consultar(t:tabla; c:tpClave) return tpValor is
-- Pre: está(t,c)
-- Post: consulta(t,c)=elValor(t,c)
-- coste en tiempo O(1) en media
pos: integer;
begin
    pos:=localizar(t,c);
    return t(pos).elvalor;
end consultar;

 
procedure borrar(t:in out tabla; c:in tpClave) is
-- Pre: t=t0
-- Post: t=borrar(t0,c,v)
-- coste en tiempo O(1) en media
pos: integer;
begin
    if esta(t,c) then 
        pos:=localizar(t,c);
        t(pos).borrado:=true;
        t(pos).vacio:=true;
    end if;
end borrar;



end tablasrecolocacion;

-- AUTOR: Elvira Mayordomo C�mara
-- PROYECTO: m�dulo de declaraci�n del
-- TAD tablas hash por recolocaci�n
-- cuadr�tica
-- FICHERO: tablasrecolocacion.ads
-- FECHA: 14-12-02
-- Especificaci�n tablasGen�ricas en fichero aparte

generic
    type tpClave is private;
    type tpValor is private;
    max: positive; -- usad tpValores de max que sean primos
    with function h(c:tpClave;tam:positive) return integer;
    -- h(c,max) devuelve un n�mero entre 0 y max-1
 
package tablasrecolocacion is
    type tabla is private;
    -- coste en memoria: una tabla de n datos
    -- ocupa O(max)
    
    -- el funcionamiento correcto y 
    -- los costes en tiempo de las operaciones s�lo est�n
    -- garantizados si 2n<=max
    
    procedure tablavacia(t:out tabla);
    -- Post: t=crearVac�a
    -- coste en tiempo O(max)
    function esta(t:tabla; c:tpClave) return boolean;
    -- Post: esta(t,c)=est�(t,c)
    -- coste en tiempo O(1) en media
    procedure modificar(t:in out tabla; c:in tpClave; v: in tpValor);
    -- Pre: t=t0
    -- Post: t=a�adir(t0,c,v)
    -- coste en tiempo O(1) en media
    function consultar(t:tabla; c:tpClave) return tpValor;
    -- Pre: est�(t,c)
    -- Post: consulta(t,c)=elValor(t,c)
    -- coste en tiempo O(1) en media
    procedure borrar(t:in out tabla; c:in tpClave);
    -- Pre: t=t0
    -- Post: t=borrar(t0,c,v)
    -- coste en tiempo O(1) en media
 
private
    type dato is 
        record
            laclave:tpClave;
            elvalor:tpValor;
            vacio:boolean;
            borrado:boolean;
        end record;
    type tabla is array(integer range 0..max-1) of dato;    
end tablasrecolocacion;

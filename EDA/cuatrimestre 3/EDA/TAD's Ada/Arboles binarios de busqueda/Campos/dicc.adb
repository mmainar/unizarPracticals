-- MODULO DE IMPLEMENTACION DEL TAD 'diccionario',
-- ALMACENADO EN UN ARBOL BINARIO DE BUSQUEDA
--
-- Version: 1.0
-- Fecha: 16-XI-98
-- Autor: Javier Campos Laclaustra (jcampos@unizar.es)

with ada.strings.unbounded, ustrings, unchecked_deallocation;
use ada.strings.unbounded, ustrings;
package body dicc is

  procedure disponer is new unchecked_deallocation(unDato,ptDato);

  procedure vacio(d:out diccionario) is
  begin
    d.numpal:=0;
    d.datos:=null;
  end vacio;

  procedure busca_rec(p:in ptDato; palabra:in ustring; definicion:out ustring) is
  -- es la busqueda en el arbol (la pongo aqui porque se usa tambien en "="
  begin
    if palabra=p.clave then  --palabra encontrada
      definicion:=p.info;
    elsif palabra<p.clave then  --buscar en subarbol izquierdo
      busca_rec(p.izq,palabra,definicion);
    else  --buscar en subarbol derecho
      busca_rec(p.der,palabra,definicion);
    end if;
  end busca_rec;

  procedure busca(d:in diccionario; palabra:in ustring; definicion:out ustring) is
  begin
    if d.numpal=0 then  --diccionario vacio
      definicion:=null_unbounded_string;
    else  --diccionario no vacio
      busca_rec(d.datos,palabra,definicion);
    end if;
  end busca;

  procedure inserta(d:in out diccionario; palabra,definicion:in ustring) is

    flag:boolean;

    procedure inserta_rec(p:in out ptDato; palabra,definicion:in ustring; 
                          flag:out boolean) is
    begin
      if p=null then  --diccionario vacio
        p:=new unDato;
        p.clave:=palabra;
        p.info:=definicion;
        p.izq:=null;
        p.der:=null;
        flag:=true;
      else  --diccionario no vacio
        if palabra=p.clave then  --palabra encontrada
          p.info:=definicion; flag:=false;
        elsif palabra<p.clave then  --insertar en subarbol izquierdo
          inserta_rec(p.izq,palabra,definicion,flag);
        else  --insertar en subarbol derecho
          inserta_rec(p.der,palabra,definicion,flag);
        end if;
      end if;
    end inserta_rec;

  begin
    inserta_rec(d.datos,palabra,definicion,flag);
    if flag then d.numpal:=d.numpal+1; end if;
  end inserta;

  procedure max(p:in ptDato; palabra,definicion:out ustring) is
  --precondicion: p es no nulo
  --devuelve la ultima palabra (en orden alfabetico) y su definicion del arbol p
  begin
    if p.der=null then  --si no hay subarbol derecho, la raiz es la ultima
      palabra:=p.clave;
      definicion:=p.info;
    else  --si hay subarbol derecho es la ultima del subarbol derecho
      max(p.der,palabra,definicion);
    end if;
  end max;

  procedure borra(d:in out diccionario; palabra:in ustring) is

    flag:boolean;

    procedure borra_rec(p:in out ptDato; palabra:in ustring; flag:in out boolean) is
      aux:ptdato;
    begin
      if p/=null then  --solo hay que borrar si es no vacio
        if palabra<p.clave then  --borrar en el subarbol izquierdo
          borra_rec(p.izq,palabra,flag);
        elsif palabra>p.clave then  --borrar en el subarbol derecho
          borra_rec(p.der,palabra,flag);
        else  --borra la raiz
          if p.izq=null then  --no tiene hijo izq, luego es facil borrar
            aux:=p;
            p:=p.der;
            disponer(aux);
            flag:=true;
         else  --hay que sustituirlo por el maximo del subarbol izquierdo
            max(p.izq,p.clave,p.info);
            borra_rec(p.izq,p.clave,flag);
         end if;
        end if;
      else
        flag:=false;
      end if;
    end borra_rec;

  begin
    borra_rec(d.datos,palabra,flag);
    if flag then d.numpal:=d.numpal-1; end if;
  end borra;

  procedure asignar(dout:out diccionario; din:in diccionario) is

    procedure asignar_rec(pout:out ptDato; pin:in ptDato) is
      ai,ad:ptDato;
    begin
      if pin=null then  --es vacio
        pout:=null;
      else  --arbol no vacio
        asignar_rec(ai,pin.izq);
        asignar_rec(ad,pin.der);
        pout:=new unDato;
        pout.clave:=pin.clave;
        pout.info:=pin.info;
        pout.izq:=ai;
        pout.der:=ad;
      end if;
    end asignar_rec;

  begin
    dout.numpal:=din.numpal;
    asignar_rec(dout.datos,din.datos);
  end asignar;

  function "="(d1,d2:in diccionario) return boolean is

    function eq_rec(p1,p2: ptDato) return boolean is
      def:ustring; aux:boolean;
    begin
      if p1=null then
        return true;
      else
        busca_rec(p2,p1.clave,def);
        if def/=p1.info then
          return false;
        else
          aux:=eq_rec(p1.izq,p2);
          if not aux then
            return false;
          else
            aux:=eq_rec(p1.der,p2);
            return aux;
          end if;
        end if;
      end if;
    end eq_rec;

  begin
    if d1.numpal/=d2.numpal then
      return false;
    else
      return eq_rec(d1.datos,d2.datos);
    end if;
  end "=";

  procedure liberar(d:in out diccionario) is

    procedure liberar_rec(p:in out ptDato) is
    begin
      if p/=null then  --hay algo que liberar
        liberar_rec(p.izq);
        liberar_rec(p.der);
        disponer(p);
        p:=null;
      end if;
    end liberar_rec;

  begin
    liberar_rec(d.datos);
    d.numpal:=0;
  end liberar;

  procedure listado(d:in diccionario) is

    procedure listado_rec(p:in ptDato) is
    begin
      if p/=null then  --hay algo que listar
        listado_rec(p.izq);
        put_line(p.clave);
        put_line(p.info);
        listado_rec(p.der);
      end if;
    end listado_rec;

  begin
    listado_rec(d.datos);
  end listado;
  
  function esDic(a: diccionario) return boolean is
  
    function esABB(a: ptdato) return boolean is
    begin
      if (a/=null) then
        if (a.izq/=null) and (a.der/=null) then
          return ((a.clave>=a.izq.clave) and (a.clave<a.der.clave)
                and (esABB(a.izq)) and (esABB(a.der)));
        else return true;
        end if;
      else return true;
      end if;
    end esABB;
  begin
    return esABB(a.datos);
  end esDic;


end dicc;

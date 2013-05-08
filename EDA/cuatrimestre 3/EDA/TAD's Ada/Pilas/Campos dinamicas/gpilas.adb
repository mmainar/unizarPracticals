--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE IMPLEMENTACION DEL TAD 'PILA GENERICA'
--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.1
--| Fecha: 17-X-2005
--| Autor: Javier Campos
--| Modificación de la versión anterior: desapilar es ahora operación "total"

with unchecked_deallocation;
package body gpilas is

  procedure disponer is new unchecked_deallocation(unDato,ptDato);
  
  procedure crearVacia(p:out pila) is
  begin
    p.cim:=null;
    p.alt:=0;
  end crearVacia;
  
  procedure apilar(p:in out pila; e:in elemto) is
    aux:ptDato;
  begin
    aux:=p.cim;
    p.cim:=new unDato;
    p.cim.dato:=e;
    p.cim.sig:=aux;
    p.alt:=p.alt+1;
  end apilar;
  
  procedure desapilar(p:in out pila) is
    aux:ptDato;
  begin
    if p.cim/=null then
      aux:=p.cim;
      p.cim:=p.cim.sig;
      disponer(aux);
      p.alt:=p.alt-1;
    end if;
  end desapilar;
  
  function cima(p:in pila) return elemto is
  begin
    return p.cim.dato;
  end cima;
  
  function esVacia(p:in pila) return boolean is
  begin
    return p.cim=null;
  end esVacia;

  function altura(p:in pila) return natural is
  begin
    return p.alt;
  end altura;

  procedure asignar(pout:out pila; pin:in pila) is
    ptout,ptin:ptDato;
  begin
    if esVacia(pin) then
      crearVacia(pout);
    else
      ptin:=pin.cim;
      pout.cim:=new unDato;
      pout.cim.dato:=ptin.dato;
      ptout:=pout.cim;
      ptin:=ptin.sig;
      while ptin/=null loop
        ptout.sig:=new unDato;
        ptout:=ptout.sig;
        ptout.dato:=ptin.dato;
        ptin:=ptin.sig;
      end loop;
      ptout.sig:=null;
      pout.alt:=pin.alt;
    end if;
  end asignar;

  function "="(p1,p2:in pila) return boolean is
    pt1,pt2:ptDato;
    iguales:boolean:=true;
  begin
    if p1.alt/=p2.alt then
      return false;
    else
      pt1:=p1.cim;
      pt2:=p2.cim;
      while pt1/=null and iguales loop
        iguales:=pt1.dato=pt2.dato;
        pt1:=pt1.sig;
        pt2:=pt2.sig;
      end loop;
      return iguales;
    end if;
  end "=";

  procedure liberar(p:in out pila) is
    aux:ptDato;
  begin
    aux:=p.cim;
    while aux/=null loop
      p.cim:=p.cim.sig;
      disponer(aux);
      aux:=p.cim;
    end loop;
    p.alt:=0;
  end liberar;

end gpilas;

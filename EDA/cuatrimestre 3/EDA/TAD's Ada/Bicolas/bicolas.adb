--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE IMPLEMENTACION DEL TAD 'BICOLA GENERICA'
--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 31-X-96
--| Autor: Javier Campos

with unchecked_deallocation;
package body bicolas is

  procedure disponer is new unchecked_deallocation(unDato,ptUnDato);

  procedure creaVacia(b:out bicola) is
  begin
    b:=(null,null,0);
  end creaVacia;
  
  procedure agnadeIzq(e:in elemto; b:in out bicola) is
    aux:ptUnDato;
  begin
    aux:=new unDato'(e,b.izq,null);
    if b.der=null then b.der:=aux; b.izq:=aux; else b.izq.ant:=aux; b.izq:=aux; end if;
    b.n:=b.n+1;
  end agnadeIzq;
  
  procedure agnadeDer(b:in out bicola; e:in elemto) is
    aux:ptUnDato;
  begin
    aux:=new unDato'(e,null,b.der);
    if b.izq=null then b.izq:=aux; b.der:=aux; else b.der.sig:=aux; b.der:=aux; end if;
    b.n:=b.n+1;
  end agnadeDer;
  
  procedure eliminaIzq(b:in out bicola) is
  begin
    b.izq:=b.izq.sig;
    if b.izq=null then disponer(b.der); else disponer(b.izq.ant); end if;
    b.n:=b.n-1;
  end eliminaIzq;
  
  procedure eliminaDer(b:in out bicola) is
  begin
    b.der:=b.der.ant;
    if b.der=null then disponer(b.izq); else disponer(b.der.sig); end if;
    b.n:=b.n-1;
  end eliminaDer;
  
  function observaIzq(b:in bicola) return elemto is
  begin
    return b.izq.dato;
  end observaIzq;
  
  function observaDer(b:in bicola) return elemto is
  begin
    return b.der.dato;
  end observaDer;
  
  function esVacia(b:in bicola) return boolean is
  begin
    return b.n=0;
  end esVacia;
  
  function long(b:in bicola) return natural is
  begin
    return b.n;
  end long;
  
  procedure libera(b:in out bicola) is
    aux:ptUnDato;
  begin
    aux:=b.izq;
    while aux/=null loop
      b.izq:=b.izq.sig;
      disponer(aux);
      aux:=b.izq;
    end loop;
    creaVacia(b);
  end libera;

  procedure asigna(bout:out bicola; bin:in bicola) is
    aux:ptUnDato;
    bout2:bicola;
  begin
    creaVacia(bout2);
    aux:=bin.izq;
    while aux/=null loop
      agnadeDer(bout2,aux.dato);
      aux:=aux.sig;
    end loop;
    bout:=bout2;
  end asigna;
    
  function "="(b1,b2:in bicola) return boolean is
    aux1,aux2:ptUnDato;
    iguales:boolean;
  begin
    if esVacia(b1) and esVacia(b2) then
      return true;
    elsif long(b1)/=long(b2) then
      return false;
    else
      iguales:=b1.izq.dato=b2.izq.dato;
      aux1:=b1.izq.sig;
      aux2:=b2.izq.sig;
      while iguales and aux1/=null loop
        iguales:=aux1.dato=aux2.dato;
        aux1:=aux1.sig;
        aux2:=aux2.sig;
      end loop;
      return iguales;
    end if;
  end "=";

end bicolas;

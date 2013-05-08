--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE IMPLEMENTACION DEL TAD 'PILA GENERICA' DE ALTURA LIMITADA
--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 07-X-2005
--| Autor: Javier Campos

package body gpilas is
  
  procedure vacia(p:out pila) is
  begin
    p.lacima:=0;
  end vacia;
  
  procedure apilar(p:in out pila; e:in elemto; error:out boolean) is
  begin
    if p.lacima=maxaltura then 
      error:=true;
    else
      error:=false;
      p.lacima:=p.lacima+1;
      p.datos(p.lacima):=e;
    end if;
  end apilar;
  
  procedure desapilar(p:in out pila) is
  begin
    if p.lacima>0 then p.lacima:=p.lacima-1; end if;
  end desapilar;
  
  function cima(p:in pila) return elemto is
  begin
    return p.datos(p.lacima);
  end cima;
  
  function esVacia(p:pila) return boolean is
  begin
    return p.lacima=0;
  end esVacia;

  function altura(p:pila) return natural is
  begin
    return p.lacima;
  end altura;

  procedure asignar(pout:out pila; pin:in pila) is
  begin
    pout.lacima:=pin.lacima;
    for n in 1..pin.lacima loop
      pout.datos(n):=pin.datos(n);
    end loop;
  end asignar;

  function "="(p1,p2:in pila) return boolean is
  begin
    if p1.lacima/=p2.lacima then
      return false;
    else
      return p1.datos(1..p1.lacima)=p2.datos(1..p2.lacima);
    end if;
  end "=";

end gpilas;

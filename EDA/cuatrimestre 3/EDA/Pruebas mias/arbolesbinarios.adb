package body arbolesBinarios is


  procedure vacio(a: out arbin) is
  begin
    a:= null;
  end vacio;
  

  procedure plantar(n: in integer; c: in colores; ai, ad: in arbin; a: out arbin) is
  begin
    a:= new nodo'(n,c,ai,ad);
  end plantar;
  

  function raiz(a: arbin) return integer is
  begin
    return (a.dato);
  end raiz;
  

  procedure subIzq(a: in arbin; ai: out arbin) is
  begin
    ai:= a.izq;
  end subIzq;
  

  procedure subDer(a: in arbin; ad: out arbin) is
  begin
    ad:= a.der;
  end subDer;
  

  function esVacio(a: arbin) return boolean is
  begin
    return (a=null);
  end esVacio;
  

  function esMonoDistante(N:integer; a: arbin) return boolean is
      
    function esMonoDistanteBis(N: integer; a: arbin; suma: integer) return boolean is
    begin      
      if (a.izq=null) and (a.der=null) then
        return (N=suma+a.dato);
      elsif (a.izq=null) and (a.der/=null) then
        return esMonoDistanteBis(N,a.der,suma+a.dato);
      elsif (a.izq/=null) and (a.der=null) then
        return esMonoDistanteBis(N,a.izq,suma+a.dato);
      else -- a.izq/=null ^ a.der/=null
        return ((esMonoDistanteBis(N,a.izq,suma+a.dato)) and (esMonoDistanteBis(N,a.der,suma+a.dato)));
      end if;
    end esMonoDistanteBis;
    
   
  begin
    return esMonoDistanteBis(N,a,0);
  end esMonoDistante;
  

  function esRojinegro(a: in arbin) return boolean is
  
    function esRojinegroAux(a: in arbin; cuenta, N: in natural) return boolean is
    begin
      if (a.izq=null) and (a.der=null) then
        return (a.color=negro) and (cuenta+1=N);
      elsif (a.izq=null) and (a.der/=null) then
        if (a.color=rojo) then
          return ((a.izq.color=negro) and esRojinegroAux(a.izq,cuenta,N));
        else return esRojinegroAux(a.izq,cuenta+1,N);
        end if;
      elsif (a.izq/=null) and (a.der=null) then
        if (a.color=rojo) then
          return ((a.der.color=negro) and esRojinegroAux(a.der,cuenta,N));
        else return (esRojinegroAux(a.der,cuenta+1,N));
        end if;
      else -- a.izq/=null ^ a.der/=null
        if (a.color=rojo) then
          return ((a.izq.color=negro) and (a.der.color=negro) and esRojinegroAux(a.izq,cuenta,N)
                   and esRojinegroAux(a.der,cuenta,N));
        else return (esRojinegroAux(a.izq,cuenta+1,N) and esRojinegroAux(a.der,cuenta+1,N));
        end if;
      end if;
    end esRojinegroAux;
    
    aux: arbin; N: natural;
        
  begin
    if (a.color=negro) then N:=1;
    else N:=0; end if;
    aux:= a.izq;
    while (aux/=null) loop
      if (aux.color=negro) then N:=N+1; end if;
      aux:= aux.izq;
    end loop;
    return esRojinegroAux(a,0,N);    
  end esRojinegro;
  
end arbolesBinarios;
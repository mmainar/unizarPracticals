with ada.strings.unbounded, ustrings;
use ada.strings.unbounded, ustrings;
package body arbolesBinarios is


  procedure vacio(a: out arbin) is
  begin
    a:= null;
  end vacio;
  

  procedure plantar(n: in integer; ai, ad: in arbin; a: out arbin) is
  begin
    a:= new arbin'(n,ai,ad);
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


end arbolesBinarios;
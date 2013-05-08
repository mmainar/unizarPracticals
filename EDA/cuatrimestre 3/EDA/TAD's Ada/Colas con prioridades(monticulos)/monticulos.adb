-- Módulo de implementación del tipo genérico "monticulo".
-- Véase la documentación del módulo de definición.
--
-- Versión: 2.0
-- Fecha: 19-XI-99
-- Autor: Javier Campos Laclaustra (jcampos@posta.unizar.es)
--
with ada.text_IO, ada.Integer_Text_IO;
use ada.Text_IO, ada.Integer_Text_IO;
package body monticulos is
  procedure creaVacio(c:out monticulo) is
  begin
    c.num:=0;
  end creaVacio;
	
  procedure encola(c:in out monticulo; e:in integer) is
    i:integer range 0..maxNum; debeSubir:boolean; aux:integer;
  begin
    c.num:=c.num+1;
    c.dato(c.num):=e;
    i:=c.num;
    if i>1 then
      debeSubir:=c.dato(i)<c.dato(i/2);
    else
      debeSubir:=false;
    end if;
    while i>1 and debeSubir loop
      aux:=c.dato(i);
      c.dato(i):=c.dato(i/2);
      c.dato(i/2):=aux;
      i:=i/2;
      if i>1 then
        debeSubir:=c.dato(i)<c.dato(i/2);
      else
        debeSubir:=false;
      end if;
    end loop;
  end encola;
	
  function menor(c:monticulo) return integer is
  begin
    return c.dato(1);
  end menor;
	
  procedure decola(c:in out monticulo) is
    i,j:integer range 1..maxNum; aux:integer;
  begin
    c.dato(1):=c.dato(c.num);
    c.num:=c.num-1;
    i:=1;
    while i<=c.num/2 loop
      if c.dato(2*i)<c.dato(2*i+1) or 2*i=c.num then 
        j:=2*i;
      else 
        j:=2*i+1;
      end if;
      if c.dato(j)<c.dato(i) then
        aux:=c.dato(i);
        c.dato(i):=c.dato(j);
        c.dato(j):=aux;
        i:=j;
      else
        i:=c.num;
      end if;
    end loop;
  end decola;
	
  function esVacio(c:monticulo) return boolean is
  begin
    return c.num=0;
  end esVacio;

  function longitud(c:monticulo) return natural is
  begin
    return c.num;
  end longitud;
  
  
  procedure de_estatica_a_dinamica(me: in monticulo; md: out monticuloDinamico) is
  
    procedure de_estatica_a_dinamica_recur(me: in monticulo; md: out monticuloDinamico; i: in integer) is
      aux: monticuloDinamico;
    begin
      if i<=me.num then
        if (i mod 2=0) then
          md.izq:= new nodo;
          aux:= md.izq;
          aux.padre:= md;
          aux.dato:= me.dato(i);
        else
          md.der:= new nodo;
          aux:= md.der;
          aux.padre:= md;
          aux.dato:= me.dato(i);
        end if;
        de_estatica_a_dinamica_recur(me,aux,2*i);
        de_estatica_a_dinamica_recur(me,aux,2*i+1);
      end if;
    end de_estatica_a_dinamica_recur;
  

  begin
    if me.num=0 then md:= null;
    else
      md:= new nodo;
      md.dato:= me.dato(1);
      md.padre:= null;
      de_estatica_a_dinamica_recur(me,md,2);
      de_estatica_a_dinamica_recur(me,md,3);
    end if;
  end de_estatica_a_dinamica;
  
  
  procedure preOrden(d:monticuloDinamico) is
  begin
    if d/=null then
      put(d.dato,3); 
      preOrden(d.izq);
      preOrden(d.der);
    end if;
  end preOrden;
  
  
  procedure pintar_arbol(d:in monticuloDinamico) is
    procedure pintar(d:in monticuloDinamico; margen:in positive_count) is
    begin
      if d/=null then
        set_col(margen);
        put(d.dato);
        new_line;
        pintar(d.izq,margen+3);
        pintar(d.der,margen+3);
      end if;
    end pintar;
  begin
    pintar(d,1);
  end pintar_arbol;
  
  
  procedure pintar_monticulo(c: in monticulo) is
  begin
    for i in 1..c.num loop put(c.dato(i)); end loop;
  end pintar_monticulo;

  

end monticulos;
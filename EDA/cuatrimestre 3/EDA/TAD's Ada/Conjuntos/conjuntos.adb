--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| MODULO DE IMPLEMENTACION DEL TAD 'conjunto generico'
--|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--| Version: 1.0
--| Fecha: 31-X-96
--| Autor: Javier Campos


package body conjuntos is

  procedure vacio (A:out conjunto) is
  begin
    A.card:=0;
    for e in elemento loop A.elmto(e):=false; end loop;
  end vacio;
  
  function esVacio (A:in conjunto) return boolean is
  begin
    return A.card=0;
  end esVacio;
  
  function pertenece (e:in elemento; A:in conjunto) return boolean is
  begin
    return A.elmto(e);
  end pertenece;

  procedure poner (e:in elemento; A:in out conjunto) is
  begin
    if not pertenece(e,A) then A.elmto(e):=true; A.card:=A.card+1; end if;
  end poner;
  
  procedure quitar (e:in elemento; A:in out conjunto) is
  begin
    if pertenece(e,A) then A.elmto(e):=false; A.card:=A.card-1; end if;
  end quitar;
  
  procedure union (A,B:in conjunto; C:out conjunto) is
    SOL:conjunto;
  begin
    SOL.card:=0;
	for e in elemento loop
	  SOL.elmto(e):=A.elmto(e) or B.elmto(e);
	  if SOL.elmto(e) then SOL.card:=SOL.card+1; end if;
	end loop;
	C:=SOL;
  end union;
  
  procedure interseccion (A,B:in conjunto; C:out conjunto) is
    SOL:conjunto;
  begin
    SOL.card:=0;
	for e in elemento loop
	  SOL.elmto(e):=A.elmto(e) and B.elmto(e);
	  if SOL.elmto(e) then SOL.card:=SOL.card+1; end if;
	end loop;
	C:=SOL;
  end interseccion;
  
  function cardinal (A:in conjunto) return integer is
  begin
    return A.card;
  end cardinal;
  
end conjuntos;

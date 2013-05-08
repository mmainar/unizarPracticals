procedure funcion1(x: in cadena;y: out cadena) is
  t: integer := -5;
begin
  if (t>0) then null;
  else
    while not (t>0) loop
      null;
    end loop;
  end if;
  y:=x;
end funcion1;
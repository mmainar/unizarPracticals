with ada.integer_text_IO, ada.text_IO;
use ada.integer_text_IO, ada.text_IO;

procedure prueba is 

  a: integer; -- Declaracion global
  
  procedure first is
  begin
    a := 1;
  end;
  
  procedure lala(a: out integer) is
  begin
    null;
  end;

  procedure second is
    a: integer; -- Declaracion local
  begin
    first;
    lala(a);
  end;
  


  n: integer;
  v: array(1..10) of integer;
  v2: array(1..a) of integer;
  v3: array(-1..0) of integer;
begin -- de prueba
  v(0) := 8;
  v(2/0) := 4;
  v(2 / 4-8/2) := 7;
  a := 2.7; -- Error semantico
  --g: integer; -- Error sintactico -> Aborta la compilacion
  put(a, 0); new_line;
  get(n); skip_line;
  if n > 0 then
    second;
  else 
    first;
  end if;
  put(a, 0);
  --h: integer; -- Error sintactico
  put(integer'last, 0);
end;


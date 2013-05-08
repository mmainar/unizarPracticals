---------------------------------------------------------------------
-- Fichero:   textos.adb
-- Autor:     J.D.Tardos
-- Version:   v1.0 28-2-2002
-- Proposito: Utilidades auxiliares de manejo de textos
---------------------------------------------------------------------

with Ada.Command_Line, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO,
     Ada.Strings.Fixed, Ada.Strings;
use  Ada.Command_Line, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO,
     Ada.Strings.Fixed;

package body Textos is

  function Texto(f: float) return string is
  -- Pasa un numero a string, sin espacios en blanco
    str: string(1..10);
  begin
    put(str, f, 1, 0);
    return Trim(str, Ada.Strings.Both);
  end;


  function Texto(n: integer) return string is
  -- Pasa un numero a string, sin espacios en blanco
  begin
    return Trim(integer'image(n), Ada.Strings.Both);
  end;

  
  function Argumento(i: positive) return integer is
  -- Devuelve el argumento i-esimo de la linea de comandos
    arg, last: integer;
  begin
    arg := 0;
    if Argument_count >= i then
      get(Argument(i), arg, last);
    end if;
    return arg;
  exception
    when others =>
      Put("Error: el argumento "); Put(i);
      Put_line(" deberia ser un entero");
      return 0;
  end;


  function Argumento(i: positive) return float is
  -- Devuelve el argumento i-esimo de la linea de comandos
    last: integer;
    arg:  float;
  begin
    arg := 0.0;
    if Argument_count >= i then
      get(Argument(i), arg, last);
    end if;
    return arg;
  exception
    when others =>
      Put("Error: el argumento "); Put(i);
      Put_line(" deberia ser un numero real");
      return 0.0;
  end;

end;

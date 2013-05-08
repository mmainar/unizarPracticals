---------------------------------------------------------------------
-- Fichero:   textos.ads
-- Autor:     J.D.Tardos
-- Version:   v1.0 28-2-2002
-- Proposito: Utilidades auxiliares de manejo de textos
---------------------------------------------------------------------

package Textos is

  function Texto(f: float) return string;
  -- Pasa un numero a string, sin espacios en blanco

  function Texto(n: integer) return string;
  -- Pasa un numero a string, sin espacios en blanco

  function Argumento(i: positive) return integer;
  -- Devuelve el argumento i-esimo de la linea de comandos

  function Argumento(i: positive) return float;
  -- Devuelve el argumento i-esimo de la linea de comandos

end;

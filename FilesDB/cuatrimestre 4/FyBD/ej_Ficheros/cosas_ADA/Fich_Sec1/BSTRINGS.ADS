--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
-- Modificado por: Fernando Tricas
-- La modificacion ha consistido en adaptar el paquete ubstrinsg a un
-- paquete generico adecuado para manejar las cadenas de caracteres
-- acotadas (Bounded_Strings). Para instanciar el paquete hay que pasarle
-- como argumento el paquete que generemos para las cadenas de caracteres
-- acotadas que vayamos a utilizar.

----------------------------------------------------------------------------
-- Ejemplo:
-- procedure miPrograma is
--     package pCadenas80 is new Generic_Bounded_Length(80);
--     use pCadenas80;
--     package pCadenas80_text_io is new Bstrings(pCadenas80);
--     use pCadenas80_text_io;
--     
--     ....
--
--
----------------------------------------------------------------------------
-- Utilizaci'on:
-- 
-- Dos posibilidades:
-- * Copiar los ficheros en el directorio en que est'a el programa y compilar
--   normalmente. 
-- * Utilizar los ficheros donde est'an. Para ello:
--
--   gnatmake miPrograma.adb -I/users/PROGRAMACION/salidas/p4
--
--   esta instrucci'on le dice que busque los paquetes en el directorio que
--   se le indica adem'as de los que 'el ya conoce (el directorio actual y 
--   los definidos en el sistema).
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
-- ************************ Nota Importante ********************************
-- Esta ha sido una adaptaci'on hecha con cierta premura de tiempo. Si se
-- detecta alg'un problema (en el paquete o en las instrucciones de uso) se
-- agradecer'a cualquier informaci'on (o cr'itica) en la direcci'on
-- ftricas (desde merlin) o en la direcci'on ftricas@posta.unizar.es (desde
-- otros computadores).
-- ************************ Nota Importante ********************************
----------------------------------------------------------------------------
--

with Text_IO;
with Ada.Strings, Ada.Strings.Bounded;
use  Text_IO; 
use Ada.Strings, Ada.Strings.Bounded;

generic
        with package P is new Generic_Bounded_Length(<>);
package Bstrings is

  -- This package provides a simpler way to work with type
  -- Bounded_String, since this type will be used very often.
  -- Most users will want to ALSO with "Ada.Strings.Bounded".
  -- Ideally this would be a child package of "Ada.Strings.Bounded".
  --

  --  + Adds other subprograms, currently just "Swap".
  --  + Other packages can use this package to provide other simplifications.

        --package my_bstrings is new Generic_Bounded_Length(Max);
        use P;

  subtype Bstring is Bounded_String;

  -- "Swap" is important for reuse in some other packages, so we'll define it.

  procedure Swap(Left, Right : in out Bounded_String);


  function Empty(S : Bounded_String) return Boolean;
   -- returns True if Length(S)=0.
  pragma Inline(Empty);


  -- I/O Routines.
  procedure Get_Line(File : in File_Type; Item : out Bounded_String);
  procedure Get_Line(Item : out Bounded_String);

  procedure Put(File : in File_Type; Item : in Bounded_String);
  procedure Put(Item : in Bounded_String);

  procedure Put_Line(File : in File_Type; Item : in Bounded_String);
  procedure Put_Line(Item : in Bounded_String);

end Bstrings;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
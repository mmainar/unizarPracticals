--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
-- Modificado por: Fernando Tricas (ftricas@posta.unizar.es)
--
package body BStrings is
  Input_Line_Buffer_Length : constant := 1024;
    -- if an input line is longer, Get_Line will recurse to read in the line.

  procedure Swap(Left, Right : in out Bounded_String) is -- portable but slow approach.
    Temporary : Bounded_String;
  begin
    Temporary := Left;    Left := Right;    Right := Temporary;
  end Swap;

  function Empty(S : Bounded_String) return Boolean is   -- returns True if Length(S)=0.
  begin
    return (Length(S) = 0);
  end Empty;

  -- Implement Bounded_String I/O by calling Text_IO String routines.

  -- Get_Line gets a line of text, limited only by the maximum number of
  -- characters in an Bounded_String.  It reads characters into a buffer
  -- and if that isn't enough, recurses to read the rest.

  procedure Get_Line (File : in File_Type; Item : out Bounded_String) is

    function More_Input return Bounded_String is
      Input : String (1 .. Input_Line_Buffer_Length);
      Last  : Natural;
    begin
      Get_Line (File, Input, Last);
      if Last < Input'Last
        then return To_Bounded_String(Input(1..Last));
        else return To_Bounded_String(Input(1..Last)) & More_Input;
      end if;
    end More_Input;

  begin
      Item := More_Input;
  end Get_Line;

  procedure Get_Line(Item : out Bounded_String) is
  begin
    Get_Line(Current_Input, Item);
  end Get_Line;

  procedure Put(File : in File_Type; Item : in Bounded_String) is
  begin
    Put(File, To_String(Item));
  end Put;

  procedure Put(Item : in Bounded_String) is
  begin
    Put(Current_Output, To_String(Item));
  end Put;

  procedure Put_Line(File : in File_Type; Item : in Bounded_String) is
  begin
    Put(File, Item);            New_Line(File);
  end Put_Line;

  procedure Put_Line(Item : in Bounded_String) is
  begin
    Put(Current_Output, Item);  New_Line;
  end Put_Line;

end BStrings;

-- screen.ads:  View ASCII terminal as 2D window using escape sequences
-- The output device must recognized ANSI X3.64 1979 terminal-control
-- escape sequences.  ECMA-48 is another such standard.
-- Ryan Stansifer (ryan@cs.fit.edu) at Mon Mar 24 18:09:39 1997
-- Written for CSE1001/CSE1002 at Florida Tech.
with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Latin_1;
use Ada;
package body Screen is
    Bell:   Character renames Characters.Latin_1.BEL;
    Escape: Character renames Characters.Latin_1.ESC;
 16 
 17    procedure Beep is
 18    begin
 19       Text_IO.Put (Item => Bell);
 20    end Beep;
 21 
 22    procedure Move_Cursor (Row, Column: Positive:=1) is
 23    begin
 24       Text_IO.Put (Item => Escape & '[');
 25       Integer_Text_IO.Put (Item => Row, Width => 1);
 26       Text_IO.Put (Item => ';');
 27       Integer_Text_IO.Put (Item => Column, Width => 1);
 28       Text_IO.Put (Item => 'f');
 29    end Move_Cursor;
 30 
 31    procedure Save_Cursor is
 32    begin
 33       Text_IO.Put (Item => Escape & "7");
 34    end Save_Cursor;
 35 
 36    procedure Restore_Cursor is
 37    begin
 38       Text_IO.Put (Item => Escape & "8");
 39    end Restore_Cursor;
 40 
 41    procedure Set_Attribute (A: Attribute) is
 42    begin
 43       Text_IO.Put (Item => Escape & '[');
 44       case A is
 45          when Normal  => Text_IO.Put ("0");
 46          when Bold    => Text_IO.Put ("1");
 47          when Inverse => Text_IO.Put ("7");
 48          when Blink   => Text_IO.Put ("5");
 49       end case;
 50       Text_IO.Put ('m');
 51    end Set_Attribute;
 52 
 53    procedure Set_Foreground_Color (C: Color) is
 54    begin
 55       Text_IO.Put (Item => Escape & "[3");
 56       Integer_Text_IO.Put (Item => Color'Pos(C), Width => 1);
 57       Text_IO.Put ('m');
 58    end Set_Foreground_Color;
 59 
 60    procedure Set_Background_Color (C: Color) is
 61    begin
 62       Text_IO.Put (Item => Escape & "[4");
 63       Integer_Text_IO.Put (Item => Color'Pos(C), Width => 1);
 64       Text_IO.Put ('m');
 65    end Set_Background_Color;
 66 
 67    procedure Set_Color (Fg, Bg: Color) is
 68    begin
 69       Text_IO.Put (Item => Escape & "[3");
 70       Integer_Text_IO.Put (Item => Color'Pos(Fg), Width => 1);
 71       Text_IO.Put (Item => ";4");
 72       Integer_Text_IO.Put (Item => Color'Pos(Bg), Width => 1);
 73       Text_IO.Put ('m');
 74    end Set_Color;
 75 
 76    procedure Clear_Screen is
 77    begin
 78       Text_IO.Put (Item => Escape & "[2J");
 79    end Clear_Screen;
 80 
 81    -- Erase remainder of current line; cursor remains where it was
 82    procedure Erase_Line is
 83    begin
 84       Text_IO.Put (Item => Escape & "[0K");
 85    end Erase_Line;
 86 
 87 end Screen;
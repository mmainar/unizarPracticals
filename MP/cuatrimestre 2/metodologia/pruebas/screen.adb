-- Package body

with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;
package body Screen is
    procedure Clear_Screen is
    begin
        Put (ASCII.ESC);
        Put ("[2J");
    end Clear_Screen;

    procedure Move_Cursor (Row, Column : in Integer) is
    begin
        Put (ASCII.ESC);
        Put ("[");
        Put (Row, Width=>1);
        Put (";");
        Put (Column, Width=>1);
        Put ("H");
    end Move_Cursor;
end Screen;

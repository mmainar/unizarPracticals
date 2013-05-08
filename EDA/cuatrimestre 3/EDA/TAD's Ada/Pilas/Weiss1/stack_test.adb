-------------------------------------------------------------------------- 
-- Main procedure which uses instantiated Stack package
-------------------------------------------------------------------------- 


with Stack_Array;
with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;

procedure Stack_test is
    package Integer_Stacks is new Stack_Array( Integer ); use Integer_Stacks;
    Stack_Of_Integers: Stack(10);
begin

    for Loop_Counter in 1..10 loop
        Push( Loop_Counter, Stack_Of_Integers );
    end loop;
    while not Is_Empty( Stack_Of_Integers ) loop
        Put( Top( Stack_Of_Integers ) ); New_Line;
        Pop( Stack_Of_Integers );
    end loop;

exception
    when Overflow  => Put_Line( "Overflow"  );
    when Underflow => Put_Line( "Underflow" );
end Stack_test;
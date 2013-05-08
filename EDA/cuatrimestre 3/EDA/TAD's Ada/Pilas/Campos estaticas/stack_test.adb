-------------------------------------------------------------------------- 
-- Main procedure which uses instantiated Stack package
-------------------------------------------------------------------------- 


with gpilas;
with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;

procedure Stack_test is
    package Integer_Stacks is new gpilas(100,Integer); use Integer_Stacks;
    Stack_Of_Integers: pila;
    error:boolean;
begin
    vacia(Stack_Of_Integers);
    for Loop_Counter in 1..10 loop
        apilar(Stack_Of_Integers,Loop_Counter,error);
    end loop;
    while not esVacia( Stack_Of_Integers ) loop
        Put( cima( Stack_Of_Integers ) ); New_Line;
        desapilar( Stack_Of_Integers );
    end loop;

end Stack_test;
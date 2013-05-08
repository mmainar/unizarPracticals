--------------------------------------

-- Package Body 3.3  Stack - Implements Specification 3.3

with text_io; use text_io;
package body stack_package is

-- procedure push         4   2   O(1)
-- procedure pop          2   2   O(1)
-- function  top          2   2   O(1)

procedure push (the_stack : in out stack; the_object : object_type) is
--   Length 4   Complexity 2   Perfomance O(1)
begin
   the_stack.objects(the_stack.latest + 1) := the_object;
   the_stack.latest := the_stack.latest + 1;
exception
   when constraint_error => raise stack_full;
end push;

procedure pop (the_stack : in out stack) is
--   Length 2   Complexity 2   Perfomance O(1)
begin
   the_stack.latest := the_stack.latest - 1;
exception
   when constraint_error | numeric_error => raise stack_empty;
end pop;

function top (the_stack : stack) return object_type is
--   Length 2   Complexity 2   Perfomance O(1)
begin
   return the_stack.objects(the_stack.latest);
exception
   when constraint_error => raise stack_empty;
end top;

function number_of_objects (the_stack : stack) return natural is
--   Length 1   Complexity 1   Perfomance O(1)
begin
   return the_stack.latest;
end number_of_objects;

procedure clear(the_stack : in out stack) is
--   Length 1   Complexity 1   Perfomance O(1)
begin
   the_stack.latest := 0;
end clear;

procedure display(the_stack : stack) is
--   Length 3   Complexity 2   Perfomance O(n)
begin
   put("size =" & natural'image(number_of_objects(the_stack)) & "   : ");
   for i in reverse 1..the_stack.latest loop
      put_object(the_stack.objects(i));
   end loop;
end display;

end stack_package;


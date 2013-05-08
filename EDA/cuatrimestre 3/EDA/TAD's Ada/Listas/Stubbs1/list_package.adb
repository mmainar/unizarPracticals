----------------------

-- Package Body 4.1  Lists - Implements Specification 4.1

with text_io; use text_io;
package body list_package is

function "&" (the_list : list; the_object : object_type) return list is
--   Length 3   Complexity 2   Perfomance O(n)
begin
   return list'(the_list.size+1, (the_list.objects & (the_object)));
exception
   when constraint_error | numeric_error => raise list_full;
end "&";

function "&" (left, right : list) return list is
--   Length 2   Complexity 2   Perfomance O(n)
begin
   return list'(left.size+right.size, (left.objects & right.objects ));
exception
   when constraint_error | numeric_error => raise list_full;
end "&";

function head (the_list : list) return object_type is
--   Length 2   Complexity 2   Perfomance O(1)
begin
   return the_list .objects (1);
exception
   when constraint_error => raise list_empty;
end head;
   
function tail (the_list : list) return list is
--   Length 3   Complexity 2   Perfomance O(n)
   subtype tail_array is array_of_objects(1 .. the_list .size-1);
begin
   return list'(the_list .size-1, 
                tail_array(the_list.objects (2 .. the_list .size)));
exception
   when constraint_error => raise list_empty;
end tail;

function empty_list return list is
--   Length 2   Complexity 1   Perfomance O(1)
   null_list : list(0);
begin
   return null_list;
end empty_list;

function number_of_objects (the_list : list) return natural is
--   Length 1   Complexity 1   Perfomance O(1)
begin
   return the_list .size;
end number_of_objects;

procedure display(the_list : list) is
begin
   put("size =" & natural'image(number_of_objects(the_list)) & "   : ");
   for i in 1..the_list.size loop
      put_object(the_list.objects(i));
   end loop;
end display;

end list_package;

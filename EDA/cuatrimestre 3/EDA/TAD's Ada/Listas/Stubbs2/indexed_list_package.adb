----------------------------------------------

-- Package Body 4.3  Indexed Lists - Implements Specification 4.3

with text_io; use text_io;
package body indexed_list_package is

procedure insert (the_list   : in out indexed_list;
                  at_index   : positive; 
                  the_object : object_type) is
--
-- Length 9   Complexity 4   Perfomance O(n)
--
begin
   if    the_list.size = 0 then the_list.size := 1; 
                                the_list.objects(1) := the_object;
   elsif at_index > the_list.size + 1      then raise faulty_position;
   elsif the_list.size = the_list.max_size then raise list_full;
   else  the_list.objects(at_index +1 .. the_list.size+1) :=                    
                                  the_list.objects(at_index .. the_list.size);
         the_list.objects(at_index) := the_object;
         the_list.size := the_list.size + 1;
   end if;
end insert;

function  list_object (the_list : indexed_list; at_index : positive) return 
object_type is
--
-- Length 4  Complexity 2  Perfomance O(1)
--
begin
   if at_index > the_list.size 
      then raise faulty_position; 
      else return the_list.objects(at_index);
   end if;
end list_object;

procedure delete (the_list : in out indexed_list; at_index : positive) is
--
-- Length 5  Complexity 2  Perfomance O(n)
--
begin
   if at_index > the_list.size 
      then raise faulty_position; 
      else the_list.objects(at_index .. the_list.size - 1) := 
                                  the_list.objects(at_index+1 .. the_list.size);
           the_list.size := the_list.size - 1;
   end if;
end delete;

procedure change (the_list   : in out indexed_list; 
                  at_index   : positive; 
                  the_object : object_type) is
--
-- Length 5  Complexity 2  Perfomance O(1)
--
begin
   if at_index > the_list.size 
      then raise faulty_position; 
      else the_list.objects(at_index) := the_object;
   end if;
end change;

procedure clear (the_list : in out indexed_list) is
--
-- Length 1  Complexity 1  Perfomance O(1)
--
begin
   the_list. size := 0;
end clear ;

function  number_of_objects (the_list : indexed_list) return natural is
--
-- Length 1  Complexity 1  Perfomance O(1)
--
begin
   return the_list.size;
end number_of_objects;

procedure display(the_list : indexed_list) is
-- Length 3   Complexity 2   Perfomance O(n)
begin
   put("size =" & natural'image(number_of_objects(the_list)) & "   : ");
   for i in 1..the_list.size loop
      put_object(the_list.objects(i));
   end loop;
end display;

end indexed_list_package;


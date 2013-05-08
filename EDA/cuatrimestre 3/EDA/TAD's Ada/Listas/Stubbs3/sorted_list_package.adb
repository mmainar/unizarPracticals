---------------------------------------------

-- Package Body 4.4  Sorted Lists - Implements Specification 4.4

with text_io; use text_io;
package body sorted_list_package is
   
   function search(the_list : sorted_list; target_key : key_type) return natural
     is separate;
   -- results    : If there is a object in the list with key_of(list_object) = 
   --              target_key, then search returns the position of the object; 
   --              if not, then search returns the position that the target 
   --              object would have occupied had it been in the list.
   -- note       : This is an internal function not visible to the user.
                
procedure insert (the_list : in out sorted_list; the_object : object_type) is
--
-- Length 8   Complexity 2   Perfomance O(n)
--
   pos : natural;
begin
   if the_list.size = the_list.max_size then raise list_full; 
   end if;
   pos := search(the_list, key_of(the_object));
 the_list.size := the_list.size + 1;     
            -- Make room for new object by moving a slice to make a gap at pos. 
   the_list.objects(pos+1 .. the_list.size) := 
                                      the_list.objects(pos .. the_list.size-1); 
   the_list.objects(pos) := the_object;   
end insert;

procedure delete (the_list : in out sorted_list; target_key : key_type) is
--
-- Length 5  Complexity 3  Perfomance O(n)
--
   pos : natural;
begin
   pos := search(the_list, target_key);
   if pos in 1 .. the_list.size and then 
                  key_of(the_list.objects(pos)) = target_key then
      -- Eliminate the list object to be deleted.
      the_list.objects(pos .. the_list.size-1) := 
                                       the_list.objects(pos+1 .. the_list.size);
      the_list.size := the_list.size - 1;
   end if;
end delete;

procedure change (the_list : in out sorted_list; the_object : object_type) is
-- Length 5  Complexity 3  Perfomance O(search)
   pos : natural;
begin
   pos := search(the_list, key_of(the_object));
   if pos in 1 .. the_list.size and then 
                  key_of(the_list.objects(pos)) = key_of(the_object) then
      the_list.objects(pos) := the_object;             -- Replace target object.
   end if;
end change;

procedure clear (the_list : in out sorted_list) is
-- Length 1  Complexity 1  Perfomance O(1)
begin
   the_list.size := 0;
end clear;

procedure find (the_list   : sorted_list;
                target_key : key_type;  
                the_object : out object_type; 
                found      : out boolean) is
-- Length 9  Complexity 3  Perfomance O(search)
   pos : natural;
begin
   found := false;
   pos := search(the_list, target_key);
   if pos in 1 .. the_list.size and then 
                  key_of(the_list.objects(pos)) = target_key then
      found := true;
      the_object := the_list.objects(pos);
   end if;
end find;

function number_of_objects (the_list : sorted_list) return natural is
-- Length 1  Complexity 1  Perfomance O(1)
begin
   return the_list.size;
end number_of_objects;


procedure traverse (the_list : in out sorted_list) is
-- Length 2   Complexity 2   Perfomance O(n)
begin
   for i in 1 .. the_list.size loop
      process(the_list.objects(i));
   end loop;
end traverse;

procedure display(the_list : sorted_list) is
-- Length 3   Complexity 2   Perfomance O(n)
begin
   put("size =" & natural'image(number_of_objects(the_list)) & "   : ");
   for i in 1..the_list.size loop
      put_object(the_list.objects(i));
   end loop;
end display;

end sorted_list_package;

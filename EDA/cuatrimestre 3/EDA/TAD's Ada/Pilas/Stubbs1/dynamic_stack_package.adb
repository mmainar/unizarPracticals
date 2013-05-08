---------------------------------------------------

-- Package Body 3.2  Generic Dynamic Stack - Implements Specification 3.2

with unchecked_deallocation;
with text_io; use text_io;

package body dynamic_stack_package is

   type node;      -- The nodes of the linked list that holds the stack objects.
   type node_pointer is access node; 
   type node is record
      object : object_type;
      next   : node_pointer;
   end record;

   type list_type is record
      head : node_pointer;                 -- Head points to the list node that 
                                                -- holds the stack's top object.
      size : natural := 0; -- The number of nodes (objects) in the list (stack).
   end record;

   procedure free is new unchecked_deallocation(node, node_pointer);

   the_list : list_type;
 
procedure push (the_object : object_type) is
-- Length 3   Complexity 2   Perfomance O(1)
begin
                                           -- Put the_object at the list's head.
   the_list.head := new node'(the_object, the_list.head); 
   the_list.size := the_list.size + 1;    
exception
   when storage_error => raise stack_full; 
                        -- This is raised if there is no space left to allocate.
end push;

function top return object_type is                     
-- Length 2   Complexity 2   Perfomance O(1)
begin
   return the_list.head.object;                    
exception
   when constraint_error => raise stack_empty;    
end top;

procedure pop is
-- Length 5   Complexity 2   Perfomance O(1)
   hold : node_pointer := the_list.head;
begin
   the_list.head  := the_list.head.next;
   the_list.size  := the_list.size - 1;
   free(hold);
exception
   when constraint_error => raise stack_empty;    
end pop;

function pop return object_type is
-- Length 3   Complexity 1   Perfomance O(1)
   hold : object_type := top;
begin
   pop;
   return hold;
end pop;

function number_of_objects return natural is
-- Length 1   Complexity 1   Perfomance O(1)
begin
   return the_list.size;
end number_of_objects;


procedure clear is
-- Length 2   Complexity 2   Perfomance O(n)
begin
   while the_list.size > 0 loop
      pop;
   end loop;
end clear;

procedure display is
-- Length 6   Complexity 2   Perfomance O(n)
   p : node_pointer := the_list.head;
begin
   put("size =" & natural'image(number_of_objects) & "   : ");
   p := the_list.head;
   while p /= null loop
      put_object(p.object);
      p := p.next;
   end loop;
end display;

end dynamic_stack_package;


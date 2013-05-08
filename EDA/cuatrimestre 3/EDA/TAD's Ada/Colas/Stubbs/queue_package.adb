----------------------------_

-- Package Body 3.4  Generic Queue - Implements Specification 3.4

with text_io; use text_io;
package body queue_package is 

procedure enqueue(the_queue : in out queue; the_object : object_type) is
--   Length 5   Complexity 2   Performance O(1)
begin
   if the_queue.size = the_queue.max_size then raise queue_full;
   else the_queue.size := the_queue.size + 1; 
   end if;
   the_queue.last := (the_queue.last mod the_queue.max_size) + 1;
                                        -- Wraps when the_queue.last = max_size.
   the_queue.objects(the_queue.last) := the_object;
end enqueue;

procedure dequeue(the_queue : in out queue) is
 --   Length 3   Complexity 2   Performance O(1)
begin
   the_queue.size := the_queue.size - 1;     -- Raise exception if queue empty.
   the_queue.first := (the_queue.first mod the_queue.max_size) + 1;
                                       -- Wraps when the_queue.first = max_size.
exception
   when constraint_error | numeric_error => raise queue_empty;
end dequeue;                        

function head(the_queue : queue) return object_type is     
--   Length 3   Complexity 2   Performance O(1)
begin
   if the_queue.size = 0 then raise queue_empty;
      else return the_queue.objects(the_queue.first);
   end if;
end head;

function number_of_objects(the_queue : queue) return natural is
--   Length 1   Complexity 1   Performance O(1)
begin
   return the_queue.size;
end number_of_objects;

procedure clear(the_queue : in out queue) is
--   Length 1   Complexity 1   Performance O(1)
begin
   the_queue.size := 0;
end clear;

procedure display(the_queue : queue) is
--   Length 10  Complexity 7   Performance O(n)
begin
   put("size =" & natural'image(number_of_objects(the_queue)) & "   : ");
   if the_queue.size > 0 then
   -- Prints the whole queue array showing the queue in it.
      if the_queue.last >= the_queue.first then        -- Queue not wrapped.
         for i in 1..the_queue.max_size loop
            if i >= the_queue.first and i <= the_queue.last then
                put_object(the_queue.objects(i));
            else put(" - ");
            end if;
         end loop;
      else                                              -- Queue wrapped.
         for i in 1..the_queue.max_size loop
            if i >= the_queue.first or i <= the_queue.last then
                put_object(the_queue.objects(i));
            else put(" - ");
            end if;
         end loop;
      end if;
   end if;
 
end display;

procedure copy (the_queue : queue; the_copy : in out queue) is
--    Length 9   Complexity 4  Performance O(n)
   index : positive := the_queue.first;
begin
   if the_queue.size > the_copy.max_size then
      raise queue_full;
   elsif the_queue.size > 0 then
      clear (the_copy);
      loop
         enqueue (the_copy, the_queue.objects(index));
         exit when index = the_queue.last;
         index := (index mod the_queue.max_size) + 1;
      end loop;
   end if;
end copy;

procedure traverse (the_queue : queue) is
--    Length 6   Complexity 3    Performance O(n)
   index : natural := the_queue.first;
begin
   if the_queue.size > 0 then
      loop
         process (the_queue.objects(index));
         exit when index = the_queue.last;
         index := (index mod the_queue.max_size) + 1;
      end loop;
   end if;
end traverse;

procedure prune (the_queue : in out queue) is
--    Length 15   Complexity 6    Performance O(n)
--    Each of the n objects in the_queue is tested for pruning.
   search, next_available : natural;
begin
   if the_queue.size > 0 then
      search := the_queue.first;
      next_available := search;

      for k in 1 .. the_queue.size loop
         if prune_object(the_queue.objects(search)) then
            the_queue.size := the_queue.size - 1;
         elsif next_available /= search then
            the_queue.objects(next_available) := the_queue.objects(search);
            the_queue.last := next_available;
            next_available := (next_available mod the_queue.max_size) + 1;
         else 
            the_queue.last := next_available;
            next_available := (next_available mod the_queue.max_size) + 1;
         end if;
         search := (search mod the_queue.max_size) + 1;
      end loop;

      if the_queue.size = 0 then
         clear(the_queue);
      end if;
   end if;
end prune;

end queue_package;


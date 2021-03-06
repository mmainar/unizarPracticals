
   -------------------------------------------------------------------------

--|

--|  Q U E U E   T E S T

--|

--|  Abstract : This file contains a procedure to test the implementation

--|     of queue operations.

--|

--|  Related compilation units contained in this directory are:

--|

--|         Type               Name               File

--|         ----               ----               ----

--|     Test Procedure         queue_test         This file

--|     Procedure              get_word           get_word.ada

--|

--|     Specification          queue_package      queue.ada

--|     Implementation         queue_package      queue.ada

--|

   ---------------------------------------------------------------------------

--|  Date 4/22/93     Version 1.0

   ---------------------------------------------------------------------------

with text_io; use text_io;

with get_word;

with queue_package; 



procedure queue_test is

   package queue_pak is new queue_package(integer);

   package iio is new integer_io(integer); use iio;



   operation    : string(1..20);

   line         : string(1..80);

   n, len, last : natural;

   object       : integer;

   queue        : queue_pak.queue(7);

   another_queue: queue_pak.queue(7);



   procedure put_object(object : integer) is

   begin

      iio.put(object,3);

   end put_object;



   function twenty_to_sixty(object : integer) return boolean is

   begin

      return object >= 20 and object <= 60;

   end twenty_to_sixty;



   function less_than_forty(object : integer) return boolean is

   begin

      return object < 40;

   end less_than_forty;



   procedure display_queue is new queue_pak.display(put_object);

   procedure traverse_queue is new queue_pak.traverse(put_object);

   procedure prune1 is new queue_pak.prune(twenty_to_sixty);

   procedure prune2 is new queue_pak.prune(less_than_forty);



begin

   loop1 : loop

      begin        -- This begin block is included so that exceptions

                   -- generated by the package being tested will not

                   -- cause termination of the test program.

         loop2 : loop

            if end_of_file then exit loop1; 

               else get_line(line, len);               -- Get next command line.

            end if;

            get_word(line(1..len), operation, n);            -- Isolate command.

            if n = 0 then exit loop1; end if;     -- Empty line; terminate test.

            put(line(1..len)); 

            if operation(1..2) = "--"                   -- Command is a comment.

               then new_line;

            else set_col(15); put("=> ");

                 if operation(1..n) = "enqueue" 

                    then iio.get(line(n+1..len), object, last); 

                         queue_pak.enqueue(queue, object);

                 elsif operation(1..n) = "head" 

                    then put_object(queue_pak.head(queue));

                 elsif operation(1..n) = "dequeue" 

                    then queue_pak.dequeue(queue);

                 elsif operation(1..n) = "clear" 

                    then queue_pak.clear(queue);

                 elsif operation(1..n) = "copy"

                    then queue_pak.copy(queue, another_queue);

                         set_col(25); display_queue(another_queue);

                 elsif operation(1..n) = "traverse"

                    then traverse_queue(queue);

                 elsif operation(1..n) = "prune1"

                    then prune1(queue);

                 elsif operation(1..n) = "prune2"

                    then prune2(queue);

                 else put("??????");

                 end if;

                 set_col(25); display_queue(queue);

                 new_line; 

            end if;

         end loop loop2;

      exception

         when queue_pak.queue_empty => 

              set_col(25);

              put_line("queue_empty exception raised");

         when queue_pak.queue_full =>  

              set_col(25);

              put_line("queue_full exception raised");

      end;

   end loop loop1;

   new_line(2); put_line("queue test completed.");

end queue_test;


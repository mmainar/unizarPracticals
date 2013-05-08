
   -------------------------------------------------------------------------

--|

--|  S O R T E D   L I S T   T E S T

--|

--|  Abstract : This file contains a procedure to test the implementation

--|     of sorted list operations.

--|

--|  Related compilation units contained in this directory are:

--|

--|         Type               Name                 File

--|         ----               ----                 ----

--|     Test Procedure         sorted_list_test     This file

--|     Procedure              get_word             get_word.ada

--|

--|     Specification          sorted_list_package  sorted_list.ada

--|     Implementation         sorted_list_package  sorted_list.ada

--|     Procedure              search               sorted_list.ada

--|

   ---------------------------------------------------------------------------

--|  Date 4/22/93     Version 1.0

   ---------------------------------------------------------------------------

with text_io; use text_io;

with get_word;

with sorted_list_package; 



procedure sorted_list_test is



   subtype key_type is string(1..2);

   type object_type is record

      key  : key_type;

      data : integer;

   end record;



   function key_of(the_object : object_type) return key_type;

   function ">"(left, right : object_type) return boolean;

   package sorted_list_pak is new sorted_list_package(key_type, 

                                                      object_type,

                                                      key_of, ">");

   package iio is new integer_io(integer); use iio;



   operation    : string(1..20);

   line         : string(1..80);

   n, len, last : natural;

   object       : object_type;

   target_key   : key_type;

   found        : boolean;

   sorted_list  : sorted_list_pak.sorted_list(13);



   procedure put_object(the_object : object_type) is

   begin

      put(the_object.key & '-');

      iio.put(the_object.data, 2);

      put(' ');

   end put_object;



   procedure put_key(the_object : object_type) is

   begin

      put(the_object.key & "  ");

   end put_key;



   function key_of(the_object : object_type) return key_type is

   begin

      return the_object.key;

   end key_of;



   function ">"(left, right : object_type) return boolean is

   begin

      return (left.key > right.key);

   end ">";



   procedure display_sorted_list is new sorted_list_pak.display(put_object);

   procedure traverse_list is new sorted_list_pak.traverse(put_key);



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

            else set_col(20); put("=> ");

                 if operation(1..n) = "insert" 

                    then object.key := line(n+2..n+3);

                         iio.get(line(n+5..len), object.data, last); 

                         sorted_list_pak.insert(sorted_list, object);

                 elsif operation(1..n) = "find" 

                    then target_key := line(n+2..n+3);

                         sorted_list_pak.find(sorted_list,

                                              target_key,

                                              object,

                                              found);

                         if found then put_object(object);

                         else put("none");

                         end if;

                 elsif operation(1..n) = "change" 

                    then object.key := line(n+2..n+3);

                         iio.get(line(n+5..len), object.data, last); 

                         sorted_list_pak.change(sorted_list, object);

                 elsif operation(1..n) = "delete" 

                    then target_key := line(n+2..n+3);

                         sorted_list_pak.delete(sorted_list, target_key);

                 elsif operation(1..n) = "traverse"

                    then traverse_list(sorted_list);

                 elsif operation(1..n) = "clear" 

                    then sorted_list_pak.clear(sorted_list);

                 else put("??????");

                 end if;

                 new_line; display_sorted_list(sorted_list);

                 new_line; 

            end if;

         end loop loop2;

      exception

         when sorted_list_pak.list_empty => 

              set_col(30);

              put_line("list_empty exception raised");

         when sorted_list_pak.list_full =>  

              set_col(30);

              put_line("list_full exception raised");

      end;

   end loop loop1;

   new_line(2); put_line("sorted_list test completed.");

end sorted_list_test;

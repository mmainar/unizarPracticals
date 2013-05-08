   -------------------------------------------------------------------------
--|
--|  S O R T E D    L I S T S             
--|
--|  Abstract : This file contains the specification and implementation of
--|     a sorted list as described in Specification 4.4 of the text
--|     and with an implementation as described in Package Body 4.4.
--|     Stubbs & Webre, "Data Structures with Abstract Data Types and Ada,"
--|     PWS-Kent, 1993.
--|
--|  Related compilation units contained in this directory are:
--|
--|         Type               Name                  File
--|         ----               ----                  ----
--|     Specification          sorted_list_package   this file
--|     Implementation         sorted_list_package   this file
--|     Procedure              search                this file
--|
   ---------------------------------------------------------------------------
--|  Date 4/9/93     Version 1.0
   ---------------------------------------------------------------------------
--|  Description of Modifications.
--|
   ---------------------------------------------------------------------------
-- Specification 4.4 - Sorted Lists

-- Abstract Structure : The list objects are  ordered pairs <key, data> whose 
--    objects are of type "key_type" and "data_type", respectively. Both types 
--    are user specified. The order pairs are arranged linearly in the list. 
--    The key values in the list are unique, which means that no two list 
--    objects have the same key values.
--    For all list objects, the key of an object is greater than its 
--    predecessor's key and less than its successor's key.

-- Constraints : 0 <= number_of_objects <= max_size.  
                                         -- list_size and max_size appear below.
generic 

   type key_type  is private;  
   type object_type is private; 

   with function key_of (an_object : object_type) return key_type;

   with function ">" (left, right : key_type) return boolean is <>;
   -- results    : True if the left key > the right key; false otherwise.

package sorted_list_package is
                 
   type sorted_list (max_size : positive) is limited private;

   list_full  : exception;
   list_empty : exception;

procedure insert (the_list : in out sorted_list; the_object : object_type);
-- assumes    : No list object has a key value equal to key_of(the_object).
-- returns    : The object is inserted into the list in its proper position so 
--              that the list  remains sorted on the keys of the list objects.
-- exceptions : A list_full  exception is raised if 
--              number_of_objects(the_list) = the_list.max_size.

procedure delete (the_list : in out sorted_list; target_key : key_type);
-- results    : Removes the list object for which key_of(list_object) = 
--              target_key from the list; does nothing if no list object 
--              has that key value.

procedure change (the_list : in out sorted_list; the_object : object_type);
-- results    : Replaces the list object for which key_of(list_object) = 
--              key_of(the_object) with the_object; does nothing if no list 
--              object has that key value.

procedure clear (the_list : in out sorted_list);
-- results    : The number of objects in the list is 0 and the list is empty.

procedure find (the_list   : sorted_list;
                target_key : key_type;  
                the_object : out object_type; 
                found      : out boolean);
-- results    : If the list holds a list objectfor which key_of(list_object) = 
--              target_key, then the_object returns that list_object and found 
--              is true; otherwise found is false.

function number_of_objects (the_list : sorted_list) return natural;
-- results    : Returns the number of objects in the list. 

generic
   with procedure process(the_object : object_type);
   -- results    : "processes" a list object.
procedure traverse (the_list : in out sorted_list);
-- results    : Procedure "process" is called for each list object, from the 
--              first to the last progressing through the list in sorted order 
--              by key.

generic
   with procedure put_object(object : object_type);
procedure display(the_list : sorted_list);
-- results    : Displays the list of objects.

private
 
   type array_of_objects is array (positive range <>) of object_type;

   type sorted_list (max_size : positive) is record
      size    : natural;
      objects : array_of_objects (1 .. max_size);
   end record;


end sorted_list_package;

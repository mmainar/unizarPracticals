   -------------------------------------------------------------------------
--|
--|  S I M P L E    L I S T S           
--|
--|  Abstract : This file contains the specification and implementation of
--|     a simple list as described in Specification 4.1 of the text
--|     and with an implementation as described in Package Body 4.1.
--|     Stubbs & Webre, "Data Structures with Abstract Data Types and Ada,"
--|     PWS-Kent, 1993.
--|
--|  Related compilation units contained in this directory are:
--|
--|         Type               Name               File
--|         ----               ----               ----
--|     Specification          list_package      this file
--|     Implementation         list_package      this file
--|
   ---------------------------------------------------------------------------
--|  Date 4/9/93     Version 1.0
   ---------------------------------------------------------------------------
--|  Description of Modifications.
--|    1. 4/22/93   Generic procedure display was added.
   ---------------------------------------------------------------------------
-- Specification 4.1 - List

-- Abstract Structure : A set of objects of a user-specified type that are 
--    ordered linearly.

-- Constraints : 0 <= number_of_objects <= max_size
                                         -- list_size and max_size appear below.
generic 

   type object_type is private;                  -- Type of objects in the list.
   max_size : in positive;                         -- Maximum size of the lists.

package list_package is
     
   subtype count is natural range 0 .. max_size;
   type list(size : count := 0) is private;

   list_full  : exception;
   list_empty : exception;

function "&" (the_list : list; the_object : object_type) return list; 
-- results    : Returns the list with the_object appended to its end.
-- exceptions : A list_full  exception is raised when 
--              number_of_objects(the_list) = max_size.

function "&" (left, right : list) return list;
-- results    : Returns left and right concatenated in that order.
-- exceptions : A list_full  exception is raised when number_of_objects(left) + 
--              number_of_objects(right) > max_size.

function empty_list return list;
-- results    : Returns the list that has zero objects.

function head (the_list : list) return object_type;
-- results    : Returns the first object on the list.
-- exceptions : A list_empty  exception is raised when 
--              number_of_objects(the_list) = 0.

function tail (the_list : list) return list;
-- returns    : Returns a list consisting of all of the list except its head 
--              object.
-- exceptions : A list_empty  exception is raised when 
--              number_of_objects(the_list) = 0.

function number_of_objects(the_list : list) return natural;
-- returns    : The number of objects in the list. 

generic
   with procedure put_object(object : object_type);
procedure display(the_list : list);
-- results    : Displays the list of objects.

private

   type array_of_objects is array(positive range <>) of object_type;
   type list(size : count := 0) is record
      objects : array_of_objects(1 .. size);
   end record;

end list_package;


   -------------------------------------------------------------------------
--|
--|  I N D E X E D    L I S T S           
--|
--|  Abstract : This file contains the specification and implementation of
--|     an indexed list as described in Specification 4.3 of the text
--|     and with an implementation as described in Package Body 4.3.
--|     Stubbs & Webre, "Data Structures with Abstract Data Types and Ada,"
--|     PWS-Kent, 1993.
--|
--|  Related compilation units contained in this directory are:
--|
--|         Type               Name                  File
--|         ----               ----                  ----
--|     Specification          indexed_list_package  this file
--|     Implementation         indexed_list_package  this file 
--|
   ---------------------------------------------------------------------------
--|  Date 4/9/93     Version 1.0
   ---------------------------------------------------------------------------
--|  Description of Modifications.
--|    1. 4/22/93   Generic procedure display was added.
   ---------------------------------------------------------------------------
-- Specification 4.3 - Indexed Lists

-- Abstract Structure : A set of objects of a user-specified type that are 
--    ordered linearly; each list object is associated with an integer; 
--    the first (head) list object is associated with 1. Each other list 
--    object is associated with an integer that is one greater that the 
--    integer associated with its predecessor in the list.

-- Constraints : 0 <= number_of_objects <= max_size.   
    -- list_ size and max_size appear below.   

generic 

   type object_type is private;                  -- type of objects in the list.

package indexed_list_package is
      
type indexed_list (max_size : positive) is limited private;
              
   list_full       : exception;
   list_empty      : exception;
   faulty_position : exception;

procedure insert (the_list : in out indexed_list;
                  at_index : positive; 
                  the_object : object_type);
-- results    : The object is inserted into the_list at position at_index; 
--              all list objects following the object are at positions one 
--              greater than before the insertion.
-- exceptions : A faulty_position exception is raised if 
--              at_index > number_of_objects(the_list) + 1  
--              A list_full exception is raised if 
--              number_of_objects(the_list) = max_size.
-- note       : At_index can be one greater than number_of_objects(the_list) 
--              to allow appending new objects to the end of the list.

function  list_object (the_list : indexed_list; 
                       at_index : positive) return object_type;
-- results    : Returns a copy of the object of the list at position at_index.
-- exceptions : A faulty_position exception is raised if 
--              at_index > number_of_objects(the_list).  

procedure delete (the_list : in out indexed_list; at_index : positive);
-- results    : The object at position at_index is deleted from the list; 
--              all objects following it take positions one less than before 
--              the deletion.
-- exceptions : A faulty_position exception is raised if 
--              at_index > number_of_objects(the_list). 

procedure change (the_list   : in out indexed_list; 
                  at_index   : positive; 
                  the_object : object_type);
-- results    : The object in the list at position at_index is changed to 
--              the new value the_object.
-- exceptions : A faulty_position exception is raised if 
--              at_index > number_of_objects(the_list).

procedure clear (the_list : in out indexed_list);
-- results    : number_of_objects(the_list) is 0.

function  number_of_objects (the_list : indexed_list) return natural;
-- results    : Returns the number of objects in the list. 

generic
   with procedure put_object(object : object_type);
procedure display(the_list : indexed_list);
-- results    : Displays the list of objects.

private
 
   type array_of_objects is array (positive range <>) of object_type;

   type indexed_list (max_size : positive) is record
      size    : natural;
      objects : array_of_objects (1 .. max_size);
   end record;

end indexed_list_package;

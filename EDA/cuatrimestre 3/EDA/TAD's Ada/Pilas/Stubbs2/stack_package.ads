   -------------------------------------------------------------------------
--|
--|  S T A C K S                          
--|
--|  Abstract : This file contains the specification and implementation of
--|     a stack as described in Specification 3.3 of the text
--|     and with an implementation as described in Package Body 3.3.
--|     Stubbs & Webre, "Data Structures with Abstract Data Types and Ada,"
--|     PWS-Kent, 1993.
--|
--|  Related compilation units contained in this directory are:
--|
--|         Type               Name               File
--|         ----               ----               ----
--|     Specification          stack_package      this file
--|     Implementation         stack_package      this file
--|
   ---------------------------------------------------------------------------
--|  Date 4/9/93     Version 1.0
   ---------------------------------------------------------------------------
--|  Description of Modifications.
--|    1. 4/9/93    Generic display procedure added to display the stack.
--|
   ---------------------------------------------------------------------------
-- Specification 3.3 Stack 

-- Structure   : A set of objects of a user-specified type that are 
--    ordered by their time of insertion into the stack; the latest 
--    arrival is called the top object.

-- Constraints : 0 <= number_of_objects <= max_size.   
                              -- Number_of_objects and max_size appear below.
generic

   type object_type is private;             -- Type of objects to be stacked.

package stack_package is

   type stack (max_size : positive) is limited private;
   -- See private section below.

   stack_full  : exception;
   stack_empty : exception;

procedure push (the_stack : in out stack; the_object : object_type);
-- results    : the_object is added to the_stack as its top object.
-- exceptions : stack_full is raised if the number of objects on the stack = 
--              max_size.

procedure pop (the_stack : in out stack);
-- results    : The top object is deleted from the stack.
-- exceptions : stack_empty is raised if the number of objects on the stack = 0.

function top (the_stack : stack) return object_type;
-- results    : A copy of the top object of the stack is returned.
-- exceptions : stack_empty is raised if the number of objects on the stack = 0.

function number_of_objects (the_stack : stack) return natural;
-- results    : Returns the number of objects on the stack.

procedure clear(the_stack : in out stack);
-- results    : The stack size is set to zero; the stack is empty.

generic
   with procedure put_object(object : object_type);
procedure display(the_stack : stack);
-- results    : Displays the stack of objects.

private

   type array_of_objects is array(positive range <>) of object_type;

   -- Type stack is represented by a constrained discriminant record.
   type stack(max_size : positive) is record
      latest  : natural := 0;
      objects : array_of_objects(1 .. max_size);
   end record;

end stack_package;


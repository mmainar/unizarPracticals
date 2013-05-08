
   -------------------------------------------------------------------------
--|
--|  D Y N A M I C   S T A C K            
--|
--|  Abstract : This file contains the specification and implementation of
--|     a dynamic stack as described in Specification 3.2 of the text
--|     and with an implementation as described in Package Body 3.2
--|     Stubbs & Webre, "Data Structures with Abstract Data Types and Ada,"
--|     PWS-Kent, 1993.
--|
--|  Related compilation units contained in this directory are:
--|
--|         Type               Name                   File
--|         ----               ----                   ----
--|     Specification          dynamic_stack_package  this file
--|     Implementation         dynamic_stack_package  this file
--|
   ---------------------------------------------------------------------------
--|  Date 4/9/93     Version 1.0
   ---------------------------------------------------------------------------
--|  Description of Modifications.
--|    1. 4/9/93    Generic display procedure added to display the stack.
--|
   ---------------------------------------------------------------------------

-- Specification 3.2  Generic Dynamic Stack.  

-- Structure   : The objects are arranged linearly in order of their arrival in 
--    the stack; the latest arrival is called the top object..

-- Constraints : The maximum stack size is implementation dependent and is 
--    unknown. The Constraint statement is different from Specification 3.1.

generic

   type object_type is private;                 -- Type of object to be stacked.
                                -- The max_size parameter was removed from here.

package dynamic_stack_package is

   stack_full   : exception;
   stack_empty  : exception;

   procedure push (the_object : object_type);
   -- results    : The_object is appended to the stack as its top object.
   -- exceptions : Stack_full is raised if number_of_objects = max_size. 

   function top return object_type;
   -- results    : A copy of the top object of the stack is returned.
   -- exceptions : Stack_empty is raised if number_of_objects = 0.
   -- note       : The stack is not changed.

   procedure pop;
   -- results    : The top object is deleted from the stack.
   -- exceptions : Stack_empty is raised if number_of_objects = 0.

   function pop return object_type;
   -- results    : The top object is deleted from the stack and returned.
   -- exceptions : Stack_empty is raised if number_of_objects = 0.

   function number_of_objects  return natural;
   -- results    : Returns the number of objects currently in the stack. 

   procedure clear;
   -- results    : The number of objects in the stack is set to 0; 
   --            : the stack is empty.

   generic
      with procedure put_object(object : object_type);
   procedure display;
   -- results    : Displays the stack of objects.

end dynamic_stack_package;


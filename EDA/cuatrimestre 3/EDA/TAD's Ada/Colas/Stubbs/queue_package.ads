
   -------------------------------------------------------------------------
--|
--|  Q U E U E    (F I F O)               
--|
--|  Abstract : This file contains the specification and implementation of
--|     a queue as described in Specification 3.4 of the text
--|     and with an implementation as described in Package Body 3.4.
--|     Stubbs & Webre, "Data Structures with Abstract Data Types and Ada,"
--|     PWS-Kent, 1993.
--|
--|  Related compilation units contained in this directory are:
--|
--|         Type               Name               File
--|         ----               ----               ----
--|     Specification          queue_package      this file
--|     Implementation         queue_package      this file
--|
   ---------------------------------------------------------------------------
--|  Date 4/9/93     Version 1.0
   ---------------------------------------------------------------------------
--|  Description of Modifications.
--|    1. 4/22/93   In the private section of the package specifications, 
--|                 as it appears in the book, the line
--|                 first   : natural := 0;
--|                 was in error and was replaced by the line
--|                 first   : natural := 1;
--|    2. 4/22/93   The body of procedure enqueue was in error in the book
--|                 for generating a queue_full exception. The replacement
--|                 code in this file corrects the error.
--|    3. 4/26/93   The specification and body of generic procedures
--|                 traverse and prune, and procedure copy were added.
--|
   ---------------------------------------------------------------------------
-- Specification 3.4  Generic FIFO Queue.

-- Structure : The objects are arranged linearly in order of their arrival in 
--    the queue; the earliest (first) arrival is at the head of the queue, and 
--    the latest (last) arrival is at the tail.

-- Constraints : 0 <= number_of_obejcts <= max_size.
                   -- Number_of_objects and max_size appear below.
generic 

   type object_type is private;                 -- Type of objects to be queued.
        
package queue_package is
                 
   type queue(max_size : positive) is limited private;

   queue_full  : exception;
   queue_empty : exception;

procedure enqueue(the_queue : in out queue; the_object : object_type);
-- results    : the_object is added to the queue.
-- exceptions : A queue_full exception is raised if 
--              the_queue.number_of_objects = max_size. 

procedure dequeue(the_queue : in out queue); 
-- results    : The object that has been in the queue longest is removed from 
--              the queue. 
-- exceptions : A queue_empty exception is raised if 
--              the_queue.number_of_objects = 0. 

function head (the_queue : queue) return object_type;     
-- results    : A copy of the object that has been in the queue longest is 
--              returned.
-- exceptions : A queue_empty exception is raised if 
--              the_queue.number_of_objects = 0. 

function number_of_objects(the_queue : queue) return natural;
-- results    : Returns the number of objects in the queue. 

procedure clear (the_queue : in out queue);
-- results    : The number of objects in the queue is set to zero; 
--              the queue is empty.

generic
   with procedure put_object(object : object_type);
procedure display(the_queue : queue); 
-- results    : Displays the queue of objects.
 
procedure copy (the_queue : queue; the_copy : in out queue);
-- results : the_copy is a duplicate of the_queue.

generic
    with procedure process (the_object : object_type);
procedure traverse (the_queue : queue);
-- results : Procedure process is applied to each object in the_queue
--           until all objects have been processed.

generic
    with function prune_object (the_object : object_type) return boolean;
procedure prune (the_queue : in out queue);
-- results : Each object in the_queue for which prune_object returns true
--           is removed from the_queue. All other objects remain in the_queue
--           with the same relative positions.

private

   type array_of_objects is array(positive range <>) of object_type;
   
   type queue(max_size : positive) is record
      first   : natural := 1;                  -- The index of the object added 
                                                       -- to the queue earliest.
      last    : natural := max_size;           -- The index of the object added
                                                         -- to the queue latest.
      size    : natural := 0;             -- The number of objects in the queue.
      objects : array_of_objects(1 .. max_size);
                                                     -- Array of queued objects.
   end record;

end queue_package;


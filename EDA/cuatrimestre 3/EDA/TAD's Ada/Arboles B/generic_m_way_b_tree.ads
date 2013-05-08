--This disk is copyrighted by Prentice Hall.  Any material
--contained in these disks may be used without fee by any
--instructor who has adopted the textbook "Introduction to 
--Abstract Data Types Using AdA" by Bruce Hillam.  The 
--software is neither warranted or guaranteed.  The following
--are the directory contents of the PC version.
--
--   GENERIC_UNBOUNDED_M_WAY_TREE ?             ADT that implements a
--                        \ADT\B_TREE.ADT       B-tree as specified in
--                                              Figure 8.5.5 and Exercise
--                                              8.5.1. Test program exists.
--
generic
   b_tree_order :
   in positive := 5;
   type key_type is private; 
   type data_type is private; 
   with function "<" (
         left,            
         right : key_type ) 
     return boolean; 
package generic_m_way_b_tree is
   type b_tree is limited private; 
   procedure copy (
         from_tree : in     b_tree; 
         to_tree   :    out b_tree  ); 
   procedure clear (
         this_tree : in out b_tree ); 
   procedure insert (
         key       : in     key_type;  
         data      : in     data_type; 
         into_tree : in out b_tree     ); 
   procedure delete (
         key       : in     key_type; 
         from_tree : in out b_tree    ); 
   procedure update (
         key     : in     key_type;  
         data    : in     data_type; 
         in_tree : in out b_tree     ); 
   procedure next_inorder (
         key     :    out key_type;  
         data    :    out data_type; 
         in_tree : in out b_tree     ); 
   procedure set_inorder (
         in_tree : in out b_tree ); 
   function empty (
         tree_to_check : b_tree ) 
     return boolean; 
   function full (
         tree_to_check : b_tree ) 
     return boolean; 
   function count (
         of_tree : b_tree ) 
     return natural; 
   function equal (
         left,          
         right : b_tree ) 
     return boolean; 
   function key_in_b_tree (
         key     : key_type; 
         in_tree : b_tree    ) 
     return boolean; 
   function get_data_for_b_tree (
         key     : key_type; 
         in_tree : b_tree    ) 
     return data_type; 
   key_not_in_tree    : exception;
   key_is_in_tree     : exception;
   tree_empty         : exception;
   overflow           : exception;
private
   type tree_node; 
   type next is access tree_node; 
   type stack_node; 
   type tree_stack is access stack_node; 
   type b_tree is 
      record 
         root    : next;  
         count   : natural    := 0;  
         next_in : tree_stack;      --Used in traversal 
      end record; 
end generic_m_way_b_tree;
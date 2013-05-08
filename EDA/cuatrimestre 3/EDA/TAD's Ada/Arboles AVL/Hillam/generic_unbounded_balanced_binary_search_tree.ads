--This disk is copyrighted by Prentice Hall.  Any material
--contained in these disks may be used without fee by any
--instructor who has adopted the textbook "Introduction to 
--Abstract Data Types Using AdA" by Bruce Hillam.  The 
--software is neither warranted or guaranteed.  The following
--are the directory contents of the PC version.
--
--  GENERIC_UNBOUNDED_BALANCED_BINARY_SEARCH_TREE  ADT specified in Figure
--                       \ADT\U_BAL_TR.ADT      8.2.3   The version has the
--                                              same public part as
--                                              U_BSTREE.ADT. See Exercise
--                                              8.3.1
--
generic
   type key_type is private; 
   type data_type is private; 
   with function "<" (
         left,            
         right : key_type ) 
     return boolean; 
package generic_unbounded_balanced_binary_search_tree is
   type tree is limited private; 
   procedure copy (
         from_tree : in     tree; 
         to_tree   :    out tree  ); 
   procedure clear (
         t :    out tree ); 
   procedure insert (
         key  : in     key_type;  
         data : in     data_type; 
         t    : in out tree       ); 
   procedure delete (
         key : in     key_type; 
         t   : in out tree      ); 
   procedure update (
         key  : in     key_type;  
         data : in     data_type; 
         t    : in     tree       ); 
   procedure next_inorder (
         key  :    out key_type;  
         data :    out data_type; 
         t    : in out tree       ); 
   procedure set_inorder (
         t : in out tree ); 
   function count (
         t : tree ) 
     return natural; 
   function empty (
         t : tree ) 
     return boolean; 
   function equal (
         t1,       
         t2 : tree ) 
     return boolean; 
   function key_in_tree (
         key : key_type; 
         t   : tree      ) 
     return boolean; 
   function get_data_for_key (
         key : key_type; 
         t   : tree      ) 
     return data_type; 
   key_not_in_tree    : exception;
   key_is_in_tree     : exception;
   tree_is_empty      : exception;
   overflow           : exception;
private
   type tree_node; 
   type next is access tree_node; 
   type traversal; 
   type next_traversal is access traversal; 
   type tree is 
      record 
         root    : next;  
         count   : natural        := 0;  
         next_in : next_traversal;      --used in NEXT_INORDER; 
      end record; 

end generic_unbounded_balanced_binary_search_tree;
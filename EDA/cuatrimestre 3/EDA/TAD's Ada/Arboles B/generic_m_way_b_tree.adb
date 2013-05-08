package body generic_m_way_b_tree is

   type next_array is array (positive range 1 .. b_tree_order) of next; 
   type key_array is array (positive range 1 .. (b_tree_order - 1)) of key_type; 
   type data_array is array (positive range 1 .. (b_tree_order - 1)) of data_type; 
   type stack_node is 
      record 
         key_number      : positive;  
         next_tree_node  : next;  
         next_stack_node : tree_stack;  
      end record; 
   type tree_node is 
      record 
         in_use    : natural    := 0; 
         --Number non-null key-data pairs in node 
         key       : key_array;  
         data      : data_array;  
         next_node : next_array;  
      end record; 

   max_key_num,  
   min_key_num : positive;  
   --****************** LOCAL package UTILITY PROCEDURES
   procedure remove_key (
         this_node    : in     next;    
         key_position : in     positive ) is 
      temp : next := this_node;  
      --Removes key-data pair at position key_position from a leaf
      -- Assumes KEY_POSITION <= THIS_NODE>IN_USE
   begin
      if key_position < temp.in_use then
         temp.key(key_position..temp.in_use-1) :=
            temp.key(key_position+1..temp.in_use);
         temp.data(key_position..temp.in_use-1) :=
            temp.data(key_position+1..temp.in_use);
      end if;
      temp.next_node(key_position..temp.in_use) :=
         temp.next_node(key_position+1..temp.in_use+1);
      temp.in_use := temp.in_use - 1;
   end remove_key;

   procedure replace_with_successor (
         this_node    : in     next;    
         key_position : in     positive ) is 
      --Replaces key at KEY_POSITION key in node accessed by n with its
      --successor. The bookkeeping is done in RESTORE_NODE
      temp      : next := this_node.next_node (key_position + 1);
         
      temp_this : next := this_node;  
   begin
      -- Find node with successor
      while temp.next_node(1) /= null loop
         temp := temp.next_node(1);
      end loop;
      temp_this.key(key_position) := temp.key(1);
      temp_this.data(key_position) := temp.data(1);
   end replace_with_successor;

   procedure rotate_right (
         parent : in     next;    
         place  : in     positive ) is 
      -- Takes largest key-data in a PLACE node, puts it in
      -- the parent, and puts parent key-data pair in Place + 1
      temp : next := parent;  
   begin
      -- Make room in the place + 1 node
      temp.next_node(place+1).key(2..parent.next_node(place+1).in_use
         +1) :=
         temp.next_node(place+1).key(1..parent.next_node(place+1).
         in_use);
      temp.next_node(place+1).data(2..parent.next_node(place+1).in_use
         +1) :=
         temp.next_node(place+1).data(1..parent.next_node(place+1)
         .in_use) ;
      temp.next_node(place+1).next_node(2..parent.next_node(place+
            1).in_use+2) :=
         temp.next_node(place+1).next_node(1..parent.next_node(place
            +1).in_use+1 );
      --MOVE KEY-data from place in PARENT TO place+1 node NODE
      temp.next_node(place+1).key(1) := temp.key(place);
      temp.next_node(place+1).data(1) := temp.data(place);
      --Move last pair of place node to place in parent
      temp.key(place) :=
         temp.next_node(place).key(temp.next_node(place).in_use);
      temp.data(place) :=
         temp.next_node(place).data(temp.next_node(place).in_use);
      -- MOVE PLACE NEXT_NODE to PLACE+1
      temp.next_node(place+1).next_node(1) :=
         temp.next_node(place).next_node(temp.next_node(place).in_use
         +1);
      --Adjust IN_USE for place, place+1 nodes
      temp.next_node(place).in_use := temp.next_node(place).in_use
         - 1;
      temp.next_node(place+1).in_use := temp.next_node(place+1).in_use
         + 1;
   end rotate_right;

   procedure rotate_left (
         parent : in     next;    
         place  : in     positive ) is 
      -- Move from PLACE to PLACE - 1 and preserve structure
      temp : next := parent;  
   begin
      -- Move key-data from place in parent to last in place-1 node
      temp.next_node(place-1).key(temp.next_node(place-1).in_use+1
         ) :=
         temp.key(place);
      temp.next_node(place-1).data(temp.next_node(place-1).in_use+
         1) :=
         temp.data(place);
      -- Move key-data from place node to parent
      temp.key(place) := temp.next_node(place).key(1);
      temp.data(place) := temp.next_node(place).data(1);
      -- Adjust next node from position 1 in place to last in place-1
      temp.next_node(place-1).next_node(temp.next_node(place-1).in_use
         +1)
         := temp.next_node(place).next_node(1);
      -- Adjust IN_USE of place, place-1
      temp.next_node(place-1).in_use := temp.next_node(place-1).in_use
         + 1;
      temp.next_node(place).in_use := temp.next_node(place).in_use
         - 1;
      -- Shift things to left one position in place child
      temp := temp.next_node(place);
      temp.key(1..temp.in_use) := temp.key(2..temp.in_use+1);
      temp.data(1..temp.in_use) := temp.data(2..temp.in_use+1);
      temp.next_node(1..temp.in_use+1) := temp.next_node(2..temp.in_use
         +2);
   end rotate_left;

   procedure combine (
         parent : in     next;    
         place  : in     positive ) is 
      temp       : next     := parent;  
      count_next,  
      count_this : positive;  
      --Combines the two subtrees at PLACE and PLACE+1
      -- Bookkeeping in RESTORE_NODE guarantees room
   begin
      -- Puts key-data at PLACE in parent into child at place.
      temp.next_node(place).in_use := temp.next_node(place).in_use
         + 1;
      temp.next_node(place).key(temp.next_node(place).in_use) :=
         temp.key(place);
      temp.next_node(place).data(temp.next_node(place).in_use) :=
         temp.data(place);
      -- Move all key data node triples from place+1 to place
      count_next := temp.next_node(place+1).in_use;
      count_this := temp.next_node(place).in_use;
      temp.next_node(place).key(count_this+1..count_next+count_this
         ) :=
         temp.next_node(place+1).key(1..count_next);
      temp.next_node(place).data(count_this+1..count_next+count_this
         ) :=
         temp.next_node(place+1).data(1..count_next);
      temp.next_node(place).next_node(count_this+1..count_next+count_this
         +1) :=
         temp.next_node(place+1).next_node(1..count_next+1);
      temp.next_node(place).in_use := count_next + count_this;
      -- Shift out place in parent
      if temp.in_use = place then
         temp.next_node(temp.in_use) := temp.next_node(temp.in_use
            +1);
      else
         temp.key(place..temp.in_use-1) := temp.key(place+1..temp.
            in_use);
         temp.data(place..temp.in_use-1) := temp.data(place+1..temp
            .in_use);
         temp.next_node(place+1..temp.in_use) :=
            temp.next_node(place+2..temp.in_use+1);
      end if;
      temp.in_use := temp.in_use - 1;
   end combine;

   procedure restore_nodes (
         parent : in     next;    
         place  : in     positive ) is 
      -- PARENT.NEXT_NODE(PLACE) has too few key-data pairs
   begin
      if place = 1 then
         if parent.next_node(2).in_use > min_key_num then
            --Right node has extra key-data pair
            rotate_left (parent, 2);
         else
            combine (parent, place);
         end if;
      elsif
         place = parent.in_use then
         if parent.next_node(place-1).in_use > min_key_num then
            -- Left has extra key-data pair
            rotate_right (parent, place-1);
         else
            combine (parent, place-1);
         end if;
      else
         -- Deficient child is an 'interior' child
         if parent.next_node(place-1).in_use > min_key_num then
            rotate_right (parent, place-1);
         elsif
            parent.next_node(place+1).in_use > min_key_num then
            rotate_left (parent, place+1);
         else
            combine (parent, place);
         end if;
      end if;
   end restore_nodes;

   procedure search_this_node (
         key     : in     key_type; 
         subtree : in     next;     
         found   :    out boolean;  
         place   :    out positive  ) is 
      -- Searches a node for a given KEY.  Signals if it is in
      -- the node and where. If not in node, signals which subtree.
      count : positive := 1;  
   begin
      place := count;
      loop
         if count > subtree.in_use then
            found := false;
            return;
         elsif
            key < subtree.key(count) then
            found := false;
            return;
         elsif
            key = subtree.key(count) then
            found := true;
            return;
         else
            count := count + 1;
            place := count;
         end if;
      end loop;
   end search_this_node;

   procedure add_key_pair_to_node (
         key     : in     key_type;  
         data    : in     data_type; 
         temp_r  : in     next;      
         subtree : in     next;      
         place   : in     positive   ) is 
      -- Inserts a key-data pair at position PLACE in a node with room
   begin
      subtree.key(place+1..subtree.in_use+1) :=
         subtree.key(place..subtree.in_use);
      subtree.data(place+1..subtree.in_use+1) :=
         subtree.data(place..subtree.in_use);
      subtree.next_node(place+2..subtree.in_use+2) :=
         subtree.next_node(place+1..subtree.in_use+1);
      subtree.key(place) := key;
      subtree.data(place) := data;
      subtree.next_node(place+1) := temp_r;
      subtree.in_use := subtree.in_use + 1;
   end add_key_pair_to_node;

   procedure split_node (
         key              : in     key_type;  
         data             : in     data_type; 
         temp_r           : in     next;      
         parent           : in     next;      
         place            : in     positive;  
         median_key       :    out key_type;  
         median_data      :    out data_type; 
         median_next_node :    out next       ) is 
      -- Called from INSERT when a node where key-data pair belongs is full.
      -- Splits the full node PARENT before inserting a key-data-next
      -- triple.  The two nodes have minimum entries and the extra
      -- key-data-next triple is passed back up the B_TREE
      -- TEMP_R is the access value that KEY_DATA references after insertion
      median        : positive;  
      temp_new_node : next;  
      temp_parent   : next     := parent;  
   begin
      if place <= min_key_num then
         --New key-data will end up in the left node
         median := min_key_num;
      else
         median := min_key_num + 1;
      end if;
      -- Create the new 'right' node and put right half of PARENT in it.
      temp_new_node := new tree_node;
      temp_new_node.key(1..(max_key_num-median)) :=
         parent.key(median+1..max_key_num);
      temp_new_node.data(1..(max_key_num-median)) :=
         parent.data(median+1..max_key_num);
      temp_new_node.next_node(2..(b_tree_order-median)) :=
         parent.next_node(median+2..b_tree_order);
      temp_new_node.in_use := max_key_num - median;
      median_next_node := temp_new_node;
      temp_parent.in_use := median;
      -- New node created, initialized.  Parent adjusted.
      -- Now insert key-data-next triple and find median key-data-next triple
      if place <= min_key_num then
         --Add new key-data-next triple to PARENT
         add_key_pair_to_node(key, data, temp_r, temp_parent, place
            );
      else
         add_key_pair_to_node(key, data, temp_r, temp_new_node, place
            -median);
      end if;
      median_key := temp_parent.key(temp_parent.in_use);
      median_data := temp_parent.data(temp_parent.in_use);
      temp_new_node.next_node(1) :=
         temp_parent.next_node(temp_parent.in_use+1);
      temp_parent.in_use := temp_parent.in_use - 1;
   end split_node;

   procedure insert (
         key              : in     key_type;  
         data             : in     data_type; 
         subtree          : in     next;      
         key_not_inserted : in out boolean;   
         temp_key         : in out key_type;  
         temp_data        : in out data_type; 
         temp_r           : in out next       ) is 
      place : positive;  
      found : boolean;  
   begin
      if subtree = null then
         -- Tree searched and key not found.  This is the base case for
         -- recursion.  Insertion follows first return.
         key_not_inserted := true;
         temp_key := key;
         temp_data := data;
         temp_r := null;
      else
         search_this_node (key, subtree, found, place);
         if found then
            raise key_is_in_tree;
         else
            -- INSERT called recursively until SUBTREE.NEXT_NODE(PLACE) = null
            insert(key, data, subtree.next_node(place), key_not_inserted
               ,
               temp_key, temp_data, temp_r);
            -- Backtrack up the B_TREE until the key-data pair is inserted
            if key_not_inserted then
               if subtree.in_use < max_key_num then
                  key_not_inserted := false;
                  add_key_pair_to_node(temp_key,temp_data, temp_r,
                     subtree, place);
               else
                  key_not_inserted := true;
                  split_node (temp_key, temp_data, temp_r, subtree
                     , place,
                     temp_key, temp_data, temp_r);
               end if;
            end if;
         end if;
      end if;
   end insert;

   procedure delete (
         key       : in     key_type; 
         this_node : in     next      ) is 
      found : boolean;  
      place : positive; 
      -- Position of KEY in THIS_NODE or which subtree of 
      -- THIS_NODE if KEY not in THIS_NODE.
   begin
      if this_node = null then
         raise key_not_in_tree;
      else
         search_this_node (key, this_node, found, place);
         if found then
            if this_node.next_node (place) = null then
               -- THIS_NODE is a leaf, see figure 15.5.7a
               remove_key (this_node, place);
            else
               --Replace THIS_NODE.KEY(PLACE) with its successor, figure 15.5.9c
               replace_with_successor (this_node, place);
               delete (this_node.key(place), this_node.next_node(place
                     +1));
            end if;
         else
            --KEY is at least one level down
            delete (key, this_node.next_node(place));
         end if;
         -- Return here from recursive calls.  Must make sure all nodes have
         -- the minimum number of keys
         if this_node.next_node(place) /= null and then
               this_node.next_node(place).in_use < min_key_num then
            restore_nodes (this_node, place);
         end if;
      end if;
   end delete;



   --*************** BEGINNING OF package DEFINED OPERATIONS


   procedure copy (
         from_tree : in     b_tree; 
         to_tree   :    out b_tree  ) is 
      -- Makes an copy of FROM_TREE that contains the same key-data pairs.
      -- Exception OVERFLOW raised if there is not space to complete the copy
      key       : key_type;  
      data      : data_type;  
      temp_from,  
      temp_to   : b_tree;  
   begin
      if from_tree.count = 0 then
         to_tree := (null, 0, null);
      else
         temp_from := from_tree;
         temp_from.next_in := null;
         for count in 1..from_tree.count loop
            next_inorder (key, data, temp_from);
            insert  (key, data, temp_to);
         end loop;
         to_tree := temp_to;
      end if;
   end copy;

   procedure clear (
         this_tree : in out b_tree ) is 
      -- Returns a B_TREE root that has only null pointers.
      -- No key-data pairs are in the root.
   begin
      this_tree := (null, 0, null);
   end clear;


   procedure insert (
         key       : in     key_type;  
         data      : in     data_type; 
         into_tree : in out b_tree     ) is 
      -- Inserts a key-data pair into a given B_TREE.  Nodes are
      -- created as required.  Traversal reset to the beginning.
      -- Exception KEY_IS_IN_TREE raised if Key already in IN_TREE.
      -- Exception OVERFLOW raised if there is not space to add a node.
      add_level      : boolean;  
      temp_key       : key_type;  
      temp_data      : data_type;  
      temp_right,  
      temp_next_node : next;  
   begin
      insert ( key, data, into_tree.root, add_level,
         temp_key, temp_data, temp_right);
      if add_level then
         -- Tree needs a new root
         temp_next_node := new tree_node;
         temp_next_node.in_use := 1;
         temp_next_node.key(1) := temp_key;
         temp_next_node.data(1) := temp_data;
         temp_next_node.next_node(1) := into_tree.root;
         temp_next_node.next_node(2) := temp_right;
         into_tree.root := temp_next_node;
      end if;
      into_tree.count := into_tree.count + 1;
      into_tree.next_in := null;
   exception
      when storage_error =>
         raise overflow;
   end insert;

   procedure delete (
         key       : in     key_type; 
         from_tree : in out b_tree    ) is 
      -- Deletes a key-data pair with a specified from the B_TREE
      -- maintaining the B_tree structure.  Traversal rest to beginning.
      -- Exception KEY_NOT_IN_TREE raised if Key not in FROM_TREE.
   begin
      delete (key, from_tree.root);
      if from_tree.root.in_use = 0 then
         -- The 2 subtrees of the root were combined, delete one level
         from_tree.root := from_tree.root.next_node(1);
      end if;
      from_tree.count := from_tree.count - 1;
      from_tree.next_in := null;
   exception
      when key_not_in_tree =>
         raise key_not_in_tree;
   end delete;


   procedure update (
         key     : in     key_type;  
         data    : in     data_type; 
         in_tree : in out b_tree     ) is 
      -- Searches for a node with a specified key in the B_TREE and
      -- replaces its data field with a new value.  Traversals reset
      -- to the beginning.
      -- Exception KEY_NOT_IN_TREE raised if Key not in T.

      procedure update (
            key       : in     key_type;  
            data      : in     data_type; 
            this_node : in out next       ) is 
      begin
         if this_node.in_use = 0 then
            -- Node could be an empty root.
            raise key_not_in_tree;
         else
            for index in positive range 1..this_node.in_use loop
               if key < this_node.key(index) then
                  if this_node.next_node(index) = null then
                     -- THIS_NODE is a leaf
                     raise key_not_in_tree;
                  else
                     update (key, data, this_node.next_node(index)
                        );
                  end if;
               elsif
                  key = this_node.key(index) then
                  this_node.data(index) := data;
                  return;
               end if;
            end loop;
            if this_node.next_node(this_node.in_use+1) = null then
               raise key_not_in_tree;
            else
               update (key, data, this_node.next_node(this_node.in_use
                     +1));
            end if;
         end if;
      end update;

   begin
      update (key, data, in_tree.root);
      in_tree.next_in := null;
   exception
      when key_not_in_tree =>
         raise key_not_in_tree;
   end update;

   procedure next_inorder (
         key     :    out key_type;  
         data    :    out data_type; 
         in_tree : in out b_tree     ) is 
      -- Returns the next key-data pair in an ascending order by key.
      -- When the traversal is finished it will repeat.  Any insertion
      -- or deletion of a key-data pair will cause the traversal to reset.
      -- Exception OVERFLOW raised if there is not space to manage the stack.
      -- Exception TREE_EMPTY raised if there are no key-data pairs to return
      temp_index : natural;  
      temp_node  : next;  
   begin
      if in_tree.count = 0 then
         raise tree_empty;
      end if;
      if in_tree.next_in = null then
         -- Stack is empty, we must build stack up for the traversal
         -- The node referenced by the top of the stack is the next to be
         -- processed.
         in_tree.next_in := new stack_node'(1, in_tree.root, null)
            ;
         while in_tree.next_in.next_tree_node.next_node(1) /= null
               loop
            in_tree.next_in := new stack_node'(1,
               in_tree.next_in.next_tree_node.next_node(1), in_tree
               .next_in);
         end loop;
      end if;
      -- Get the next key-data pair
      temp_index := in_tree.next_in.key_number;
      temp_node := in_tree.next_in.next_tree_node;
      key  := temp_node.key(temp_index);
      data := temp_node.data(temp_index);
      -- Update the stack so the next key-data pair is on top.  Recall
      -- that if the node is a leaf, all pairs must be returned before
      -- the node is popped.  If the node is not a leaf, the next key-data
      -- pair returned will be from a leaf.
      if temp_node.next_node(temp_index) = null then
         -- TEMP_NODE is a leaf
         if temp_index < temp_node.in_use then
            -- More pairs to return in this leaf
            in_tree.next_in.key_number := in_tree.next_in.key_number
               + 1;
         else
            -- Parent has next key-data pair, Pop the stack.
            in_tree.next_in := in_tree.next_in.next_stack_node;
         end if;
      else
         -- TEMP_NODE is not a leaf
         if temp_index < temp_node.in_use then
            -- More pairs in this node and in subtrees to return
            in_tree.next_in.key_number := in_tree.next_in.key_number
               + 1;
            -- Must get down to leaf for the first key data pair
            in_tree.next_in := new stack_node'(1,
               temp_node.next_node(temp_index+1), in_tree.next_in)
               ;
            while in_tree.next_in.next_tree_node.next_node(1) /= null
                  loop
               in_tree.next_in := new stack_node'(1,
                  in_tree.next_in.next_tree_node.next_node(1), in_tree
                  .next_in);
            end loop;
         else
            -- All key-data pairs in this non-leaf node have been return,
            -- must pop stack but put on the last subtree
            in_tree.next_in := in_tree.next_in.next_stack_node;
            in_tree.next_in := new stack_node'(1,
               temp_node.next_node(temp_index+1), in_tree.next_in)
               ;
            while in_tree.next_in.next_tree_node.next_node(1) /= null
                  loop
               in_tree.next_in := new stack_node'(1,
                  in_tree.next_in.next_tree_node.next_node(1), in_tree
                  .next_in);
            end loop;
         end if;
      end if;
   end next_inorder;

   procedure set_inorder (
         in_tree : in out b_tree ) is 
      -- Resets the traversal sequence.
   begin
      in_tree.next_in := null;
   end set_inorder;

   function empty (
         tree_to_check : b_tree ) 
     return boolean is 
      -- Returns true the tree contains no key-data pairs.
   begin
      return tree_to_check.count = 0;
   end empty;

   function full (
         tree_to_check : b_tree ) 
     return boolean is 
      -- Returns true if there is no space to add a new node to the tree.
      -- It is possible to add key-data pairs without adding nodes
      temp : next;  
   begin
      temp := new tree_node;
      return false;
   exception
      when storage_error =>
         return true;
   end full;

   function count (
         of_tree : b_tree ) 
     return natural is 
      -- Returns true the tree contains no key-data pairs.
   begin
      return of_tree.count;
   end count;

   function equal (
         left,          
         right : b_tree ) 
     return boolean is 
      -- Returns true if both B-trees contain the same key-data pairs.
      left_key,  
      right_key  : key_type;  
      left_data,  
      right_data : data_type;  
      left_tree  : b_tree    := left;  
      right_tree : b_tree    := right;  
   begin
      if left_tree.count = 0 then
         return right_tree.count = 0;
      elsif
         left_tree.count /= right_tree.count then
         return false;
      else
         left_tree.next_in := null;
         right_tree.next_in := null;
         for count in 1..left_tree.count loop
            next_inorder (left_key, left_data, left_tree);
            next_inorder (right_key, right_data, right_tree);
            if left_key /= right_key or else left_data /= right_data
                  then
               return false;
            end if;
         end loop;
         return true;
      end if;
   end equal;

   function key_in_b_tree (
         key     : key_type; 
         in_tree : b_tree    ) 
     return boolean is 
      -- Returns true if the specified key is in the tree.

      function find_key (
            key       : key_type; 
            this_node : next      ) 
        return boolean is 
      begin
         if this_node.in_use = 0 then
            -- Node could be an empty root.
            return false;
         else
            for index in positive range 1..this_node.in_use loop
               if key < this_node.key(index) then
                  if this_node.next_node(index) = null then
                     -- THIS_NODE is a leaf
                     return false;
                  else
                     return find_key (key, this_node.next_node(index
                           ));
                  end if;
               elsif
                  key = this_node.key(index) then
                  return true;
               end if;
            end loop;
            if this_node.next_node(this_node.in_use+1) = null then
               return false;
            else
               return find_key (key, this_node.next_node(this_node
                     .in_use+1));
            end if;
         end if;
      end find_key;

   begin
      if in_tree.count = 0 then
         return false;
      else
         return find_key (key, in_tree.root);
      end if;
   end key_in_b_tree;

   function get_data_for_b_tree (
         key     : key_type; 
         in_tree : b_tree    ) 
     return data_type is 
      -- Searches a specified B-tree for a node with a specified key-data
      -- pair and returns the associated data field.
      -- Exception KEY_NOT_IN_TREE raised if Key not in T.

      function find_data (
            key       : key_type; 
            this_node : next      ) 
        return data_type is 
      begin
         if this_node.in_use = 0 then
            -- Node could be an empty root.
            raise key_not_in_tree;
         else
            for index in positive range 1..this_node.in_use loop
               if key < this_node.key(index) then
                  if this_node.next_node(index) = null then
                     -- THIS_NODE is a leaf
                     raise key_not_in_tree;
                  else
                     return find_data (key, this_node.next_node(index
                           ));
                  end if;
               elsif
                  key = this_node.key(index) then
                  return this_node.data(index);
               end if;
            end loop;
            if this_node.next_node(this_node.in_use+1) = null then
               raise key_not_in_tree;
            else
               return find_data (key, this_node.next_node(this_node
                     .in_use+1));
            end if;
         end if;
      end find_data;

   begin
      return find_data (key, in_tree.root);
   end get_data_for_b_tree;

begin --Set up package global values.  These are treated as constants

   min_key_num := positive (float (b_tree_order-1)/2.0);
   max_key_num := b_tree_order - 1;

end generic_m_way_b_tree;
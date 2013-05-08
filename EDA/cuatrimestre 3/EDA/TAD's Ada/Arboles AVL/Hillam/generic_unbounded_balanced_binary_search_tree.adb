package body generic_unbounded_balanced_binary_search_tree is

   type balance_type is 
         (left_heavy, 
          in_balance, 
          right_heavy); 

   type tree_node is 
      record 
         key     : key_type;  
         data    : data_type;  
         balance : balance_type;  
         left,  
         right   : next;  
      end record; 

   type traversal is 
      record 
         process   : next;  
         next_proc : next_traversal;  
      end record; 

   procedure balance_l (
         t            : in out next;   
         balance_flag :    out boolean ) is 
      -- A node was deleted out of left subtree of T, and the height
      -- shortened.  BALANCE_L will rebalance.
      t1 : next         := t.right;  
      t2 : next;  
      tb : balance_type := t1.balance;  
   begin
      case t.balance is
         when left_heavy   =>
            -- T was LEFT_HEAVY before the deletion, and left subtree has
            -- had its height reduced, so T must be in balance
            t.balance := in_balance;
         when in_balance   =>
            -- T was IN_BALANCE before the deletion, and left subtree has
            -- had its height reduced, so T is Right heavy and its
            -- height has no been changed.  No further rebalancing needed
            t.balance := right_heavy;
            balance_flag := false;
         when right_heavy  =>
            -- T was RIGHT_HEAVY before deletion, left subtree's height has
            -- been reduced, so T is out of balance
            if tb /= left_heavy then
               -- Right subtree is not left heavy, need single R rotation
               t.right := t1.left;
               t1.left := t;
               if tb = in_balance then
                  -- Right subtree still IN_BALANCE, T now right heavy, and
                  -- height of T not changed.  No more rebalancing necessary
                  t.balance := right_heavy;
                  t1.balance := left_heavy;
                  balance_flag := false;
               else
                  -- Right subtree was RIGHT_HEAVY, T now IN_BALANCE and its
                  -- height has been reduced.  More balancing needed.
                  t.balance := in_balance;
                  t1.balance := in_balance;
               end if;
               t := t1;
            else
               -- Situation similar to figure 15.3.12c, double RL rotation
               -- needed
               t2 := t1.left;
               tb := t2.balance;
               t1.left := t2.right;
               t2.right := t1;
               t.right := t2.left;
               t2.left := t;
               if tb = right_heavy then
                  t.balance := left_heavy;
               else
                  t.balance := in_balance;
               end if;
               if tb = left_heavy then
                  t1.balance := right_heavy;
               else
                  t1.balance := in_balance;
               end if;
               t := t2;
               t2.balance := in_balance;
            end if;
      end case;
   end balance_l;

   procedure balance_r (
         t            : in out next;   
         balance_flag :    out boolean ) is 

      t1 : next         := t.left;  
      t2 : next;  
      tb : balance_type := t1.balance;  
   begin
      case t.balance is
         when right_heavy   =>
            t.balance := in_balance;
         when in_balance   =>
            t.balance := left_heavy;
            balance_flag := false;
         when left_heavy  =>
            if tb /= right_heavy then -- need single LL rotation
               t.left := t1.right;
               t1.right := t;
               if tb = in_balance then
                  t.balance := left_heavy;
                  t1.balance := right_heavy;
                  balance_flag := false;
               else --Tb = Right_heavy
                  t.balance := in_balance;
                  t1.balance := in_balance;
               end if;
               t := t1;
            else  --double LR rotation
               t2 := t1.right;
               tb := t2.balance;
               t1.right := t2.left;
               t2.left := t1;
               t.left := t2.right;
               t2.right := t;
               if tb = left_heavy then
                  t.balance := right_heavy;
               else
                  t.balance := in_balance;
               end if;
               if tb = right_heavy then
                  t1.balance := left_heavy;
               else
                  t1.balance := in_balance;
               end if;
               t := t2;
               t2.balance := in_balance;
            end if;
      end case;
   end balance_r;

   procedure copy (
         from_tree : in     tree; 
         to_tree   :    out tree  ) is 
      -- Makes an exact copy of a specified tree that preserves structure an
      -- shares no nodes.  The traversals of the tree TO_TREE start at the first
      -- node of the particular traversal
      -- Exception OVERFLOW raised if insufficient memory left to add a node
      temp_root : next;  

      procedure copy (
            from : in     next; 
            to   :    out next  ) is 
         -- Recursive procedure that first copies the current node,
         -- then the node's left subtree, then the nodes right subtree
         temp_node : next;  
      begin
         if from = null then
            to := null;
         else
            temp_node := new tree_node'
               (from.key, from.data, from.balance, null, null);
            copy(from.left, temp_node.left);
            copy (from.right, temp_node.right);
            to := temp_node;
         end if;
      end copy;

   begin
      if from_tree.count /= 0 then
         copy(from_tree.root, temp_root);
      end if;
      to_tree := (temp_root, from_tree.count, null);
   exception
      when storage_error =>
         raise overflow;
   end copy;



   procedure clear (
         t :    out tree ) is 
   begin
      t := (null, 0, null);
   end clear;

   procedure insert (
         key  : in     key_type;  
         data : in     data_type; 
         t    : in out tree       ) is 
      -- Creates a node containing a given key-data pair and inserts that
      -- node into the tree T while preserving the binary search structure
      -- The inorder traversals is set to begin at the first key-data pair.
      -- After insertion, the tree is rebalanced if necessary.
      -- Exception OVERFLOW raised if insufficient memory left to add a node
      -- Exception KEY_IS_IN_TREE raised if an attempt is made to insert a
      --           duplicate key

      rebalance_flag : boolean := false; 
      -- Signals if node's balance has  
      -- changed
      procedure insert (
            key            : in     key_type;  
            data           : in     data_type; 
            t              : in out next;      
            rebalance_flag : in out boolean    ) is 
         t1,  
         t2 : next;  
      begin
         if t = null then
            -- At the leaf, so insert.  Note all leaves IN_BALANCE by definition.
            t := new tree_node' (key, data, in_balance, null, null
               );
            -- Balance of the parent has been changed, set REBALANCE_FLAG
            -- accordingly.
            rebalance_flag := true;
         elsif
            key < t.key then
            insert (key, data, t.left, rebalance_flag);
            if rebalance_flag then
               -- Subtree balance altered because the left subtree height increased
               case t.balance is
                  when left_heavy  =>
                     -- Current node was LEFT_HEAVY before insertion, situation now
                     -- same as illustrated in figure 15.3.5a or 15.3.7a
                     t1 := t.left;
                     if t.left.balance = left_heavy then
                        -- The left child's left child is also left heavy, situation              
                        -- same as in figure 15.3.5a. Single L rotation needed
                        t.left := t1.right;
                        t1.right := t;
                        t := t1;
                        t.balance := in_balance;
                        -- After rebalancing, situation same as in figure 15.3.5b
                     else
                        -- Left subtree is now right heavy, see figure 15.3.7a
                        -- Double LR rotation required
                        t2 := t1.right;
                        t1.right := t2.left;
                        t2.left := t1;
                        t.left := t2.right;
                        t2.right := t;
                        if t2.balance = left_heavy then
                           t.balance := right_heavy;
                        else
                           t.balance := in_balance;
                        end if;
                        if t2.balance = right_heavy then
                           t1.balance := left_heavy;
                        else
                           t1.balance := in_balance;
                        end if;
                        t := t2;
                     end if;
                     -- Rebalancing now complete.  Resulting node is IN_BALANCE
                     -- and node's depth has not changed.  No further rebalancing  
                     -- needed.
                     t.balance := in_balance;
                     rebalance_flag := false;
                  when in_balance  =>
                     -- Present node was IN_BLANCE before insertion, its left subtree
                     -- had its height increased.  Balance is now LEFT_HEAVY.
                     --  Rebalancing still necessary so REBALANCE_FLAG not changed.
                     t.balance := left_heavy;
                  when right_heavy =>
                     -- Present node was RIGHT_HEAVY, left subtree depth increased,
                     -- Result is that node is IN_BALANCE, no futher rebabalancing
                     -- is necessay as its depth has not been changed
                     t.balance := in_balance;
                     rebalance_flag := false;
               end case;
            end if;
         elsif
            t.key < key then
            insert (key, data, t.right, rebalance_flag);
            if rebalance_flag then
               case t.balance is
                  when left_heavy  =>
                     -- Present node was LEFT_HEAVY before insertion.  Now that right
                     -- subtree has had its height increased, node becomes balanced
                     -- and no further rebalancing necessary
                     t.balance := in_balance;
                     rebalance_flag := false;
                  when in_balance  =>
                     -- Present node was IN_BALANCE but its right subtree height
                     -- increased, so node is now RIGHT_HEAVY, its height increased,
                     -- so further rebalancing still necessary.
                     t.balance := right_heavy;
                  when right_heavy =>
                     -- Present node was right heavy before insertion and now
                     -- the right subtree height has increased. Situation same as
                     -- illusatrated in figure 15.3.6a or figure 15.3.8.
                     t1 := t.right;
                     if t1.balance = right_heavy then
                        -- Right subtree's is now RIGHT_HEAVY, see figure 15.3.6a.
                        -- A single R rotation needed.  Result is present node
                        -- IN_BALANCE and no further rebalancing necessary
                        t.right := t1.left;
                        t1.left := t;
                        t.balance := in_balance;
                        t := t1;
                     else
                        -- Right subtree's left subtree height has increased.  
                        -- Situation illustrated in figure 15.3.8.  Double RL rotation
                        -- required. Result is a node IN_BLANCE without height of
                        -- the subtree being changed.  No further rebalancing needed
                        t2 := t1.left;
                        t1.left := t2.right;
                        t2.right := t1;
                        t.right := t2.left;
                        t2.left := t;
                        if t2.balance = left_heavy then
                           t1.balance := right_heavy;
                        else
                           t1.balance := in_balance;
                        end if;
                        if t2.balance = right_heavy then
                           t.balance := left_heavy;
                        else
                           t.balance := in_balance;
                        end if;
                        t := t2;
                     end if;
                     t.balance := in_balance;
                     rebalance_flag := false;
               end case;
            end if;
         else
            --T.KEY = KEY
            raise key_is_in_tree;
         end if;
      end insert;

   begin
      insert (key, data, t.root, rebalance_flag);
      t.count := t.count + 1;
      t.next_in := null;
   exception
      when key_is_in_tree =>
         raise key_is_in_tree;
   end insert;

   procedure delete (
         key : in     key_type; 
         t   : in out tree      ) is 
      -- Deletes a node with a given key from a specified tree T while
      -- preserving the search structure.  The inorder traversal is
      -- reset to start at the beginning.  The tree is re-balanced if necessary
      -- Exception KEY_NOT_IN_TREE raised if no node contains specified key.

      rebalance_flag : boolean := false;  


      procedure delete (
            key            : in     key_type; 
            t              : in out next;     
            rebalance_flag : in out boolean   ) is 

         procedure delete_largest_key (
               t              : in out next;      
               key            :    out key_type;  
               data           :    out data_type; 
               rebalance_flag : in out boolean    ) is 
            -- Finds the node with the key, returns the key and data in that
            -- node, and deletes that node
         begin
            if t.right = null then
               -- Node with the largest key can never have a right subtree
               -- because all keys on the right would be larger
               key := t.key;
               data := t.data;
               -- Node with largest key may have left child
               t := t.left;
               -- Signal balance has changed because node deleted
               -- See figure 15.3.12a
               rebalance_flag := true;
            else
               delete_largest_key (t.right, key, data, rebalance_flag
                  );
               if rebalance_flag then
                  balance_r (t, rebalance_flag);
               end if;
            end if;
         end delete_largest_key;

      begin
         if t = null then
            raise key_not_in_tree;
         elsif
            key < t.key then
            delete (key, t.left, rebalance_flag);
            -- If balance of the left subtree has changed, must balance the left
            if rebalance_flag then
               balance_l (t, rebalance_flag);
            end if;
         elsif
            t.key < key then
            delete (key, t.right, rebalance_flag);
            -- If balance of the right subtree has changed, must balance the right
            if rebalance_flag then
               balance_r (t, rebalance_flag);
            end if;
         else
            --T.Key = Key
            if t.left = null then
               -- Because T is balanced,T either has no children or a single right
               -- child
               t := t.right;
               rebalance_flag := true;
            elsif
               t.right = null then
               -- T has a single left child
               t := t.left;
               rebalance_flag := true;
            else
               --T has two children
               delete_largest_key (t.left, t.key, t.data, rebalance_flag
                  );
               -- The left subtree may have had its balance altered
               if rebalance_flag then
                  balance_l (t, rebalance_flag);
               end if;
            end if;
         end if;
      end delete;

   begin
      delete (key, t.root, rebalance_flag);
      t.count := t.count - 1;
      t.next_in := null;
   exception
      when key_not_in_tree =>
         raise key_not_in_tree;
   end delete;

   procedure update (
         key  : in     key_type;  
         data : in     data_type; 
         t    : in     tree       ) is 

      procedure update (
            k : in     key_type;  
            x : in     data_type; 
            r : in     next       ) is 
         temp_r : next := r;  
      begin
         if r = null then
            raise key_not_in_tree;
         elsif
            r.key = k then
            temp_r.data := x;
         elsif
            k < r.key then
            update(k, x, r.left);
         else
            update(k, x, r.right);
         end if;
      end update;

   begin
      update(key, data, t.root);
   end update;

   procedure next_inorder (
         key  :    out key_type;  
         data :    out data_type; 
         t    : in out tree       ) is 
      temp : next;  
   begin
      if t.count = 0 then
         raise tree_is_empty;
      end if;
      if t.next_in = null then
         t.next_in := new traversal'(t.root, null);
         temp := t.root;
         while temp /= null and then temp.left /= null loop
            t.next_in := new traversal'(temp.left, t.next_in);
            temp := temp.left;
         end loop;
      end if;
      temp := t.next_in.process;
      key    := temp.key;
      data    := temp.data;
      t.next_in := t.next_in.next_proc;
      if temp.right /= null then
         t.next_in := new traversal'(temp.right, t.next_in);
         temp := temp.right;
         while temp /= null and then temp.left /= null loop
            t.next_in := new traversal'(temp.left, t.next_in);
            temp := temp.left;
         end loop;
      end if;
   end next_inorder;

   procedure set_inorder (
         t : in out tree ) is 
   begin
      t.next_in := null;
   end set_inorder;

   function empty (
         t : tree ) 
     return boolean is 
   begin
      return t.count = 0;
   end empty;

   function count (
         t : tree ) 
     return natural is 
   begin
      return t.count;
   end count;

   function equal (
         t1,       
         t2 : tree ) 
     return boolean is 
      -- Returns true if both trees contain the same key-data pairs.
      -- Trees may have different structures.
      temp1 : tree      := t2;  
      temp2 : tree      := t2;  
      k1,  
      k2    : key_type;  
      d1,  
      d2    : data_type;  
   begin
      if t1.count = 0 then
         return t2.count = 0;
      elsif
         t1.count /= t2.count then
         return false;
      else
         -- Trees are equal if contain the same KEY-DATA pairs
         -- TEMP1 and TEMP2 reference T1 and T2 directly, but TEMP1.NEXT_IN
         -- and TEMP2.NEXT_IN can be manipulated without affecting T1.NEXT_IN
         -- and T2.NEXT_IN.  T1 and T2 both have the same number of key-data
         -- pairs. Do an inorder traversal and compare pair by pair.
         -- Make sure both traversals start at the beginning.
         temp1.next_in := null; --SET_INORDER (TEMP1);
         temp2.next_in := null; --SET_INORDER (TEMP2);
         for i in 1..temp1.count loop
            next_inorder(k1, d1, temp1);
            next_inorder(k2, d2, temp2);
            if k1 /= k2 or d1 /= d2 then
               return false;
            end if;
         end loop;
         return true;
      end if;
   end equal;

   function key_in_tree (
         key : key_type; 
         t   : tree      ) 
     return boolean is 

      function key_tree (
            k : key_type; 
            r : next      ) 
        return boolean is 
      begin
         if r = null then
            return false;
         elsif
            r.key = k then
            return true;
         elsif
            k < r.key  then
            return key_tree(k, r.left);
         else
            return key_tree(k, r.right);
         end if;
      end key_tree;

   begin
      return key_tree(key, t.root);
   end key_in_tree;

   function get_data_for_key (
         key : key_type; 
         t   : tree      ) 
     return data_type is 

      function key_data (
            k : key_type; 
            r : next      ) 
        return data_type is 
      begin
         if r = null then
            raise key_not_in_tree;
         elsif
            r.key = k then
            return r.data;
         elsif
            k < r.key  then
            return key_data(k, r.left);
         else
            return key_data(k, r.right);
         end if;
      end key_data;

   begin
      return key_data(key, t.root);
   end get_data_for_key;

end generic_unbounded_balanced_binary_search_tree;
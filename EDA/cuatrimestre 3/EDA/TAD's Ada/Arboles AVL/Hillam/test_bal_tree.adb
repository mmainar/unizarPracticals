with text_io;
use text_io;
with generic_unbounded_balanced_binary_search_tree;
procedure test_bal_tree is 

   -- Same as TEST_TREE except all references to preorder and
   -- postorder traversals removed

   type traversal_array is array (integer range <>) of integer; 

   package my_tree is new
      generic_unbounded_balanced_binary_search_tree (integer, integer
      , "<");
   use my_tree;

   flag_copy,                         
   -- Used with operation COPY 
   flag_clear,                        
   -- Used with operation CLEAR 
   flag_insert,                       
   -- Used with operation INSERT 
   flag_delete,                       
   -- Used with operation DELETE 
   flag_update,                       
   -- Used with operation UPDATE 
   flag_next_in,                      
   -- Used with operation NEXT_INORDER 
   flag_set_in,                       
   -- Used with operation SET_INORDER 
   flag_count,                        
   -- Used with operation COUNT 
   flag_empty,                        
   -- Used with operation EMPTY 
   flag_equal,                        
   -- Used with operation EQUAL 
   flag_key,                          
   -- Used with operation KEY_IN_TREE 
   flag_get,                          
   -- Used with operation GET_DATA_FOR_TREE 
   flag_key_in,                       
   -- Used with exception KEY_IS_IN_TREE 
   flag_key_not,                      
   -- Used with exception KEY_NOT_IN_TREE 
   flag_tree_empty : boolean := true; 
   -- Used with exception TREE_IS_EMPTY 
   key,  
   data            : integer := 0;    
   -- Dummy variables as needed 
   empty_tree,  
   full_tree,  
   random_tree,  
   temp_tree       : tree;  
   --      FULL_TREE         4
   --                      /   \
   --                    2       6
   --                   / \     / \
   --                  1   3   5   7
   --
   full_inorder : traversal_array (1 .. 7) := (1, 2, 3, 4, 5, 6, 7);
      
   --
   --      RANDOM_TREE             20
   --                       /                 \
   --                   10                        30
   --               /        \                /        \
   --             7           15           25            40
   --          /     \       /   \       /    \             \
   --        4        9    13     18    22     27            45
   --      /   \     /       \   /  \                           \
   --     1     5   8        14 17   19                          50
   --      \                                                    /
   --       2                                                 48
   --
   random_inorder : traversal_array (1 .. 23) := (1, 2, 4, 5, 7, 8,
     9, 10, 13, 14, 15, 17, 18, 19, 20, 22, 25, 27, 30, 40, 45, 48,
     50);  

   procedure build_trees is 
   begin
      --A preorder insertion will build the trees exactly as above
      for index in 1..7 loop
         insert (full_inorder(index), full_inorder(index), full_tree
            );
      end loop;
      for index in 1..23 loop
         insert (random_inorder(index), random_inorder(index), random_tree
            );
      end loop;
   exception
      when others =>
         put_line ("Unanswered exception raised in BUILD_TREES");
         put_line ("BUILD_TREES trees does partial test of INSERT"
            );
   end build_trees;

   procedure test_exceptions is 
   begin
      -- Testing KEY_NOT_IN_TREE, note 11 not in RANDOM_TREE
      begin
         delete (11, random_tree);
         flag_delete := false;
         put_line ("9");
         flag_key_not := false;
      exception
         when key_not_in_tree =>
            null;
         when others          =>
            flag_key_not := false;
      end;
      begin
         update (11, 11, random_tree);
         flag_update := false;
         flag_key_not := false;
      exception
         when key_not_in_tree =>
            null;
         when others          =>
            flag_key_not := false;
      end;
      begin
         if 11 = get_data_for_key (11, random_tree) then
            null;
         end if;
         flag_get := false;
         flag_key_not := false;
      exception
         when key_not_in_tree =>
            null;
         when others          =>
            flag_key_not := false;
      end;
      -- Testing KEY_IS_IN_TREE, note 18 in RANDOM_TREE
      begin
         insert (18, 11, random_tree);
         flag_insert := false;
         flag_key_in := false;
      exception
         when key_is_in_tree =>
            null;
         when others          =>
            flag_key_in := false;
      end;
      -- Testing TREE_IS_EMPTY
      begin
         next_inorder (key, data, empty_tree);
         flag_next_in := false;
         flag_tree_empty := false;
      exception
         when tree_is_empty =>
            null;
         when others        =>
            flag_tree_empty := false;
      end;
      if flag_key_in then
         put_line ("Exception KEY_IS_IN_TREE properly raised.");
      else
         put_line ("Exception KEY_IS_IN_TREE not properly raised."
            );
      end if;
      if flag_key_not then
         put_line ("Exception KEY_NOT_IN_TREE properly raised.");
      else
         put_line ("Exception KEY_NOT_IN_TREE not properly raised."
            );
      end if;
      if flag_tree_empty then
         put_line ("Exception TREE_IS_EMPTY properly raised.");
      else
         put_line ("Exception TREE_IS_EMPTY not properly raised.")
            ;
      end if;
   end test_exceptions;

   procedure test_count_empty is 
   begin
      if count (full_tree) /= 7 or else
            count (random_tree) /= 23 or else
            count (empty_tree) /= 0 then
         flag_count := false;
         flag_insert := false;
      end if;
      if empty (full_tree) or else
            empty (random_tree) or else
            not empty (empty_tree) then
         flag_insert := false;
         flag_empty := false;
      end if;
   exception
      when others =>
         put_line ("Unanswered exception raised when testing COUNT, EMPTY"
            );
   end test_count_empty;

   procedure test_traversal is 
   begin
      set_inorder (full_tree);
      for index in 1..7 loop
         next_inorder (key, data, full_tree);
         if key /= full_inorder (index) or else key /= data then
            flag_next_in := false;
         end if;
      end loop;
      for index in 1..3 loop
         next_inorder (key, data, full_tree);
         if key /= full_inorder (index) or else key /= data then
            flag_next_in := false;
         end if;
      end loop;
      set_inorder (full_tree);
      next_inorder (key, data, full_tree);
      if key /= full_inorder (1) or else key /= data then
         flag_set_in := false;
      end if;
      set_inorder (random_tree);
      for index in 1..23 loop
         next_inorder (key, data, random_tree);
         if key /= random_inorder (index) or else key /= data then
            flag_next_in := false;
         end if;
      end loop;
   exception
      when others =>
         put_line ("Unanswered exception raised when testing TRAVERSALS"
            );
   end test_traversal;

   procedure test_copy_clear_equal is 
      key1,  
      data1 : integer;  
   begin
      -- Try tree same structure
      copy (random_tree, temp_tree);
      if count (temp_tree) /= count (random_tree) then
         flag_copy := false;
      else
         set_inorder (random_tree);
         set_inorder (temp_tree);
         for index in 1..30 loop
            next_inorder (key, data, random_tree);
            next_inorder (key1, data1, temp_tree);
            if key /= key1 or data /= data1 then
               flag_copy := false;
               exit;
            end if;
         end loop;
      end if;
      if not equal (random_tree, temp_tree) then
         flag_equal := false;
      end if;
      clear (temp_tree);
      if count (temp_tree) /= 0 then
         flag_clear := false;
         flag_count := false;
      end if;
      -- Try tree with different structure but same key-data
      for index in reverse 1..23 loop
         insert (random_inorder(index), random_inorder(index), temp_tree
            );
      end loop;
      if not equal (random_tree, temp_tree) then
         flag_equal := false;
      end if;
      clear (temp_tree);
      if equal (full_tree, random_tree) then
         flag_equal := false;
      end if;
      if   equal (empty_tree, full_tree) then
         flag_equal := false;
      end if;
      if not equal (empty_tree, temp_tree) then
         flag_equal := false;
         flag_clear := false;
      end if;
   exception
      when others =>
         put ("Unanswered exception raised when testing COPY, CLEAR, "
            );
         put_line (" EQUAL, or EMPTY");
   end test_copy_clear_equal;

   procedure test_key_get is 
   begin
      begin
         if key_in_tree (23, random_tree) or else
               key_in_tree (51, random_tree) or else
               key_in_tree (10, empty_tree) then
            flag_key := false;
         end if;
      exception
         when others =>
            flag_key := false;
      end;
      begin
         if get_data_for_key (50, random_tree) /= 50 or else
               get_data_for_key (20, random_tree) /= 20 or else
               get_data_for_key (5, random_tree) /= 5 or else
               get_data_for_key (2, random_tree) /= 2 then
            flag_get := false;
         end if;
      exception
         when others =>
            put ("Unanswered exception raised when testing KEY_IN_TREE or"
               );
            put_line (" GET_DATA_FOR_KEY");
            flag_get := false;
      end;
   end test_key_get;

   procedure test_update is 
   begin
      update (13, 26, random_tree);
      update (20, 40, random_tree);
      update (48, 96, random_tree);
      if get_data_for_key (13, random_tree) /= 26 or else
            get_data_for_key (20, random_tree) /= 40 or else
            get_data_for_key (48, random_tree) /= 96 then
         flag_update := false;
      end if;
   exception
      when others =>
         put_line ("Unanswered exception raised when testing UPDATE"
            );
   end test_update;

   procedure test_delete is 
   begin
      delete (7, random_tree);
      if key_in_tree (7, random_tree) or else
            count (random_tree) /= 22 then
         flag_delete := false;
      end if;
      delete (20, random_tree);
      next_inorder (key, data, random_tree);
      next_inorder (key, data, random_tree);
      delete (27, random_tree);
      if key_in_tree (27, random_tree) or else
            count (random_tree) /= 20 then
         flag_delete := false;
      end if;
      next_inorder (key, data, random_tree);
      if key /= 1 then
         flag_delete := false;
      end if;
   exception
      when others =>
         put_line ("Unanswered exception raised when testing DELETE"
            );
   end test_delete;

   procedure test_insert is 
   begin
      insert (55, 55, random_tree);
      if (not key_in_tree (55,  random_tree)) and then
            (get_data_for_key (55, random_tree) /= 55) then
         flag_insert := false;
      end if;
      next_inorder (key, data, random_tree);
      next_inorder (key, data, random_tree);
      insert (16, 16, random_tree);
      if (not key_in_tree (16,  random_tree)) and then
            (get_data_for_key (16, random_tree) /= 16) then
         flag_insert := false;
      end if;
      next_inorder (key, data, random_tree);
      if key /= 1 then
         flag_insert := false;
      end if;
      insert (16, 16, empty_tree);
      if (not key_in_tree (16,  empty_tree)) and then
            (get_data_for_key (16, empty_tree) /= 16) then
         flag_insert := false;
      end if;
   exception
      when others =>
         put_line ("Unanswered exception raised when testing INSERT"
            );
   end test_insert;


begin
   put_line ("Procedure to test GENERIC_UNBOUNDED_BINARY_SEARCH_TREE."
      );
   put_line ("WARNING! One error can lead to other false reports."
      );
   put_line ("Exception OVERFLOW not tested.");
   new_line;
   build_trees;
   test_exceptions;
   test_count_empty;
   test_traversal;
   test_copy_clear_equal;
   test_key_get;
   test_update;
   test_delete;
   test_insert;
   if flag_copy then
      put_line ("Operation COPY passes.");
   else
      put_line ("Operation COPY fails.");
   end if;
   if flag_clear then
      put_line ("Operation CLEAR passes.");
   else
      put_line ("Operation CLEAR fails.");
   end if;
   if flag_insert then
      put_line ("Operation INSERT passes.");
   else
      put_line ("Operation INSERT fails.");
   end if;
   if flag_delete then
      put_line ("Operation DELETE passes.");
   else
      put_line ("Operation DELETE fails.");
   end if;
   if flag_update then
      put_line ("Operation UPDATE passes.");
   else
      put_line ("Operation UPDATE fails.");
   end if;
   if flag_next_in then
      put_line ("Operation NEXT_INORDER passes.");
   else
      put_line ("Operation NEXT_INORDER fails.");
   end if;
   if flag_set_in then
      put_line ("Operation SET_INORDER passes.");
   else
      put_line ("Operation SET_INORDER fails.");
   end if;
   if flag_count then
      put_line ("Operation COUNT passes.");
   else
      put_line ("Operation COUNT fails.");
   end if;
   if flag_empty then
      put_line ("Operation EMPTY passes.");
   else
      put_line ("Operation EMPTY fails.");
   end if;
   if flag_equal then
      put_line ("Operation EQUAL passes.");
   else
      put_line ("Operation EQUAL fails.");
   end if;
   if flag_key then
      put_line ("Operation KEY_IN_TREE passes.");
   else
      put_line ("Operation KEY_IN_TREE fails.");
   end if;
   if flag_get then
      put_line ("Operation GET_DATA_FOR_TREE passes.");
   else
      put_line ("Operation GET_DATA_FOR_KEY fails.");
   end if;
end test_bal_tree;
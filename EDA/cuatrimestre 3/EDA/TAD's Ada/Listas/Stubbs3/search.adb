
   separate(sorted_list_package)
   function search(the_list   : sorted_list; 
                   target_key : key_type) return natural is
   -- Length 12   Complexity 5   Perfomance O(log2 n)
      low  : natural := 1;
      high  : natural := the_list.size;
      mid  : natural;
 begin

      if the_list.size = 0 or else target_key > 
                                    key_of(the_list.objects(the_list.size)) then
         return the_list.size + 1;
      end if;

      while high > low loop
         mid := (low + high) / 2;
         if target_key > key_of(the_list.objects(mid))
            then low  := mid + 1; 
            else high := mid;
         end if;
      end loop;

      return high;

   end search;

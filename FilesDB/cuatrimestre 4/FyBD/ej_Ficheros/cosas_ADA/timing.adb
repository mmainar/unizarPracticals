with ada.calendar; use ada.calendar;

package body Timing is


   --generic
   --   with procedure Test;
   --   Iterations:Natural;
   procedure Execute(Avg:out Duration) is
      T1,T2:Time;
      T    :Duration:=Duration(0);
   begin
      for i in 1..Iterations loop
         T1:=Clock;
         Test;
         T2:=Clock;

         T:=T+(T2-T1);
      end loop;
      Avg:=T/Iterations;
   end;

   --generic
   --   with procedure Test;
   --   Iterations:Natural;
   procedure Par_Execute(Total:out Duration) is
      T1,T2:Time;
      task type tryer;
      task body Tryer is
      begin
         Test;
      end Tryer;
      procedure Multi_Try is
         Tryers:array(1..Iterations) of Tryer;
      begin
         null;
      end;

   begin
      T1:=Clock;
      Multi_Try;
      T2:=Clock;

      Total:=T2-T1;
   end;
end;
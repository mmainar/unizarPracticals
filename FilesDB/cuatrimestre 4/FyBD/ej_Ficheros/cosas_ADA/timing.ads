-- Timing Package
-- Supplies routines to time execution of routines.
-- Routines are Execute and Par_Execute (for timing concurrent exection)
-- exact details below.
-- 
-- Ehud Lamm, (c) 1999
-- Permission granted to use this code as is or modified provided
-- this copyright notice is included. No warranty is made
-- concerning the behavior or applicability of this code.


package Timing is
   -- Purpose:   Time the avergae execution time of a give procedure over a
   --            given number of iterations.
   -- Generic Parameters: 
   --     * Test       - The procedure to time (no parameters allowed)
   --     * Iterations - (Natural) the number of iterations to use
   -- Parameters:
   --     * Avg - OUT - The average duration to execute Test
   -----------------------------------------------------------------------
   -- The reliability of this routive depends on the precision of the 
   -- Time/Duration types and on the results from Ada.Calendar.Clock. 
   -- These depend on the computer/compiler etc. So it suggested to do
   -- some sanity checks before relying on the measurements.
   -----------------------------------------------------------------------
   -- Programmed by Ehud Lamm (C) 1999
   -----------------------------------------------------------------------

   generic
      with procedure Test;
      Iterations:Natural;
   procedure Execute(Avg:out Duration);

   -- Purpose:   Time the overal execution time of a give procedure ececuted
   --            concurrently in a given number of parallel tasks.
   -- Generic Parameters: 
   --    * Test       - The procedure to time (no parameters allowed)
   --    * Iterations - (Natural) the number tasks to use
   -- Parameters:
   --    * Total - OUT - The total duration. Time until last task terminates
   -----------------------------------------------------------------------
   -- 1. The reliability of this routive depends on the precision of the 
   -- Time/Duration types and on the results from Ada.Calendar.Clock. 
   -- These depend on the computer/compiler etc. So it suggested to do
   -- some sanity checks before relying on the measurements.
   -- 2. Examine the exact way this routine tries to amke sure the timing
   -- really measures the time all tasks take, with little overhead.
   -- The quality of the technique used is arguable.
   -- 3. Total time is returned. Other logical measures which can easily
   -- be calculated are Overhard=(Total - Avg-non parallel-time) and
   -- average overhead=Overhead/iteration
   -----------------------------------------------------------------------
   -- Programmed by Ehud Lamm (C) 1999
   -----------------------------------------------------------------------


   generic
      with procedure Test;
      Iterations:Natural;
   procedure Par_Execute(Total:out Duration);



end;
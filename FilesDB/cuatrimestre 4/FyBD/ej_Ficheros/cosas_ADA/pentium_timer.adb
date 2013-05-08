-----------------------------------------------------------------------------
--  File: penttime.adb; see specification (penttime.ads)
-----------------------------------------------------------------------------
with System.Machine_Code;               use System.Machine_Code;

package body Pentium_Timer is

  function RDTSC return CPU_tick_type is
    r: CPU_tick_type;
  begin
    asm("rdtsc", CPU_tick_type'Asm_Output ("=A", r) ); -- A=(eax,edx)
    return r;
  end;
  pragma Inline(RDTSC);

  function Pentium_clock return CPU_tick_type renames RDTSC;

  function CPU_frequency return CPU_tick_type is -- in Hertz
    t0,t1: CPU_tick_type;
    seconds_in_test: constant:= 10;
  begin
    t0:=  Pentium_clock;
    delay duration(seconds_in_test);
    t1:=  Pentium_clock;
    return (t1-t0) / seconds_in_test;
  end;

end Pentium_Timer;

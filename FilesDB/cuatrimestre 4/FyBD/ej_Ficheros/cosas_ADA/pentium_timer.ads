------------------------------------------------------------------------------
--  File:            PentTime.ads   (maybe from DOS_PAQS.ZIP or WIN_PAQS.ZIP)
--
--  Description:     Non-intrusive, high precision timer,
--                   for Pentium and compatible processors
--
--                   Tested: GNAT/DOS 3.10p, GNAT/Windows 3.13p
--
--  Date/version:    10-Jun-2001 ; 20-Oct-2000
--
--  Author:          Nate Eldredge <neldredge@hmc.edu>;
--                   Ada version: Gautier de Montmollin - gdemont@hotmail.com
------------------------------------------------------------------------------

package Pentium_Timer is

  type CPU_tick_type is mod 2**64;       -- the counter is stored on 64 bits

  function Pentium_clock return CPU_tick_type;

  function CPU_frequency return CPU_tick_type; -- CPU frequency, in Hertz

end Pentium_Timer;

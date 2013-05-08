pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~prueba_utiles.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~prueba_utiles.adb");

with System.Restrictions;

package body ada_main is
   pragma Warnings (Off);

   procedure Do_Finalize;
   pragma Import (C, Do_Finalize, "system__standard_library__adafinal");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   procedure adainit is
      E024 : Boolean; pragma Import (Ada, E024, "system__secondary_stack_E");
      E020 : Boolean; pragma Import (Ada, E020, "system__soft_links_E");
      E016 : Boolean; pragma Import (Ada, E016, "system__exception_table_E");
      E103 : Boolean; pragma Import (Ada, E103, "ada__io_exceptions_E");
      E067 : Boolean; pragma Import (Ada, E067, "ada__numerics_E");
      E013 : Boolean; pragma Import (Ada, E013, "ada__strings_E");
      E081 : Boolean; pragma Import (Ada, E081, "ada__tags_E");
      E079 : Boolean; pragma Import (Ada, E079, "ada__streams_E");
      E059 : Boolean; pragma Import (Ada, E059, "interfaces__c_E");
      E061 : Boolean; pragma Import (Ada, E061, "interfaces__c__strings_E");
      E096 : Boolean; pragma Import (Ada, E096, "system__finalization_root_E");
      E054 : Boolean; pragma Import (Ada, E054, "ada__strings__maps_E");
      E057 : Boolean; pragma Import (Ada, E057, "ada__strings__maps__constants_E");
      E098 : Boolean; pragma Import (Ada, E098, "system__finalization_implementation_E");
      E094 : Boolean; pragma Import (Ada, E094, "ada__finalization_E");
      E106 : Boolean; pragma Import (Ada, E106, "ada__finalization__list_controller_E");
      E104 : Boolean; pragma Import (Ada, E104, "system__file_control_block_E");
      E092 : Boolean; pragma Import (Ada, E092, "system__file_io_E");
      E078 : Boolean; pragma Import (Ada, E078, "ada__text_io_E");
      E007 : Boolean; pragma Import (Ada, E007, "gnu__plotutil_E");
      E150 : Boolean; pragma Import (Ada, E150, "gnu__plotutil__device_E");
      E152 : Boolean; pragma Import (Ada, E152, "gnu__plotutil__device__direct_E");
      E154 : Boolean; pragma Import (Ada, E154, "gnu__plotutil__fplot_E");
      E156 : Boolean; pragma Import (Ada, E156, "textos_E");
      E142 : Boolean; pragma Import (Ada, E142, "vectores_E");
      E066 : Boolean; pragma Import (Ada, E066, "geometria_E");
      E144 : Boolean; pragma Import (Ada, E144, "graficas_E");

      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Zero_Cost_Exceptions : Integer;
      pragma Import (C, Zero_Cost_Exceptions, "__gl_zero_cost_exceptions");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");
   begin
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False),
         Value => (0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, True, True, False, False, False, True, 
           True, True, False, False, True, False, False, True, 
           True, False, True, True, True, True, True, True, 
           False, False, True, False, True, False, True, False, 
           False, True, False, False, False, True, False, True, 
           False, False, False, False, False, False, False, True, 
           True, True, False, False, False, True, True, False, 
           True, True, True, False, False, False, False, False, 
           False, False),
         Count => (0, 0, 0, 0, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Zero_Cost_Exceptions := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      System.Soft_Links'Elab_Body;
      E020 := True;
      System.Secondary_Stack'Elab_Body;
      E024 := True;
      System.Exception_Table'Elab_Body;
      E016 := True;
      Ada.Io_Exceptions'Elab_Spec;
      E103 := True;
      Ada.Numerics'Elab_Spec;
      E067 := True;
      Ada.Strings'Elab_Spec;
      E013 := True;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E079 := True;
      Interfaces.C'Elab_Spec;
      E059 := True;
      Interfaces.C.Strings'Elab_Spec;
      E061 := True;
      System.Finalization_Root'Elab_Spec;
      E096 := True;
      Ada.Strings.Maps'Elab_Spec;
      E054 := True;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E057 := True;
      System.Finalization_Implementation'Elab_Spec;
      System.Finalization_Implementation'Elab_Body;
      E098 := True;
      Ada.Finalization'Elab_Spec;
      E094 := True;
      Ada.Finalization.List_Controller'Elab_Spec;
      E106 := True;
      System.File_Control_Block'Elab_Spec;
      E104 := True;
      System.File_Io'Elab_Body;
      E092 := True;
      Ada.Tags'Elab_Body;
      E081 := True;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E078 := True;
      GNU.PLOTUTIL'ELAB_SPEC;
      GNU.PLOTUTIL'ELAB_BODY;
      E007 := True;
      GNU.PLOTUTIL.DEVICE'ELAB_SPEC;
      E150 := True;
      E152 := True;
      E154 := True;
      E156 := True;
      E142 := True;
      geometria'elab_spec;
      E066 := True;
      E144 := True;
   end adainit;

   procedure adafinal is
   begin
      Do_Finalize;
   end adafinal;

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure initialize (Addr : System.Address);
      pragma Import (C, initialize, "__gnat_initialize");

      procedure finalize;
      pragma Import (C, finalize, "__gnat_finalize");

      procedure Ada_Main_Program;
      pragma Import (Ada, Ada_Main_Program, "_ada_prueba_utiles");

      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Break_Start;
      Ada_Main_Program;
      Do_Finalize;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   ./gnu.o
   --   /home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/ada-plotutil/gnu-plotutil.o
   --   /home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/ada-plotutil/gnu-plotutil-athena.o
   --   ./configuracion.o
   --   /home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/ada-plotutil/gnu-plotutil-device.o
   --   /home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/ada-plotutil/gnu-plotutil-device-direct.o
   --   /home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/ada-plotutil/gnu-plotutil-fplot.o
   --   ./textos.o
   --   ./vectores.o
   --   ./geometria.o
   --   ./graficas.o
   --   ./prueba_utiles.o
   --   -L./
   --   -L/home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/utiles-1.1/
   --   -L/home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1/ada-plotutil/
   --   -L/usr/lib/gcc/i486-linux-gnu/4.3.2/adalib/
   --   -L/usr/lib
   --   -L/usr/X11R6/lib
   --   -lXaw
   --   -lX11
   --   -lm
   --   -lplot
   --   -shared
   --   -lgnat-4.3
--  END Object file/option list   

end ada_main;

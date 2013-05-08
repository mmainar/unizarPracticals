pragma Source_File_Name (ada_main, Spec_File_Name => "b~mezcladirecta.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~mezcladirecta.adb");

package body ada_main is

   procedure Do_Finalize;
   pragma Import (C, Do_Finalize, "system__standard_library__adafinal");

   procedure adainit is
      E008 : Boolean; pragma Import (Ada, E008, "ada__exceptions_E");
      E014 : Boolean; pragma Import (Ada, E014, "system__exception_table_E");
      E057 : Boolean; pragma Import (Ada, E057, "ada__io_exceptions_E");
      E017 : Boolean; pragma Import (Ada, E017, "system__exceptions_E");
      E028 : Boolean; pragma Import (Ada, E028, "system__secondary_stack_E");
      E039 : Boolean; pragma Import (Ada, E039, "ada__tags_E");
      E037 : Boolean; pragma Import (Ada, E037, "ada__streams_E");
      E024 : Boolean; pragma Import (Ada, E024, "system__soft_links_E");
      E048 : Boolean; pragma Import (Ada, E048, "system__finalization_root_E");
      E050 : Boolean; pragma Import (Ada, E050, "system__finalization_implementation_E");
      E046 : Boolean; pragma Import (Ada, E046, "ada__finalization_E");
      E061 : Boolean; pragma Import (Ada, E061, "ada__finalization__list_controller_E");
      E059 : Boolean; pragma Import (Ada, E059, "system__file_control_block_E");
      E044 : Boolean; pragma Import (Ada, E044, "system__file_io_E");
      E036 : Boolean; pragma Import (Ada, E036, "ada__text_io_E");
      E091 : Boolean; pragma Import (Ada, E091, "system__sequential_io_E");
      E093 : Boolean; pragma Import (Ada, E093, "tpfsec_E");

      Restrictions : constant String :=
        "nnvvnnnvnnnnnvvvvvvnvvvnvnnvnnnvnvvnnnnnnvvvnnnnvvnn";

      procedure Set_Globals
        (Main_Priority            : Integer;
         Time_Slice_Value         : Integer;
         WC_Encoding              : Character;
         Locking_Policy           : Character;
         Queuing_Policy           : Character;
         Task_Dispatching_Policy  : Character;
         Restrictions             : System.Address;
         Unreserve_All_Interrupts : Integer;
         Exception_Tracebacks     : Integer;
         Zero_Cost_Exceptions     : Integer);
      pragma Import (C, Set_Globals, "__gnat_set_globals");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");
   begin
      Set_Globals
        (Main_Priority            => -1,
         Time_Slice_Value         => -1,
         WC_Encoding              => 'b',
         Locking_Policy           => ' ',
         Queuing_Policy           => ' ',
         Task_Dispatching_Policy  => ' ',
         Restrictions             => Restrictions'Address,
         Unreserve_All_Interrupts => 0,
         Exception_Tracebacks     => 0,
         Zero_Cost_Exceptions     => 0);

      if Handler_Installed = 0 then
        Install_Handler;
      end if;
      if not E008 then
         Ada.Exceptions'Elab_Spec;
      end if;
      if not E014 then
         System.Exception_Table'Elab_Body;
         E014 := True;
      end if;
      if not E057 then
         Ada.Io_Exceptions'Elab_Spec;
         E057 := True;
      end if;
      if not E017 then
         System.Exceptions'Elab_Spec;
         E017 := True;
      end if;
      if not E039 then
         Ada.Tags'Elab_Spec;
      end if;
      if not E039 then
         Ada.Tags'Elab_Body;
         E039 := True;
      end if;
      if not E037 then
         Ada.Streams'Elab_Spec;
         E037 := True;
      end if;
      if not E024 then
         System.Soft_Links'Elab_Body;
         E024 := True;
      end if;
      if not E028 then
         System.Secondary_Stack'Elab_Body;
         E028 := True;
      end if;
      if not E048 then
         System.Finalization_Root'Elab_Spec;
      end if;
      E048 := True;
      if not E008 then
         Ada.Exceptions'Elab_Body;
         E008 := True;
      end if;
      if not E050 then
         System.Finalization_Implementation'Elab_Spec;
      end if;
      if not E050 then
         System.Finalization_Implementation'Elab_Body;
         E050 := True;
      end if;
      if not E046 then
         Ada.Finalization'Elab_Spec;
      end if;
      E046 := True;
      if not E061 then
         Ada.Finalization.List_Controller'Elab_Spec;
      end if;
      E061 := True;
      if not E059 then
         System.File_Control_Block'Elab_Spec;
         E059 := True;
      end if;
      if not E044 then
         System.File_Io'Elab_Body;
         E044 := True;
      end if;
      if not E036 then
         Ada.Text_Io'Elab_Spec;
      end if;
      if not E036 then
         Ada.Text_Io'Elab_Body;
         E036 := True;
      end if;
      if not E091 then
         System.Sequential_Io'Elab_Spec;
      end if;
      E091 := True;
      E093 := True;
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
      procedure initialize;
      pragma Import (C, initialize, "__gnat_initialize");

      procedure finalize;
      pragma Import (C, finalize, "__gnat_finalize");


      procedure Ada_Main_Program;
      pragma Import (Ada, Ada_Main_Program, "_ada_prueba");

      Ensure_Reference : System.Address := Ada_Main_Program_Name'Address;

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize;
      adainit;
      Break_Start;
      Ada_Main_Program;
      Do_Finalize;
      Finalize;
      return (gnat_exit_status);
   end;

-- BEGIN Object file/option list
   --   ./tpfsec.o
   --   ./mezcladirecta.o
   --   -L./
   --   -LC:\DOCUME~1\MARCOS~1\ESCRIT~1\ASIGNA~1\CUATRI~1\FyBD\EJ_FIC~1\COSAS_~1\FICH_S~1\
   --   -LC:\GNAT\Bindings\Win32Ada\
   --   -LC:\GNAT\lib\win32\
   --   -LC:\GNAT\lib\gcc-lib\pentium-mingw32msv\2.8.1\adalib\
   --   -static
   --   -lgnat
   --   -Wl,--stack=0x2000000
-- END Object file/option list   

end ada_main;

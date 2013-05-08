with System;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 3.15p  (20020523)";
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_prueba" & Ascii.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure Break_Start;
   pragma Import (C, Break_Start, "__gnat_break_start");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#37c52e38#;
   u00002 : constant Version_32 := 16#612a2371#;
   u00003 : constant Version_32 := 16#6d0b25e7#;
   u00004 : constant Version_32 := 16#a0108083#;
   u00005 : constant Version_32 := 16#58c81565#;
   u00006 : constant Version_32 := 16#600f369a#;
   u00007 : constant Version_32 := 16#18074f0d#;
   u00008 : constant Version_32 := 16#5097162c#;
   u00009 : constant Version_32 := 16#6380ea48#;
   u00010 : constant Version_32 := 16#c5fbb2c4#;
   u00011 : constant Version_32 := 16#dc301c49#;
   u00012 : constant Version_32 := 16#2f3d0cfb#;
   u00013 : constant Version_32 := 16#58c090c8#;
   u00014 : constant Version_32 := 16#0bbec219#;
   u00015 : constant Version_32 := 16#2c01a59d#;
   u00016 : constant Version_32 := 16#eb251ef2#;
   u00017 : constant Version_32 := 16#bbfe2e15#;
   u00018 : constant Version_32 := 16#aafe6ddd#;
   u00019 : constant Version_32 := 16#15ecf685#;
   u00020 : constant Version_32 := 16#deb56e68#;
   u00021 : constant Version_32 := 16#5b831103#;
   u00022 : constant Version_32 := 16#22cfda4b#;
   u00023 : constant Version_32 := 16#85d0fac3#;
   u00024 : constant Version_32 := 16#1d36b7a3#;
   u00025 : constant Version_32 := 16#e1ec3288#;
   u00026 : constant Version_32 := 16#1e6071ed#;
   u00027 : constant Version_32 := 16#7e6eaca1#;
   u00028 : constant Version_32 := 16#0a072375#;
   u00029 : constant Version_32 := 16#a4e49d90#;
   u00030 : constant Version_32 := 16#e983fc56#;
   u00031 : constant Version_32 := 16#9a0b3df4#;
   u00032 : constant Version_32 := 16#664672fc#;
   u00033 : constant Version_32 := 16#4d4e8ee2#;
   u00034 : constant Version_32 := 16#19703964#;
   u00035 : constant Version_32 := 16#5191bd63#;
   u00036 : constant Version_32 := 16#0d73f03e#;
   u00037 : constant Version_32 := 16#7bf62c37#;
   u00038 : constant Version_32 := 16#4475095f#;
   u00039 : constant Version_32 := 16#f5ea57bc#;
   u00040 : constant Version_32 := 16#6e859da6#;
   u00041 : constant Version_32 := 16#83609014#;
   u00042 : constant Version_32 := 16#139120f0#;
   u00043 : constant Version_32 := 16#67de7468#;
   u00044 : constant Version_32 := 16#656bf107#;
   u00045 : constant Version_32 := 16#dec8b4cc#;
   u00046 : constant Version_32 := 16#0af0a97f#;
   u00047 : constant Version_32 := 16#2707dc21#;
   u00048 : constant Version_32 := 16#8a85a734#;
   u00049 : constant Version_32 := 16#b2e77bbf#;
   u00050 : constant Version_32 := 16#be06a09e#;
   u00051 : constant Version_32 := 16#9d5e2b8a#;
   u00052 : constant Version_32 := 16#d461359f#;
   u00053 : constant Version_32 := 16#cf0ab27e#;
   u00054 : constant Version_32 := 16#320a65fb#;
   u00055 : constant Version_32 := 16#de189fd2#;
   u00056 : constant Version_32 := 16#41941407#;
   u00057 : constant Version_32 := 16#753e9209#;
   u00058 : constant Version_32 := 16#2a903bc9#;
   u00059 : constant Version_32 := 16#acd3010b#;
   u00060 : constant Version_32 := 16#ffad3e68#;
   u00061 : constant Version_32 := 16#29e5afbc#;
   u00062 : constant Version_32 := 16#f4128bc8#;
   u00063 : constant Version_32 := 16#2eb80aec#;
   u00064 : constant Version_32 := 16#ae3d0e1f#;
   u00065 : constant Version_32 := 16#9ae01713#;
   u00066 : constant Version_32 := 16#3acc2294#;
   u00067 : constant Version_32 := 16#7580cb1b#;
   u00068 : constant Version_32 := 16#70f6a786#;
   u00069 : constant Version_32 := 16#de878898#;
   u00070 : constant Version_32 := 16#a51734bc#;
   u00071 : constant Version_32 := 16#ee15f95e#;
   u00072 : constant Version_32 := 16#f02ff885#;
   u00073 : constant Version_32 := 16#769bd5ea#;
   u00074 : constant Version_32 := 16#2909e352#;
   u00075 : constant Version_32 := 16#8cfff05c#;
   u00076 : constant Version_32 := 16#2b9118f5#;
   u00077 : constant Version_32 := 16#f00d2da1#;
   u00078 : constant Version_32 := 16#5fde144c#;
   u00079 : constant Version_32 := 16#f858504c#;
   u00080 : constant Version_32 := 16#9eef795c#;
   u00081 : constant Version_32 := 16#371c6472#;
   u00082 : constant Version_32 := 16#47a468aa#;
   u00083 : constant Version_32 := 16#dff1465b#;
   u00084 : constant Version_32 := 16#1e439027#;
   u00085 : constant Version_32 := 16#f3d435e7#;
   u00086 : constant Version_32 := 16#4824fe2c#;
   u00087 : constant Version_32 := 16#3ee7cf2c#;
   u00088 : constant Version_32 := 16#23e9e737#;
   u00089 : constant Version_32 := 16#23a6d526#;
   u00090 : constant Version_32 := 16#2badfa82#;
   u00091 : constant Version_32 := 16#8f189d8e#;
   u00092 : constant Version_32 := 16#eacd3992#;
   u00093 : constant Version_32 := 16#189fdf12#;

   pragma Export (C, u00001, "pruebaB");
   pragma Export (C, u00002, "system__standard_libraryB");
   pragma Export (C, u00003, "system__standard_libraryS");
   pragma Export (C, u00004, "adaS");
   pragma Export (C, u00005, "ada__integer_text_ioB");
   pragma Export (C, u00006, "ada__integer_text_ioS");
   pragma Export (C, u00007, "ada__exceptionsB");
   pragma Export (C, u00008, "ada__exceptionsS");
   pragma Export (C, u00009, "gnatS");
   pragma Export (C, u00010, "gnat__heap_sort_aB");
   pragma Export (C, u00011, "gnat__heap_sort_aS");
   pragma Export (C, u00012, "systemS");
   pragma Export (C, u00013, "system__exception_tableB");
   pragma Export (C, u00014, "system__exception_tableS");
   pragma Export (C, u00015, "gnat__htableB");
   pragma Export (C, u00016, "gnat__htableS");
   pragma Export (C, u00017, "system__exceptionsS");
   pragma Export (C, u00018, "system__machine_state_operationsB");
   pragma Export (C, u00019, "system__machine_state_operationsS");
   pragma Export (C, u00020, "system__machine_codeS");
   pragma Export (C, u00021, "system__memoryB");
   pragma Export (C, u00022, "system__memoryS");
   pragma Export (C, u00023, "system__soft_linksB");
   pragma Export (C, u00024, "system__soft_linksS");
   pragma Export (C, u00025, "system__parametersB");
   pragma Export (C, u00026, "system__parametersS");
   pragma Export (C, u00027, "system__secondary_stackB");
   pragma Export (C, u00028, "system__secondary_stackS");
   pragma Export (C, u00029, "system__storage_elementsB");
   pragma Export (C, u00030, "system__storage_elementsS");
   pragma Export (C, u00031, "system__stack_checkingB");
   pragma Export (C, u00032, "system__stack_checkingS");
   pragma Export (C, u00033, "system__tracebackB");
   pragma Export (C, u00034, "system__tracebackS");
   pragma Export (C, u00035, "ada__text_ioB");
   pragma Export (C, u00036, "ada__text_ioS");
   pragma Export (C, u00037, "ada__streamsS");
   pragma Export (C, u00038, "ada__tagsB");
   pragma Export (C, u00039, "ada__tagsS");
   pragma Export (C, u00040, "interfacesS");
   pragma Export (C, u00041, "interfaces__c_streamsB");
   pragma Export (C, u00042, "interfaces__c_streamsS");
   pragma Export (C, u00043, "system__file_ioB");
   pragma Export (C, u00044, "system__file_ioS");
   pragma Export (C, u00045, "ada__finalizationB");
   pragma Export (C, u00046, "ada__finalizationS");
   pragma Export (C, u00047, "system__finalization_rootB");
   pragma Export (C, u00048, "system__finalization_rootS");
   pragma Export (C, u00049, "system__finalization_implementationB");
   pragma Export (C, u00050, "system__finalization_implementationS");
   pragma Export (C, u00051, "system__string_ops_concat_3B");
   pragma Export (C, u00052, "system__string_ops_concat_3S");
   pragma Export (C, u00053, "system__string_opsB");
   pragma Export (C, u00054, "system__string_opsS");
   pragma Export (C, u00055, "system__stream_attributesB");
   pragma Export (C, u00056, "system__stream_attributesS");
   pragma Export (C, u00057, "ada__io_exceptionsS");
   pragma Export (C, u00058, "system__unsigned_typesS");
   pragma Export (C, u00059, "system__file_control_blockS");
   pragma Export (C, u00060, "ada__finalization__list_controllerB");
   pragma Export (C, u00061, "ada__finalization__list_controllerS");
   pragma Export (C, u00062, "ada__text_io__integer_auxB");
   pragma Export (C, u00063, "ada__text_io__integer_auxS");
   pragma Export (C, u00064, "ada__text_io__generic_auxB");
   pragma Export (C, u00065, "ada__text_io__generic_auxS");
   pragma Export (C, u00066, "system__img_biuB");
   pragma Export (C, u00067, "system__img_biuS");
   pragma Export (C, u00068, "system__img_intB");
   pragma Export (C, u00069, "system__img_intS");
   pragma Export (C, u00070, "system__img_llbB");
   pragma Export (C, u00071, "system__img_llbS");
   pragma Export (C, u00072, "system__img_lliB");
   pragma Export (C, u00073, "system__img_lliS");
   pragma Export (C, u00074, "system__img_llwB");
   pragma Export (C, u00075, "system__img_llwS");
   pragma Export (C, u00076, "system__img_wiuB");
   pragma Export (C, u00077, "system__img_wiuS");
   pragma Export (C, u00078, "system__val_intB");
   pragma Export (C, u00079, "system__val_intS");
   pragma Export (C, u00080, "system__val_unsB");
   pragma Export (C, u00081, "system__val_unsS");
   pragma Export (C, u00082, "system__val_utilB");
   pragma Export (C, u00083, "system__val_utilS");
   pragma Export (C, u00084, "gnat__case_utilB");
   pragma Export (C, u00085, "gnat__case_utilS");
   pragma Export (C, u00086, "system__val_lliB");
   pragma Export (C, u00087, "system__val_lliS");
   pragma Export (C, u00088, "system__val_lluB");
   pragma Export (C, u00089, "system__val_lluS");
   pragma Export (C, u00090, "system__sequential_ioB");
   pragma Export (C, u00091, "system__sequential_ioS");
   pragma Export (C, u00092, "tpfsecB");
   pragma Export (C, u00093, "tpfsecS");

   -- BEGIN ELABORATION ORDER
   -- ada (spec)
   -- gnat (spec)
   -- gnat.case_util (spec)
   -- gnat.case_util (body)
   -- gnat.heap_sort_a (spec)
   -- gnat.heap_sort_a (body)
   -- gnat.htable (spec)
   -- gnat.htable (body)
   -- interfaces (spec)
   -- system (spec)
   -- system.img_int (spec)
   -- system.img_lli (spec)
   -- system.machine_code (spec)
   -- system.parameters (spec)
   -- system.parameters (body)
   -- interfaces.c_streams (spec)
   -- interfaces.c_streams (body)
   -- system.standard_library (spec)
   -- ada.exceptions (spec)
   -- system.exception_table (spec)
   -- system.exception_table (body)
   -- ada.io_exceptions (spec)
   -- system.exceptions (spec)
   -- system.storage_elements (spec)
   -- system.storage_elements (body)
   -- system.machine_state_operations (spec)
   -- system.secondary_stack (spec)
   -- system.img_lli (body)
   -- system.img_int (body)
   -- ada.tags (spec)
   -- ada.tags (body)
   -- ada.streams (spec)
   -- system.stack_checking (spec)
   -- system.soft_links (spec)
   -- system.soft_links (body)
   -- system.stack_checking (body)
   -- system.secondary_stack (body)
   -- system.finalization_root (spec)
   -- system.finalization_root (body)
   -- system.memory (spec)
   -- system.memory (body)
   -- system.machine_state_operations (body)
   -- system.standard_library (body)
   -- system.string_ops (spec)
   -- system.string_ops (body)
   -- system.string_ops_concat_3 (spec)
   -- system.string_ops_concat_3 (body)
   -- system.traceback (spec)
   -- system.traceback (body)
   -- ada.exceptions (body)
   -- system.unsigned_types (spec)
   -- system.img_biu (spec)
   -- system.img_biu (body)
   -- system.img_llb (spec)
   -- system.img_llb (body)
   -- system.img_llw (spec)
   -- system.img_llw (body)
   -- system.img_wiu (spec)
   -- system.img_wiu (body)
   -- system.stream_attributes (spec)
   -- system.stream_attributes (body)
   -- system.finalization_implementation (spec)
   -- system.finalization_implementation (body)
   -- ada.finalization (spec)
   -- ada.finalization (body)
   -- ada.finalization.list_controller (spec)
   -- ada.finalization.list_controller (body)
   -- system.file_control_block (spec)
   -- system.file_io (spec)
   -- system.file_io (body)
   -- ada.text_io (spec)
   -- ada.text_io (body)
   -- ada.text_io.generic_aux (spec)
   -- ada.text_io.generic_aux (body)
   -- ada.text_io.integer_aux (spec)
   -- ada.integer_text_io (spec)
   -- ada.integer_text_io (body)
   -- system.sequential_io (spec)
   -- system.sequential_io (body)
   -- system.val_int (spec)
   -- system.val_lli (spec)
   -- ada.text_io.integer_aux (body)
   -- system.val_llu (spec)
   -- system.val_uns (spec)
   -- system.val_util (spec)
   -- system.val_util (body)
   -- system.val_uns (body)
   -- system.val_llu (body)
   -- system.val_lli (body)
   -- system.val_int (body)
   -- tpfsec (spec)
   -- tpfsec (body)
   -- prueba (body)
   -- END ELABORATION ORDER

end ada_main;

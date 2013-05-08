pragma Ada_95;
with System;
package ada_main is
   pragma Warnings (Off);

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 4.3.2" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_prueba_utiles" & Ascii.NUL;
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
   u00001 : constant Version_32 := 16#06195f2a#;
   u00002 : constant Version_32 := 16#a448b566#;
   u00003 : constant Version_32 := 16#cb24d150#;
   u00004 : constant Version_32 := 16#e171139a#;
   u00005 : constant Version_32 := 16#283c7ebe#;
   u00006 : constant Version_32 := 16#6bdcb2c6#;
   u00007 : constant Version_32 := 16#c01bd3ff#;
   u00008 : constant Version_32 := 16#9c7dd3ea#;
   u00009 : constant Version_32 := 16#cc1134cf#;
   u00010 : constant Version_32 := 16#b061ea80#;
   u00011 : constant Version_32 := 16#8cddb9b3#;
   u00012 : constant Version_32 := 16#b9828a2f#;
   u00013 : constant Version_32 := 16#1bc9f0e1#;
   u00014 : constant Version_32 := 16#e2b32c27#;
   u00015 : constant Version_32 := 16#dbf34042#;
   u00016 : constant Version_32 := 16#246b012b#;
   u00017 : constant Version_32 := 16#1a63fe0c#;
   u00018 : constant Version_32 := 16#94136b37#;
   u00019 : constant Version_32 := 16#91c0f6c5#;
   u00020 : constant Version_32 := 16#56918bcb#;
   u00021 : constant Version_32 := 16#4c0302b0#;
   u00022 : constant Version_32 := 16#119d7ace#;
   u00023 : constant Version_32 := 16#4dd9543a#;
   u00024 : constant Version_32 := 16#8819d287#;
   u00025 : constant Version_32 := 16#a97dd90b#;
   u00026 : constant Version_32 := 16#f3b7e4a6#;
   u00027 : constant Version_32 := 16#a8a5666f#;
   u00028 : constant Version_32 := 16#1045e437#;
   u00029 : constant Version_32 := 16#7d7a78ec#;
   u00030 : constant Version_32 := 16#ecad2c4f#;
   u00031 : constant Version_32 := 16#5b8b9839#;
   u00032 : constant Version_32 := 16#3a7fb590#;
   u00033 : constant Version_32 := 16#0a4e56be#;
   u00034 : constant Version_32 := 16#66ec5ef5#;
   u00035 : constant Version_32 := 16#573451fa#;
   u00036 : constant Version_32 := 16#907d3c44#;
   u00037 : constant Version_32 := 16#9c49ee35#;
   u00038 : constant Version_32 := 16#88ddf8cf#;
   u00039 : constant Version_32 := 16#224ad6c2#;
   u00040 : constant Version_32 := 16#743d3d0d#;
   u00041 : constant Version_32 := 16#49b1abbe#;
   u00042 : constant Version_32 := 16#ccde3404#;
   u00043 : constant Version_32 := 16#cdc6e44f#;
   u00044 : constant Version_32 := 16#2c57c517#;
   u00045 : constant Version_32 := 16#c222a0d8#;
   u00046 : constant Version_32 := 16#a69cad5c#;
   u00047 : constant Version_32 := 16#300a43f3#;
   u00048 : constant Version_32 := 16#e90bfca8#;
   u00049 : constant Version_32 := 16#99c8a881#;
   u00050 : constant Version_32 := 16#5fec0b74#;
   u00051 : constant Version_32 := 16#e1e7b9d6#;
   u00052 : constant Version_32 := 16#d6ccdf4e#;
   u00053 : constant Version_32 := 16#eccbd1ca#;
   u00054 : constant Version_32 := 16#3c09e836#;
   u00055 : constant Version_32 := 16#ba1865ed#;
   u00056 : constant Version_32 := 16#04e247f8#;
   u00057 : constant Version_32 := 16#ec7a3063#;
   u00058 : constant Version_32 := 16#59507545#;
   u00059 : constant Version_32 := 16#e98c0dd7#;
   u00060 : constant Version_32 := 16#cfd32827#;
   u00061 : constant Version_32 := 16#38237c53#;
   u00062 : constant Version_32 := 16#f5269f91#;
   u00063 : constant Version_32 := 16#75172ecd#;
   u00064 : constant Version_32 := 16#e617a7fc#;
   u00065 : constant Version_32 := 16#137b7f46#;
   u00066 : constant Version_32 := 16#40752606#;
   u00067 : constant Version_32 := 16#808e35e2#;
   u00068 : constant Version_32 := 16#b3ddb2e1#;
   u00069 : constant Version_32 := 16#e9d51972#;
   u00070 : constant Version_32 := 16#45aed95a#;
   u00071 : constant Version_32 := 16#3cdf3a90#;
   u00072 : constant Version_32 := 16#026e74c4#;
   u00073 : constant Version_32 := 16#87251953#;
   u00074 : constant Version_32 := 16#e0683b80#;
   u00075 : constant Version_32 := 16#a561ab2c#;
   u00076 : constant Version_32 := 16#97d7fcd1#;
   u00077 : constant Version_32 := 16#820fd89a#;
   u00078 : constant Version_32 := 16#68b12451#;
   u00079 : constant Version_32 := 16#a8d17654#;
   u00080 : constant Version_32 := 16#52e22fd2#;
   u00081 : constant Version_32 := 16#8ec8b2ff#;
   u00082 : constant Version_32 := 16#647de85b#;
   u00083 : constant Version_32 := 16#c3759bfc#;
   u00084 : constant Version_32 := 16#8213b492#;
   u00085 : constant Version_32 := 16#b89d514b#;
   u00086 : constant Version_32 := 16#44c7af1b#;
   u00087 : constant Version_32 := 16#73293f23#;
   u00088 : constant Version_32 := 16#62e56d2b#;
   u00089 : constant Version_32 := 16#a8e5b34e#;
   u00090 : constant Version_32 := 16#fe040075#;
   u00091 : constant Version_32 := 16#06c4e987#;
   u00092 : constant Version_32 := 16#b782cf7b#;
   u00093 : constant Version_32 := 16#fcec4850#;
   u00094 : constant Version_32 := 16#16dfe486#;
   u00095 : constant Version_32 := 16#6d0998e1#;
   u00096 : constant Version_32 := 16#93f7edba#;
   u00097 : constant Version_32 := 16#47048e11#;
   u00098 : constant Version_32 := 16#2216744e#;
   u00099 : constant Version_32 := 16#293ff6f7#;
   u00100 : constant Version_32 := 16#fa1253bc#;
   u00101 : constant Version_32 := 16#716a9db2#;
   u00102 : constant Version_32 := 16#40ea6cd5#;
   u00103 : constant Version_32 := 16#2274d34a#;
   u00104 : constant Version_32 := 16#53d0166e#;
   u00105 : constant Version_32 := 16#923573c8#;
   u00106 : constant Version_32 := 16#183b4446#;
   u00107 : constant Version_32 := 16#3a4fe8af#;
   u00108 : constant Version_32 := 16#7244c52a#;
   u00109 : constant Version_32 := 16#c572d19b#;
   u00110 : constant Version_32 := 16#6ddb8e2e#;
   u00111 : constant Version_32 := 16#8d02aab0#;
   u00112 : constant Version_32 := 16#383b9ed8#;
   u00113 : constant Version_32 := 16#3e7d115b#;
   u00114 : constant Version_32 := 16#efe0221f#;
   u00115 : constant Version_32 := 16#9b936ce6#;
   u00116 : constant Version_32 := 16#d65f9deb#;
   u00117 : constant Version_32 := 16#c26cc523#;
   u00118 : constant Version_32 := 16#c9db2a5e#;
   u00119 : constant Version_32 := 16#06751674#;
   u00120 : constant Version_32 := 16#6ffd7991#;
   u00121 : constant Version_32 := 16#9a4b8e7f#;
   u00122 : constant Version_32 := 16#d9f6bc78#;
   u00123 : constant Version_32 := 16#f616124c#;
   u00124 : constant Version_32 := 16#0255db5c#;
   u00125 : constant Version_32 := 16#15ce3f1b#;
   u00126 : constant Version_32 := 16#8ab10de5#;
   u00127 : constant Version_32 := 16#100b3ec7#;
   u00128 : constant Version_32 := 16#17c88cd6#;
   u00129 : constant Version_32 := 16#02eb80bf#;
   u00130 : constant Version_32 := 16#76b10c12#;
   u00131 : constant Version_32 := 16#ea3b65b2#;
   u00132 : constant Version_32 := 16#91b7530a#;
   u00133 : constant Version_32 := 16#a0c7e5f7#;
   u00134 : constant Version_32 := 16#294c3b74#;
   u00135 : constant Version_32 := 16#308125f5#;
   u00136 : constant Version_32 := 16#3131a464#;
   u00137 : constant Version_32 := 16#a978eee4#;
   u00138 : constant Version_32 := 16#5056e8dd#;
   u00139 : constant Version_32 := 16#de11c4c5#;
   u00140 : constant Version_32 := 16#c059b001#;
   u00141 : constant Version_32 := 16#63991d28#;
   u00142 : constant Version_32 := 16#14e2fc77#;
   u00143 : constant Version_32 := 16#e4cf22c6#;
   u00144 : constant Version_32 := 16#d7cde48b#;
   u00145 : constant Version_32 := 16#3407344a#;
   u00146 : constant Version_32 := 16#14149f5e#;
   u00147 : constant Version_32 := 16#03bc737c#;
   u00148 : constant Version_32 := 16#23afd868#;
   u00149 : constant Version_32 := 16#a9c90b49#;
   u00150 : constant Version_32 := 16#169f05d6#;
   u00151 : constant Version_32 := 16#665b750f#;
   u00152 : constant Version_32 := 16#82aa2acb#;
   u00153 : constant Version_32 := 16#c849c2be#;
   u00154 : constant Version_32 := 16#409c4cd9#;
   u00155 : constant Version_32 := 16#cbbe76bf#;
   u00156 : constant Version_32 := 16#c1ff011b#;
   u00157 : constant Version_32 := 16#fff74ea3#;
   u00158 : constant Version_32 := 16#a70c0a76#;
   u00159 : constant Version_32 := 16#70f768a2#;
   u00160 : constant Version_32 := 16#f0ddc3f6#;
   u00161 : constant Version_32 := 16#3ab3e7b1#;
   u00162 : constant Version_32 := 16#54ed61ee#;
   u00163 : constant Version_32 := 16#9a7bf588#;
   u00164 : constant Version_32 := 16#5ea20b04#;
   u00165 : constant Version_32 := 16#daba2cb1#;
   u00166 : constant Version_32 := 16#e6e46743#;

   pragma Export (C, u00001, "prueba_utilesB");
   pragma Export (C, u00002, "system__standard_libraryB");
   pragma Export (C, u00003, "system__standard_libraryS");
   pragma Export (C, u00004, "configuracionS");
   pragma Export (C, u00005, "gnuS");
   pragma Export (C, u00006, "gnu__plotutilB");
   pragma Export (C, u00007, "gnu__plotutilS");
   pragma Export (C, u00008, "adaS");
   pragma Export (C, u00009, "ada__charactersS");
   pragma Export (C, u00010, "ada__characters__handlingB");
   pragma Export (C, u00011, "ada__characters__handlingS");
   pragma Export (C, u00012, "ada__characters__latin_1S");
   pragma Export (C, u00013, "ada__stringsS");
   pragma Export (C, u00014, "systemS");
   pragma Export (C, u00015, "system__exception_tableB");
   pragma Export (C, u00016, "system__exception_tableS");
   pragma Export (C, u00017, "system__htableB");
   pragma Export (C, u00018, "system__htableS");
   pragma Export (C, u00019, "system__soft_linksB");
   pragma Export (C, u00020, "system__soft_linksS");
   pragma Export (C, u00021, "system__parametersB");
   pragma Export (C, u00022, "system__parametersS");
   pragma Export (C, u00023, "system__secondary_stackB");
   pragma Export (C, u00024, "system__secondary_stackS");
   pragma Export (C, u00025, "system__storage_elementsB");
   pragma Export (C, u00026, "system__storage_elementsS");
   pragma Export (C, u00027, "ada__exceptionsB");
   pragma Export (C, u00028, "ada__exceptionsS");
   pragma Export (C, u00029, "ada__exceptions__last_chance_handlerB");
   pragma Export (C, u00030, "ada__exceptions__last_chance_handlerS");
   pragma Export (C, u00031, "system__exceptionsB");
   pragma Export (C, u00032, "system__exceptionsS");
   pragma Export (C, u00033, "system__string_opsB");
   pragma Export (C, u00034, "system__string_opsS");
   pragma Export (C, u00035, "system__string_ops_concat_3B");
   pragma Export (C, u00036, "system__string_ops_concat_3S");
   pragma Export (C, u00037, "system__tracebackB");
   pragma Export (C, u00038, "system__tracebackS");
   pragma Export (C, u00039, "system__unsigned_typesS");
   pragma Export (C, u00040, "system__wch_conB");
   pragma Export (C, u00041, "system__wch_conS");
   pragma Export (C, u00042, "system__wch_stwB");
   pragma Export (C, u00043, "system__wch_stwS");
   pragma Export (C, u00044, "system__wch_cnvB");
   pragma Export (C, u00045, "system__wch_cnvS");
   pragma Export (C, u00046, "interfacesS");
   pragma Export (C, u00047, "system__wch_jisB");
   pragma Export (C, u00048, "system__wch_jisS");
   pragma Export (C, u00049, "system__traceback_entriesB");
   pragma Export (C, u00050, "system__traceback_entriesS");
   pragma Export (C, u00051, "system__stack_checkingB");
   pragma Export (C, u00052, "system__stack_checkingS");
   pragma Export (C, u00053, "ada__strings__mapsB");
   pragma Export (C, u00054, "ada__strings__mapsS");
   pragma Export (C, u00055, "system__bit_opsB");
   pragma Export (C, u00056, "system__bit_opsS");
   pragma Export (C, u00057, "ada__strings__maps__constantsS");
   pragma Export (C, u00058, "interfaces__cB");
   pragma Export (C, u00059, "interfaces__cS");
   pragma Export (C, u00060, "interfaces__c__stringsB");
   pragma Export (C, u00061, "interfaces__c__stringsS");
   pragma Export (C, u00062, "system__img_enum_newB");
   pragma Export (C, u00063, "system__img_enum_newS");
   pragma Export (C, u00064, "gnu__plotutil__athenaS");
   pragma Export (C, u00065, "geometriaB");
   pragma Export (C, u00066, "geometriaS");
   pragma Export (C, u00067, "ada__numericsS");
   pragma Export (C, u00068, "ada__numerics__elementary_functionsB");
   pragma Export (C, u00069, "ada__numerics__elementary_functionsS");
   pragma Export (C, u00070, "ada__numerics__auxB");
   pragma Export (C, u00071, "ada__numerics__auxS");
   pragma Export (C, u00072, "system__fat_llfS");
   pragma Export (C, u00073, "system__machine_codeS");
   pragma Export (C, u00074, "system__exn_llfB");
   pragma Export (C, u00075, "system__exn_llfS");
   pragma Export (C, u00076, "system__fat_fltS");
   pragma Export (C, u00077, "ada__text_ioB");
   pragma Export (C, u00078, "ada__text_ioS");
   pragma Export (C, u00079, "ada__streamsS");
   pragma Export (C, u00080, "ada__tagsB");
   pragma Export (C, u00081, "ada__tagsS");
   pragma Export (C, u00082, "system__val_unsB");
   pragma Export (C, u00083, "system__val_unsS");
   pragma Export (C, u00084, "system__val_utilB");
   pragma Export (C, u00085, "system__val_utilS");
   pragma Export (C, u00086, "system__case_utilB");
   pragma Export (C, u00087, "system__case_utilS");
   pragma Export (C, u00088, "interfaces__c_streamsB");
   pragma Export (C, u00089, "interfaces__c_streamsS");
   pragma Export (C, u00090, "system__crtlS");
   pragma Export (C, u00091, "system__file_ioB");
   pragma Export (C, u00092, "system__file_ioS");
   pragma Export (C, u00093, "ada__finalizationB");
   pragma Export (C, u00094, "ada__finalizationS");
   pragma Export (C, u00095, "system__finalization_rootB");
   pragma Export (C, u00096, "system__finalization_rootS");
   pragma Export (C, u00097, "system__finalization_implementationB");
   pragma Export (C, u00098, "system__finalization_implementationS");
   pragma Export (C, u00099, "system__restrictionsB");
   pragma Export (C, u00100, "system__restrictionsS");
   pragma Export (C, u00101, "system__stream_attributesB");
   pragma Export (C, u00102, "system__stream_attributesS");
   pragma Export (C, u00103, "ada__io_exceptionsS");
   pragma Export (C, u00104, "system__file_control_blockS");
   pragma Export (C, u00105, "ada__finalization__list_controllerB");
   pragma Export (C, u00106, "ada__finalization__list_controllerS");
   pragma Export (C, u00107, "ada__text_io__float_auxB");
   pragma Export (C, u00108, "ada__text_io__float_auxS");
   pragma Export (C, u00109, "ada__text_io__generic_auxB");
   pragma Export (C, u00110, "ada__text_io__generic_auxS");
   pragma Export (C, u00111, "system__img_realB");
   pragma Export (C, u00112, "system__img_realS");
   pragma Export (C, u00113, "system__img_lluB");
   pragma Export (C, u00114, "system__img_lluS");
   pragma Export (C, u00115, "system__img_unsB");
   pragma Export (C, u00116, "system__img_unsS");
   pragma Export (C, u00117, "system__powten_tableS");
   pragma Export (C, u00118, "system__val_realB");
   pragma Export (C, u00119, "system__val_realS");
   pragma Export (C, u00120, "ada__text_io__integer_auxB");
   pragma Export (C, u00121, "ada__text_io__integer_auxS");
   pragma Export (C, u00122, "system__img_biuB");
   pragma Export (C, u00123, "system__img_biuS");
   pragma Export (C, u00124, "system__img_intB");
   pragma Export (C, u00125, "system__img_intS");
   pragma Export (C, u00126, "system__img_llbB");
   pragma Export (C, u00127, "system__img_llbS");
   pragma Export (C, u00128, "system__img_lliB");
   pragma Export (C, u00129, "system__img_lliS");
   pragma Export (C, u00130, "system__img_llwB");
   pragma Export (C, u00131, "system__img_llwS");
   pragma Export (C, u00132, "system__img_wiuB");
   pragma Export (C, u00133, "system__img_wiuS");
   pragma Export (C, u00134, "system__val_intB");
   pragma Export (C, u00135, "system__val_intS");
   pragma Export (C, u00136, "system__val_lliB");
   pragma Export (C, u00137, "system__val_lliS");
   pragma Export (C, u00138, "system__val_lluB");
   pragma Export (C, u00139, "system__val_lluS");
   pragma Export (C, u00140, "text_ioS");
   pragma Export (C, u00141, "vectoresB");
   pragma Export (C, u00142, "vectoresS");
   pragma Export (C, u00143, "graficasB");
   pragma Export (C, u00144, "graficasS");
   pragma Export (C, u00145, "ada__float_text_ioB");
   pragma Export (C, u00146, "ada__float_text_ioS");
   pragma Export (C, u00147, "ada__integer_text_ioB");
   pragma Export (C, u00148, "ada__integer_text_ioS");
   pragma Export (C, u00149, "gnu__plotutil__deviceB");
   pragma Export (C, u00150, "gnu__plotutil__deviceS");
   pragma Export (C, u00151, "gnu__plotutil__device__directB");
   pragma Export (C, u00152, "gnu__plotutil__device__directS");
   pragma Export (C, u00153, "gnu__plotutil__fplotB");
   pragma Export (C, u00154, "gnu__plotutil__fplotS");
   pragma Export (C, u00155, "textosB");
   pragma Export (C, u00156, "textosS");
   pragma Export (C, u00157, "ada__command_lineB");
   pragma Export (C, u00158, "ada__command_lineS");
   pragma Export (C, u00159, "ada__strings__fixedB");
   pragma Export (C, u00160, "ada__strings__fixedS");
   pragma Export (C, u00161, "ada__strings__searchB");
   pragma Export (C, u00162, "ada__strings__searchS");
   pragma Export (C, u00163, "system__string_ops_concat_4B");
   pragma Export (C, u00164, "system__string_ops_concat_4S");
   pragma Export (C, u00165, "system__memoryB");
   pragma Export (C, u00166, "system__memoryS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.handling%s
   --  ada.characters.latin_1%s
   --  ada.command_line%s
   --  interfaces%s
   --  system%s
   --  system.bit_ops%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.htable%s
   --  system.htable%b
   --  system.img_enum_new%s
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.img_real%s
   --  system.machine_code%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.restrictions%s
   --  system.restrictions%b
   --  system.standard_library%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.img_enum_new%b
   --  system.secondary_stack%s
   --  ada.command_line%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_ops%s
   --  system.string_ops%b
   --  system.string_ops_concat_3%s
   --  system.string_ops_concat_3%b
   --  system.string_ops_concat_4%s
   --  system.string_ops_concat_4%b
   --  system.traceback%s
   --  system.traceback%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  ada.exceptions.last_chance_handler%s
   --  system.soft_links%s
   --  system.soft_links%b
   --  ada.exceptions.last_chance_handler%b
   --  system.secondary_stack%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.io_exceptions%s
   --  ada.numerics%s
   --  ada.numerics.aux%s
   --  ada.strings%s
   --  ada.tags%s
   --  ada.streams%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  interfaces.c.strings%s
   --  interfaces.c.strings%b
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.unsigned_types%s
   --  system.bit_ops%b
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.fixed%s
   --  ada.strings.maps.constants%s
   --  ada.characters.handling%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.fixed%b
   --  system.fat_flt%s
   --  ada.numerics.elementary_functions%s
   --  ada.numerics.elementary_functions%b
   --  system.fat_llf%s
   --  ada.numerics.aux%b
   --  system.img_biu%s
   --  system.img_biu%b
   --  system.img_llb%s
   --  system.img_llb%b
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_llw%s
   --  system.img_llw%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.img_real%b
   --  system.img_wiu%s
   --  system.img_wiu%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  system.finalization_implementation%s
   --  system.finalization_implementation%b
   --  ada.finalization%s
   --  ada.finalization%b
   --  ada.finalization.list_controller%s
   --  ada.finalization.list_controller%b
   --  system.file_control_block%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.val_int%s
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_real%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_real%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.val_int%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.tags%b
   --  ada.exceptions%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.float_aux%s
   --  ada.float_text_io%s
   --  ada.float_text_io%b
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.text_io.float_aux%b
   --  ada.text_io.integer_aux%s
   --  ada.text_io.integer_aux%b
   --  ada.integer_text_io%s
   --  ada.integer_text_io%b
   --  text_io%s
   --  gnu%s
   --  gnu.plotutil%s
   --  gnu.plotutil%b
   --  gnu.plotutil.athena%s
   --  configuracion%s
   --  gnu.plotutil.device%s
   --  gnu.plotutil.device%b
   --  gnu.plotutil.device.direct%s
   --  gnu.plotutil.device.direct%b
   --  gnu.plotutil.fplot%s
   --  gnu.plotutil.fplot%b
   --  textos%s
   --  textos%b
   --  vectores%s
   --  vectores%b
   --  geometria%s
   --  geometria%b
   --  graficas%s
   --  graficas%b
   --  prueba_utiles%b
   --  END ELABORATION ORDER

end ada_main;

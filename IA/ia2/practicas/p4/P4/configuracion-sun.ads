---------------------------------------------------------------------
-- Fichero:   configuracion.ads
-- Autor:     J.D.Tardos
-- Version:   v1.0 10-5-2000
-- Proposito: opciones para linkar en merlin, solaris y Linux
---------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Opciones para el linkado: Elige las adecuadas para tu sistema
-- Merlin: -------------------------------------------------------------------
-- with GNU.plotutil.Motif ;
-- Pragma Linker_Options("-L/users2/IAIC2/salidas/plotutil/lib") ;
-- Linux: -------------------------------------------------------------------
-- with GNU.plotutil.Athena ;
-- Pragma Linker_Options("-L/donde_lo_tengas/plotutil/lib") ;
-- Solaris: -----------------------------------------------------------------
   pragma Linker_Options ("-L/usr/openwin/lib");
   pragma Linker_Options ("-L/home/jdtardos/usr/lib");
   pragma Linker_Options ("-lXm");
   pragma Linker_Options ("-lXt");
   pragma Linker_Options ("-lXext");
   pragma Linker_Options ("-lX11");
   pragma Linker_Options ("-lm");
----------------------------------------------------------------------------

Package configuracion is

  -- Coloca aqui el path adecuado para los ficheros de datos
  --PATH: string := "/users2/IAIC2/salidas/p2/datos/" ; -- Para merlin
  PATH: string := "../datos/" ; -- Para otros

end;

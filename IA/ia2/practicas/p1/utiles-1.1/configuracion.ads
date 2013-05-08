---------------------------------------------------------------------
-- Fichero:   configuracion.ads
-- Autor:     J.D.Tardos
-- Version:   v1.1 6-4-2001
-- Proposito: opciones para linkar en merlin, solaris y Linux
---------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Paquete de ventanas a utilizar: Elige el adecuado para tu sistema
-- Merlin: -------------------------------------------------------------------
--with GNU.plotutil.Motif ;
-- Linux: -------------------------------------------------------------------
with GNU.plotutil.Athena ;
-- Solaris: -----------------------------------------------------------------
----------------------------------------------------------------------------

Package configuracion is

-----------------------------------------------------------------------------
-- Opciones para el linkado: Elige las adecuadas para tu sistema
-- Merlin: -------------------------------------------------------------------
-- Pragma Linker_Options("-L/users2/IAIC2/salidas/plotutil/lib") ;
-- Linux: -------------------------------------------------------------------
Pragma Linker_Options("-L/usr/lib") ;
-- Solaris: -----------------------------------------------------------------
--   pragma Linker_Options ("-L/usr/openwin/lib");
--   pragma Linker_Options ("-L/home/jdtardos/usr/lib");
--   pragma Linker_Options ("-lXm");
--   pragma Linker_Options ("-lXt");
--   pragma Linker_Options ("-lXext");
--  pragma Linker_Options ("-lX11");
--   pragma Linker_Options ("-lm");
----------------------------------------------------------------------------

  -- Coloca aqui el path adecuado para los ficheros de datos
  PATH: string := "/home/marcos/asignaturas/cuatrimestre8/ia2/practicas/p1" ; -- Para merlin
  --PATH: string := "../datos/" ; -- Para otros

end;

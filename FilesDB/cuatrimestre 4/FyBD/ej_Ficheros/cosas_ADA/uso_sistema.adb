--***************************************************************
--Fichero:	uso_sistema.adb
--Tema:		m'odulo para llamadas al S.O. Utiliza la llamada
--				'system()' de C
--Fecha:		Enero-97
--Fuente:	Propio
--Com.:		Uso en ADA de funciones de stdlib (C) 
--***************************************************************

--------------------------------------------------
-- System para la stdlib
-- Interfaces.C para transformar strings
--------------------------------------------------

with Interfaces.C,System;
use Interfaces.C,System;

package body uso_sistema is

	-----------------------------------------------
	procedure sistema_C(orden: in char_array);
	pragma IMPORT(C,sistema_C,"system");
	-----------------------------------------------	
	procedure sistema(laOrden: in string) is
	begin
		sistema_C(TO_C(laOrden));			
	end;
	-----------------------------------------------
	procedure times(buffer:out regTMS);
	pragma IMPORT(C,times,"times");
	-----------------------------------------------
	procedure marca(m:out ticks) is
	elTiempo:regTMS;
	begin
		times(elTiempo);
		m:=ticks(elTiempo.utime);
	end marca;
	-----------------------------------------------
end uso_sistema;

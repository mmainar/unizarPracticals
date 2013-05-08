--***************************************************************
--Prog.:		prueba.adb
--Tema:		uso conjunto de C y ADA
--Fecha:		Diciembre-96
--Fuente:	Propio
--Com.:		En "uso_sistema" hay un paquete con algunas funciones
--				para uso de invocaciones al S.O., que usan
--				la 'stdlib' de C
--				Para compilar: "gnatmake prueba.adb"
--***************************************************************


with text_io;use text_io;				--E/S para texto
with Ada.integer_text_io;use Ada.integer_text_io;
with uso_sistema;use uso_sistema;	--mi paquete para practMP


procedure prueba is
	--package ticksIO is new integer_io(ticks);use ticksIO;
	--package intIO is new integer_io(integer);use intIO;
	---------------------------------------------------------------
	procedure espera(val1,val2:in integer) is
	a:integer;
	begin
		for i in val1..val2 loop
			for j in val1..val2 loop
				a:=23435;
			end loop;
		end loop;
	end;
	---------------------------------------------------------------
	t1,t2,intervalo:ticks;
	limite,n:integer:=0;
	
	fichSalida:FILE_TYPE;
begin
	put("Valor limite de n:");get(limite);
	create(fichSalida,name=>"resultados");
	while n<=limite loop
		marca(t1);
		espera(0,n);
		marca(t2);
		
		put("n:"); put(n,width=>5);
		intervalo:=t2-t1;
		put("    t:");put(intervalo,width=>5);
		new_line;
		
		put(fichSalida,n,width=>5);
		put(fichSalida,intervalo,width=>5);
		new_line(fichSalida);
		n:=n+100;
	end loop;
	close(fichSalida);
end prueba;

------------------------------------------------------------------------------
-- Fichero: paraautoreplicar.adb
-- Tema:    programa que calcula un programa autoreplicante
--          usando el TAD simuladorPrograma
-- Fecha:   17 de Octubre de 2007
-- Autor:   Elvira Mayordomo Cámara
-- Com.:    Ejercicio propuesto de MAC (Modelos abstractos de cálculo).
------------------------------------------------------------------------------ 

with Ada.text_IO, simuladorPrograma; 
USE Ada.text_IO, SimuladorPrograma; 

PROCEDURE paraAutoReplicar IS
-- El resultado de este programa es un autoreplicante 
   F:FileType;
   CP,CResultado:Cadena;
   resultado:programa;
BEGIN 
   cP:=A_cadena("PROCEDURE Uno(A:IN cadena; B:OUT cadena) IS BEGIN   CalculaSelf(A,B); END Uno; ");
   CalculaSelf(CP,CResultado); 
   
   -- escribimos el resultado en el fichero misp.adb
   Create(F,Out_File,"misp.adb");
   cadenaaprograma(cresultado,resultado);
   Escribeafichero(resultado,F);
   Close(F);
   -- en el fichero misp.adb está un procedimiento autoreplicante
end paraAutoReplicar;
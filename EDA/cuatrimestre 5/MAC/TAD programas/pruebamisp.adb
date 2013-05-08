------------------------------------------------------------------------------
-- Fichero: pruebamisp.adb
-- Tema:    programa que prueba el funcionamiemto del procedimiento que está en misp.adb, 
--          dejando el resultado en el fichero copia.adb
--          usa el TAD simuladorPrograma
-- Fecha:   17 de Octubre de 2007
-- Autor:   Elvira Mayordomo Cámara
-- Com.:    Ejercicio propuesto de MAC (Modelos abstractos de cálculo).
------------------------------------------------------------------------------ 

with Ada.text_IO, simuladorPrograma, misp; 
USE Ada.text_IO, SimuladorPrograma; 

PROCEDURE pruebaMisp IS
   X,Y:cadena;
   F:FileType;
   auxy:programa;
BEGIN
   misp(X,Y); -- con cualquier entrada misp da como resultado misp

   -- escribimos y en el fichero copia.adb   
   Create(F,Out_File,"copia.adb");
   cadenaaprograma(y,auxy);
   Escribeafichero(auxy,F);
   close(f);
END pruebaMisp;
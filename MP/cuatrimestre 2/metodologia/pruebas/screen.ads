----------------------------------------------------------------------------
-- Utilizaci'on:
-- 
-- Dos posibilidades:
-- * Copiar los ficheros en el directorio en que est'a el programa y compilar
--   normalmente. 
-- * Utilizar los ficheros donde est'an (recomendado). Para ello:
--
--   gnatmake miPrograma.adb -I/users2/PROGRAMACION/salidas/LIBS/
--
--   esta instrucci'on le dice que busque los paquetes en el directorio que
--   se le indica adem'as de los que 'el ya conoce (el directorio actual y 
--   los definidos en el sistema).
----------------------------------------------------------------------------
package Screen is
	procedure Clear_Screen;
	procedure Move_Cursor (Row, Column : in Integer);
end Screen;

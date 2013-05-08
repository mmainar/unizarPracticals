-- AUTORES: Ismael Saad Garc�a. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: programa de gestion del TAD listaexitos
--           para la pr�ctica 3 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: gestor.adb
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de �xitos formada por canciones con un t�tulo, un
--              int�rprete, una fecha de grabaci�n y un n�mero de
--              ventas.
with interfaces.c, Ada.Strings.Unbounded,  ada.text_IO, ada.integer_text_IO;
use Ada.Strings.Unbounded , ada.text_IO, ada.integer_text_IO;

procedure gestor is

package c renames interfaces.c;
function system (command: c.char_array) return c.int;
pragma import(C,system,"system");




  rc: c.int;
  opcion, opcionAux, car: character;
  elegida: boolean:= false;
begin
   rc:= system(c.to_c("prueba2"));
end gestor;
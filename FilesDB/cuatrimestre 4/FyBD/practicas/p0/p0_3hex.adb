-- Tema: Visor genérico de ficheros secuenciales en formato hexadecimal.
-- Fecha de la última revisión: 24-3-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: Permite visualizar por pantalla el contenido de cualquier
--              fichero, byte a byte, mostrando el valor hexadecimal del
--              byte junto con el carácter ASCII. En caso de que no sea
--              posible mostrar el carácter ASCII correspondiente, se
--              mostrará el carácter '.'.
--------------------------------------------------------------------------
with ada.text_IO, ada.sequential_IO;

procedure p0_3hex is


 PUNTO: constant character:= character'val(46);

 package byte_IO is new ada.sequential_IO(character);
 use ada.text_IO, byte_IO;
 subtype fichSec is byte_IO.file_type;


 function ValorHexadecimal (num : integer) return character is
 -- Post: Devuelve el carácter hexadecimal correspondiente al
 --       valor entero "num".

 begin
   case num is
     when 0 => return '0';
     when 1 => return '1';
     when 2 => return '2';
     when 3 => return '3';
     when 4 => return '4';
     when 5 => return '5';
     when 6 => return '6';
     when 7 => return '7';
     when 8 => return '8';
     when 9 => return '9';
     when 10 => return 'A';
     when 11 => return 'B';
     when 12 => return 'C';
     when 13 => return 'D';
     when 14 => return 'E';
     when 15 => return 'F';
     when others => return '0';
   end case;
 end ValorHexadecimal;


 procedure decimalAHexa(numero: in integer; hexa: out string; longitudHexa: in integer) is
 -- Post: Transforma un decimal a hexadecimal con longitud "longitudHex"

   resto, n, aux : integer;
   nuevoCaracter : character;
 begin
   n:= longitudHexa; aux:= numero;
   for i in 1..n loop
      hexa(i) := '0';
   end loop;
   while (aux/=0) and (n/=0) loop
      resto:= aux mod 16;
      aux:= aux / 16;
      nuevoCaracter:= ValorHexadecimal(resto);
      hexa(n):= nuevoCaracter;
      n:= n - 1;
   end loop;
 end decimalAHexa;


 procedure visorHexadecimal(f: in out fichSec) is
 --
 -- Post: Muestra por pantalla el contenido del fichero "f" byte a byte en
 --       formato hexadecimal junto con el carácter ASCII. En caso de que
 --       sea no imprimible(caracteres del 0 al 31) se muestra un punto.

   dato: character;
   buffer: array(1..16) of character;
   cuenta, i, numByte: natural:= 0;
   hexa: string(1..6);
 begin
   decimalAHexa(numByte,hexa,6);
   put(hexa(1..6)); put("  ");
   while not end_of_file(f) loop
     read(f,dato); cuenta:= cuenta + 1;
     numByte:= numByte + 1;
     if character'pos(dato)<=31 then buffer(cuenta):= PUNTO;
     else buffer(cuenta):= dato;
     end if;
     i:= character'pos(dato);
     decimalAHexa(i,hexa,2);
     put(hexa(1..2)); put(' ');
     if (cuenta mod 16=0) or end_of_file(f) then
       if end_of_file(f) then
         for i in 1..17-cuenta loop put("   "); end loop;
         for i in 1..cuenta loop put(buffer(i)); end loop;
       else
         i:= 1; cuenta:= 0; put("   ");
         for i in 1..16 loop put(buffer(i)); end loop;
         new_Line;
         decimalAHexa(numByte,hexa,6);
         put(hexa(1..6)); put("  ");
      end if;
     end if;
   end loop;
 end visorHexadecimal;


 nombre: string(1..150);
 longitud: integer;
 f: fichSec;
 esCorrecto: boolean:= false;
begin
 while not esCorrecto loop
   begin
     put("fichero a visualizar en formato hexadecimal? ");
     get_line(nombre,longitud); new_line;
     open(f,in_file,nombre(1..longitud));
     esCorrecto:= true;
     exception
       when byte_IO.Name_Error =>
         put_line("El fichero introducido no existe, por favor, introduzca el nombre correcto");
         new_line;
   end;
 end loop;
 visorHexadecimal(f); close(f);
end p0_3hex;
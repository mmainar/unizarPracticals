-- Tema: Visor genérico de ficheros secuenciales en formato decimal.
-- Fecha de la última revisión: 24-3-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: Permite visualizar por pantalla el contenido de cualquier
--              fichero, byte a byte, mostrando el valor decimal del byte
--              junto con el carácter ASCII. En caso de que no sea posible
--              mostrar el carácter ASCII correspondiente, se mostrará
--              el carácter '.'.
--------------------------------------------------------------------------
with ada.text_IO, ada.sequential_IO, ada.integer_text_IO;

procedure p0_3dec is

 CERO: constant integer:= 48; -- Posición del '0' en la tabla ASCII
 PUNTO: constant character:= character'val(46);

 package byte_IO is new ada.sequential_IO(character);
 use ada.text_IO, ada.integer_text_IO, byte_IO;
 subtype fichSec is byte_IO.file_type;


 procedure decimal(numero: in integer; dec: out string; longDec: in integer) is
 -- Post: Transforma el entero "numero" a una cadena "dec" de "longDec"
 --       caracteres.

   resto, n, aux : integer;
   nuevoCaracter : character;
 begin
   n:= longDec; aux:= numero;
   for i in 1..n loop
      dec(i) := '0';
   end loop;
   while (aux/=0) and (n/=0) loop
      resto:= aux mod 10;
      aux:= aux / 10;
      nuevoCaracter:= character'val(resto+CERO);
      dec(n):= nuevoCaracter;
      n:= n - 1;
   end loop;
 end decimal;


 procedure visorDecimal(f: in out fichSec) is
 -- Post: Muestra por pantalla el contenido del fichero "f" byte a byte en
 --       formato decimal junto con el carácter ASCII. En caso de que dicho
 --       carácter sea no imprimible(caracteres del 0 al 31) se muestra un
 --       punto.

   dato: character;
   buffer: array(1..10) of character;
   cuenta, i, numByte: natural:= 0;
   dec: string(1..6);
 begin
   decimal(numByte,dec,6);
   put(dec(1..6)); put("  ");
   while not end_of_file(f) loop
     read(f,dato); cuenta:= cuenta + 1;
     numByte:= numByte + 1;
     if character'pos(dato)<=31 then buffer(cuenta):= PUNTO;
     else buffer(cuenta):= dato;
     end if;
     i:= character'pos(dato);
     put(i,3); put(' ');
     if (cuenta mod 10=0) or end_of_file(f) then
       if end_of_file(f) then
         for i in 1..11-cuenta loop put("    "); end loop;
         for i in 1..cuenta loop put(buffer(i)); end loop;
       else
         i:= 1; cuenta:= 0; put("   ");
         for i in 1..10 loop put(buffer(i)); end loop;
         new_Line;
         decimal(numByte,dec,6);
         put(dec(1..6)); put("  ");
      end if;
     end if;
   end loop;
 end visorDecimal;


 nombre: string(1..150);
 longitud: integer;
 f: fichSec;
 esCorrecto: boolean:= false;
begin
 while not esCorrecto loop
   begin
     put("fichero a visualizar en formato decimal? ");
     get_line(nombre,longitud); new_line;
     open(f,in_file,nombre(1..longitud));
     esCorrecto:= true;
     exception
       when byte_IO.Name_Error =>
         put_line("El fichero introducido no existe, por favor, introduzca el nombre correcto");
         new_line;
   end;
 end loop;
 visorDecimal(f); close(f);
end p0_3dec;
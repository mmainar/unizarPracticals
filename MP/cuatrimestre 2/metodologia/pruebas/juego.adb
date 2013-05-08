with interfaces.c, ada.Text_IO;
use ada.Text_IO;
procedure cls is
package c renames interfaces.c;
function system (command: c.char_array) return c.int;
pragma import(C,system,"system");
rc: c.int;
car:character;
fila,columna:integer;
begin
put("Para moverte pulsa las teclas W, S, A y D, cuando pulses una de estas empezaras"); new_line;
put("Podras pulsar 0 para salir"); 
columna:=0;
fila:=0;
car:='A';
while not (car='0') loop
get_immediate(car);
if car='w' then fila:=fila-1; end if;
if car='s' then fila:=fila+1; end if;
if car='a' then columna:=columna-1; end if;
if car='d' then columna:=columna+1; end if;
rc:=system(c.to_c("cls"));
for i in 0..fila loop
new_line;
end loop;
for j in 0..columna loop
put(' ');
end loop;
put("0^0"); new_line;

for i in 0..columna loop
put(" ");
end loop;
put(" | ");
new_line;
for i in 0..columna loop
put(" ");
end loop;

put("\_/");        
end loop;
end cls;
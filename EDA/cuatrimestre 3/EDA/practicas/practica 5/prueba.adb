with ada.Text_IO,arbolesDeDir,ustrings,interfaces.c,glistas,ada.Integer_Text_IO,ada.Strings.Unbounded;
use ada.Text_IO,arbolesDeDir,ustrings,ada.Integer_Text_IO,ada.Text_IO,ada.Strings.Unbounded;


procedure prueba is
 use mislistas;
 package c renames interfaces.c;
 function system (command: c.char_array) return c.int;
 pragma import(C,system,"system");


 procedure listarMenu is
 begin
   put("1 - Busqueda de un directorio hijo del actual"); new_line;
   put("2 - Anyadir un directorio al actual"); new_line;
   put("3 - Pwd"); new_line;
   put("4 - Cd"); new_line;
   put("5 - Cd.."); new_line;
   put("6 - Listado en preorden "); new_line;
   put("7 - Tamanio de los directorios que descienden del actual"); new_line;
   put("8 - ls");
   put("0 - Salir"); new_Line;
   put("Elige una opcion: ");
 end listarMenu;


 procedure cogerTamanio(n: out natural) is
   error: boolean:= true;
 begin
   while error loop
     begin
       put("Introduce el tamano del directorio: "); get(n);
       skip_line; error:=false;
       exception
         when DATA_ERROR =>
           skip_line;
           put("Debe introducir un numero"); new_line;
     end;
   end loop;
 end cogerTamanio;


 procedure buscarDir(d: in arbolDeDir) is
   nombre: ustring;
 begin
   new_Line;
   put("Introduzca nombre del directorio: "); get_line(nombre);
   if esta(d,nombre) then
     put("El directorio introducido es hijo del actual");
   else put("El directorio introducido no es hijo del actual");
   end if;
   new_Line;
 end buscarDir;


 procedure aniadeDir(d: in out arbolDeDir) is
   nombre: ustring;
   tamanio: natural;
 begin
   new_Line;
   put("Introduzca el nombre del directorio a aniadir: ");
   get_line(nombre);
   if not esta(d,nombre) then
     cogerTamanio(tamanio);
     anadeDirectorio(d,nombre,tamanio);
     put("Directorio anyadido correctamente"); new_Line;
   else put("Ya existe el directorio de nombre: "); put(nombre);
   end if;
   new_Line;
 end aniadeDir;


 procedure cd(d: in out arbolDeDir) is
   nombre: ustring;
 begin
   new_Line;
   put("Nombre del directorio: "); get_line(nombre);
   if esta(d,nombre) then
     cd(d,nombre);
   else put("no existe el directorio");
   end if;
   new_Line;
 end cd;


 procedure arriba(d: in out arbolDeDir) is
 begin
   new_Line;
   if tienePadre(d) then cdpp(d);
   else put("El directorio actual es el directorio raiz");
   end if;
   new_Line;
 end;


 procedure listar(d: in arbolDeDir) is
   l: lista;
 begin
   new_Line;
   listado(d,l);
   while not(esVacia(l)) loop
     put(observaIzq(l)); put(" ");
     eliminaIzq(l);
   end loop;
   new_Line;
 end listar;


 procedure crearRaiz(d: out arbolDeDir) is
   raiz: ustring;
   tamanio: natural;
 begin
   put("Introduce el nombre del directorio raiz: "); get_line(raiz);
   cogerTamanio(tamanio);
   crearEstructura(raiz,tamanio,d);
   put("Estructura creada"); new_line(2);
   put("Pulsa una tecla para continuar...");
 end crearRaiz;
 
  
 procedure ponerAyuda is
   rc:c.int; car:character;
 begin
   rc:=system(c.to_c("cls"));
   put("  Opciones disponibles:"); new_line;
   put("  $> pwd"); new_line;
   put("  $> cd"); new_line;
   put("  $> cd.."); new_line;
   put("  $> preorden"); new_line;
   put("  $> tamano"); new_line;
   put("  $> mkdir"); new_line;
   put("  $> buscar"); new_line;
   put("  $> help"); new_line;
   put("  $> clear"); new_line;
   put("  Pulsa una tecla para continuar"); get_immediate(car);
   rc:=system(c.to_c("cls"));
 end ponerAyuda;


 rc: c.int;
 d: arbolDeDir;
 car: character;
 opcion: character;
 nombre,comando: ustring;
begin
 crearRaiz(d);
 get_immediate(car);
 rc:=system(c.to_c("cls"));
 put("Pulse 1 para modo menu o 2 para modo comandos: "); get(opcion); skip_line;
 if opcion='1' then
   listarMenu; get(opcion); skip_line;
   while not(opcion='0') loop
     case opcion is
       when '0' => null;
       when '1' => buscarDir(d);
       when '2' => aniadeDir(d);
       when '3' => pwd(d,nombre); put(nombre); new_line;
       when '4' => cd(d);
       when '5' => arriba(d);
       when '6' => listar(d);
       when '7' => put("El tamanio es: "); put(tamano(d),0); new_Line;
       when '8' => ls(d);
       when others => put("Opcion incorrecta"); new_Line;
     end case;
     new_Line(2);
     put("Pulsa una tecla para continuar...");
     get_immediate(car);
     rc:=system(c.to_c("cls"));
     listarMenu; get(opcion); skip_line;
   end loop;
 else
   ponerAyuda;
   put("$> "); get_line(comando);
   while not(comando="exit") loop
     if comando="ls" then ls(d);
       elsif comando="pwd" then pwd(d,nombre); put(nombre); new_line;
       elsif comando="cd.." then arriba(d);
       elsif comando="preorden" then listar(d);
       elsif comando="tamano" then put("El tamanio es: "); put(tamano(d),0); new_Line;
       elsif length(comando)=5 and then to_string(comando)(1..5)="mkdir" then aniadeDir(d);
       elsif length(comando)=6 and then to_string(comando)(1..6)="buscar" then buscarDir(d);
       elsif comando="help" then ponerAyuda;
       elsif comando="cd" then cd(d);
       elsif comando=null_unbounded_string then null;
       elsif comando="clear" then rc:=system(c.to_c("cls"));
       else put("Opcion incorrecta"); new_line;
     end if;
     put("$> "); get_line(comando);
   end loop;  
 end if; 
end prueba;








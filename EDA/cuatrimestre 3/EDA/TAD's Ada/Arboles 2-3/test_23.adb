-- Programa de prueba del módulo genérico "arbol_23".
-- Fecha: 17/XI/99
-- Autor: Javier Campos Laclaustra (jcampos@posta.unizar.es)
--
-- El programa utiliza el módulo "ustrings", disponible en
-- /users2/EDA/salidas/ y el módulo "arbol_23".
--
-- El programa solicita interactivamente los nombres de dos ficheros
-- de los que lee palabras y sus definiciones (respectivamente)
-- y guarda esa información en un árbol 2-3 (variable del tipo "a23"
-- exportado por el módulo "arbol_23").
--
-- Se puede ejecutar también el programa con dos argumentos (los 
-- nombres de los ficheros de palabras y definiciones), como por ej.:
--
--   merlin_$ test_23 palabras.txt definiciones.txt
--
-- en cuyo caso yo no solicita tales nombres de forma interactiva.
--
-- A continuación el programa muestra un menú con opciones de
-- buscar, insertar(modificar), borrar una palabra, listar todas,
-- y terminar.
-- Las operaciones se realizan con el árbol almacenado en memoria.
-- En ningún momento se guardan en los ficheros los cambios realizados
-- en memoria.
--

with ada.text_io;           use ada.text_io;
with ada.strings.unbounded; use ada.strings.unbounded;
with ustrings;              use ustrings;
with ada.command_line;      use ada.command_line;
with arbol_23;
procedure test_23 is

  package diccionario is new arbol_23(ustring,ustring,"<",put,put);
  use diccionario;

  a:a23;            -- para almacenar el diccionario
  opcion:character; -- para elegir una opción del menú

  procedure cargaDiccionario(a:in out a23) is
  --
  -- Almacena en el árbol 'a' las palabras y definiciones
  -- leídas de sendos ficheros de texto cuyos nombres son solicitados 
  -- interactivamente (los ficheros deben tener una palabra o una 
  -- definición en cada línea).
  --
    fichPal,fichDef:file_type; -- ficheros de texto
    nombrefichPal,nombreFichDef,palabra,definicion:ustring;
  begin
    vacio(a);
    if argument_count<2 then --si se ha ejecutado el programa sin 
                    --argumentos (en realidad, con menos de 2) se pide
                    --interactivamente el nombre de los ficheros
                    --de palabras y de definiciones
      put("Nombre del fichero de palabras:");
      new_line;
      get_line(nombrefichPal);
      put("Nombre del fichero de definiciones:");
      new_line;
      get_line(nombreFichDef);
    else --los dos primeros argumentos son tales ficheros
      nombrefichPal:=U(argument(1));
      nombreFichDef:=U(argument(2));
    end if;
    put_line("Cargando en memoria el diccionario...");
    new_line;
    open(fichPal,in_file,S(nombrefichPal));
    open(fichDef,in_file,S(nombreFichDef));
    while not end_of_file(fichPal) loop
      get_line(fichPal,palabra);
      get_line(fichDef,definicion);
      modificar(a,palabra,definicion);
    end loop;
    close(fichPal);
    close(fichDef);
  end cargaDiccionario;

  procedure buscar(a:in a23) is
  --
  -- Solicita interactivamente una palabra para buscar, la busca
  -- en el árbol y (si está) escribe su significado.
  --
    palabra,significado:ustring; exito:boolean;
  begin
    new_line;
    put_line("Palabra buscada?");
    get_line(palabra);
    new_line;
    buscar(a,palabra,exito,significado);
    if exito then
      put_line("Significado:");
      put_line(significado);
    else
      put_line("No esta");
    end if;
    new_line;
  end buscar;

  procedure insertar(a:in out a23) is
  --
  -- Solicita interactivamente una palabra y su significado y la
  -- añade al árbol (o modifica su significado si ya estaba).
  --
    palabra,significado:ustring;
  begin
    new_line;
    put_line("Palabra a insertar?");
    get_line(palabra);
    new_line;
    put_line("Su significado?");
    get_line(significado);
    new_line;
    modificar(a,palabra,significado);
  end insertar;

  procedure borrar(a:in out a23) is
  --
  -- Solicita interactivamente una palabra y la borra del 
  -- diccionario (si está).
  --
    palabra:ustring;
  begin
    new_line;
    put_line("Palabra a borrar?");
    get_line(palabra);
    new_line;
    borrar(a,palabra);
  end borrar;

begin

  cargaDiccionario(a);

  loop
    put_line("OPERACIONES CON EL DICCIONARIO");
    new_line;
    put_line("(a) Buscar palabra.");
    put_line("(b) Insertar palabra.");
    put_line("(c) Borrar palabra.");
    put_line("(d) Listar palabras.");
    put_line("(e) Terminar.");
    new_line;
    put_line("Elige una opcion...");
    get(opcion);
    skip_line;
    case opcion is
      when 'a' | 'A' => buscar(a);
      when 'b' | 'B' => insertar(a);
      when 'c' | 'C' => borrar(a);
      when 'd' | 'D' => listado(a);
      when others    => null;
    end case;
    exit when opcion='e' or opcion='E';
  end loop;

end test_23;
--
-- Programa de prueba del m�dulo gen�rico "arbol_avl".
-- Fecha: 10/XI/99
-- Autor: Javier Campos Laclaustra (jcampos@posta.unizar.es)
--
-- El programa utiliza el m�dulo "ustrings", disponible en
-- /users2/EDA/salidas/ y el m�dulo "arbol_avl".
--
-- El programa solicita interactivamente los nombres de dos ficheros
-- de los que lee palabras y sus definiciones (respectivamente)
-- y guarda esa informaci�n en un �rbol AVL (variable del tipo "avl"
-- exportado por el m�dulo "arbol_avl").
--
-- Se puede ejecutar tambi�n el programa con dos argumentos (los nombres
-- de los ficheros de palabras y definiciones), como por ejemplo:
--
--   merlin_$ test_avl palabras.txt definiciones.txt
--
-- en cuyo caso yo no solicita tales nombres de forma interactiva.
--
-- A continuaci�n el programa muestra un men� con opciones de
-- buscar, insertar(modificar), borrar una palabra, listar en in-orden,
-- "pintar" el �rbol y terminar.
-- Las operaciones se realizan con el �rbol almacenado en memoria.
-- En ning�n momento se guardan en los ficheros los cambios realizados
-- en memoria.
--

with ada.text_io;           use ada.text_io;
with ada.strings.unbounded; use ada.strings.unbounded;
with ustrings;              use ustrings;
with ada.command_line;      use ada.command_line;
with arbol_avl;
procedure test_avl is

  package diccionario is new arbol_avl(ustring,ustring,"<",put,put);
  use diccionario;

  a:avl;            -- para almacenar el diccionario
  opcion:character; -- para elegir una opci�n del men�

  procedure cargaDiccionario(a:in out avl) is
  --
  -- Almacena en el �rbol 'a' las palabras y definiciones
  -- le�das de sendos ficheros de texto cuyos nombres son solicitados 
  -- interactivamente (los ficheros deben tener una palabra o una definici�n
  -- en cada l�nea).
  --
    fichPal,fichDef:file_type; -- ficheros de texto
    nombrefichPal,nombreFichDef,palabra,definicion:ustring;
  begin
    vacio(a);
    if argument_count<2 then --si se ha ejecutado el programa sin argumentos
                             --(en realidad, con menos de 2) se pide
                             --interactivamente el nombre de los ficheros
                             --de palabras y de definiciones
      put("Nombre del fichero de palabras:");
      new_line;
      get_line(nombrefichPal);
      put("Nombre del fichero de definiciones:");
      new_line;
      get_line(nombreFichDef);
    else --en caso contrario, los dos primeros argumentos son tales ficheros
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

  procedure buscar(a:in avl) is
  --
  -- Solicita interactivamente una palabra para buscar, la busca
  -- en el �rbol y (si est�) escribe su significado.
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

  procedure insertar(a:in out avl) is
  --
  -- Solicita interactivamente una palabra y su significado y la
  -- a�ade al �rbol (o modifica su significado si ya estaba).
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

  procedure borrar(a:in out avl) is
  --
  -- Solicita interactivamente una palabra y la borra del diccionario (si est�).
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
    new_line;
    if not equilibrado(a) then --a�adido en la fase de depuraci�n
      put_line("OJO: EL ARBOL NO ESTA EQUILIBRADO!!!");
      new_line;
    end if;
    if not test_factores_equilibrio(a) then --a�adido en la fase de depuraci�n
      put_line("OJO: LOS FACTORES DE EQUILIBRIO ESTAN MAL!!!");
      new_line;
    end if;
    put_line("OPERACIONES CON EL DICCIONARIO");
    new_line;
    put_line("(a) Buscar palabra.");
    put_line("(b) Insertar palabra.");
    put_line("(c) Borrar palabra.");
    put_line("(d) Listar en in-orden.");
    put_line("(e) Pintar el �rbol.");
    put_line("(f) Terminar.");
    new_line;
    put_line("Elige una opcion...");
    get(opcion);
    skip_line;
    case opcion is
      when 'a' | 'A' => buscar(a);
      when 'b' | 'B' => insertar(a);
      when 'c' | 'C' => borrar(a);
      when 'd' | 'D' => put_inorden(a);
      when 'e' | 'E' => pintar_arbol(a);
      when others    => null;
    end case;
    exit when opcion='f' or opcion='F';
  end loop;

end test_avl;
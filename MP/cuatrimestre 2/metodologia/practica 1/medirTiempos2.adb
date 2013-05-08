-----------------------------------------------------------------------------
-- Fichero: medirTiempos.adb
-- Tema:    Fichero de medida experimental de tiempos de ejecución.
-- Fecha:   Marzo de 2006
-- Versión: 1.0
-- Autor:   Ismael Saad García. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 1 de Metodología de la Programación.
------------------------------------------------------------------------------
with ada.calendar, ada.integer_text_IO, ada.text_IO, operaciones,
    ada.numerics.discrete_random, ada.float_text_IO;
------------------------------------------------------------------------------
procedure medirTiempos is
--
-- Pre: cierto
-- Post: Mide experimentalmente los tiempos de ejecucion de los algoritmos
--       de ordenacion QuickSort, seleccion e insercion, y los de busqueda
--       binaria, lineal y en fichero aplicados a tablas y ficheros de
--       distintos tamaños N de datos predefinidos en el programa.
--
--
-- Instanciación del paquete operaciones para datos de tipo entero
-- (integer) con la relación de orden definida por la función "<="
-- de comparación de pares de datos de tipo 'integer'.

  package bibOperaciones is new operaciones(integer,"<=");
  subtype tpIndice is integer range 1..Integer'Last;
  package bibAleatorios is new ada.numerics.discrete_random(tpIndice);

  use ada.Calendar, ada.integer_text_IO, ada.text_IO, bibOperaciones,
     bibAleatorios, ada.float_text_IO;


  procedure aleatorio(T: out tpTabla) is
  --
  -- Pre:  cierto
  -- Post: (PT alfa en [T'first..T'last].
  --        ((1<=T(alfa)) AND (T(alfa)<=Integer'Last)
  --         AND (PT x en [1,Integer'Last].probabilidad(T(alfa)<=x)=x))
  --
  -- Procedimiento que asigna valores enteros aleatorios a todas
  -- las componentes de la tabla T. El tipo de la tabla T es tpTabla
  -- (no restringido), pero podemos conocer los valores de los limites
  -- inferior y superior de los indices utilizando los atributos T'first
  -- y T'last de la tabla que se pase como argumento al parametro T.
  --
    g: generator;
  begin
    reset(g); -- inicia el generador de numeros aleatorios
    -- recorrido de todas las componenes de la tabla: T'range es
    -- equivalente a T'first..T'last
    for i in T'range loop
      T(i) := random(g);  -- almacena un numero aleatorio
    end loop;
  end aleatorio;


  -------------------------------------------------------------------
  -- ordenada(T,desde,hasta)
  -- <-> (PT alfa en [desde..hasta-1].T(alfa)<=T(alfa+1))
  -------------------------------------------------------------------
  -- sonPermutacion(T1,T2,desde,hasta)
  -- <-> (PT alfa en [desde..hasta].
  --       (Num beta en [desde,hasta].T1(beta)=T1(alfa))
  --       =(Num beta en [desde,hasta].T2(beta)=T1(alfa)))
  -------------------------------------------------------------------


  procedure tiempoQuickSort (T: in out tpTabla) is
  --
  -- Pre: T = T_0
  -- Post: ordenada(T,T'First,T'Last)
  --       AND sonPermutacion(T,T_0,T'First,T'Last)
  --       Ademas, muestra por pantalla el tiempo invertido en la
  --       ejecucion del algoritmo.
  --
   hora1, hora2: time;
  begin
    hora1:= clock;
    ordenacionRapida(T);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
  end tiempoQuickSort;


  procedure tiempoSeleccion (T: in out tpTabla) is
  --
  -- Pre: T = T_0
  -- Post: ordenada(T,T'First,T'Last)
  --       AND sonPermutacion(T,T_0,T'First,T'Last)
  --       Ademas, muestra por pantalla el tiempo invertido en la
  --       ejecucion del algoritmo.
  --
    hora1, hora2: time;
  begin
    hora1:= clock;
    ordenacionPorSeleccion(T);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
  end tiempoSeleccion;


  procedure tiempoInsercion (T: in out tpTabla) is
  --
  -- Pre: T = T_0
  -- Post: ordenada(T,T'First,T'Last)
  --       AND sonPermutacion(T,T_0,T'First,T'Last)
  --       Ademas, muestra por pantalla el tiempo invertido en la
  --       ejecucion del algoritmo.
  --
   hora1, hora2: time;
  begin
    hora1:= clock;
    ordenacionPorInsercion(T);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
  end tiempoInsercion;


  procedure tiempoBusquedaBinaria (T: in out tpTabla) is
  --
  -- Pre: cierto
  -- Post: ((EX alfa en [T'First..T'Last].T(alfa)=d)
  --           -> T(busquedaBinaria(T,d))=d)
  --        AND (NOT (EX alfa en [T'First..T'Last].T(alfa)=d)
  --           -> busquedaBinaria(T,d)=0)
  --        Ademas, muestra por pantalla el tiempo invertido en la
  --        ejecucion del algoritmo.
  --
    resultado: integer;
    g: generator;
    d: integer;
    hora1, hora2: time;
  begin
    reset(g); d:= random(g); ordenacionRapida(T);
    hora1:= clock;
    resultado:= busquedaBinaria(T,d);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
  end tiempoBusquedaBinaria;


  procedure tiempoBusquedaLineal (T: tpTabla) is
  --
  -- Pre: cierto
  -- Post: ((EX alfa en [T'First..T'Last].T(alfa)=d)
  --           -> T(busquedaLineal(T,d))=d)
  --        AND (NOT (EX alfa en [T'First..T'Last].T(alfa)=d)
  --           -> busquedaLineal(T,d)=0)
  --        Ademas, muestra por pantalla el tiempo invertido en la
  --        ejecucion del algoritmo.
  --
    resultado: integer;
    d: integer := 0; -- Dato fuera del intervalo del rango de
                     -- los datos aleatorios de la tabla
    hora1, hora2: time;
  begin
    hora1:= clock;
    resultado:= busquedaLineal(T,d);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
  end tiempoBusquedaLineal;


  procedure tiempoBusquedaEnFichero (n: integer) is
  --
  -- Pre: cierto
  -- Post: ((EX alfa en [1..numDatos(f)].dato(f,alfa)=d)
  --            -> dato(f,busquedaEnFichero(f,d))=d)
  --          AND (NOT (EX alfa en [1..numDatos(f)].dato(f,alfa)=d)
  --                 -> busquedaEnFichero(f,d)=0)
  --
  --        Ademas, muestra por pantalla el tiempo invertido en la
  --        ejecucion del algoritmo.           
  --
    use moduloFichero;
    resultado: integer;


    procedure crearFicheroAleatorio (n: in integer; f: in out tpFichero) is
    --
    -- Pre: (EX f AND modo(f)=Esc AND numEscritos(f)=0)
    -- Post: (PT alfa EN [1..n].
    --        ((1<=T(alfa)) AND (T(alfa)<=Integer'Last)
    --        AND (PT x EN [1,Integer'Last].probabilidad(T(alfa)<=x)=x))
    --        AND (modo(f)=Lec AND numLeidos(f)=0)
    --
    -- Procedimiento que escribe en el fichero "f" n numeros enteros
    -- aleatoriamente desordenados
    --
      g: generator;
    begin
      reset(g); -- Inicia el generador de numeros aleatorios
      reset(f);
      for i in 1..n loop
        write (f,random(g));
      end loop;
      reset(f,in_file);
    end crearFicheroAleatorio;

    d: constant integer:= 0; -- Dato fuera del intervalo del rango de
                             -- los datos aleatorios de la tabla
    hora1, hora2: time;
    f: tpFichero;
  begin
    create(f,out_file);
    crearFicheroAleatorio(n,f);
    hora1:= clock;
    resultado:= busquedaEnFichero(f,d);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
    close(f);
  end tiempoBusquedaEnFichero;


  procedure algoritmosOrdenacion (n: in positive) is
  --
  -- Pre: cierto
  -- Post: Muestra el tiempo invertido en la ejecucion de los
  --       algoritmos de ordenacion rapida (QuickSort), ordenacion
  --       por seleccion y ordenacion por insercion aplicados a tablas
  --       de "n" datos enteros aleatoriamente desordenados.
  --
    T: tpTabla(1..n);
  begin
    put(n,6);
    aleatorio(T);
    tiempoQuickSort(T);
    aleatorio(T);
    tiempoSeleccion(T);
    aleatorio(T);
    tiempoInsercion(T);
    new_Line;
  end algoritmosOrdenacion;


  procedure algoritmosBusqueda (n: in positive) is
  --
  -- Pre: cierto
  -- Post: Muestra el tiempo invertido en la ejecucion de los
  --       algoritmos de busqueda binaria, lineal en tabla y
  --       lineal en fichero, aplicados a tablas y ficheros
  --       de "n" datos enteros aleatoriamente desordenados en el
  --       caso de los algoritmos de busqueda lineal y "n" datos
  --       ordenados en el caso de la busqueda binaria o dicotomica.
  --
    T: tpTabla(1..n);
  begin
    put(n,6);
    aleatorio(T);
    --tiempoBusquedaBinaria(T);
    --aleatorio(T);
    tiempoBusquedaLineal(T);
    --aleatorio(T);
    --tiempoBusquedaEnFichero(n);
    new_Line;
  end algoritmosBusqueda;


  procedure mostrarResultadosOrdenacion is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla una cabecera con informacion
  --       acerca de los algoritmos de ordenacion rapida
  --       (QuickSort), ordenacion por seleccion y por insercion.
  --
  begin
    for i in 1..80 loop put('-'); end loop; new_Line;
    put ("NUMERO"); for i in 1..7 loop put(' '); end loop;
    put ("QuickSort"); for i in 1..9 loop put (' '); end loop;
    put ("Seleccion"); for i in 1..7 loop put (' '); end loop;
    put ("Insercion"); new_Line; put ("DE DATOS"); new_Line;
    for i in 1..80 loop put('-'); end loop; new_Line;
  end mostrarResultadosOrdenacion;


  procedure mostrarResultadosBusqueda is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla una cabecera con informacion
  --       acerca de los algoritmos de busqueda binaria, busqueda
  --       lineal y busqueda en fichero.
  --
  begin
    new_Line(3);
    for i in 1..80 loop put('-'); end loop; new_Line;
    put ("NUMERO"); for i in 1..12 loop put(' '); end loop;
    put ("Binaria"); for i in 1..9 loop put (' '); end loop;
    put ("Lineal Tabla"); for i in 1..7 loop put (' '); end loop;
    put ("Fichero"); new_Line; put ("DE DATOS"); new_Line;
    for i in 1..80 loop put('-'); end loop; new_Line;
  end mostrarResultadosBusqueda;


  procedure ordenacionConNDatos is
  --
  -- Pre: cierto
  -- Post: Ejecuta los algoritmos de ordenacion del programa
  --       con distintos numeros de datos: 1000, 5000, 10000,
  --       25000, 35000 y 50000.
  --
  begin
    algoritmosOrdenacion(1000);
    --algoritmosOrdenacion(5000);
    --algoritmosOrdenacion(10000);
    --algoritmosOrdenacion(25000);
    --algoritmosOrdenacion(35000);
    --algoritmosOrdenacion(50000);
  end ordenacionConNDatos;


  procedure busquedaConNDatos is
  --
  -- Pre: cierto
  -- Post: Ejecuta los algoritmos de busqueda del programa
  --       con distintos numeros de datos: 1000, 5000, 10000,
  --       25000, 35000 y 50000.
  --
  begin
    algoritmosBusqueda(1000000);
    --algoritmosBusqueda(5000);
    --algoritmosBusqueda(10000);
    --algoritmosBusqueda(25000);
    --algoritmosBusqueda(35000);
    --algoritmosBusqueda(50000);
  end busquedaConNDatos;


begin
  mostrarResultadosOrdenacion;
  --ordenacionConNDatos;
  mostrarResultadosBusqueda;
  busquedaConNDatos;
end medirTiempos;
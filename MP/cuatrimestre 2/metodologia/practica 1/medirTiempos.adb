-----------------------------------------------------------------------------
-- Fichero: medirTiempos.adb
-- Tema:    Fichero de medida experimental de tiempos de ejecución.
-- Fecha:   Marzo de 2006
-- Versión: 1.0
-- Autores: Ismael Saad García. NIP: 547942. air_saad@hotmail.com
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
-- Post: Mide experimentalmente los tiempos de ejecución de los algoritmos
--       de ordenación quicksort, selección e inserción, y los de búsqueda
--       binaria, lineal y en fichero aplicados a tablas y ficheros de
--       distintos tamaños N de datos predefinidos en el programa.
--

-- Instanciación del paquete operaciones para datos de tipo entero
-- (integer) con la relación de orden definida por la función "<="
-- de comparación de pares de datos de tipo 'integer'.
  package bibOperaciones is new operaciones(integer,"<=");
  subtype tpIndice is integer range 1..Integer'Last;
  package bibAleatorios is new ada.numerics.discrete_random(tpIndice);
  
  N1: constant integer:= 1000;
  N2: constant integer:= 5000;
  N3: constant integer:= 10000;
  N4: constant integer:= 25000;
  N5: constant integer:= 35000;
  N6: constant integer:= 50000;

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
  -- (no restringido), pero podemos conocer los valores de los límites
  -- inferior y superior de los índices utilizando los atributos T'first
  -- y T'last de la tabla que se pase como argumento al parámetro T.
  --
    g: generator;
  begin
    reset(g); -- inicia el generador de números aleatorios
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
  --       Además, muestra por pantalla el tiempo invertido en la
  --       ejecución del algoritmo de ordenación rápida.
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
  --       Además, muestra por pantalla el tiempo invertido en la
  --       ejecución del algoritmo de ordenación por selección.
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
  --       Además, muestra por pantalla el tiempo invertido en la
  --       ejecución del algoritmo de ordenación por inserción.
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
  -- Post: Muestra por pantalla el tiempo invertido en la
  --       ejecución del algoritmo de búsqueda binaria aplicado
  --       a la tabla 'T' cuyos datos están ordenados.
  --
    resultado: integer;
    g: generator;
    d: integer; -- Dato a buscar en la tabla
    hora1, hora2: time;
  begin
    reset(g); d:= random(g); 
    ordenacionRapida(T);
    -- ordenada(T,T'First,T'Last) AND sonPermutacion(T,T_0,T'First,T'Last)
    hora1:= clock;
    resultado:= busquedaBinaria(T,d);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
  end tiempoBusquedaBinaria;


  procedure tiempoBusquedaLineal (T: tpTabla) is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla el tiempo invertido en la
  --       ejecución del algoritmo de búsqueda lineal.
  --
    resultado: integer;
    d: integer := 0; -- Dato fuera del rango de los datos 
                     -- aleatorios de la tabla 'T' para considerar 
                     -- el caso peor de la búsqueda lineal.
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
  -- Post: Muestra por pantalla el tiempo invertido en la
  --       ejecución del algoritmo de búsqueda en fichero.  
  --
    use moduloFichero;
    resultado: integer;


    procedure escribeFicheroAleatorio (n: in integer; f: in out tpFichero) is
    --
    -- Pre: (EX f AND modo(f)=Esc AND numEscritos(f)=0)
    -- Post: (PT alfa EN [1..n].
    --        ((1<=T(alfa)) AND (T(alfa)<=Integer'Last)
    --        AND (PT x EN [1,Integer'Last].probabilidad(T(alfa)<=x)=x))
    --        AND (modo(f)=Lec AND numLeidos(f)=0)
    --
    -- Procedimiento que escribe en el fichero "f" 'n' números enteros
    -- aleatoriamente desordenados.
    --
      g: generator;
    begin
      reset(g); -- Inicia el generador de números aleatorios
      reset(f);
      for i in 1..n loop
        write (f,random(g));
      end loop;
      reset(f,in_file);
    end escribeFicheroAleatorio;

    d: constant integer:= 0; -- Dato fuera del rango de los datos
                             -- aleatorios de la tabla para considerar
                             -- el caso peor de la búsqueda en fichero.
    hora1, hora2: time;
    f: tpFichero;
  begin
    create(f,out_file);
    escribeFicheroAleatorio(n,f);
    hora1:= clock;
    resultado:= busquedaEnFichero(f,d);
    hora2:= clock;
    put(float(hora2-hora1),8,8,0);
    close(f);
  end tiempoBusquedaEnFichero;


  procedure algoritmosOrdenacion (n: in positive) is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla el tiempo invertido en la ejecución 
  --       de los algoritmos de ordenación rápida (QuickSort), ordenación
  --       por selección y ordenación por inserción aplicados a tablas
  --       de "n" datos enteros aleatoriamente desordenados.
  --
    T: tpTabla(1..n);
  begin
    put(n,6);
    aleatorio(T); tiempoQuickSort(T);
    aleatorio(T); tiempoSeleccion(T);
    aleatorio(T); tiempoInsercion(T);
    new_Line;
  end algoritmosOrdenacion;


  procedure algoritmosBusqueda (n: in positive) is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla el tiempo invertido en la ejecución
  --       de los algoritmos de búsqueda binaria, búsqueda lineal y
  --       búsqueda en fichero, aplicados a tablas y ficheros de "n" 
  --       datos enteros aleatoriamente desordenados en el caso de los 
  --       algoritmos de busqueda lineal y en fichero y "n" datos 
  --       ordenados en el caso de la busqueda binaria o dicotomica.
  --
    T: tpTabla(1..n);
  begin
    put(n,6);
    aleatorio(T); tiempoBusquedaBinaria(T);
    aleatorio(T); tiempoBusquedaLineal(T);
    aleatorio(T); tiempoBusquedaEnFichero(n);
    new_Line;
  end algoritmosBusqueda;


  procedure mostrarInformacionOrdenacion is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla una cabecera con información
  --       acerca de los algoritmos de ordenación rápida
  --       (QuickSort), ordenación por selección y por inserción.
  --
  begin
    for i in 1..80 loop put('-'); end loop; new_Line;
    put ("NUMERO");    for i in 1..7 loop put(' '); end loop;
    put ("QuickSort"); for i in 1..9 loop put (' '); end loop;
    put ("Seleccion"); for i in 1..7 loop put (' '); end loop;
    put ("Insercion"); new_Line; put ("DE DATOS"); new_Line;
    for i in 1..80 loop put('-'); end loop; new_Line;
  end mostrarInformacionOrdenacion;


  procedure mostrarInformacionBusqueda is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla una cabecera con información
  --       acerca de los algoritmos de búsqueda binaria, busqueda
  --       lineal y búsqueda en fichero.
  --
  begin
    new_Line(3);
    for i in 1..80 loop put('-'); end loop; new_Line;
    put ("NUMERO");  for i in 1..7 loop put(' '); end loop;
    put ("Binaria"); for i in 1..9 loop put (' '); end loop;
    put ("Lineal Tabla"); for i in 1..7 loop put (' '); end loop;
    put ("Fichero"); new_Line; put ("DE DATOS"); new_Line;
    for i in 1..80 loop put('-'); end loop; new_Line;
  end mostrarInformacionBusqueda;


  procedure ordenacionConNDatos is
  --
  -- Pre: cierto
  -- Post: Ejecuta los algoritmos de ordenación del programa
  --       con distintos números de datos: N1, N2, N3, N4, N5, N6,
  --       y muestra por pantalla, de manera detallada, los tiempos
  --       invertidos por los algoritmos aplicados a cada número de datos.
  --
  begin
    algoritmosOrdenacion(N1);
    algoritmosOrdenacion(N2);
    algoritmosOrdenacion(N3);
    algoritmosOrdenacion(N4);
    algoritmosOrdenacion(N5);
    algoritmosOrdenacion(N6);
  end ordenacionConNDatos;


  procedure busquedaConNDatos is
  --
  -- Pre: cierto
  -- Post: Ejecuta los algoritmos de búsqueda del programa
  --       con distintos números de datos: N1, N2, N3, N4, N5, N6,
  --       y muestra por pantalla, de manera detallada, los tiempos
  --       invertidos los algoritmos aplicados a cada número de datos.
  --
  begin
    algoritmosBusqueda(N1);
    algoritmosBusqueda(N2);
    algoritmosBusqueda(N3);
    algoritmosBusqueda(N4);
    algoritmosBusqueda(N5);
    algoritmosBusqueda(N6);
  end busquedaConNDatos;


begin
  mostrarInformacionOrdenacion;
  ordenacionConNDatos;
  mostrarInformacionBusqueda;
  busquedaConNDatos;
end medirTiempos;
-----------------------------------------------------------------------------
-- Fichero: medirTiempos.adb
-- Tema:    Fichero de medida experimental de tiempos de ejecuci�n.
-- Fecha:   Marzo de 2006
-- Versi�n: 1.0
-- Autores: Ismael Saad Garc�a. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Pr�ctica 1 de Metodolog�a de la Programaci�n.
------------------------------------------------------------------------------
with ada.calendar, ada.integer_text_IO, ada.text_IO, operaciones,
     ada.numerics.discrete_random, ada.float_text_IO;
------------------------------------------------------------------------------
procedure medirTiempos is
--
-- Pre: cierto
-- Post: Mide experimentalmente los tiempos de ejecuci�n de los algoritmos
--       de ordenaci�n quicksort, selecci�n e inserci�n, y los de b�squeda
--       binaria, lineal y en fichero aplicados a tablas y ficheros de
--       distintos tama�os N de datos predefinidos en el programa.
--

-- Instanciaci�n del paquete operaciones para datos de tipo entero
-- (integer) con la relaci�n de orden definida por la funci�n "<="
-- de comparaci�n de pares de datos de tipo 'integer'.
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
  -- (no restringido), pero podemos conocer los valores de los l�mites
  -- inferior y superior de los �ndices utilizando los atributos T'first
  -- y T'last de la tabla que se pase como argumento al par�metro T.
  --
    g: generator;
  begin
    reset(g); -- inicia el generador de n�meros aleatorios
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
  --       Adem�s, muestra por pantalla el tiempo invertido en la
  --       ejecuci�n del algoritmo de ordenaci�n r�pida.
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
  --       Adem�s, muestra por pantalla el tiempo invertido en la
  --       ejecuci�n del algoritmo de ordenaci�n por selecci�n.
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
  --       Adem�s, muestra por pantalla el tiempo invertido en la
  --       ejecuci�n del algoritmo de ordenaci�n por inserci�n.
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
  --       ejecuci�n del algoritmo de b�squeda binaria aplicado
  --       a la tabla 'T' cuyos datos est�n ordenados.
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
  --       ejecuci�n del algoritmo de b�squeda lineal.
  --
    resultado: integer;
    d: integer := 0; -- Dato fuera del rango de los datos 
                     -- aleatorios de la tabla 'T' para considerar 
                     -- el caso peor de la b�squeda lineal.
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
  --       ejecuci�n del algoritmo de b�squeda en fichero.  
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
    -- Procedimiento que escribe en el fichero "f" 'n' n�meros enteros
    -- aleatoriamente desordenados.
    --
      g: generator;
    begin
      reset(g); -- Inicia el generador de n�meros aleatorios
      reset(f);
      for i in 1..n loop
        write (f,random(g));
      end loop;
      reset(f,in_file);
    end escribeFicheroAleatorio;

    d: constant integer:= 0; -- Dato fuera del rango de los datos
                             -- aleatorios de la tabla para considerar
                             -- el caso peor de la b�squeda en fichero.
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
  -- Post: Muestra por pantalla el tiempo invertido en la ejecuci�n 
  --       de los algoritmos de ordenaci�n r�pida (QuickSort), ordenaci�n
  --       por selecci�n y ordenaci�n por inserci�n aplicados a tablas
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
  -- Post: Muestra por pantalla el tiempo invertido en la ejecuci�n
  --       de los algoritmos de b�squeda binaria, b�squeda lineal y
  --       b�squeda en fichero, aplicados a tablas y ficheros de "n" 
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
  -- Post: Muestra por pantalla una cabecera con informaci�n
  --       acerca de los algoritmos de ordenaci�n r�pida
  --       (QuickSort), ordenaci�n por selecci�n y por inserci�n.
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
  -- Post: Muestra por pantalla una cabecera con informaci�n
  --       acerca de los algoritmos de b�squeda binaria, busqueda
  --       lineal y b�squeda en fichero.
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
  -- Post: Ejecuta los algoritmos de ordenaci�n del programa
  --       con distintos n�meros de datos: N1, N2, N3, N4, N5, N6,
  --       y muestra por pantalla, de manera detallada, los tiempos
  --       invertidos por los algoritmos aplicados a cada n�mero de datos.
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
  -- Post: Ejecuta los algoritmos de b�squeda del programa
  --       con distintos n�meros de datos: N1, N2, N3, N4, N5, N6,
  --       y muestra por pantalla, de manera detallada, los tiempos
  --       invertidos los algoritmos aplicados a cada n�mero de datos.
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
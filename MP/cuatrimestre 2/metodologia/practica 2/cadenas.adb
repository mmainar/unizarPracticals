-----------------------------------------------------------------------
-- Fichero: cadenas.adb
-- Tema:    Fichero de implementación de procedimientos para gestionar
--          cadenas de caracteres de tamaño variable.
-- Fecha:   Abril de 2006
-- Versión: 1.0
-- Autor:   Ismael Saad García. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 2 de Metodología de la Programación.
-----------------------------------------------------------------------
with ada.text_IO, ada.strings.bounded, ada.characters.handling; 
-----------------------------------------------------------------------

package body cadenas is

  use ada.text_IO, ada.strings.bounded,ada.characters.handling, 
      palabras;


  ---------------------------------------------------------------------
  -- Procedimientos de la biblioteca Bstrings para operaciones de E/S 
  --        con cadenas de caracteres del tipo privado tpCadena      --
  

  procedure Get_Line (File : in texto; Item : out tpCadena) is
    Input_Line_Buffer_Length : constant := 1024;
    
    function More_Input return tpCadena is
       Input : String (1 .. Input_Line_Buffer_Length);
       Last  : Natural;
    begin
       Get_Line (File, Input, Last);
       if Last < Input'Last then
          return   To_Bounded_String(Input(1..Last));
       else
          return   To_Bounded_String(Input(1..Last)) & More_Input;
       end if;
    end More_Input;
  begin
    Item := More_Input;
  end Get_Line;
  

  procedure get_Line(Item : out tpCadena) is
  begin
    get_Line(Current_Input, Item);
  end get_Line;


  procedure put(file : in File_Type; item : in tpCadena) is
  begin
    ada.text_IO.put(file, to_string(item));
  end put;


  procedure put(item : in tpCadena) is
  begin
    ada.text_IO.put(Current_Output, to_string(item));
  end put;


  procedure put_Line(file : in file_type; item : in tpCadena) is
  begin
    put(file, item);
    new_Line(file);
  end put_Line;


  procedure put_Line(item : in tpCadena) is
  begin
    put(current_output, item);
    new_Line;
  end put_Line;
  
  ---------------------------------------------------------------------
  --    Fin de los procedimientos de la biblioteca Bstrings          --
  ---------------------------------------------------------------------


  function contarNumeroEtiquetas (cad: tpCadena) return integer is 
  --
  -- Pre: cierto
  -- Post: devuelve el número de palabras separadas por un espacio en 
  --       blanco contenidas en "cad". 
  --            
    numEtiquetas: integer:= 1;
  begin
    for indice in 1..length(cad)-1 loop
      if (element(cad,indice)=' ') and not(element(cad,indice+1)=' ')
        then numEtiquetas:= numEtiquetas+1;
      end if;
    end loop;
    return numEtiquetas;
  end contarNumeroEtiquetas;


  procedure leerCadenaDeFicheroDeTexto(f: in texto; cad: out tpCadena) is
  --
  -- Pre: modo(f)=Lec 
  -- Post: lee una línea del fichero "f" y la almacena en "cad".
  --
  begin
    get_Line(f,cad);
  end leerCadenaDeFicheroDeTexto;
  

  procedure leerCadenaConEspacios(cad: out tpCadena; 
                                           numEtiquetas: out integer) is
  --
  -- Pre: cierto
  -- Post: lee una cadena "cad" de caracteres limitada por espacios en 
  --       blanco y "numEtiquetas" almacena el número de palabras 
  --       separadas por espacios en blanco contenidas en "cad".
  --
  begin
    get_line(cad);
    numEtiquetas:= contarNumeroEtiquetas(cad);
  end leerCadenaConEspacios;
  

  procedure leerCadenaConEspaciosDeFicheroDeTexto (f: in texto; 
                       cad: out tpCadena; numEtiquetas: out integer) is
  --
  -- Pre: modo(f)= Lec 
  -- Post: lee una cadena "cad" de caracteres limitada por espacios en 
  --       blanco de un fichero de texto y "numEtiquetas" almacena el
  --       número de palabras separadas por espacios en blanco contenidas
  --       en "cad".
  --
  begin
    get_line(f,cad);
    numEtiquetas:= contarNumeroEtiquetas(cad);
  end leerCadenaConEspaciosDeFicheroDeTexto;


  function crearCadenaNula return tpCadena is
  -- 
  -- Pre: cierto
  -- Post: crearCadenaNula=""
  --
    cad: tpCadena;
  begin 
    return(cad); 
  end crearCadenaNula;
  

  function longitudCadena(cad: tpCadena) return integer is
  --
  -- Pre: cierto
  -- Post: (cad = "c_1, ..., c_N") AND (longitudCadena(cad)=N)
  --
  begin
    return length(cad);
  end longitudCadena;
    
  
  procedure crearListaPalabras(cad: tpCadena; lista: out tpListaPalabras) is
  --
  -- Pre: cierto
  -- Post: almacena en "lista" todas las cadenas de caracteres
  --       delimitadas por espacios en blanco contenidas en "cad".
  --
    caract: string(1..50);
    cotaInf, cotaSup, contador: integer;
    exitoCotaInferior, exitoCotaSuperior: boolean;
  begin
    lista.numPalabras:=0;
    contador:=0;
    while not(contador=length(cad)) loop
      exitoCotaInferior:= false;
      contador:= contador+1;
      if longitudCadena(cad)=1 then cotaInf:= 1; cotaSup:= 1; end if;
      while not ((exitoCotaInferior) or (contador=length(cad))) loop
        if not (element(cad,contador)=' ') then 
          cotaInf:= contador;
          exitoCotaInferior:= true;
        end if;
        contador:= contador+1;
      end loop;
      exitoCotaSuperior:= false;
      while not (exitoCotaSuperior or contador=length(cad)) loop
        if (not(element(cad,contador)=' ')) and 
           (element(cad,contador+1)=' ') then
             cotaSup:= contador;
             exitoCotaSuperior:= true;
        end if;
        contador:= contador+1;      
      end loop;
      if contador=length(cad) then
        cotaSup:= length(cad);
      end if;
      lista.numPalabras:= lista.numPalabras+1;
      caract(1..(cotaSup-cotaInf+1)):= slice(cad,cotaInf,cotaSup);
      lista.tabla(lista.numpalabras):= to_bounded_string
                                  (caract(1..(cotaSup-cotaInf+1)));
    end loop;
  end crearListaPalabras;
  

  function stringACadena(cad: string) return tpCadena is
  --
  -- Pre: cierto
  -- Post: convierte la cadena de tipo string "cad" a una del tipo 
  --       privado tpCadena equivalente.
  --
    cadena: tpCadena;
  begin
    cadena:= to_bounded_string(cad);
    return cadena;
  end stringACadena;
  

  function compararCadenas (cad1, cad2: tpCadena) return boolean is
  --
  -- Pre: cierto
  -- Post: devuelve el valor cierto si y solo si existe una cadena de 
  --       caracteres delimitada por espacios en blanco en "cad1" que 
  --       esté contenida en alguna de las cadenas de caracteres 
  --       delimitadas por espacios en blanco que hay en "cad2".
  --
    listaCad1, listaCad2: tpListaPalabras;
    exito: boolean;
    caract: string(1..15);
    cadProv: tpCadena;
    i, j, k, cotaInf, cotaSup: integer;
  begin
    crearListaPalabras(cad1,listaCad1);
    crearListaPalabraS(cad2,listaCad2);
    i:= 0;
    exito:= (listaCad1.numpalabras=0) and (listaCad2.numpalabras=0);
    while not(i=listaCad1.numPalabras) and not exito loop
      i:= i+1; j:= 0;
      while not(j=listaCad2.numPalabras) and not exito loop
        j:= j+1;
        if length(listaCad1.tabla(i)) = length(listaCad2.tabla(j)) then
          exito:= listaCad1.tabla(i)=listaCad2.tabla(j);
        elsif length(listaCad1.tabla(i)) < length(listaCad2.tabla(j)) then
            cotaInf:= 1; cotaSup:= length(listaCad1.tabla(i)); k:= 0;
          while not
             (k=(length(listaCad2.tabla(j)) - length(listaCad1.tabla(i))+1))
            and not(exito) loop
              k:= k+1;
              caract(1..length(listaCad1.tabla(i))):= 
                              slice(listaCad2.tabla(j),cotaInf,cotaSup);
              cadProv:= to_bounded_string(caract(1..(cotaSup-cotaInf+1)));
              exito:= listaCad1.tabla(i)=cadProv;
              cotaInf:= cotaInf+1; cotaSup:= cotaSup+1;
          end loop;
        end if;
      end loop;
    end loop;
    return exito;
  end compararCadenas;
  
  
  procedure busqueda(etiqueta: tpCadena; l: listaEtiquetas; 
                     exito: out boolean; posicion: out integer) is
  --
  -- Pre: cierto
  -- Post: exito= (EX alfa en [1..l.numEtiquetas].(l.tabla(alfa).etiqueta
  --       =etiqueta) AND (exito -> l.tabla(posicion).etiqueta=etiqueta)
  --
  begin
    exito:= false;
    posicion:= 0;
    while not exito and not (posicion=l.numEtiquetas) loop
      posicion:= posicion+1;
      exito:= (etiqueta = l.tabla(posicion).etiqueta);
    end loop;
  end busqueda;
  
  
  procedure ordenarEtiquetas (l: in out listaEtiquetas; izda, dcha: integer) is
  --
  -- Pre:  T = T_0
  -- Post: ordenada(T,izda,dcha) AND sonPermutacion(T,T_0,izda,dcha)
  --
    procedure intercambia(x, y: in out regEtiquetas) is
    --
    -- Pre: x=A AND y=B
    -- Post: x=B AND y=A
    --
      aux: regEtiquetas;
    begin
      aux := x;  x := y;  y := aux;
    end intercambia;
      
      
    i, s: integer;
    pivote: regEtiquetas;
  begin  
    if izda < dcha then
      pivote := l.tabla(izda); i := izda; s := dcha;
      while i < s + 1 loop
        if (l.tabla(i).numApariciones <= pivote.numApariciones)
	    then i := i + 1;
        elsif (pivote.numApariciones <= l.tabla(s).numApariciones) 
          then s := s - 1;
        else
          intercambia(l.tabla(i), l.tabla(s));
          i := i + 1;  s := s - 1;
        end if;
      end loop;
      intercambia(l.tabla(izda), l.tabla(s));
      ordenarEtiquetas(l,izda,s-1);
      ordenarEtiquetas(l,s+1,dcha);
    end if;
  end ordenarEtiquetas;
  

  function depurarCadena(cad: tpCadena) return tpCadena is
  --
  -- Pre: cierto
  -- Post: Devuelve la cadena de caracteres "cad" en minúsculas
  --       y sin letras acentuadas.
  --
    cadAux: tpCadena;
  begin
    cadAux:= cad;
    for i in 1..longitudCadena(cadAux) loop
      if is_upper(element(cadAux,i)) then
        replace_Element(cadAux,i,to_lower(element(cadAux,i)));
      end if;
      replace_Element(cadAux,i,to_basic(element(cadAux,i)));
    end loop;
    return cadAux;
  end depurarCadena;
  

end cadenas;

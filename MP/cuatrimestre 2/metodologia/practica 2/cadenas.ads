-----------------------------------------------------------------------
-- Fichero: cadenas.ads
-- Tema:    Fichero de especificación de procedimientos para gestionar
--          cadenas de caracteres de tamaño variable.
-- Fecha:   Abril de 2006
-- Versión: 1.0
-- Autor:   Ismael Saad García. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 2 de Metodología de la Programación.
-----------------------------------------------------------------------
with ada.text_IO, ada.strings.bounded;
use  ada.text_IO, ada.strings.bounded;
-----------------------------------------------------------------------
generic
  -- Modulo genérico para gestionar cadenas de caracteres de tamaño 
  -- variable. El parámetro es el tamaño máximo de la cadena de
  -- caracteres que se va a almacenar.
  MAX_LONG_CADENA: positive;
   
package cadenas is

  type tpCadena is private;
  subtype texto is ada.text_IO.file_type;
  type tpTablaPalabras is array (integer range <>) of tpCadena;
  N: constant integer := 15000;
  
  type tpListaPalabras is record
    tabla: tpTablaPalabras(1..N);
    numPalabras: integer;
  end record;
  
  type regEtiquetas is record
    etiqueta: tpCadena;
    numApariciones : integer:= 0;
  end record;
  
  type tpTablaEtiquetas is array (integer range <>) of regEtiquetas;
   
  type listaEtiquetas is record
    tabla: tpTablaEtiquetas(1..N);
    numEtiquetas: integer:= 0;
  end record;
  
    
  -------------  Procedimientos de Bstrings ---------------------
  ---------------------------------------------------------------
   
  procedure get_Line (file : in texto; item : out tpCadena);
  procedure get_Line (item : out tpCadena);
  procedure put (file : in file_Type; item : in tpCadena);
  procedure put (item : in tpCadena);
  procedure put_Line (file : in File_Type; item : in tpCadena);
  procedure put_Line (item : in tpCadena);
   
  ------------  Fin de procedimientos de Bstrings  --------------
  ---------------------------------------------------------------
  
  
  ---------------------------------------------------------------------
  function contarNumeroEtiquetas (cad: tpCadena) return integer;
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: devuelve el número de palabras separadas por un espacio en 
  --       blanco contenidas en "cad".
  ---------------------------------------------------------------------


  ---------------------------------------------------------------------
  procedure leerCadenaDeFicheroDeTexto(f: in texto; cad: out tpCadena);
  ---------------------------------------------------------------------
  -- Pre: modo(f)=Lec                                                       
  -- Post: lee una línea del fichero "f" y la almacena en "cad".
  ---------------------------------------------------------------------
   

  ---------------------------------------------------------------------
  procedure leerCadenaConEspacios(cad: out tpCadena; 
                                            numEtiquetas: out integer);
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: lee una cadena "cad" de caracteres limitada por espacios en 
  --       blanco y "numEtiquetas" almacena el número de palabras 
  --       separadas por espacios en blanco contenidas en "cad".
  ---------------------------------------------------------------------
   

  ---------------------------------------------------------------------
  procedure leerCadenaConEspaciosDeFicheroDeTexto (f: texto; cad: out 
                                  tpCadena; numEtiquetas: out integer);
  ---------------------------------------------------------------------
  -- Pre: modo(f)= Lec 
  -- Post: lee una cadena "cad" de caracteres limitada por espacios en 
  --       blanco de un fichero de texto y "numEtiquetas" almacena el
  --       número de palabras separadas por espacios en blanco 
  --       contenidas en "cad".
  ---------------------------------------------------------------------
   
   
  ---------------------------------------------------------------------
  function crearCadenaNula return tpCadena;
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: crearCadenaNula= ""
  ---------------------------------------------------------------------


  ---------------------------------------------------------------------
  function longitudCadena(cad: tpCadena) return integer;
  --------------------------------------------------------------------- 
   -- Pre: cierto
   -- Post: (cad = "c_1, ..., c_N") AND (longitudCadena(cad)=N)
  ---------------------------------------------------------------------
  
  
  ---------------------------------------------------------------------
  procedure crearListaPalabras (cad: tpCadena; lista: out 
                                                      tpListaPalabras);
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: almacena en "lista" todas las cadenas de caracteres
  --       delimitadas por espacios en blanco contenidas en "cad".
  ---------------------------------------------------------------------
 

  ---------------------------------------------------------------------
  function stringACadena(cad: string) return tpCadena;
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: convierte la cadena de tipo string "cad" a una del tipo 
  --       privado tpCadena equivalente.
  ---------------------------------------------------------------------
  

  ---------------------------------------------------------------------
  function compararCadenas (cad1, cad2: tpCadena) return boolean;
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: devuelve el valor cierto si y solo si existe una cadena de 
  --       caracteres delimitada por espacios en blanco en "cad1" que 
  --       esté contenida en alguna de las cadenas de caracteres 
  --       delimitadas por espacios en blanco que hay en "cad2".
  ---------------------------------------------------------------------
  
  
  ---------------------------------------------------------------------
  procedure busqueda(etiqueta: tpCadena; l: listaEtiquetas; 
                     exito: out boolean; posicion: out integer);
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: exito= (EX alfa en [1..l.numEtiquetas].
  --       (l.tabla(alfa).etiqueta=etiqueta) AND 
  --       (exito -> l.tabla(posicion).etiqueta=etiqueta)
  ---------------------------------------------------------------------
  
  
  ---------------------------------------------------------------------
  procedure ordenarEtiquetas(l: in out listaEtiquetas; izda,dcha: 
                                                              integer);
  ---------------------------------------------------------------------
  -- Pre:  T = T_0
  -- Post: ordenada(T,izda,dcha) AND sonPermutacion(T,T_0,izda,dcha)
  ---------------------------------------------------------------------
  

  ---------------------------------------------------------------------
  function depurarCadena(cad: tpCadena) return tpCadena;
  ---------------------------------------------------------------------
  -- Pre: cierto
  -- Post: Devuelve la cadena de caracteres "cad" en minúsculas
  --       y sin letras acentuadas.
  ---------------------------------------------------------------------

private
  package palabras is new Generic_Bounded_Length(MAX_LONG_CADENA);
  type tpCadena is new palabras.bounded_string;  
  -- Notación para esta representación:
  -- (cad = "c_1, ..., c_N") == 
  --  ==((length(cad=N) AND (PT alfa EN [1,N].(element(cad,alfa)=c_alfa)))  
end cadenas;

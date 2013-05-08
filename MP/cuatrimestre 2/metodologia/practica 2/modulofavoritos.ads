--------------------------------------------------------------------------
-- Fichero: modulofavoritos.ads
-- Tema:    Fichero de especificacion de procedimientos para gestionar
--          la estructura de datos para almacenar y gestionar los enlaces
--          favoritos tanto en memoria como en fichero.
-- Fecha:   Abril de 2006
-- Versión: 1.0
-- Autor:   Ismael Saad García. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 2 de Metodología de la Programación.
--------------------------------------------------------------------------
with ada.text_IO, cadenas, ada.sequential_IO;
--------------------------------------------------------------------------
package moduloFavoritos is
  
 
  nombreFichero : constant string := "favoritos.dat";
  MAX_LONG_CADENA : constant integer := 140;
  N: constant integer := 1000;
  
  package palabras is new cadenas(MAX_LONG_CADENA);
  use palabras, ada.text_IO;
  
  type tpFavorito is record
    titulo : tpCadena;
    url : tpCadena;
    etiquetas: tpCadena;
    numEtiquetas : integer;
  end record;
 
  type tpTabla is array (integer range <>) of tpFavorito;
 
  type tpLista is record
    tabla: tpTabla(1..N);
    numDatos: integer:= 0;
  end record;
    
  package bibFavoritos is new ada.sequential_IO(tpFavorito);
  subtype tpFichero is bibFavoritos.file_type;
  subtype texto is ada.text_IO.file_type; 
  use bibFavoritos;
 

  ------------------------------------------------------------------------
  procedure agregarFavorito(favorito: tpFavorito; t: in out tpLista);
  ------------------------------------------------------------------------
  -- Pre:  t.tabla=(t(1),...,t(N)) AND t.numDatos = N
  -- Post: t.tabla=(t(1),...,t(N+1)) AND t.numDatos = N+1 AND
  --       t.tabla(N+1) = favorito
  ------------------------------------------------------------------------
  
  
  ------------------------------------------------------------------------
  procedure accederAFavoritos(t: tpLista; indice: integer);
  ------------------------------------------------------------------------
  -- Pre: cierto
  -- Post: accede a la posición "indice" de la lista de favoritos "t" y 
  --       escribe por pantalla los datos del favorito correspondiente.
  ------------------------------------------------------------------------


  ------------------------------------------------------------------------
  procedure leerFavoritosDeFicheroDeTexto(f: texto; t: in out tpLista);
  ------------------------------------------------------------------------  
  -- Pre:  el fichero de texto "f" contiene favoritos de acuerdo con el 
  --       siguiente formato: una línea con el enlace, la siguiente con
  --       el título que corresponde al enlace y la tercera línea contiene 
  --       las etiquetas separadas por espacios en blanco (15 como máximo).
  -- Post: la lista de favoritos contiene los favoritos que antes tenía, y
  --       a continuación, los que se encontraban en el fichero "f".
  ------------------------------------------------------------------------
  

  ------------------------------------------------------------------------
  procedure leerFavoritosDeFicheroSecuencial(f:tpFichero; t: in out 
                                                                 tpLista);
  ------------------------------------------------------------------------
  -- Pre:  el fichero "f" contiene datos de enlaces favoritos.
  -- Post: la lista de favoritos contiene los favoritos que antes tenía, y
  --       los que se encontraban en el fichero "f".  
  ------------------------------------------------------------------------
  

  ------------------------------------------------------------------------
  procedure escribirFavoritosEnFicheroDeTexto(t: tpLista; f: in out texto);
  ------------------------------------------------------------------------
  -- Pre:  "t" contiene la lista actual de favoritos.
  -- Post: el fichero de texto "f" almacena todos los favoritos contenidos 
  --       en la lista de favoritos "t".
  ------------------------------------------------------------------------
  

  ------------------------------------------------------------------------
  procedure escribirFavoritosEnFicheroSecuencial(t: tpLista; 
                                                     f: in out tpFichero);  
  ------------------------------------------------------------------------
  -- Pre: cierto
  -- Post: "f" contiene los favoritos almacenados en la lista "t".
  ------------------------------------------------------------------------
  
  
  ------------------------------------------------------------------------
  procedure actualizarListaEtiquetas (l: in out listaEtiquetas; 
                                      cad: tpCadena);
  ------------------------------------------------------------------------
  -- Pre: cierto
  -- Post: Para todas las cadenas de caracteres delimitadas por espacios
  --       de "cad", si una cadena se encuentra en la tabla de la lista,
  --       añade 1 al número de apariciones de la cadena. En caso 
  --       contrario, añade la cadena a la lista e incrementa en una 
  --       unidad el número de datos de la lista.
  ------------------------------------------------------------------------


end moduloFavoritos;



-------------------------------------------------------------------------
-- Fichero: modulofavoritos.adb
-- Tema:    Fichero de implementacion de procedimientos para gestionar
--          cadenas de caracteres de tamaño variable.
-- Fecha:   Abril de 2006
-- Versión: 1.0
-- Autor:   Ismael Saad García.     NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 2 de Metodología de la Programación.
-------------------------------------------------------------------------
with ada.text_IO, ada.sequential_IO, cadenas;
--------------------------------------------------------------------------------
package body moduloFavoritos is
   

  procedure agregarFavorito(favorito: tpFavorito; t: in out tpLista) is
  --
  -- Pre:  t.tabla=(t(1),...,t(N)) AND t.numDatos = N
  -- Post: t.tabla=(t(1),...,t(N+1)) AND t.numDatos = N+1 AND
  --       t.tabla(N+1) = favorito
  --
  begin
    t.numDatos:= t.numDatos+1;
    t.tabla(t.numDatos).titulo:= favorito.titulo;
    t.tabla(t.numDatos).url:= favorito.url;
    t.tabla(t.numDatos).etiquetas:= favorito.etiquetas;
    t.tabla(t.numDatos).numEtiquetas:= favorito.numEtiquetas;
  end agregarFavorito;
  
  
  procedure accederAFavoritos(t: tpLista; indice: integer) is 
  --
  -- Pre: cierto
  -- Post: accede a la posición "indice" de la lista de favoritos "t" y 
  --       escribe por pantalla los datos del favorito correspondiente.
  --
  begin
    put ("Titulo: "); put_line(t.tabla(indice).titulo);
    put ("Url: "); put_line(t.tabla(indice).url);
    put ("Lista de etiquetas: "); put_line(t.tabla(indice).etiquetas);
  end accederAFavoritos;
 
  
  procedure leerFavoritosDeFicheroDeTexto(f: texto; t: in out tpLista) is
  --
  -- Pre:  el fichero de texto "f" contiene favoritos de acuerdo con el 
  --       siguiente formato: una línea con el enlace, la siguiente con
  --       el título que corresponde al enlace y la tercera línea contiene las
  --       etiquetas separadas por espacios en blanco (15 como máximo).
  -- Post: la lista de favoritos contiene los favoritos que antes tenía, y
  --       a continuación, los que se encontraban en el fichero "f".
  --
    numEtiquetas: integer;
    cad: tpCadena;
  begin
    while not end_of_file(f) loop
      t.numDatos:= t.numDatos+1;
      get_line(f,cad); cad:= depurarCadena(cad);
      t.tabla(t.numDatos).url:= cad;
      get_line(f,cad); cad:= depurarCadena(cad);
      t.tabla(t.numDatos).titulo:= cad;
      get_line(f,cad); cad:= depurarCadena(cad);
      t.tabla(t.numDatos).etiquetas:= cad;
      numEtiquetas:= contarNumeroEtiquetas(cad);  
    end loop;
  end leerFavoritosDeFicheroDeTexto;
  
 
  procedure leerFavoritosDeFicheroSecuencial(f: tpFichero; 
                                             t : in out tpLista) is
  --
  -- Pre:  el fichero "f" contiene datos de enlaces favoritos.
  -- Post: la lista de favoritos contiene los favoritos que antes tenía, y
  --       los que se encontraban en el fichero "f".   
  --
  begin  
    while not end_of_file(f) loop
      t.numDatos:= t.numDatos+1;
      read(f,t.tabla(t.numDatos));
    end loop;
  end leerFavoritosDeFicheroSecuencial;

  
  procedure escribirFavoritosEnFicheroDeTexto(t: tpLista; 
                                              f: in out texto) is
  -- 
  -- Pre:  "t" contiene la lista actual de favoritos.
  -- Post: el fichero de texto "f" almacena todos los favoritos contenidos 
  --       en la lista de favoritos "t".
  -- 
  begin
    reset(f,out_file);
    for indice in 1..t.numDatos loop
      put(f,t.tabla(indice).url); new_line(f);
      put(f,t.tabla(indice).titulo); new_line(f);
      put(f,t.tabla(indice).etiquetas); new_line(f,2);
    end loop;
  end escribirFavoritosEnFicheroDeTexto;
    

  procedure escribirFavoritosEnFicheroSecuencial(t: tpLista; 
                                                 f: in out tpFichero) is  
  --
  -- Pre: cierto
  -- Post: "f" contiene los favoritos almacenados en la lista "t".
  --
  begin
    for indice in 1..t.numDatos loop
      write(f,t.tabla(indice));
    end loop;
  end escribirFavoritosEnFicheroSecuencial;


  procedure actualizarListaEtiquetas (l: in out listaEtiquetas; 
                                      cad: tpCadena) is
  --
  -- Pre: cierto
  -- Post: Para todas las cadenas de caracteres delimitadas por espacios
  --       de "cad", si una cadena se encuentra en la tabla de la lista,
  --       añade 1 al número de apariciones de la cadena. En caso 
  --       contrario, añade la cadena a la lista e incrementa en una 
  --       unidad el número de datos de la lista.
  --
    listaPalabras: tpListaPalabras;
    exito: boolean;
    posicion: integer;
  begin
    crearListaPalabras(cad,listaPalabras);
    for i in 1..listaPalabras.numPalabras loop
      busqueda(listaPalabras.tabla(i),l,exito,posicion);
      if exito then
	  l.tabla(posicion).numApariciones:= l.tabla(posicion).numApariciones+1;
	else
	  l.numEtiquetas:= l.numEtiquetas+1;
	  l.tabla(l.numEtiquetas).etiqueta:= listaPalabras.tabla(i);
	  l.tabla(l.numEtiquetas).numApariciones:= 
	                               l.tabla(l.numEtiquetas).numApariciones+1;
      end if;			       
    end loop;
  end actualizarListaEtiquetas;
 

end moduloFavoritos;



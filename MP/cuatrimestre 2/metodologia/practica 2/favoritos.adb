-----------------------------------------------------------------------
-- Fichero: favoritos.adb
-- Tema:    Fichero de gesti�n elemental de enlaces favoritos.
-- Fecha:   Abril de 2006
-- Versi�n: 1.0
-- Autor:   Ismael Saad Garc�a. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Pr�ctica 2 de Metodolog�a de la Programaci�n.
-----------------------------------------------------------------------
with ada.integer_text_IO, ada.text_IO, ada.command_line, IO_exceptions, 
     moduloFavoritos;
     
use  ada.integer_text_IO, ada.text_IO, ada.command_line, IO_exceptions, 
     moduloFavoritos;
-----------------------------------------------------------------------
procedure favoritos is
--
-- Pre: cierto
-- Post: realiza una gesti�n elemental de enlaces o v�nculos favoritos,
--       cada uno de los cuales tiene asociado un t�tulo y un conjunto
---      de etiquetas. El programa tiene 2 modos de funcionamiento,
--       uno guiado por men�s y el otro desde la l�nea de �rdenes del
--       sistema operativo. Un fichero secuencial externo almacena,
--       al finalizar la ejecuci�n del programa, la lista de enlaces
--       favoritos y sus informaciones asociadas.
--
  subtype texto is ada.text_IO.file_type;
  use palabras, bibFavoritos;


  procedure comprobarFichero(f: in out tpFichero) is   
  --
  -- Pre: cierto
  -- Post: comprueba si existe el fichero de favoritos "f". En caso de que
  --       no exista, procede a crearlo con una lista sin ning�n enlace
  --       favorito.
  --
  begin
    open(f,in_file,nombreFichero);
    exception
      when IO_Exceptions.Name_Error =>
        create(f,out_file,nombreFichero);
  end comprobarFichero;
   
  
  procedure generarTablaFavoritos(f: in out tpFichero; t: in out tpLista) is
  -- 
  -- Pre: "f" almacena los datos de v�nculos favoritos actuales.
  -- Post: almacena en una lista "t" en memoria los datos de favoritos 
  --       actuales y cierra el fichero "f" de favoritos.
  --
  begin
    reset(f,in_file);
    leerFavoritosDeFicheroSecuencial(f,t);
    close(f);
  end generarTablaFavoritos;
  
  
  procedure agregarDeFicheroDeTexto(t: in out tpLista) is    
  --
  -- Pre: "t" almacena la lista actual de v�nculos o enlaces favoritos.
  -- Post: agrega a la lista "t" de favoritos los definidos en un fichero
  --       de texto con un formato determinado, cuyo nombre es introducido 
  --       por el usuario a trav�s del teclado.
  -- 
    nombre: string(1..80); longitud: integer;
    f: texto;
    esCorrecto: boolean:= false;
  begin
    while not esCorrecto loop
      begin
        put("Introduzca el nombre del fichero: ");
        get_line(nombre,longitud);
        open(f,in_file,nombre(1..longitud));
        esCorrecto:= true;
      exception
        when IO_Exceptions.Name_Error =>
          put ("Error, el fichero introducido no existe");
          new_Line;
      end;
    end loop;
    leerFavoritosDeFicheroDeTexto(f,t);
    close(f);
    put("Los favoritos han sido guardados correctamente"); new_Line;
  end agregarDeFicheroDeTexto;
  
  
  procedure agregarDeTeclado(lista: in out tpLista) is
  --
  -- Pre: cierto
  -- Post: agrega a la lista de favoritos la url, el t�tulo y las
  --       etiquetas de nuevos v�nculos favoritos introducidos por el 
  --       usuario.
  --  
    favorito: tpFavorito;   
    lineaTitulo: tpCadena;
  begin
    put("Introduzca el titulo del enlace (linea en blanco para acabar): ");
    get_line(lineaTitulo); 
    while not (longitudCadena(lineaTitulo)=0) loop
      new_Line; 
      favorito.titulo:= lineaTitulo;
      put("Introduzca la url del enlace: "); get_Line(favorito.url); 
      new_Line; favorito.url:= depurarCadena(favorito.url);
      put("Introduzca el listado de etiquetas (seguidas y separadas por espacios): ");
      get_Line(favorito.etiquetas); new_Line;
      favorito.etiquetas:= depurarCadena(favorito.etiquetas);
      favorito.numEtiquetas:= contarNumeroEtiquetas(favorito.etiquetas); 
      agregarFavorito(favorito,lista);
      put("Introduzca el nombre del titulo (linea en blanco para acabar): ");
      get_Line(lineaTitulo); 
    end loop;
  end agregarDeTeclado;
  
  
  procedure seleccionarPorEtiquetas(t: tpLista; etiquetas: tpCadena) is 
  --
  -- Pre: "t" almacena en memoria la lista actual de favoritos y
  --       "etiquetas", las introducidas por el usuario a trav�s de la 
  --       l�nea de instrucciones o tras la solicitud a trav�s del men�.
  -- Post: muestra por pantalla la lista de enlaces favoritos en cuya 
  --       lista de etiquetas se encuentren las etiquetas "etiquetas".
  --
    exito: boolean;
  begin
    new_Line;
    for indice in 1..t.numDatos loop
      if compararCadenas(etiquetas,t.tabla(indice).etiquetas) then
        exito:= true;
        accederAFavoritos(t,indice);
      end if;
    end loop;
      if not exito then
        put("No se han encontrado favoritos coincidentes con las etiquetas ");
        put('"'); put(etiquetas); put('"');
      end if;
    new_Line(2);
  end seleccionarPorEtiquetas; 
  
  
  procedure seleccionarPorTitulo(t: tpLista; titulo: tpCadena) is  
  --
  -- Pre: "t" almacena en memoria la lista actual de favoritos y
  --       "titulo" el introducido por el usuario a trav�s de la 
  --       l�nea de �rdenes o tras la solicitud a trav�s del men�.
  -- Post: muestra por pantalla la lista de v�nculos favoritos en 
  --       cuyo t�tulo est� contenido "titulo".
  --
    exito: boolean;
  begin 
    exito:= false; new_Line;
    for indice in 1..t.numDatos loop
      if compararCadenas(titulo,t.tabla(indice).titulo) then
        exito:= true;
        accederAFavoritos(t,indice);
      end if;
    end loop;  
    if not exito then
      put("No se han encontrado favoritos coincidentes con el titulo ");
      put('"'); put(titulo); put('"');
    end if;
    new_Line(2);
  end seleccionarPorTitulo; 
  
  
  procedure seleccionarPorUrl(t: tpLista; url: tpCadena) is   
  --
  -- Pre: "t" almacena en memoria la lista actual de favoritos y
  --       "url" la introducida por el usuario a trav�s de la 
  --       l�nea de �rdenes o tras la solicitud a trav�s del men�.
  -- Post: muestra por pantalla la lista de v�nculos favoritos 
  --       en cuya url est� contenida "url".
  --
    exito: boolean;
  begin
    exito:= false; new_Line;
    for indice in 1..t.numDatos loop
      if compararCadenas(url,t.tabla(indice).url) then
        exito:= true;
        accederAFavoritos(t,indice);
      end if;  
    end loop;
    if not exito then
      put("No se han encontrado favoritos coincidentes con la url ");
      put('"'); put(url); put('"');
    end if;
    new_Line(2);
  end seleccionarPorURL;
  

  procedure mostrarListadoEtiquetas(t: tpLista) is
  --
  -- Pre: "t" almacena en memoria la lista actual de favoritos.
  -- Post: muestra por pantalla un listado de las etiquetas de los
  --       enlaces favoritos en orden decreciente de utilizaci�n.
  --
    l: listaEtiquetas;
  begin 
    for i in 1..t.numDatos loop
      actualizarListaEtiquetas(l,t.tabla(i).etiquetas);
    end loop;
    ordenarEtiquetas(l,1,l.numEtiquetas);
    for j in reverse 1..l.numEtiquetas loop
      put(l.tabla(j).etiqueta); put(' ');
      put(l.tabla(j).numApariciones,0);
      new_line;
    end loop;
  end mostrarListadoEtiquetas;


  procedure lineaDeComandos(t: tpLista) is
  --
  -- Pre: cierto
  -- Post: gestiona las diferentes opciones del programa que pueden
  --       activarse a trav�s de la l�nea de �rdenes del sistema 
  --       operativo.
  --
  begin 
    if (command_name="favoritos") then
      if argument(1)="-e" then
        if argument_count=1 then  
          mostrarListadoEtiquetas(t);
        else
          for indice in 2..argument_count loop
            seleccionarPorEtiquetas(t, stringACadena(argument(indice)));
          end loop;
        end if;
      elsif argument(1)="-t" then
        for indice in 2..argument_count loop
          seleccionarPorTitulo(t, stringACadena(argument(indice)));
        end loop;
      elsif argument(1)="-u" then 
        for indice in 2..argument_count loop
          seleccionarPorUrl(t, stringACadena(argument(indice)));
        end loop;
      end if;
    end if;   
  end lineaDeComandos;

  
  procedure generarFicheroEtiquetas(t: tpLista; f: out texto) is
  --
  -- Pre: "t" almacena en memoria la lista actual de favoritos.
  -- Post: escribe en un fichero de texto "f" las etiquetas utilizadas por los
  --       favoritos. Cada etiqueta se escribe en una l�nea junto con el
  --       n�mero de veces que aparece asociada a enlaces almacenados, en 
  --       orden decreciente de apariciones.
  -- 
    
    nombre: string(1..80); 
    longitud: integer;
    l: listaEtiquetas;
  begin
    put("Introduzca el nombre del fichero en el que generar etiquetas: ");
    get_line(nombre,longitud);
    create(f,out_file,nombre(1..longitud));
    for i in 1..t.numDatos loop
      actualizarListaEtiquetas(l,t.tabla(i).etiquetas);
    end loop;
    ordenarEtiquetas(l,1,l.numEtiquetas);
    for j in reverse 1..l.numEtiquetas loop
      put(f,l.tabla(j).etiqueta); put(f,' ');
      put(f,l.tabla(j).numApariciones,0);
      new_line(f);
    end loop;
    put ("El fichero "); put('"'); put(nombre(1..longitud)); put('"');
    put (" se ha creado correctamente"); new_Line;
    close(f);
  end generarFicheroEtiquetas;
  
  
  procedure actualizarFicheroFavoritos(t: tpLista; f: in out tpFichero) is
  --
  -- Pre: "t" almacena en memoria la lista actual de favoritos y "f" 
  --      almacena en un fichero secuencial la lista inicial de favoritos.
  -- Post: actualiza el fichero "f" de favoritos con los datos de favoritos 
  --       contenidos en la lista "t" y cierra el fichero "f".
  --
  begin
    open(f,out_file,nombreFichero);
    escribirFavoritosEnFicheroSecuencial(t,f);
    close(f);
  end actualizarFicheroFavoritos;
   
   
  procedure mostrarMenu(opcion : out integer) is   
  --
  -- Pre: cierto
  -- Post: muestra por pantalla el men� del programa con las diferentes
  --       opciones disponibles y solicita al usuario que introduzca una
  --       opci�n.
  --
  begin
    for i in 1..80 loop put('-'); end loop; new_line;
    for i in 1..20 loop put(' '); end loop;
    put ("Gestor de enlaces favoritos"); new_Line;
    for i in 1..80 loop put('-'); end loop; new_line;
    put("1. Agregar favoritos desde un fichero"); new_Line;
    put("2. Agregar favoritos desde el teclado"); new_Line;
    put("3. Seleccionar favoritos por etiquetas"); new_Line;
    put("4. Seleccionar favoritos por contenido en el titulo"); new_Line;
    put("5. Seleccionar favoritos por contenido en la url"); new_Line;
    put("6. Generar fichero de etiquetas"); new_Line;
    put("0. Salir"); new_Line(2);
    put("Seleccione una opcion del menu: "); 
    get(opcion); skip_Line; new_Line;
  end mostrarMenu;
  
  
  procedure comprobarOpcion(listaFavoritos: in out tpLista) is
  --
  -- Pre: "listaFavoritos" almacena en memoria la lista actual de favoritos.
  -- Post: muestra por pantalla el men� del programa y ejecuta la opci�n 
  --       elegida por el usuario.
  --
    opcion: integer;
    infoSeleccion: tpCadena;
    t: texto;
  begin
    mostrarMenu(opcion);  
    while not (opcion=0) loop
      if opcion=1 then agregarDeFicheroDeTexto(listaFavoritos);
        elsif opcion=2 then agregarDeTeclado(listaFavoritos);
        elsif opcion=3 then
          put ("Introduzca las etiquetas del favorito buscado: ");
          get_line(infoSeleccion);
          seleccionarPorEtiquetas(listaFavoritos, infoSeleccion);
        elsif opcion=4 then 
          put ("Introduzca el titulo del favorito buscado: ");
          get_line(infoSeleccion);
          seleccionarPorTitulo(listaFavoritos, infoSeleccion);
         elsif opcion=5 then 
           put ("Introduzca la url del favorito buscado: ");
           get_line(infoSeleccion);
           seleccionarPorUrl(listaFavoritos, infoSeleccion);
         elsif opcion=6 then generarFicheroEtiquetas(listaFavoritos,t);
         else put ("Introduzca una opcion del menu"); new_line(2);
      end if;
      mostrarMenu(opcion);
    end loop;
  end comprobarOpcion;
  
 
  f: tpFichero;
  listaFavoritos: tpLista;
begin
  comprobarFichero(f);
  generarTablaFavoritos(f,listaFavoritos);
  if (argument_count=0) then
    comprobarOpcion(listaFavoritos);
    actualizarFicheroFavoritos(listaFavoritos,f);
  else lineaDeComandos(listaFavoritos); 
  end if;
end favoritos;
 
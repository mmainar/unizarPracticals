-----------------------------------------------------------------------
-- Fichero: pruebaInvertir.adb
-- Tema:    Fichero de prueba para observar el funcionamiento del 
--          algoritmo invertir diseñado aplicando un método recursivo 
--          y sin bucles.
-- Fecha:   Mayo de 2006
-- Versión: 1.0
-- Autor:   Ismael Saad García.     NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. jj.colomer@gmail.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 3 de Metodología de la Programación.
-----------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, ada.sequential_IO;
-----------------------------------------------------------------------
procedure pruebaInvertir is
-----------------------------------------------------------------------
-- Pre: cierto
-- Post: Almacena en un fichero secuencial una determinada 
--       secuencia de enteros y presenta por pantalla su contenido. 
--       A continuación, invoca al procedimiento invertir y muestra 
--       de nuevo por pantalla el contenido del fichero.
-----------------------------------------------------------------------


  DIM: constant integer:= 1000; -- Maximo numero de datos de la tabla
                                -- y por tanto del fichero a invertir
  
  package bibFichero is new ada.sequential_IO(integer);
  subtype tpFichero is bibFichero.file_type;
  subtype tpIndice is integer range 1..DIM;  
  type tpTabla is array(tpIndice) of integer;
  use ada.text_IO, ada.integer_text_IO, bibFichero;


  -----------------------------------------------------------------
  procedure invertir(f: in out tpFichero) is
  -----------------------------------------------------------------
  -- Pre: f=F_0
  -- Post: (PT alfa en [1,numDatos(F_0)].dato(f,alfa)=
  --       dato(F_0,numDatos(F_0)+1-alfa))
  -----------------------------------------------------------------
    T: tpTabla; 
    N: integer; -- Numero de datos del fichero "f"
  -----------------------------------------------------------------
    procedure copiarEnTabla(f: tpFichero; indice: integer;
                            T: out tpTabla; N: out integer) is
    --
    -- Pre: (modo(f)=Lec) AND (indice>=1) AND (numLeidos(f)=indice-1)
    --       AND (numDatos(f)>=numLeidos(f)) AND
    --       (PT alfa en [1,indice-1].T(alfa)=dato(f,alfa))
    -- Post: (PT alfa en [1,numDatos(f)].T(alfa)=dato(f,alfa)) 
    --       AND (N=numDatos(f))
    --
    begin
      if not end_of_file(f) then
        read(f,T(indice)); 
        copiarEnTabla(f,indice+1,T,N);
      else
        N:= indice-1;
      end if;
    end copiarEnTabla;

 
    procedure copiarTablaInvertidaEnFichero(T: tpTabla; indice: integer; 
                                            f: in out tpFichero) is
    --
    -- Pre: (modo(f)=Esc) AND (indice>=0) AND
    --      (PT EN [1,N-indice].dato(f,alfa)= T(N-alfa+1))
    -- Post: (PT alfa EN [1,numDatos(f)].dato(f,alfa)=T(N-alfa+1))
    --
    begin
      if indice>=1 then
        write(f,T(indice));
        copiarTablaInvertidaEnFichero(T,indice-1,f);
      end if;
    end copiarTablaInvertidaEnFichero;    
    

  begin -- de invertir 
    reset(f,in_file); 
    copiarEnTabla(f,1,T,N);
    reset(f,out_file);
    copiarTablaInvertidaEnFichero(T,N,f);
  end invertir; 
  -----------------------------------------------------------------
  
  
  f: tpFichero;
  indice, dato: integer;
begin
  create(f,out_file);
  for i in 1..100 loop write(f,i); end loop;
  reset(f,in_file); indice:= 0;
  put ("Contenido inicial del fichero: "); new_Line(2);
  while not end_of_file(f) loop
    indice:= indice+1;
    read(f,dato); put(dato,5);
    if (indice mod 10=0) then new_line; end if;
  end loop;
  new_Line(2);
  invertir(f); 
  indice:= 0; reset(f,in_file);
  put ("Contenido del fichero tras invertirlo: "); new_Line(2);
  while not end_of_file(f) loop
    indice:= indice+1;
    read(f,dato); put(dato,5);
    if (indice mod 10=0) then new_line; end if;
  end loop;
  close(f);
end pruebaInvertir;
------------------------------------------------------------------------------
-- Fichero: operaciones.adb
-- Tema:    Fichero de implementación de procedimientos de ordenación
-- Fecha:   Marzo de 2006
-- Versión: 1.0
-- Autores: Ismael Saad García. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 1 de Metodología de la Programación.
------------------------------------------------------------------------------
package body operaciones is
  
  
   -------------------------------------------------------------------
   function busquedaLineal(T: tpTabla; d: tpDato) return integer is
   -------------------------------------------------------------------
   -- Pre:  cierto
   -- Post: ((EX alfa en [T'First..T'Last].T(alfa)=d)
   --            -> T(busquedaLineal(T,d))=d)
   --          AND (NOT (EX alfa en [T'First..T'Last].T(alfa)=d)
   --                 -> busquedaLineal(T,d)=0)
   -------------------------------------------------------------------
     indice: integer;
     exito: boolean;
     N: integer;
   begin
     indice:= 0; exito:= false; N:= T'Last;
     while indice<N and not exito loop
       indice:= indice+1; 
       exito:= T(indice)=d;
     end loop;
     if exito 
       then return indice;
       else return 0;
     end if;
   end busquedaLineal;
   

   ---------------------------------------------------------------------
   function busquedaBinaria (T: tpTabla; d: tpDato) return integer is
   ---------------------------------------------------------------------
   -- Pre:  (PT alfa en [T'First..T'Pred(T'Last)].T(alfa)<=T(alfa+1))
   -- Post: ((EX alfa en [T'First..T'Last].T(alfa)=d)
   --            -> T(busquedaBinaria(T,d))=d)
   --          AND (NOT (EX alfa en [T'First..T'Last].T(alfa)=d)
   --                 -> busquedaBinaria(T,d)=0)
   ---------------------------------------------------------------------
     I, S: integer;   -- Límites del espacio de búsqueda.
     medio: integer;  -- Punto medio del espacio de búsqueda.
     exito: boolean;
   begin
     I:= T'First; S:= T'Last; 
     while not (I=S) loop
       medio:= (I+S)/2;
       if d<=T(medio)
         then S:= medio;
         else I:= medio+1;
       end if;
     end loop;
     exito:= T(I)=d;
     if exito 
       then return I;
       else return 0;
     end if;
   end busquedaBinaria;
   

   ---------------------------------------------------------------------
   function busquedaEnFichero(f: tpFichero; d: tpDato) return integer is
   ---------------------------------------------------------------------
   -- Pre:  cierto
   -- Post: ((EX alfa en [1..numDatos(f)].dato(f,alfa)=d)
   --            -> dato(f,busquedaEnFichero(f,d))=d)
   --          AND (NOT (EX alfa en [1..numDatos(f)].dato(f,alfa)=d)
   --                 -> busquedaEnFichero(f,d)=0)
   ---------------------------------------------------------------------
     use moduloFichero;
     exito: boolean;
     dato: Tpdato;
     indice: integer;
   begin
      exito:= false; indice:= 0;
      while not end_of_file(f) and not exito loop
         read(f,dato); 
         indice:= indice+1;
         exito:= dato=d;
      end loop;
      if exito then 
        return indice;
        else return 0;
      end if;
   end busquedaEnFichero; 
  

   -------------------------------------------------------------------
   -- ordenada(T,desde,hasta)
   -- <-> (PT alfa en [desde..hasta-1].T(alfa)<=T(alfa+1))
   -------------------------------------------------------------------
   -- sonPermutacion(T1,T2,desde,hasta)
   -- <-> (PT alfa en [desde..hasta].
   --       (Num beta en [desde,hasta].T1(beta)=T1(alfa))
   --       =(Num beta en [desde,hasta].T2(beta)=T1(alfa)))
   -------------------------------------------------------------------


   -------------------------------------------------------------------
   procedure ordenacionPorInsercion(T: in out tpTabla) is
   -------------------------------------------------------------------
   -- Pre:  T = T_0
   -- Post: ordenada(T,T'First,T'Last) 
   --       AND sonPermutacion(T,T_0,T'First,T'Last)
   -------------------------------------------------------------------
     insercion, limite: integer;
     dato: tpDato;
     N: integer;
   begin
     N:= T'Last;
     for indice in 2..N loop
       dato:= T(indice); insercion:= indice; limite:= 1;
       while not(insercion=limite) loop
         if T(insercion-1)<=dato then
	     limite:= insercion;
	   else
	     T(insercion):= T(insercion-1); insercion:= insercion-1;
	   end if;
       end loop;
       T(insercion):= dato;
     end loop;   
   end ordenacionPorInsercion;
   -------------------------------------------------------------------
   

   -------------------------------------------------------------------
   procedure ordenacionPorSeleccion(T: in out tpTabla) is
   -------------------------------------------------------------------
   -- Pre:  T = T_0
   -- Post: ordenada(T,T'First,T'Last) 
   --       AND sonPermutacion(T,T_0,T'First,T'Last)
   -------------------------------------------------------------------
     indiceMenor: integer;
     datoAuxiliar: Tpdato;
     N: integer;
   begin
     N:= T'Last;
     for indice in 1..N-1 loop
       indiceMenor:= indice;
       for indiceBusqueda in indice+1..N loop
         if T(indiceBusqueda)<=T(indiceMenor) then
           indiceMenor:= indiceBusqueda;
         end if;
       end loop;
       datoAuxiliar:= T(indice);
       T(indice):= T(indiceMenor);
       T(indiceMenor):= datoAuxiliar;
     end loop;
   end ordenacionPorSeleccion;
   ------------------------------------------------------------------- 
 

   ------------------------------------------------------
   procedure ordenacionRapida(t: in out tpTabla) is
   -- Pre:  T = T_0
   -- Post: ordenada(T,T'First,T'Last) 
   --       AND sonPermutacion(T,T_0,T'First,T'Last)
   -------------------------------------------------------------------

      -------------------------------------------------------------
      procedure intercambia(x, y: in out tpDato) is
      -- Pre: x=A AND y=B
      -- Post: x=B AND y=A
      -------------------------------------------------------------
         aux: tpDato;
      begin
         aux := x;  x := y;  y := aux;
      end intercambia;
      -------------------------------------------------------------
      
      i, s: integer ;--range t'range;
      pivote: tpDato;
   begin  -- de ordenacionRapida
      if t'first < t'last then
         pivote := t(t'first);
         i := t'first + 1;
         s := t'last;
         while i < s + 1 loop
            if t(i) <= pivote then
               i := i + 1;
            elsif pivote <= t(s) then
               s := s - 1;
            else
               intercambia(t(i), t(s));
               i := i + 1;  s := s - 1;
            end if;
         end loop;
         intercambia(t(t'first), t(s));
         ordenacionRapida( t(t'first..s-1) );
         ordenacionRapida( t(s+1..t'last)  );
      end if;
   end ordenacionRapida;
   -------------------------------------------------------------------
      
end operaciones;
------------------------------------------------------------------------------        




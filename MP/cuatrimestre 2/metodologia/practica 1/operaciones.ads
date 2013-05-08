----------------------------------------------------------------------
-- Fichero: operaciones.ads
-- Tema: Fichero de especificaci�n de funciones de b�squeda en
--       tablas y ficheros y de procedimientos de ordenaci�n
--       de tablas
-- Fecha: Marzo de 2006
-- Versi�n: 1.0
-- Autores: Ismael Saad Garc�a. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.: Pr�ctica 1 de Metodolog�a de la Programaci�n. El fichero
--       de especificaci�n no debe modificarse, excepto para especi-
--       ficar adecuadamente cada funci�n o procedimiento
----------------------------------------------------------------------
with ada.sequential_IO;
----------------------------------------------------------------------
generic
   -- Modulo gen�rico con funciones de b�squeda en tablas y en ficheros
   -- secuenciales y procedimientos de ordenaci�n de tablas. Cuenta como
   -- par�metros gen�ricos el de tipo 'tpDato' y la relaci�n de orden "<="
   type tpDato is private;
   with function "<=" (a, b: tpDato) return boolean;

package operaciones is

   -- Tablas no restringidas de datos de tipo 'tpDato'
   type tpTabla is array (integer range <>) of tpDato;

   -- Ficheros secuenciales de datos de tipo 'tpDato'
   package moduloFichero is new ada.Sequential_IO(tpDato);

   subtype tpFichero is moduloFichero.file_type;

   -------------------------------------------------------------------
   function busquedaLineal(T: tpTabla; d: tpDato) return integer;
   -------------------------------------------------------------------
   -- Pre:  cierto
   -- Post: ((EX alfa en [T'First..T'Last].T(alfa)=d)
   --            -> T(busquedaLineal(T,d))=d)
   --          AND (NOT (EX alfa en [T'First..T'Last].T(alfa)=d)
   --                -> busquedaLineal(T,d)=0)
   -------------------------------------------------------------------

   -------------------------------------------------------------------
   function busquedaBinaria(T: tpTabla; d: tpDato) return integer;
   -------------------------------------------------------------------
   -- Pre:  (PT alfa en [T'First..T'Pred(T'Last)].T(alfa)<=T(alfa+1))
   -- Post: ((EX alfa en [T'First..T'Last].T(alfa)=d)
   --            -> T(busquedaLineal(T,d))=d)
   --          AND (NOT (EX alfa en [T'First..T'Last].T(alfa)=d)
   --                 -> busquedaLineal(T,d)=0)
   -------------------------------------------------------------------

   -------------------------------------------------------------------
   function busquedaEnFichero(f: tpFichero; d: tpDato) return integer;
   -------------------------------------------------------------------
   -- Pre:  cierto
   -- Post: ((EX alfa en [1..numDatos(f)].dato(f,alfa)=d)
   --            -> dato(f,busquedaEnFichero(f,d))=d)
   --          AND (NOT (EX alfa en [1..numDatos(f)].dato(f,alfa)=d)
   --                 -> busquedaEnFichero(f,d)=0)
   -------------------------------------------------------------------

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
   procedure ordenacionPorInsercion(T: in out tpTabla);
   -------------------------------------------------------------------
   -- Pre:  T = T_0
   -- Post: ordenada(T,T'First,T'Last) 
   --       AND sonPermutacion(T,T_0,T'First,T'Last)
   -------------------------------------------------------------------

   -------------------------------------------------------------------
   procedure ordenacionPorSeleccion(T: in out tpTabla);
   -- Pre:  T = T_0
   -- Post: ordenada(T,T'First,T'Last) 
   --       AND sonPermutacion(T,T_0,T'First,T'Last)
   -------------------------------------------------------------------

   -------------------------------------------------------------------
   procedure ordenacionRapida(T: in out tpTabla);
   -------------------------------------------------------------------
   -- Pre:  T = T_0
   -- Post: ordenada(T,T'First,T'Last) 
   --       AND sonPermutacion(T,T_0,T'First,T'Last)
   -------------------------------------------------------------------

end operaciones;
----------------------------------------------------------------------




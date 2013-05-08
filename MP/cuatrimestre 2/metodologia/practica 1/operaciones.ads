----------------------------------------------------------------------
-- Fichero: operaciones.ads
-- Tema: Fichero de especificación de funciones de búsqueda en
--       tablas y ficheros y de procedimientos de ordenación
--       de tablas
-- Fecha: Marzo de 2006
-- Versión: 1.0
-- Autores: Ismael Saad García. NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. searinox@msn.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.: Práctica 1 de Metodología de la Programación. El fichero
--       de especificación no debe modificarse, excepto para especi-
--       ficar adecuadamente cada función o procedimiento
----------------------------------------------------------------------
with ada.sequential_IO;
----------------------------------------------------------------------
generic
   -- Modulo genérico con funciones de búsqueda en tablas y en ficheros
   -- secuenciales y procedimientos de ordenación de tablas. Cuenta como
   -- parámetros genéricos el de tipo 'tpDato' y la relación de orden "<="
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




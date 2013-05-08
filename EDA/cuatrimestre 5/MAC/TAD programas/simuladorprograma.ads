------------------------------------------------------------------------------
-- Fichero: simuladorprograma.ads
-- Tema:    Fichero de especificacion del TAD para la simulacion y gestion de datos
--          de tipo programa 
-- Fecha:   17 de Octubre de 2007
-- Autor:   Basado en las soluciones de Santiago Marco Sola y Jorge Mena Martínez
-- Com.:    Ejercicio propuesto de MAC (Modelos abstractos de cálculo).
------------------------------------------------------------------------------ 

with Ada.text_IO, Ada.Strings.Unbounded;
use Ada.text_IO, Ada.Strings.Unbounded;

package simuladorPrograma is

  TYPE Programa IS PRIVATE; 
  -- cada programa es un procedimiento con un sólo parámetro en entrada y uno de salida, ambos de tipo cadena
  TYPE Cadena IS PRIVATE;
  -- cadena de caracteres

  subtype filetype is Ada.text_IO.file_type;

  procedure ejecutar(p:in programa; x:in cadena; y:out cadena);
    -- Post: Este procedimiento ejecuta p con entrada x. Si para, el resultado final
    --       está en y.
  procedure simular(p:in programa; x:in cadena; exito:out boolean);
    -- Post: Este procedimiento ejecuta p con entrada x. Si para éxito=true.
  procedure simularConReloj(p:in programa; x:in cadena; t:in integer; exito:out boolean);
    -- Post: Este procedimiento ejecuta t pasos de p con entrada x. Si para en t
    --       pasos o menos éxito=true, si no éxito=false.
   procedure leeDeFichero(f:in filetype; p:out programa);
    -- Post: Asigna a p el programa contenido en el
    --       fichero asociado a f.
  procedure escribeAFichero(p:in programa; f:in filetype);
    -- Post: Escribe en el fichero asociado a f el programa
    --       contenido en p.
    
    
  -- Los siguientes procedimientos hacen el cambio de tipo. 
  PROCEDURE ProgramaAcadena(P:IN Programa; Cp:OUT Cadena); 
  procedure cadenaAprograma(cad:in cadena; pcad:out programa);
  
  PROCEDURE CalculaSelf(Cp: IN Cadena; Csp:OUT Cadena);
    -- Post: Este procedimiento devuelve un programa codificado con csp que para cualquier entrada
    --       hace lo mismo que el codificado como cp con entrada cp.


   --- algunos procedimientos útiles para la prueba del tad 
      
  procedure MostrarPrograma(p: in programa);
    -- Post: Imprime por pantalla el programa 'programa'

  FUNCTION A_String(Cad: IN cadena) RETURN String;
  
  FUNCTION A_Programa(S: IN String) RETURN Programa;
  FUNCTION A_cadena(S: IN String) RETURN cadena;
  procedure Concatenar(cad1:out cadena; cad2:in string);

PRIVATE
  TYPE Programa IS NEW Unbounded_String; 
  type cadena is new Unbounded_String; 

     
end simuladorPrograma;
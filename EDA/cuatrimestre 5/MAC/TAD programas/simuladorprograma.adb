------------------------------------------------------------------------------
-- Fichero: simuladorprograma.adb
-- Tema:    Fichero de implementación del TAD para la simulacion y gestion de datos
--          de tipo programa 
-- Fecha:   17 de Octubre de 2007
-- Autor:   Basado en las soluciones de Santiago Marco Sola y Jorge Mena Martínez
-- Com.:    Ejercicio propuesto de MAC (Modelos abstractos de cálculo).
------------------------------------------------------------------------------ 
with Interfaces.C;
package body simuladorPrograma is

  function NombrePrograma(p: in programa) return string is
    -- Post: Devuelve el nombre del procedimiento principal del 
    --       programa 'p'

    aux : character;
    contador, final: integer;
  begin
    contador := 1;
    aux := Element(p, contador);
    while (aux /= 'p' and aux /= 'P') loop -- Buscamos la palabra reservada procedure
      contador := contador + 1; -- suponiendo que el programa p es un
      aux := Element(p, contador); -- programa ADA sintacticamente correcto
    end loop;
      
    contador := contador + 9; -- Avanzamos el tamaño correspondiente a procedure (9)
       
    while Element(p, contador) = ' ' loop
      contador := contador + 1;
    end loop;
    final := contador + 1;
      
    aux := Element(p, final);
    while aux /= '(' and aux/= ' ' loop
      final := final + 1;
      aux := Element(p, final);
    end loop;
      
    return Slice(p,contador,final-1);
  end NombrePrograma;

  procedure ejecutar(p:in programa; x:in cadena; y:out cadena) is
    -- Post: Este procedimiento ejecuta p con entrada x. Si para el resultado final
    --       está en y.

    package C renames Interfaces.C;

    function System (Command : C.Char_Array) return C.Int;
    pragma Import(C, System, "system");

    procedure escribirLiteral(codigoEjecutar: in out filetype; x: in cadena) is
      -- Post : Escribe el el fichero codigoEjecutar el contenido de la cadena
      --        'x' de forma tabulada y acotada.
      codigo1 : string := "  x:= A_cadena( " & character'val(34);
      codigo2 : string := character'val(34) & " ); " & ASCII.LF;
      codigo3 : string := "  concatenar(x," & character'val(34);
      MAX_LINEA : constant integer := 80;
      TAM_X : constant integer := Length(x);
      posicion : integer;
    begin
      put(codigoEjecutar,codigo1);
      if Length(x) < MAX_LINEA then
        put(codigoEjecutar,To_String(x));
        put(codigoEjecutar,codigo2);
      else
        put(codigoEjecutar,Slice(x,1,MAX_LINEA));
        put(codigoEjecutar,codigo2);
        posicion := MAX_LINEA + 1;
        while ( TAM_X - posicion + 1 ) > MAX_LINEA loop
          put(codigoEjecutar,codigo3);
          put(codigoEjecutar,Slice(x,posicion,posicion+MAX_LINEA-1));
          put(codigoEjecutar,codigo2);
          posicion := posicion + MAX_LINEA;
        end loop;
        put(codigoEjecutar,codigo3);
        put(codigoEjecutar,Slice(x,posicion,TAM_X));
        put(codigoEjecutar,codigo2);
      end if;
    end escribirLiteral;

    procedure GenerarCodigo(p:in programa; x:in cadena) is
      -- Post: Genera el codigo necesario para ejecutar el programa 'p'
      --       con entrada x y poder guardar su salida.
      --

      codigo1 : string := "with ada.text_IO, simuladorprograma; " & ASCII.LF &
                          "use ada.text_IO, simuladorprograma; " & ASCII.LF &
                          "procedure codigoEjecutar is " & ASCII.LF;
   
      codigo2 : string := "  x: cadena; y: cadena; " & ASCII.LF &
                          "  Resultado: filetype; " & ASCII.LF &
                          "begin " & ASCII.LF;
  
      codigo3 : string := "(x,y); " & ASCII.LF &
                          "  create(Resultado,out_file," & character'val(34) &
                                   "SalidaEjecutar" & character'val(34) & "); " & ASCII.LF &
                          "  put(Resultado,A_String(y)); close(Resultado); " & ASCII.LF &
                          "end codigoEjecutar;";
    
      codigoEjecutar : filetype;
    begin
      create(codigoEjecutar,out_file,"codigoejecutar.adb");
      put(codigoEjecutar,codigo1);
      escribeAFichero(p,codigoEjecutar);
      put(codigoEjecutar,codigo2);
      escribirLiteral(codigoEjecutar,x);
      put(codigoEjecutar,NombrePrograma(p));
      put(codigoEjecutar,codigo3);
      close(codigoEjecutar);
    end GenerarCodigo;

    procedure EjecutarPrograma(y: out cadena) is
      FicheroResultado : filetype;
      aux : character;
      Resultado : cadena := To_Unbounded_String("");
      ResEjecucion : C.Int;
    begin
      ResEjecucion := System (C.To_C ("./codigoejecutar"));--para unix/linux
      --ResEjecucion := System (C.To_C ("codigoejecutar"));--para windows

      open(FicheroResultado,in_file,"SalidaEjecutar");
      while not end_of_file(FicheroResultado) loop
        while not end_of_line(FicheroResultado) loop
          get(FicheroResultado,aux);
          Append(Resultado,aux);
        end loop;
        skip_line(FicheroResultado);
      end loop;
      close(FicheroResultado);
      -- ResEjecucion := System (C.To_C ("rm SalidaEjecutar"));

      y := Resultado;
    end EjecutarPrograma;

    ResEjecucion : C.Int;
  begin
    GenerarCodigo(p, x);
    ResEjecucion := System (C.To_C ("gnatmake codigoejecutar.adb 2> InformeCompilacion.inf"));
    EjecutarPrograma(y);
    --ResEjecucion := System (C.To_C ("rm codigoEjecutar.adb"));
    --ResEjecucion := System (C.To_C ("del codigoejecutar.exe codigoejecutar.ali codigoejecutar.o"));--windows
    ResEjecucion := System (C.To_C ("rm codigoejecutar codigoejecutar.ali codigoejecutar.o"));
    --para unix/linux
  end ejecutar;
  
  procedure simular(p:in programa; x:in cadena; exito:out boolean) is
    -- Post. Este procedimiento ejecuta p con entrada x. Si para éxito=true.
--    f: filetype;
    y: cadena;
  begin
    ejecutar(p,x,y);
    exito:= true;
  end simular;
  
  procedure simularConReloj(p:in programa; x:in cadena; t:in integer; exito:out boolean) is
    -- Post: Este procedimiento ejecuta t pasos de p con entrada x. Si para en t
    --       pasos o menos éxito=true, si no éxito=false.

    task Simulacion is
      entry Terminado;
    end;

    task body Simulacion is
      termina : boolean;
    begin
       simular(p,x,termina);
       accept Terminado;
    end Simulacion;

  begin
    select
      Simulacion.Terminado;
      exito := true;
    or
      delay Duration(t);
      abort Simulacion;
      exito := false;
    end select;
  end simularConReloj;


  procedure leeDeFichero(f:in filetype; p:out programa) is
    Aux : character;
    Resultado: programa := To_Unbounded_String("");
  begin
    while not end_of_file(f) loop
      while not end_of_line(f) loop
        get(f,Aux);
        Append(Resultado,Aux);
      end loop;
      Append(Resultado,ASCII.LF);
      skip_line(f);
    end loop;
    p:=Resultado;
  end leeDeFichero;
  
  procedure escribeAFichero(p:in programa; f:in filetype) is
  begin
    put(f,To_String(p));
  end escribeAFichero;
  
  PROCEDURE ProgramaAcadena(P:IN Programa; Cp:OUT Cadena) IS
  BEGIN
     Cp:=cadena(P);
  END Programaacadena;
  
  PROCEDURE CadenaAprograma(Cad:IN Cadena; Pcad:OUT Programa) IS
  BEGIN
     Pcad:=programa(Cad);
     END Cadenaaprograma;


procedure calculaSelf(cp: in cadena; csp:out cadena) is
    -- Post: Este procedimiento devuelve un programa codificado con csp que para cualquier entrada
    --       hace lo mismo que el codificado como cp con entrada cp.

      codigo1 : string := "with simuladorprograma; " & ASCII.LF &
         "use simuladorprograma; " & ASCII.LF & "procedure misp(x:in cadena; y:out cadena) is " 
         & ASCII.LF & "pp:programa;cpp:cadena;"  & ASCII.LF & "begin " & ASCII.LF&
         "pp:=a_programa(" & ASCII.quotation;
  
      codigo2 : string := ASCII.quotation & ");" & ASCII.LF & "programaacadena(pp,cpp); ejecutar(pp,cpp,y); " & ASCII.LF &
         "end misp;";

      Aux : cadena := To_Unbounded_String("");
BEGIN
   Append(Aux,Codigo1);
   aux := aux & cp;
   Append(Aux,Codigo2);
   csp:=aux;
END CalculaSelf;


  procedure MostrarPrograma(p: in programa)is
  begin put(To_String(p)); end MostrarPrograma;

  function A_programa(s: in string) return programa is
  begin
    return To_Unbounded_String(s);
  END A_Programa;
  
  function A_cadena(s: in string) return cadena is
  begin
    return To_Unbounded_String(s);
  end A_cadena;


  function A_String(cad: in cadena) return string is
  begin
    return To_String(cad);
  end A_String;

  procedure Concatenar(cad1:out cadena; cad2:in string) is
  begin
    Append(cad1,cad2);
  end Concatenar;

end simuladorPrograma;
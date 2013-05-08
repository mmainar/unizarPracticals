--------------------------------------------------------------------------------
-- Fichero: principal.adb
-- Titulo: Programacion con TAD's genericos en Ada.
-- Fecha: 28 de septiembre de 2006
-- Autores: Ismael Saad Garcia. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- Com: Practica 1 de Esctructuras de Datos y Algoritmos.
--------------------------------------------------------------------------------

with numerosbasen, ada.text_IO, ada.integer_text_IO;
use ada.text_IO, ada.integer_text_IO;


procedure principal is
--
-- Pre: cierto
-- Post: Permite seleccionar entre 2 bases de numeracion b1 y b2,
--       realizar las operaciones aritmeticas de suma, resta, producto
--       y division entera y mostrar los resultados por pantalla o un
--       mensaje de error si la operación no ha sido realizada
--       correctamente.
--

  type digitosb1 is ('0','1','2','3','4','5','6'); -- b1: base 7
  type digitosb2 is ('0','1'); -- b2: base binaria


  procedure sumaDigitosb1(x,y: in digitosb1; r,acarreo: out digitosb1) is
  --
  -- procedimiento de suma de digitos en base b1. Devuelve el ultimo digito
  -- de la suma en s y en acarreo devuelve 1 si la suma ha excedido
  -- el digito maximo
  --
    aux: integer;
  begin
    aux:= digitosb1'pos(x) + digitosb1'pos(y);
    if aux>(digitosb1'pos(digitosb1'last)) then
      acarreo:= digitosb1'succ(digitosb1'first);
      aux:= aux - (digitosb1'pos(digitosb1'last))-1;
    else
      acarreo:= digitosb1'first;
    end if;
    r:= digitosb1'val(aux);
  end sumaDigitosb1; 
  

  procedure restaDigitosb1(x,y: in digitosb1; r,acarreo: out digitosb1) is
  --
  -- procedimiento de resta de digitos en base b1. Devuelve el ultimo digito
  -- de la resta en r y en acarreo devuelve 1 si es que la resta ha necesitado
  -- un "prestamo". Bajo estas condiciones restadig SIEMPRE es posible.
  --
    aux: integer;
  begin
    aux:= digitosb1'pos(x) - digitosb1'pos(y);
    if aux<digitosb1'pos(digitosb1'first) then
      acarreo:= digitosb1'succ(digitosb1'first);
      aux:= aux + (digitosb1'pos(digitosb1'last))+1;
    else
      acarreo:= digitosb1'first;
    end if;
    r:= digitosb1'val(aux);
  end restaDigitosb1;
  

  procedure sumaDigitosb2(x,y: in digitosb2; r,acarreo: out digitosb2) is
  --
  -- procedimiento de suma de digitos en base b2. Devuelve el ultimo digito
  -- de la suma en s y en acarreo devuelve 1 si la suma ha excedido
  -- el digito maximo
  --
    aux: integer;
  begin
    aux:= digitosb2'pos(x) + digitosb2'pos(y);
    if aux>(digitosb2'pos(digitosb2'last)) then
      acarreo:= digitosb2'succ(digitosb2'first);
      aux:= aux - (digitosb2'pos(digitosb2'last))-1;
    else
      acarreo:= digitosb2'first;
    end if;
    r:= digitosb2'val(aux);
  end sumaDigitosb2; 
  

  procedure restaDigitosb2 (x,y: in digitosb2; r,acarreo: out digitosb2) is
  --
  -- procedimiento de resta de digitos en base n. Devuelve el ultimo digito
  -- de la resta en r y en acarreo devuelve 1 si es que la resta ha necesitado
  -- un "prestamo". Bajo estas condiciones restadig SIEMPRE es posible.
  --
    aux: integer;
  begin
    aux:= digitosb2'pos(x) - digitosb2'pos(y);
    if aux<digitosb2'pos(digitosb2'first) then
      acarreo:= digitosb2'succ(digitosb2'first);
      aux:= aux + (digitosb2'pos(digitosb2'last))+1;
    else
      acarreo:= digitosb2'first;
    end if;
    r:= digitosb2'val(aux);
  end restaDigitosb2;
        
 
  package operacionesb1 is new numerosbasen(digitosb1,sumaDigitosb1,restaDigitosb1);
  package operacionesb2 is new numerosbasen(digitosb2,sumaDigitosb2,restaDigitosb2);


  procedure escribirMenu is
  --
  -- Pre: cierto
  -- Post: muestra por pantalla un menú con las diferentes 
  --       opciones del programa.
  --
  begin
    put("1 - Elegir una base (primera) o (segunda): "); new_line;
    put("2 - Sumar dos numeros en la base seleccionada: "); new_line;
    put("3 - Restar dos numeros en la base seleccionada: "); new_line;
    put("4 - Multiplicar dos numeros en la base seleccionada: "); new_line;
    put("5 - Dividir dos numeros en la base seleccionada: "); new_line;
    put("0 - Salir"); new_line;
    put("Elige una opcion: "); 
  end escribirMenu;
  

  procedure escribirNumerob1(numero: in operacionesb1.nbasen) is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla los digitos de "numero".
  --
    encontrado: boolean;
  begin
    encontrado:= false;
    for i in 1..79 loop
      if not encontrado then
        encontrado:= not (numero(i)=digitosb1'first);
        if encontrado then put(digitosb1'pos(numero(i)),0); end if;
      else
        put(digitosb1'pos(numero(i)),0);
      end if;
    end loop;
    put(digitosb1'pos(numero(80)),0);
  end escribirNumerob1;
  
  
 procedure escribirNumerob2(numero: in operacionesb2.nbasen) is
  --
  -- Pre: cierto
  -- Post: Muestra por pantalla los digitos de "numero".
  --
    encontrado: boolean;
  begin
    encontrado:= false;
    for i in 1..79 loop
      if not encontrado then
        encontrado:= not (numero(i)=digitosb2'first);
        if encontrado then put(digitosb2'pos(numero(i)),0); end if;
      else
        put(digitosb2'pos(numero(i)),0);
      end if;
    end loop;
    put(digitosb2'pos(numero(80)),0);
  end escribirNumerob2;


  procedure pedirNumerosb1(x,y: out operacionesb1.nbasen) is
  --
  -- Pre: cierto
  -- Post: Solicita al operador que introduzca los números
  --       en la base b1.
  --
  --
    indice, longitud: integer;
    numero: string(1..80);
  begin
    operacionesb1.cero(x); operacionesb1.cero(y);
    put("Introduce el primer numero: "); get_line(numero,longitud); 
    indice:= 80;
    while longitud/=0 loop
      x(indice):= digitosb1'val(character'pos(numero(longitud))-character'pos('0'));
      longitud:= longitud-1;
      indice:= indice-1;
    end loop;
    put("Introduce el segundo numero: "); get_line(numero,longitud);
    indice:= 80;
    while longitud/=0 loop
      y(indice):= digitosb1'val(character'pos(numero(longitud))-character'pos('0'));
      longitud:= longitud-1;
      indice:= indice-1;
    end loop;
  end pedirNumerosb1;


  procedure pedirNumerosb2(x,y: out operacionesb2.nbasen) is
  --
  -- Pre: cierto
  -- Post: Solicita al operador que introduzca los números
  --       en la base b2.
  --
  --
    indice, longitud: integer;
    numero: string(1..80);
  begin
    operacionesb2.cero(x); operacionesb2.cero(y);
    put("Introduce el primer numero: "); get_line(numero,longitud); 
    indice:= 80;
    while longitud/=0 loop
      x(indice):= digitosb2'val(character'pos(numero(longitud))-character'pos('0'));
      longitud:= longitud-1;
      indice:= indice-1;
    end loop;
    put("Introduce el segundo numero: "); get_line(numero,longitud);
    indice:= 80;
    while longitud/=0 loop
      y(indice):= digitosb2'val(character'pos(numero(longitud))-character'pos('0'));
      longitud:= longitud-1;
      indice:= indice-1;
    end loop;
  end pedirNumerosb2;


  procedure evaluarOpcion(opcion,base: integer) is
  --
  --
  --
  --
    x, y, resultadob1: operacionesb1.nbasen;
    a,b,resultadob2: operacionesb2.nbasen;
  begin
    operacionesb1.cero(x); operacionesb1.cero(y);
    if opcion=2 then 
      if base=1 then
        pedirNumerosb1(x,y);
        put("Su suma en base 7 es: "); 
        resultadob1:= operacionesb1.suma(x,y); 
        escribirNumerob1(resultadob1);
        if operacionesb1.errorOp then 
          new_Line;
          put("Se ha producido un error en la operacion"); 
        end if;
        new_line(2);
      else
        pedirNumerosb2(a,b);
        put("Su suma en base binaria es: "); 
        resultadob2:= operacionesb2.suma(a,b); 
        escribirNumerob2(resultadob2);
        if operacionesb2.errorOp then 
          new_Line;
          put("Se ha producido un error en la operacion"); 
        end if;
        new_line(2);
      end if;
    elsif opcion=3 then
      if base=1 then
        pedirNumerosb1(x,y);
        put("Su resta en base 7 es: "); 
        resultadob1:= operacionesb1.resta(x,y);
        escribirNumerob1(resultadob1);
        if operacionesb1.errorOp then 
          new_Line;
          put("Se ha producido un error en la operacion"); 
        end if;
        new_line(2);
      else
        pedirNumerosb2(a,b);
        put("Su resta en base binaria es: "); 
        resultadob2:= operacionesb2.resta(a,b); 
        escribirNumerob2(resultadob2);
        if operacionesb2.errorOp then 
          new_Line;
          put("Se ha producido un error en la operacion"); 
        end if;
        new_line(2);
      end if;
    elsif opcion=4 then
      if base=1 then
        pedirNumerosb1(x,y);
        put("Su multiplicacion en base 7 es: "); 
        resultadob1:= operacionesb1.multip(x,y);
        escribirNumerob1(resultadob1);
        if operacionesb1.errorOp then 
          new_Line;
          put("Se ha producido un error en la operacion"); 
        end if;
        new_line(2);
      else
        pedirNumerosb2(a,b);
        put("Su producto en base binaria es: "); 
        resultadob2:= operacionesb2.multip(a,b); 
        escribirNumerob2(resultadob2);
        if operacionesb2.errorOp then 
          new_Line;
          put("Se ha producido un error"); 
        end if;
        new_line(2);
      end if;
    elsif opcion=5 then
      if base=1 then
        pedirNumerosb1(x,y);
        put("Su division en base 7 es: "); 
        resultadob1:= operacionesb1.divide(x,y);
        escribirNumerob1(resultadob1);
        if operacionesb1.errorOp then 
          new_Line;
          put("Se ha producido un error"); 
        end if;
        new_line(2);
      else
        pedirNumerosb2(a,b);
        put("Su division en base binaria es: "); 
        resultadob2:= operacionesb2.divide(a,b); 
        escribirNumerob2(resultadob2);
        if operacionesb2.errorOp then 
          new_Line;
          put("Se ha producido un error"); 
        end if;
        new_line(2);
      end if;
    else
        new_line; put("Opcion incorrecta"); new_line(2);
    end if;
  end evaluarOpcion;



  opcion, base: integer;
begin 
  base:= 1; escribirMenu; get(opcion); skip_Line;
  while not (opcion=0) loop
    if opcion=1 then
      new_Line(2);
      put("Bases disponibles"); new_Line;
      put("-----------------"); new_Line;
      put("1: base 7"); new_Line;
      put("2: base binaria"); new_Line;
      put("Introduzca la base en la que desea trabajar (1 o 2): ");
      get(base); skip_Line;
      new_line(2);
    else 
      evaluarOpcion(opcion,base);
    end if;
    escribirMenu; get(opcion); skip_Line;
  end loop;
end principal;
-------------------------------------------------------------------
-- AUTORES: Equipo de profesores de MP
-- PROYECTO: Practica 3 de MP. Curso 2005-06
-- FECHA ULTIMA REVISION: 20-ABR-2006
-- DESCRIPCION: Programa iterativo que ha de ser transformado en
--              un programa sin bucles equivalente haciendo uso
--              de un diseño recursivo.
-------------------------------------------------------------------

with ada.text_io, ada.integer_text_io, ada.float_text_io;

-------------------------------------------------------------------
procedure calculosIter is
-------------------------------------------------------------------
-- Pre: cierto
-- Post: Presenta reiteradamente por pantalla un menú con varias
--       opciones para realizar cálculos diversos y permite
--       que el operador elija en cada ocasión la operación
--       de cálculo que desea ser ejecutada. 
-------------------------------------------------------------------

  use ada.text_io, ada.integer_text_io, ada.float_text_io;
  
  -----------------------------------------------------------------
  function raiz(x: in float) return float is
  -----------------------------------------------------------------
  -- Pre: x>=0.0
  -- Post: raiz(x)=x^0.5
  -----------------------------------------------------------------
     aproximacion: float;
  -----------------------------------------------------------------
  begin
     -- Se aplica el método de Newton
     aproximacion:= 10.0;    -- Primera aproximación a la solución
     for i in 1..100 loop        
       -- Ley de recurrencia: aplicación del método de Newton
       aproximacion := (aproximacion + x/aproximacion) / 2.0;
     end loop;
    return aproximacion;
  end raiz; 
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  function exponencial(x: float) return float is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: exponencial(x)=e^x
  -----------------------------------------------------------------
    cotaTermino: constant float:=1.0E-5;  -- cota inferior de los 
                                          -- términos sumados
    resultado: float;  -- Aproximación calculada de "e^x"
    termino: float;    -- Valor del termino que se está calculando
    indice: integer;   -- Índice del termino que se está calculando
  -----------------------------------------------------------------
  begin
    -- Se suman los terminos de la serie 1 + x/1! + x^2/2! + ...
    -- hasta que el valor absoluto del último término sumado sea 
    -- inferior a la constante "cotaTermino"
    termino:= 1.0;         -- Valor del primer término de la serie
    resultado:=termino;    -- Solución de partida
    indice:= 0;            -- Indice del término considerado
    while abs termino>cotaTermino loop
      -- resultado = 1 + x/1! + ... + x^indice/indice!
      indice:= indice+1;
      termino:= x*termino/float(indice);    -- termino=1.0/indice!
      resultado:= resultado +termino;
      -- resultado = 1 + x/1! + ... + x^indice/indice!
    end loop;
    return resultado;
  end exponencial;
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  function calcularSen (x: float) return float is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: calcularSen(x) = sen x
  -----------------------------------------------------------------
    termino, resultado: float;
  -----------------------------------------------------------------
  begin
    resultado:= 0.0; termino:=x;
    for i in 1..200 loop
      if i mod 2=0
        then resultado:= resultado - termino;
        else resultado:= resultado + termino;
      end if;
      termino:= termino*x*x/(float(2*i)*float(2*i+1));  
    end loop;
    return resultado;
  end calcularSen;
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  function calcularTg (x: float) return float is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: calcularTg(x)=tg x
  -----------------------------------------------------------------
    seno: float;
  begin
    seno:= calcularSen(x);
    return seno/raiz(1.0-seno**2);
  end calcularTg;
  -----------------------------------------------------------------
  
  -----------------------------------------------------------------
  procedure resolverEcuacionPrimerGrado is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: Escribe por pantalla la solución de una
  --       ecuación de primer grado de la forma
  --       a.x + b =0 donde los coeficientes a y b son
  --       definidos por el operador
  -----------------------------------------------------------------
    a, b: float;
  -----------------------------------------------------------------
  begin
    put("Resolucion de la ecuacion a.x + b = 0"); new_Line;
    put("Escriba el valor del coeficiente a : "); 
    get(a); skip_Line;
    put("Escriba el valor del coeficiente b : "); 
    get(b); skip_Line;
    put("La solucion de la ecuacion es x = "); 
    put(-b/a,0,2,0); new_Line(2);
  end resolverEcuacionPrimerGrado;
  -----------------------------------------------------------------
  
  -----------------------------------------------------------------
  procedure resolverEcuacionSegundoGrado is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: Escribe por pantalla la solución de una
  --       ecuación de primer grado de la forma
  --       a.x + b =0 donde los coeficientes a, b y c son
  --       definidos por el operador
  -----------------------------------------------------------------
    a, b, c: float;        -- coeficientes de la ecuación
    discriminante: float;  -- discriminante = b^2 - 4.a.c
    termino1: float;       -- termino1 = -b/(2.a)
    termino2: float;       -- termino2 = sqrt(abs(discriminante))/(2.a)
  -----------------------------------------------------------------
  begin
    put("Resolucion de la ecuacion a.x^2 + b.x + c = 0"); new_Line;
    put("Escriba el valor del coeficiente a : "); 
    get(a); skip_Line;
    put("Escriba el valor del coeficiente b : "); 
    get(b); skip_Line;
    put("Escriba el valor del coeficiente c : "); 
    get(c); skip_Line;
    put("Las soluciones de la ecuacion son x = "); 
    -- Realiza los cálculos comunes
    discriminante:= b*b - 4.0*a*c;
    termino1 := -b/(2.0*a);
    termino2 := raiz(abs(discriminante))/(2.0*a);
    if discriminante>=0.0
      then  -- Las dos raíces son reales
        put(termino1+termino2,0,2,0); 
        put(" y  x = "); put(termino1-termino2,0,2,0);
      else  -- Las dos raíces son complejas conjugadas
        put(termino1,0,2,0); put('+'); put(termino2,0,2,0);
        put('i'); put(" y  x = "); 
        put(termino1,0,2,0); put(-termino2,0,2,0); put('i'); 
    end if;
    new_Line(2);
  end resolverEcuacionSegundoGrado;
  -----------------------------------------------------------------
  
  -----------------------------------------------------------------
  procedure resolverEcuacionLogaritmica is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: Escribe por pantalla la solución de una ecuación
  --       de la forma a.ln x + b donde los coeficientes
  --       a y b son definidos por el operador
  --       
    a, b: float;
  begin
    put("Resolucion de la ecuacion a.ln x + b = 0"); new_Line;
    put("Escriba el valor del coeficiente a : "); 
    get(a); skip_Line;
    put("Escriba el valor del coeficiente b : "); 
    get(b); skip_Line;
    put("La solucion de la ecuacion es x = "); 
    put(exponencial(-b/a),0,3,0); new_Line(2);
  end resolverEcuacionLogaritmica;
  -----------------------------------------------------------------
  
  -----------------------------------------------------------------
  procedure reducirRacional is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: Pide al operador que defina un número racional y
  --       escribe por pantalla un numero racional equivalente
  --       irreducible
  -----------------------------------------------------------------

    
    ---------------------------------------------------------------
    function calcularMcd (uno,otro: integer) return integer is
    ---------------------------------------------------------------
    --  Pre: uno>=0 y otro>0
    --  Post: calcularMcd(uno,otro) = mcd(uno,otro)
    ---------------------------------------------------------------
      a,b,resto: integer;
    ---------------------------------------------------------------
    begin
      a:= uno; b:= otro;
      while not (b=0) loop  -- mcd(a,b)=mcd(uno,otro)
        resto:= a mod b; a:= b; b:= resto;
      end loop;
      return a;
    end calcularMcd;
    ---------------------------------------------------------------

  -----------------------------------------------------------------
    num,den: integer;
    elMcd: integer;
  -----------------------------------------------------------------
  begin
    put("Reduccion del racional a/b"); new_Line;
    put("Escriba el valor del numerador a : "); 
    get(num); skip_Line;
    put("Escriba el valor del denominador b : "); 
    get(den); skip_Line;
    put(num,0); put('/'); put(den,0);
    put(" es equivalente al racional irreducible ");
    if num*den<0 then put('-'); end if;
    num:= abs num; den := abs den; elMcd:= calcularMcd(num,den);
    put(num/elMcd,0); put('/'); put(den/elMcd,0);
    new_Line(2);
  end reducirRacional;
  -----------------------------------------------------------------
  
  -----------------------------------------------------------------
  procedure calcularDistancia is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: Escribe por la pantalla el valor de la distancia
  --       al origen de un punto del plano de coordenadas (x,y)
  --       definidas por el operador
  -----------------------------------------------------------------
    x,y: float;
  -----------------------------------------------------------------
  begin
    put("Calculo de la distancia al origen de coordenadas"); new_Line;
    put("Coordenada x del punto : "); get(x); skip_Line;
    put("Coordenada y del punto : "); get(y); skip_Line;
    put("La distancia del punto ("); put(x,0,2,0);
    put(','); put(y,0,2,0); put(") al origen es ");
    put(raiz(x*x+y*y),0,2,0); new_Line(2);
  end calcularDistancia;
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  procedure calcularAreaPoligono is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: Calcula el área de un polígono regular definido
  --       por el operador
  -----------------------------------------------------------------
  
    ---------------------------------------------------------------
    function areaPoligono (nlados: integer; lado: float) 
             return float is
    ---------------------------------------------------------------
    -- Pre: cierto
    -- Post: Devuelve el área de un polígono regular de "nlados" lados
    --       y cuyo lado tiene como longitud "lado"
    ---------------------------------------------------------------
    begin
      return float(nlados)*lado*lado/(4.0*calcularTg(3.141596/float(nlados)));
    end areaPoligono;
    ---------------------------------------------------------------
  
  -----------------------------------------------------------------
    nlados: integer; lado: float;
  -----------------------------------------------------------------
  begin
    put( "Calculo del area de un poligono regular");  new_Line;
    put( "Numero de lados del poligono : "); get(nlados); skip_Line;
    put( "Longitud de cada lado : "); get(lado); skip_Line;
    put("El area del poligono es "); 
    put(areaPoligono (nlados,lado),0,2,0); new_Line(2);
  end calcularAreaPoligono;
  -----------------------------------------------------------------
  
  -----------------------------------------------------------------
  procedure menu (opcion: out integer) is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: Plantea un menu de cálculos disponibles y asigna
  --       al parámetro "opcion" el valor de la opcion definida
  --       por el operador
  -----------------------------------------------------------------

    ---------------------------------------------------------------
    procedure plantearMenu is
    ---------------------------------------------------------------
    -- Pre: cierto
    -- Post: Escribe por pantalla las opciones del menu
    ---------------------------------------------------------------
    begin
      put("CALCULOS DISPONIBLES"); new_Line(2);
      put("0 - Fin del programa"); new_Line;
      put("1 - Resolver la ecuacion a.x + b = 0"); new_Line;
      put("2 - Resolver la ecuacion a.x^2 + b.x + c = 0"); new_Line;
      put("3 - Resolver la ecuacion a.ln x + b = 0"); new_Line;
      put("4 - Reducir el racional a/b"); new_Line;
      put("5 - Calcular la distancia al origen de coordenadas"); new_Line;
      put("6 - Calcular el area de un poligono regular"); new_Line(2);
    end plantearMenu;
    ---------------------------------------------------------------

  -----------------------------------------------------------------
  begin
    plantearMenu; put("Seleccione una opcion: "); get(opcion);
    skip_Line; new_Line;
    while not ((opcion>=0) and (opcion<=6)) loop
      plantearMenu; put("Seleccione una opcion: "); get(opcion);
      skip_Line; new_Line;  
    end loop;
  end menu;
  -----------------------------------------------------------------
  
-------------------------------------------------------------------
  opcion: integer;
-------------------------------------------------------------------
begin
  menu(opcion);
  while not (opcion=0) loop
    if opcion=1 then resolverEcuacionPrimerGrado;
      elsif opcion=2 then resolverEcuacionSegundoGrado;
      elsif opcion=3 then resolverEcuacionLogaritmica;
      elsif opcion=4 then reducirRacional;
      elsif opcion=5 then calcularDistancia;
      elsif opcion=6 then calcularAreaPoligono;
    end if;
    menu(opcion);
  end loop;
end calculosIter;
------------------------------------------------------------------- 
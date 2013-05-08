--------------------------------------------------------------------------
-- Fichero: calculosRecur.adb
-- Tema:    Programa recursivo sin bucles diseñado a partir de un programa
--          iterativo que ofrece un menú al operador con la posibilidad de
--          realizar seis cálculos distintos.
-- Fecha:   Mayo de 2006
-- Versión: 1.0
-- Autor:   Ismael Saad García.     NIP: 547942. air_saad@hotmail.com
--          Javier Colomer Vieitez. NIP: 550372. jj.colomer@gmail.com
--          Marcos Mainar Lalmolda. NIP: 550710. marcosmainar@gmail.com
-- Com.:    Práctica 3 de Metodología de la Programación.
--------------------------------------------------------------------------
with ada.text_io, ada.integer_text_io, ada.float_text_io;

-------------------------------------------------------------------
procedure calculosRecur is
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
    procedure raizBis (x: float; aproximacion: in out float;
                         marcador: integer) is
    --
    -- Pre: (x>=0.0) AND (marcador<=100) AND (aproximacion>=0.0)
    -- Post: aproximacion = x^0.5
    --                                       
    begin
      if x=0.0    -- En el caso directo x=0.0 su raíz vale 0.0.
        then aproximacion:= 0.0;
      elsif x=1.0 -- En el caso directo x=1.0 su raíz vale 1.0.
        then aproximacion:= 1.0;
      else 
        if (marcador<100) 
          then 
            -- Calculamos una aproximación de la solución
            aproximacion:= (aproximacion+x/aproximacion)/2.0;      
            -- Invocamos recursivamente al procedimiento hasta 
            -- aproximar la solucion con la suficiente exactitud.                            
            raizBis(x,aproximacion,marcador+1);
        end if;
      end if;
    end raizBis;
       

    marcador: integer:= 0; -- Iniciamos el contador a 0. Así, se ejecutará
                           -- recursivamente el procedimiento raizBis
                           -- 100 veces, un número suficiente para lograr
                           -- una buena aproximación a la solución real.
    aproximacion: float:= 10.0; -- Iniciamos la aproximación de la solución
                                -- al valor real 10.0.
  begin
    raizBis(x,aproximacion,marcador);
    return aproximacion;
  end raiz;
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  function exponencial (x: float) return float is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: exponencial(x)=e^x
  -----------------------------------------------------------------

    function exponencialBis (termAnt,x: float; indiceAnt: integer) 
                                                  return float is
    --
    -- Pre: (termAnt=x^indiceAnt/indiceAnt!) AND (indiceAnt>=0)
    -- Post: exponencialBis(termAnt,x,indiceAnt)=e^x
    --
      cotaTermino: constant float:= 1.0E-5;  
      -- cota inferior de los terminos sumados   
    begin 
      -- En cada invocación recursiva suma el correspondiente 
      -- término de la sucesion de Taylor correspondiente 
      -- a la exponencial sumando los términos de la serie 
      -- 1 + x/1! + x^2/2! + ... + x^n/n!
      if abs termAnt<cotaTermino then
        return 0.0; 
      else 
        return termAnt+exponencialBis(x*termAnt/float(indiceAnt+1),x,indiceAnt+1);
      end if;
    end exponencialBis;

  
  begin
    return exponencialBis(1.0, x, 0); 
  end exponencial;
  -----------------------------------------------------------------

  -----------------------------------------------------------------
  function calcularSen (x: float) return float is
  -----------------------------------------------------------------
  -- Pre: cierto
  -- Post: calcularSen(x) = sen x
  -----------------------------------------------------------------
    N: constant integer:= 200; -- Número de términos que sumamos
  -----------------------------------------------------------------
    function calcularSenGen(x: float; indiceAnt: integer; 
                            terminoAnt, resultado: float) return float is
    -- 
    -- Pre: (indiceAnt>=0) AND (terminoAnt=x)
    -- Post: calcularSenGen(x,indiceAnt,terminoAnt,resultado)= sen x
    --       
      termino: float; 
      indice: integer;
    begin
      indice:= indiceAnt + 1; 
      -- Calculamos el siguiente termino de la serie de Taylor
      termino:= terminoAnt*x*x/(float(2*indice)*float(2*indice+1));
      if indice=N then
         return resultado; -- Ya hemos sumado un numero de terminos
	                   -- suficiente de la serie para tener
                           -- una buena aproximacion del seno
      else
        if (indice mod 2=0) then
	  -- Recurrencia
          return calcularSenGen(x,indice,termino,resultado-terminoAnt); 
        else
	  -- Recurrencia
          return calcularSenGen(x,indice,termino,resultado+terminoAnt);
        end if;
      end if;
    end calcularSenGen;

  begin
    return calcularSenGen(x, 0, x, 0.0);
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
    --  Pre: (uno>=0) AND (otro>=0)
    --  Post: calcularMcd(uno,otro) = mcd(uno,otro)
    ---------------------------------------------------------------
    ---------------------------------------------------------------
    begin
      if (otro=0) then 
        return uno; -- Base
      else
        return calcularMcd(otro,uno mod otro); -- Recurrencia
      end if;
    end calcularMcd;
    ---------------------------------------------------------------

  -----------------------------------------------------------------
    num, den: integer;
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
    put("Calculo del area de un poligono regular");  new_Line;
    put("Numero de lados del poligono : "); get(nlados); skip_Line;
    put("Longitud de cada lado : "); get(lado); skip_Line;
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
  begin
    put("CALCULOS DISPONIBLES"); new_Line(2);
    put("0 - Fin del programa"); new_Line;
    put("1 - Resolver la ecuacion a.x + b = 0"); new_Line;
    put("2 - Resolver la ecuacion a.x^2 + b.x + c = 0"); new_Line;
    put("3 - Resolver la ecuacion a.ln x + b = 0"); new_Line;
    put("4 - Reducir el racional a/b"); new_Line;
    put("5 - Calcular la distancia al origen de coordenadas"); new_Line;
    put("6 - Calcular el area de un poligono regular"); new_Line(2);
    put("Seleccione una opcion: "); get(opcion);
    skip_Line; new_Line;
    if (opcion<0) or (opcion>6) then
      menu(opcion);
    end if;
  end menu;
  ------------------------------------------------------------------
  
-------------------------------------------------------------------
  opcion: integer;
-------------------------------------------------------------------
begin
  menu(opcion);
  if opcion=1 then resolverEcuacionPrimerGrado; calculosRecur;
    elsif opcion=2 then resolverEcuacionSegundoGrado; calculosRecur;
    elsif opcion=3 then resolverEcuacionLogaritmica; calculosRecur;
    elsif opcion=4 then reducirRacional; calculosRecur;
    elsif opcion=5 then calcularDistancia; calculosRecur;
    elsif opcion=6 then calcularAreaPoligono; calculosRecur;
  end if;
end calculosRecur;
-------------------------------------------------------------------                     
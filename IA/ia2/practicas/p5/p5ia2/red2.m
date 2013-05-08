%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fichero  red2.m
% Autor: Marcos Mainar Lalmolda
% Versión: 1.0, 27-5-02
% Herramienta: Matlab R12
% Utilidad: Muestra la gráfica del error de reconocimiento en función del
%           tamaño de la red (apartado 4 de los resultados de la práctica).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function net = red2()

  [alfabeto, fototeca, salidas] = catalogo;
  prmin = zeros(35, 1);
  prmax = ones(35, 1);
  % Matriz Rx2 de valores min y max para los R elementos de entrada
  % R = 35
  pr = [prmin prmax];
  % Definición de la red neuronal
  % Con el algoritmo de aprendizaje/entrenamiento de descenso del 
  % gradiente con factor de rapidez variable (traingdx).
  % Utilizamos la función de activación o de salida logsig.
  
  rango_red = 10:1:30;
  errores = 0;
  res = []; % Vector fila
  for j = rango_red
  
  
  net = newff(pr, [j 36], {'logsig', 'logsig'}, 'traingdx');
  % Inicializamos la red con valores aleatorios
  net = init(net);
  % Modificamos con valores empíricos 
  net.LW{2,1} = net.LW{2,1}*0.01;
  net.b{2} = net.b{2}*0.01;
  % Ponemos los parámetros para entrenar la red neuronal
  net.trainParam.show = 20;
  net.trainParam.epochs = 5000;
  net.trainParam.goal = 0.001; 

  % Entrenamiento de la red por retropropagacion para reconocer todos los
  % caracteres sin ruido
  net = train(net, fototeca, salidas);
  
  % Entrenamiento de la red por retropropagacion para reconocer caracteres
  % con ruido, hasta un valor de 0,2 (tanto por uno de pixels cambiados).
  net.trainParam.goal = 0.005;
  net.trainParam.epochs = 300;
  T = [salidas salidas salidas salidas];
  [F,C] = size(fototeca);
  for i = 1:10
    P = [fototeca fototeca tomafoto(alfabeto, 0.1) tomafoto(alfabeto, 0.2)];
    net = train(net,P,T);
  end
  
  % Volvemos a entrenar la red sin ruido a modo de recordatorio
  net.trainParam.epochs = 5000;
  net.trainParam.goal = 0.001;   
  net = train(net, fototeca, salidas);
  
  % Salvaguardamos la red en disco
  save red-matriculas net
  
  % Tests
  rango_ruido = 0:.05:.2;
  num_tests = 100;
  T = salidas;
  for nivel_ruido = rango_ruido
    for i= 1:num_tests
      P = tomafoto(alfabeto, nivel_ruido);
      Y1 = sim(net,P);
      Y2 = compet(Y1);
      errores = errores + sum(sum(abs(Y2-T)))/2; 
    end
  end
  
  [a, b] = size(rango_ruido);
  [c, d] = size(rango_red);
  res = [res; errores/(num_tests*b)];
  
  end
  
  % Mostramos gráfica de estadística de errores de reconocimiento en
  % función del tamaño de la red.
  
  plot(rango_red, res*100);
  title('Porcentaje de errores en función del tamaño de la red');
  xlabel('Tamaño de la red');
  ylabel('Porcentaje de errores');

  

 



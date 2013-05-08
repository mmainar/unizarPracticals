%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fichero  red3.m
% Autor: Marcos Mainar Lalmolda
% Versión: 1.0, 27-5-02
% Herramienta: Matlab R12
% Utilidad: Muestra la gráfica del error de reconocimiento en función de
%           cada caracter del alfabeto para ruidos de 0.1 y 0.2 
%           (apartado 4 de los resultados de la práctica).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function net = red3()

  [alfabeto, fototeca, salidas] = catalogo;
  prmin = zeros(35, 1);
  prmax = ones(35, 1);
  % Matriz Rx2 de valores min y max para los R elementos de entrada
  % R = 35
  pr = [prmin prmax];
  % Definición de la red neuronal
  % 3 niveles (Entrada + 1 nivel oculto + Salida)
  % Entrada: 35 neuronas
  % Nivel intermedio (oculto): 5-15 neuronas
  % Salida: 36 neuronas  
  % Devuelve red neuronal de 2 capas con conexion hacia adelante 
  % Con el algoritmo de aprendizaje/entrenamiento de Levenberg-Marquard.
  % Utilizamos la función de activación o de salida logsig.
  %net = newff(pr, [10 36], {'logsig', 'logsig'}, 'trainlm');
  % Con función de activación o salida tansig
  %net = newff(pr, [10 36], {'tansig', 'tansig'}, 'trainlm');
  % Con el algoritmo de aprendizaje/entrenamiento de descenso del 
  % gradiente con factor de rapidez variable (traingdx).
  % Utilizamos la función de activación o de salida logsig.
   
  net = newff(pr, [10 36], {'logsig', 'logsig'}, 'traingdx');
  net = init (net);
  net.b{2} = net.b{2}*0.01;
  net.LW{2,1} = net.LW{2,1}*0.01;
  % Ponemos los parámetros para entrenar la red neuronal
  net.trainParam.show = 20;
  net.trainParam.epochs = 5000;
  net.trainParam.goal = 0.001; 

  % Entrenamiento de la red por retropropagacion para reconocer todos los
  % caracteres sin ruido.
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
  net = train(net, P, T);
  
  % Salvaguardamos la red en disco
  save red-matriculas net
  
  % Tests
  rango_ruido = 0:.05:.2;
  num_tests = 100;
  res = []; % Vector fila
  [a,b] = size(fototeca);
  [c,d] = size(rango_ruido);
  rango_alfabeto = 1:1:36;
  for j = rango_alfabeto
     errores = 0;
    for nivel_ruido = rango_ruido
      for i= 1:num_tests
        letraConRuido = tomafoto(alfabeto(j), nivel_ruido);
        T = salidas(:, j);
        Y1 = sim(net, letraConRuido);
        Y2 = compet(Y1);
        errores = errores + sum(sum(abs(Y2-T)))/2; 
      end     
    end
    res = [res; errores/(num_tests*d)];
  end
  
  % Mostramos gráfica de estadística de errores de reconocimiento en
  % función de cada caracter del alfabeto para ruidos de 0.1 y 0.2.
  
  plot(rango_alfabeto,res*100);
  title('Porcentaje de errores en función de cada caracter');
  xlabel('Número del caracter en el alfabeto');
  ylabel('Porcentaje de errores');
  

  
  

 



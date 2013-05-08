%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fichero  red.m
% Autor: Marcos Mainar Lalmolda
% Versión: 1.0, 27-5-02
% Herramienta: Matlab R12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Realiza las siguientes funciones:
% 1. Entrena una red neuronal de 3 niveles (1 nivel oculto)
%    para reconocer caracteres del alfabeto.
% 2. Realiza los tests para analizar el comportamiento de la 
%    red con caracteres sin ruido y con ruido.
% 3. Salvaguarda la red en disco (red-matriculas.mat).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function net = red()

  [alfabeto, fototeca, salidas] = catalogo;
  prmin = zeros(35, 1);
  prmax = ones(35, 1);
  % Matriz Rx2 de valores min y max para los R elementos de entrada
  % R = 35
  pr = [prmin prmax];
  % Definición de la red neuronal
  % 3 niveles (Entrada + 1 nivel oculto + Salida)
  % Entrada: 35 neuronas
  % Nivel intermedio (oculto): 10-15 neuronas
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
  % Con función de activación o salida tansig
  %net = newff(pr, [10 36], {'tansig', 'tansig'}, 'traingdx')
  % Inicializamos la red con valores aleatorios
  net = init (net);
  % Modificamos con valores empíricos 
  net.b{2} = net.b{2}*0.01;
  net.LW{2,1} = net.LW{2,1}*0.01;
  % Ponemos los parámetros para entrenar la red neuronal
  net.trainParam.show = 20;
  net.trainParam.epochs = 5000;
  net.trainParam.goal = 0.001; 

  % Entrenamiento de la red por retropropagacion para reconocer todos los
  % caracteres sin ruido.
  disp('Entrenando sin ruido');
  net = train(net, fototeca, salidas);
  
  % Entrenamiento de la red por retropropagacion para reconocer caracteres
  % con ruido, hasta un valor de 0,2 (tanto por uno de pixels cambiados).
  net.trainParam.goal = 0.005;
  net.trainParam.epochs = 300;
  T = [salidas salidas salidas salidas];
  [F,C] = size(fototeca);
  disp('Entrenando con ruido');
  for i = 1:10
    P = [fototeca fototeca tomafoto(alfabeto, 0.1) tomafoto(alfabeto, 0.2)];
    net = train(net,P,T);
  end
  
  % Volvemos a entrenar la red sin ruido a modo de recordatorio
  disp('Entrenando sin ruido de nuevo');
  net.trainParam.epochs = 5000;
  net.trainParam.goal = 0.001;   
  net = train(net, fototeca, salidas);
  
  % Salvaguardamos la red en disco
  save red-matriculas net
  
  % Tests
  rango_ruido = 0:.05:.2; % Desde nivel de ruido 0 a 0.2 en incrementos de
                          % 0.05
  num_tests = 100;
  res = []; % Vector fila
  for nivel_ruido = rango_ruido
    errores = 0;
    for j= 1:num_tests 
      P = tomafoto(alfabeto, nivel_ruido);
      Y1 = sim(net,P);
      Y2 = compet(Y1);
      errores = errores + sum(sum(abs(Y2-salidas)))/2; 
      % El sum más interno suma todas las filas de cada columna y el más
      % externo suma todas las columnas. El div por 2 es para no contar
      % como error la posicion correcta del 1.
    end
    res = [res errores/3600];
  end
  
  % Mostramos gráfica de estadística de errores de reconocimiento en
  % función del grado de distorsión (0 a 0.2).
  plot(rango_ruido,res*100);
  title('Porcentaje de errores en función del grado de distorsión');
  xlabel('Grado de distorsión');
  ylabel('Porcentaje de errores');
  
  % Representamos las matrices de ponderacion de las capas de 
  % entrada-oculta y oculta-salida.
  pause;
  hintonwb(net.IW{1}, net.b{1}); % entrada-oculta
  pause;
  hintonwb(net.LW{2,1}, net.b{2}) % oculta-salida

 



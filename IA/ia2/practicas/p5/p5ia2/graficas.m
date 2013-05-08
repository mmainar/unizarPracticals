%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fichero  graficas.m
% Autor: Marcos Mainar Lalmolda
% Versión: 1.0, 27-5-02
% Herramienta: Matlab R12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Representa las matrices de ponderación de las capas de 
% entrada-oculta y oculta-salida a través de sus grafos de 
% Hinton. También muestra ambos sesgos o bias.
% Se corresponde con el apartado 5 de los resultados de la 
% práctica.
% Argumentos:
%  net : descripción de la red neuronal.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function graficas(net)

  % Representamos las matrices de ponderación de las capas de 
  % entrada-oculta y oculta-salida.
  hintonwb(net.IW{1}, net.b{1}); % entrada-oculta
  disp('Pulsa intro para mostrar la siguiente gráfica');
  pause;
  hintonwb(net.LW{2,1}, net.b{2}) % oculta-salida




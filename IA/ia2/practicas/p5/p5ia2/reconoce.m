function caracteres=reconoce(foto,net);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fichero:  reconoce
% Autor: Marcos Mainar Lalmolda	  
% Versión: 	1.0, 27-5-02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Función que reconoce caracteres a partir
% de una foto, mediante una red neuronal de 3 niveles
% Argumentos:
%  foto : matriz(35xn) de pixels  0/1
%  net: descripción de la red
%  caracteres: cadena con los n caracteres reconocidos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alfabeto, fototeca, salidas] = catalogo;
[a,b] = size(foto);
caracteres = '';

for i = 1:b
    Y1 = sim(net, foto(:, i));
    Y2 = compet(Y1);
    resp = find(compet(Y2) == 1);
    caracteres = [caracteres;alfabeto(resp)];   
end


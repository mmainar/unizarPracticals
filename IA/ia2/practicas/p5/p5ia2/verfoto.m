function verfoto(foto);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funcion para visualizar una foto de matricula
% Argumentos: 
%   foto :  matriz de 35 x n pixels
%   dibujo: matricula dibujada
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m,n]=size(foto);
dibujo=[];
for i=1:n,
  foto_5x7= reshape(foto(:,i) * ('o'-' ')+' ',5,7) ;
  dibujo=[dibujo, setstr(foto_5x7'), ones(7,2)*' '] ;
end
disp(dibujo);

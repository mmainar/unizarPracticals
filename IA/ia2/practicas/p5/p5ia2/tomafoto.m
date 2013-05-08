function foto=tomafoto(cadena,errores);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simula la toma de foto de cadena de caracteres, con ruido
% Argumentos:
%   cadena:  string(n)
%   errores: tanto por uno de pixels erroneos
%   foto:    matriz(35 x n) con los pixels 0/1 de la foto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alfabeto,fototeca]=catalogo;
[uno,n]=size(cadena);
fotobien=zeros(35,n) ;
for i=1:n,
  fotobien(:,i)=fototeca(:,find(alfabeto==cadena(i))) ;
end
cambios=rand(size(fotobien)) <= errores ;
foto=xor(fotobien,cambios)*1 ;

% Para ver la foto por pantalla:
%verfoto(foto);
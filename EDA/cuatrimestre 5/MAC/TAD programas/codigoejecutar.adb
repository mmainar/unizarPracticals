with ada.text_IO, simuladorprograma; 
use ada.text_IO, simuladorprograma; 
procedure codigoEjecutar is 
PROCEDURE Uno(A:IN cadena; B:OUT cadena) IS BEGIN   CalculaSelf(A,B); END Uno;   x: cadena; y: cadena; 
  Resultado: filetype; 
begin 
  x:= A_cadena( "PROCEDURE Uno(A:IN cadena; B:OUT cadena) IS BEGIN   CalculaSelf(A,B); END Uno; " ); 
Uno(x,y); 
  create(Resultado,out_file,"SalidaEjecutar"); 
  put(Resultado,A_String(y)); close(Resultado); 
end codigoEjecutar;

with simuladorprograma; 
use simuladorprograma; 
procedure misp(x:in cadena; y:out cadena) is 
pp:programa;cpp:cadena;
begin 
pp:=a_programa("PROCEDURE Uno(A:IN cadena; B:OUT cadena) IS BEGIN   CalculaSelf(A,B); END Uno; ");
programaacadena(pp,cpp); ejecutar(pp,cpp,y); 
end misp;

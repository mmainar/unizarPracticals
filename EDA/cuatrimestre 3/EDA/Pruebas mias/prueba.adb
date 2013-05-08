with ada.text_IO, ada.integer_text_IO, monticulos, ustrings;
use ada.text_IO, ada.integer_text_IO, ustrings;




procedure prueba is
  
 
  package misMonticulosEstaticos is new monticulos(100,">");
  package misMonticulosDinamicos is new monticulos(100,">");
  use misMonticulosEstaticos;
  c: monticulo;  d: monticuloDinamico;
begin
  creaVacio(c);
  encola(c,8);
  encola(c,9);
  encola(c,10);
  encola(c,11);
  encola(c,12);
  encola(c,13);
  encola(c,14);
  pintar_monticulo(c);
  new_Line(2);
  de_estatica_a_dinamica(c,d);
  preOrden(d);
  new_Line(2);
  pintar_arbol(d);
  

end prueba;
with ada.text_IO, ada.integer_text_IO, arbolesbinarios;
use ada.text_IO, ada.integer_text_IO, arbolesbinarios;


procedure prueba is

  b, aiprincipal,ai, ad, adprincipal, aux1, aux2, auxi, auxd: arbin;
  N: integer;
begin
  vacio(b); vacio(ai); vacio(ad); vacio(auxi); vacio(auxd); N:=10;
  vacio(aux1); vacio(aux2);
  --plantar(1,auxi,auxd,auxi);
  --plantar(1,auxd,auxi,auxd);
  --plantar(2,ai,ad,auxi);
 -- plantar(2,auxi,auxd,aux);
  --plantar(4,a,a,ai);
  --plantar(5,ai,aux,ai);
  --plantar(1,a,a,auxi);
  --plantar(1,a,a,auxd); 
  --plantar(8,auxi,auxd,ad);
  --plantar(1,ai,ad,a);
  --if esMonoDistante(N,a) 
  --  then 
  --    put("si es monodistante de orden "); put(N,0);
  --else put("no es monodistante de orden "); put(N,0);
  --end if;
  plantar(1,negro,auxi,auxi,auxd);
  plantar(2,rojo,auxd,auxd,ai);
  vacio(auxi); vacio(auxd);
  plantar(1,negro,auxi,auxi,auxd);
  plantar(2,rojo,auxd,auxd,ad);
  plantar(2,negro,ai,ad,aux1);
  vacio(auxi); vacio(auxd); vacio(ai); vacio(ad);
  plantar(1,negro,auxi,auxi,auxd);
  plantar(2,rojo,auxd,auxd,ai);
  vacio(auxi); vacio(auxd);
  plantar(1,negro,auxi,auxi,auxd);
  plantar(2,rojo,auxd,auxd,ad);
  plantar(2,negro,ai,ad,aux2);
  plantar(2,rojo,aux1,aux2,b);
  
  if esRojinegro(b) then
    put("si es rojinegro");
  else put ("no es rojinegro");
  end if;



end prueba;
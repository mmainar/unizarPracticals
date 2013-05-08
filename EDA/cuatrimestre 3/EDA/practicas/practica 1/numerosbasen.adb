--------------------------------------------------------------------------------
-- Fichero: numerosBaseN.adb
-- Titulo: Programacion con TAD's genericos en Ada.
-- Fecha: 28 de septiembre de 2006
-- Autores: Ismael Saad Garcia. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- Com: Practica 1 de Estructuras de Datos y Algoritmos.
--------------------------------------------------------------------------------
package body numerosBaseN is


  procedure cero(v:out nbasen) is
  -- asigna a un numero en base n, el elemento inicial
  --
  begin
    for indice in 1..80 loop
      v(indice):= digito'first;
    end loop;
  end cero;
  

  procedure uno(v:out nbasen) is
  -- asigna a un numero en base n, el elemento inicial
  --
  begin
    for indice in 1..79 loop
      v(indice):= digito'first;
    end loop;
    v(80):= digito'succ(digito'first);
  end uno;


  function suma(x,y:nbasen) return nbasen is
  -- suma un par de numeros en base n
  --
    acarreo, acarreo1, acarreo2: digito;
    resultado: nbasen;
    aux: digito;
  begin
    acarreo:= digito'first; error:= false;
    for indice in reverse 1..80 loop
      sumadig(acarreo,x(indice),aux,acarreo1);
      sumadig(aux,y(indice),resultado(indice),acarreo2);
      if not (acarreo1=digito'first) or not (acarreo2=digito'first) then
        acarreo:= digito'succ(digito'first);
      else
        acarreo:= digito'first;
      end if;   
    end loop;
    if acarreo=digito'succ(digito'first) then error:= true; end if;
    return resultado;
  end suma;


  function resta(x,y:nbasen) return nbasen is
  -- resta un par de numeros en base n: x-y
  --
    resultado: nbasen;
    acarreo, acarreo1, acarreo2: digito;
    aux: digito;
  begin
    acarreo:= digito'first; error:= false;
    for indice in reverse 1..80 loop
      restadig(x(indice),y(indice),aux,acarreo1);
      restadig(aux,acarreo,resultado(indice),acarreo2);
      if not (acarreo1=digito'first) or not (acarreo2=digito'first) then
        acarreo:= digito'succ(digito'first);
      else
        acarreo:= digito'first;
      end if;              
    end loop;
    if x<y then error:= true; end if;
    return resultado;
  end resta;


  function multip(x,y:nbasen) return nbasen is
  -- multiplica un par de numeros en base n
  --
    resultado, aux, numCero, numUno: nbasen;
  begin
    aux:= y; cero(resultado); cero(numCero); uno(numUno); error:= false;
    while not (aux=numCero) loop
      resultado:= suma(resultado,x);
      if error then 
        cero(resultado); 
        return resultado;
      end if;
      aux:= resta(aux,numUno);
    end loop;
    return resultado;
  end multip;


  function divide(x,y:nbasen) return nbasen is
  -- divide un par de numeros en base n: x/y
  --
    resultado, aux, numUno: nbasen;
  begin
    aux:= x; cero(resultado); uno(numUno); error:= false;
    if (y=resultado) then 
      error:= true;
      return resultado;
    end if;
    while (aux>=y) loop
      aux:= resta(aux,y);
      resultado:= suma(resultado,numUno);
    end loop;
    return resultado;
  end divide;


  function errorOp return boolean is
  -- informa si la ultima funcion aritmetica realizada ha producido un error.
  --
  begin
    return error;
  end errorOp;


end numerosBaseN;
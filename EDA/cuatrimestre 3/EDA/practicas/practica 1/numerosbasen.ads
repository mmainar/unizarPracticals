--------------------------------------------------------------------------------
-- Fichero: numerosbasen.ads
-- Titulo: Programacion con TAD's genericos en Ada.
-- Fecha: 28 de septiembre de 2006
-- Autores: Ismael Saad Garcia. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- Com: Practica 1 de Estructuras de Datos y Algoritmos.
--------------------------------------------------------------------------------
generic
  type digito is (<>);
  -- el tipo enumerado de los digitos validos en base n
  with procedure sumadig(x,y: in digito; r,acarreo:out digito);
  -- procedimiento de suma de digitos en base n. Devuelve el ultimo digito
  -- de la suma en s y en acarreo devuelve 1 si la suma ha excedido
  -- el digito maximo
  with procedure restadig (x,y:in digito; r,acarreo:out digito);
  -- procedimiento de resta de digitos en base n. Devuelve el ultimo digito
  -- de la resta en r y en acarreo devuelve 1 si es que la resta ha necesitado
  -- un "prestamo". Bajo estas condiciones restadig SIEMPRE es posible.
  package numerosbasen is
    type nbasen is array(1..80) of digito;
    -- almacena los digitos del numero en base n
    procedure cero(v:out nbasen);
    -- asigna a un numero en base n, el elemento inicial
    function suma(x,y:nbasen) return nbasen;
    -- suma un par de numeros en base n
    function resta(x,y:nbasen) return nbasen;
    -- resta un par de numeros en base n: x-y
    function multip(x,y:nbasen) return nbasen;
    -- multiplica un par de numeros en base n
    function divide(x,y:nbasen) return nbasen;
    -- divide un par de numeros en base n: x/y
    function errorOp return boolean;
    -- informa si la ultima funcion aritmetica realizada ha procudico un error.
  private
    error:boolean;
end numerosBaseN;
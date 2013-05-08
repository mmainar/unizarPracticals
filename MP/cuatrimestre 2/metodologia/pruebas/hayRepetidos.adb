with ada.text_IO, ada.integer_text_IO, ada.sequential_IO;


procedure prueba is
--
-- Pre: cierto
-- Post:
--
  package bibFichero is new ada.Sequential_IO(Integer);
  use bibFichero, ada.text_IO, ada.integer_text_IO, bibFichero;
  subtype tpFichero is bibFichero.file_type;
 

  function hayRepetidos(f: tpFichero) return boolean is
  -- 
  -- Pre: modo(f)=Lec AND numLeidos(f)=0
  -- Post: hayRepetidos(f)=(EX alfa en [1,numDatos(f)].(EX beta en 
  --       [1,numDatos(f)].dato(f,alfa)=dato(f,beta))
  --
  --
    losHay: boolean; 
    i, j: integer;
    dato1, dato2: integer;
  begin
    losHay:= false; i:= 0;
    while not end_of_file(f) and not losHay loop
      read(f,dato1); i:= i+1; j:= i;
      while not end_of_file(f) and not losHay loop
        read(f,dato2);
        j:= j+1;
        losHay:= (j/=i) AND (dato1=dato2);
      end loop;
    end loop;
    return losHay;
  end hayRepetidos;










  f: tpFichero;
  dato: integer;
begin
  create(f,out_file);
  put ("Introduzca dato: "); get(dato); skip_Line;
  while not (dato=0) loop
    write(f,dato);
    put ("Introduzca dato: ");
    get(dato); skip_Line;
  end loop;
  put ("Vamos a comprobar si hay al menos un par de datos iguales");
  new_Line; reset(f,in_file);
  if hayRepetidos(f) then put ("si los hay"); else put ("no los hay"); end if;
  close(f);
end prueba;
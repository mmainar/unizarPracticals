-- Tema: Fichero de implementación de metodos de ordenacion de ficheros
--       secuenciales de cotizaciones para la practica 2.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------

with ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES_p2,
    ada.calendar;

use ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES_p2,
   ada.calendar;


procedure ordenar is

 type pMetodo is access procedure(f: in out tpFCotizaciones; enOrden: in pFuncion);


 procedure testOrdenado(f: in out tpFCotizaciones; criterio: in pFuncion) is
   cot: cotizacion;
   estaOrdenado: boolean:= true;
 begin
   iniciarLectura(f);
   if not finFichero(f) then leerCotizacion(f,cot); end if;
   while not finFichero(f) and estaOrdenado loop
     if criterio(cot,siguienteDato(f))
       then leerCotizacion(f,cot);
       else estaOrdenado:= false;
     end if;
   end loop;
   if estaOrdenado
     then put_line("El fichero se ha ordenado correctamente");
     else put_line("ERROR en la ORDENACION del fichero");
   end if;
 end testOrdenado;


 procedure seleccionarMetodo(refMetodo: out pMetodo) is
  metSel: character;
 begin
  loop
    put_line("Tecnicas de ordenacion disponibles: ");
    put_line("    N: por Mezcla Natural");
    put_line("    P: por Mezcla Polifasica"); new_Line;
    put("Introduzca el metodo de ordenacion(N/P): ");
    get(metSel); skip_Line;
    case metSel is
      when 'N' | 'n' => refMetodo:= ord_MNatural'access;
      when 'P' | 'p' => refMetodo:= ord_MPolifasica'access;
      when others => refMetodo:= null;
    end case;
    exit when (refMetodo/=null);
  end loop;
 end seleccionarMetodo;


 procedure seleccionarCriterio(criterio: out pFuncion) is
  critSel: character;
 begin
  loop
    put_line("Criterios de ordenacion disponibles: ");
    put_line("   P: por Porcentaje de Variacion");
    put_line("   C: por Precio de Cierre");
    put_line("   A: por Precio de Apertura");
    put_line("   M: por Precio Max. de Sesion");
    put_line("   N: por Precio Min. de Sesion");
    put_line("   F: por Fecha de Sesion");
    put("Ordenacion seleccionada ? ");
    get(critSel); skip_Line;
    case critSel is
      when 'P' | 'p' => criterio:= ordenPVariacion'access;
      when 'C' | 'c' => criterio:= ordenPrecioCierre'access;
      when 'A' | 'a' => criterio:= ordenPrecioApertura'access;
      when 'M' | 'm' => criterio:= ordenPrecioMaxSesion'access;
      when 'N' | 'n' => criterio:= ordenPrecioMinSesion'access;
      when 'F' | 'f' => criterio:= ordenFecha'access;
      when others => criterio:= null;
    end case;
    exit when (criterio/=null);
  end loop;
 end seleccionarCriterio;

 nombreFich: tpNomFich;
 exito: boolean;
 f: tpFCotizaciones;
 t0, t1: time;
 mOrdenacion: pMetodo;
 claseOrden: pFuncion;
 resp: character;
begin
 loop
   put("Nombre del fichero de cotizaciones a ordenar? ");
   get_line(nombreFich.nom,nombreFich.long);
   asociar(f,nombreFich,tpAccF'first,exito);
   seleccionarMetodo(mOrdenacion);
   seleccionarCriterio(claseOrden);
   if exito and (mOrdenacion/=null) and (claseOrden/=null) then
     t0:= clock;
     mOrdenacion(f,claseOrden); -- Ejecutamos la ordenacion
     t1:= clock;
     put("La ordenacion del fichero ha tardado ");
     put(float(t1-t0),0,3,0); put(" segundos"); new_Line;
     testOrdenado(f,claseOrden); -- Verificamos la ordenacion
     new_Line; put("Desea realizar una nueva ordenacion?(S/N): ");
     get(resp); skip_Line; disociar(f);
   else put("No se ha podido abrir el fichero"); new_Line;
   end if;
   exit when (resp/='S');
 end loop;
end ordenar;
-- Tema: Programa interactivo dirigido por menu que permite el uso y la
--       manipulacion de la organizacion indexada desarrollada en la
--       practica 3.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-------------------------------------------------------------------------
with ada.text_IO, fcotizaciones, fdircot, findexcot;

use ada.text_IO, fcotizaciones, fdircot, findexcot;

procedure pmenu is


 procedure mostrarMenu is
 begin
   put("MENU                                         "); new_line;
   put("Asociar Org. Indexada                     asi"); new_line;
   put("Disociar Org. Indexada                    dsi"); new_line;
   put("Leer Cotizacion Org. Indexada             lci"); new_line;
   put("Escribir/Actualizar Cotizacion            eci"); new_line;
   put("Eliminar Cotizacion Org. Indexada         eli"); new_line;
   put("Primera Clave Fichero Indexado            pci"); new_line;
   put("Siguiente Clave Fichero Indexado          sci"); new_line;
   put("Generar Indice Org. Indexada              gii"); new_Line;
   put("Reestructurar Org. Indexada               roi"); new_Line(2);
   put("Salir del menu                            sdm"); new_line(2);
   put("Elija una opcion: ");
 end mostrarMenu;


 procedure asi(f: in out tpFIndexCotizaciones; asociado: in out boolean) is
 -- Asocia la organizacion indexada de cotizaciones.
   nombre: fdircot.tpNomFich;
 begin
   -- Si teniamos uno ya asociado, lo disociamos
   if asociado then findexcot.disociar(f); asociado:= false; end if;
   put("Introduzca el nombre del fichero a asociar(sin extension): ");
   get_line(nombre.nom,nombre.long);
   findexcot.asociar(f,nombre);
   asociado:= true;
   put("Fichero asociado correctamente"); new_Line;
 end asi;


 procedure dsi(f: in out tpFIndexCotizaciones; asociado: in out boolean) is
 -- Disocia la organizacion indexada de cotizaciones.
 begin
   findexcot.disociar(f);
   asociado:= false;
   put("Fichero disociado correctamente"); new_Line;
 end dsi;


 procedure lci(f: in out tpFIndexCotizaciones) is
 -- Solicita la clave de una cotizacion y si esta existe
 -- la muestra por pantalla
   cot: fdircot.cotizacion;
   exito: boolean;
   clave: tpClave;
   ticker: fdircot.tpTicker;
   fecha: fdircot.tpFecha;
   c: character:= character'Val(126);
 begin
   loop
     begin
       put("Introduzca los datos de la clave a buscar"); new_Line;
       put("Introduzca el ticker: ");
       get_line(ticker.nom,ticker.long);
       new_line; exit;
       exception
         when CONSTRAINT_ERROR => put("Elija un ticker valido."); new_line;
     end;
   end loop;
   -- Normalizamos el ticker para que la comparacion sea correcta
   while ticker.long < 12 loop
     ticker.long:= ticker.long+1;
     ticker.nom(ticker.long):= c;
   end loop;
   fdircot.pideFecha(fecha);
   clave:= creaClave(fecha, ticker);
   findexcot.leerCotizacion(f, clave, cot, exito);
   if exito then
     put_line("Mostrando cotizacion..."); new_Line;
     fdircot.mostrarCotizacion(cot);
   else put_line("Ha habido algun error al leer la cotizacion"); new_Line;
   end if;
 end lci;


 procedure eci(f: in out tpFIndexCotizaciones) is
 -- Solicita al usuario los datos de una cotizacion y la escribe
 -- en la organizacion indexada.
   cot: fdircot.cotizacion;
   clave: tpClave;
 begin
   fdircot.obtenerCotizacion(cot);
   clave:= creaClave(fdircot.fecha(cot), fdircot.ticker(cot));
   findexcot.escribirCotizacion(f, clave, cot);
 end eci;


 procedure eli(f: in out tpFIndexCotizaciones) is
 -- Solicita al usuario la clave de una cotizacion
 -- y si existe la elimina de la organizacion indexada.
   cot: fdircot.cotizacion;
   exito: boolean;
   clave: tpClave;
   fecha: fdircot.tpFecha;
   ticker: fdircot.tpTicker;
   c: character:= character'Val(126);
 begin
   loop
     begin
       put("Introduzca los datos de la clave a buscar"); new_Line;
       put("Introduzca el ticker(maximo 12 caracteres): ");
       get_line(ticker.nom,ticker.long);
       new_line; exit;
       exception
         when CONSTRAINT_ERROR => put("Elija un ticker valido."); new_line;
     end;
   end loop;
   -- Normalizamos el ticker para que la comparacion sea correcta
   while ticker.long < 12 loop
     ticker.long:= ticker.long+1;
     ticker.nom(ticker.long):= c;
   end loop;
   fdircot.pideFecha(fecha);
   clave:= creaClave(fecha, ticker);
   findexcot.eliminarCotizacion(f, clave, exito);
   if exito then put_line("Cotizacion eliminada correctamente"); new_Line;
   else put_line("Ha habido algun problema al eliminar la cotizacion"); new_Line;
   end if;
 end eli;


 procedure pci(f: in out tpFIndexCotizaciones) is
 -- Si hay entradas en el fichero de indice, muestra
 -- por pantalla la primera clave del indice.
   exito: boolean;
   clave: tpClave;
 begin
   findexcot.primeraClave(f, clave, exito);
   if exito then findexcot.mostrarClave(clave);
   else put_line("No hay claves en el fichero de indice"); new_Line;
   end if;
 end pci;


 procedure sci(f: in out tpFIndexCotizaciones) is
 -- Muestra por pantalla la clave del indice
 -- siguiente a la ultima accedida en caso de que exista.
   exito: boolean;
   clave: tpClave;
 begin
   findexcot.siguienteClave(f, clave, exito);
   if exito then findexcot.mostrarClave(clave);
   else put("No hay mas claves en el fichero de indice");
        put(" o aun no se ha visualizado la primera clave"); new_Line;
   end if;
 end sci;


 procedure gii(f: in out tpFIndexCotizaciones) is
 -- Genera o reconstruye el fichero de indice para la organizacion
 -- indexada.
 begin
   findexcot.generarIndice(f);
   put_line("Indice generado correctamente"); new_Line;
 end gii;


 procedure roi(f: in out tpFIndexCotizaciones) is
 -- Reestructura la organizacion indexada.
 begin
   findexcot.reestructurar(f);
   put_line("Org. indexada reestructurada correctamente"); new_Line;
 end roi;


 procedure tratarOpcionI (cad: in string; f: in out tpFIndexCotizaciones;
                          asociado: in out boolean) is
 -- Elige, en funcion del operador deseado, la secuencia de instrucciones a
 -- ejecutar.
 begin
   -- Si todavia no hemos asociado ningun fichero y pretendemos
   -- realizar alguna operacion distinta de "Asociar".
   if not asociado and cad/="asi"
     then put("Ha de asociar un fichero previamente.");
   else -- Hemos asociado ya algun fichero o tratamos de asociarlo.
     if cad="asi" then asi (f, asociado);
     elsif cad="dsi" then dsi (f, asociado);
     elsif cad="lci" then lci(f);
     elsif cad="eci" then eci(f);
     elsif cad="eli" then eli(f);
     elsif cad="pci" then pci(f);
     elsif cad="sci" then sci(f);
     elsif cad="gii" then gii(f);
     elsif cad="roi" then roi(f);
     else put("Opcion no valida");
     end if;
  end if;
  new_line(2);
 end tratarOpcionI;


 cad: string(1..3);
 g: tpFIndexCotizaciones;
 asociado: boolean:= false;
 pos: tpPosicion;
begin
 resetPos(pos); mostrarMenu;
 get(cad(1)); get(cad(2)); get(cad(3)); skip_Line;
 while (cad(1..3)/="sdm") loop
   tratarOpcionI(cad,g,asociado);
   mostrarMenu;
   get(cad(1)); get(cad(2)); get(cad(3)); skip_Line;
 end loop;
 if asociado then dsi(g,asociado); end if;
 new_line(2);
 put("Fin de la ejecucion del programa.");
end pmenu;
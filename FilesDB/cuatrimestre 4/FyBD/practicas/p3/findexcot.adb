-- Tema: Fichero de implementación de un módulo para el trabajo con
--       ficheros indexados de cotizaciones de la práctica 3.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
--------------------------------------------------------------------------
with ada.text_IO, fdircot, unchecked_deallocation;

use ada.text_IO, fdircot;

package body FINDEXCOT is

 procedure disponer is new unchecked_deallocation(nodo,pNodo);



 procedure agregarClave(f: in out tpFIndexCotizaciones; dato: in tpIndice) is
   aux, nuevo: pNodo;
 begin
   aux:= f.indice.primero;
   if (aux=null) then
     aux:= new nodo'(dato,null);
   else
     while (aux.sig/=null) loop
       aux:= aux.sig;
     end loop;
     nuevo:= new nodo'(dato,null);
     aux.sig:= nuevo;
   end if;
 end agregarClave;



 procedure asociar(f: in out tpFIndexCotizaciones; nomFich: in tpNomFich) is
   nombre: tpNomFich;
   indice: tpIndice;
   aux: pNodo;
 begin
   f.nombre:= nomFich;
   resetPos(f.ultimaPos);
   f.indice.primero:= null;
   -- Asociamos el fichero directo de datos de cotizaciones
   nombre.nom:= nomFich.nom;
   nombre.long:= nomFich.long+4;
   nombre.nom(nombre.long-3..nombre.long):=".dir";
   fdircot.asociar(f.fDir,nombre);
   -- Cargamos el indice desde el fichero de indice a memoria dinamica
   nombre.nom(nombre.long-2..nombre.long):="idx";
   bibFichIndice.open(f.fIndex,in_file,nombre.nom(1..nombre.long));
   if not bibFichIndice.end_of_file(f.fIndex) then
     bibFichIndice.read(f.fIndex,indice);
     f.indice.primero:= new nodo'(indice,null);
     aux:= f.indice.primero;
   end if;
   while not bibFichIndice.end_of_file(f.fIndex) loop
     bibFichIndice.read(f.fIndex,indice);
     aux.sig:= new nodo'(indice,null);
     aux:= aux.sig;
   end loop;
 end asociar;


 procedure crearFichIndice (f: in out tpFIndexCotizaciones;
                            nombre: tpNomFich) is
 begin
   create(f.fIndex, out_file, nombre.nom(1..nombre.long));
   f.nombre.nom:= nombre.nom; f.nombre.long:= nombre.long;
 end crearFichIndice;


 procedure cerrarFichIndice (f: in out tpFIndexCotizaciones) is
 begin
   close(f.fIndex);
 end cerrarFichIndice;


 procedure borrarIndice(f: in out tpFIndexCotizaciones) is
   aux: pNodo;
 begin
   aux:= f.indice.primero;
   while (aux/=null) loop
     f.indice.primero:= f.indice.primero.sig;
     disponer(aux);
     aux:= f.indice.primero;
   end loop;
   f.indice.primero:= null;
 end borrarIndice;


 procedure buscar(f: in out tpFIndexCotizaciones; clave: in tpClave;
                  posicion: out tpPosicion; exito: out boolean) is
   aux: pNodo;
 begin
   if (f.indice.primero=null) then exito:= false;
   else
     aux:= f.indice.primero;  exito:= false;
     while not exito and (aux/=null) loop
       exito:= (aux.dato.clave.ticker.nom(1..aux.dato.clave.ticker.long)
                =  clave.ticker.nom(1..clave.ticker.long)) and
               (aux.dato.clave.fecha=clave.fecha);
       if exito then posicion:= aux.dato.dirDato;
       else aux:= aux.sig;
       end if;
     end loop;
   end if;
 end buscar;


 procedure borrarClave(f: in out tpFIndexCotizaciones; clave: in tpClave) is
   aux, ant: pNodo;
   exito: boolean;
 begin
   aux:= f.indice.primero;
   if (aux=null) then exito:= false;
   else
     exito:= (aux.dato.clave.ticker.nom(1..aux.dato.clave.ticker.long)
                =  clave.ticker.nom(1..clave.ticker.long)) and
               (aux.dato.clave.fecha=clave.fecha);
     if exito then f.indice.primero:= aux.sig; disponer(aux);
     else ant:= aux; aux:= aux.sig; end if;
     while not exito and (aux/=null) loop
       exito:= (aux.dato.clave.ticker.nom(1..aux.dato.clave.ticker.long)
                =  clave.ticker.nom(1..clave.ticker.long)) and
               (aux.dato.clave.fecha=clave.fecha);
       if not exito then ant:= aux; aux:= aux.sig;
       else ant.sig:= aux.sig; disponer(aux); end if;
     end loop;
   end if;
 end borrarClave;



 procedure leerCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                          cot: out cotizacion; exito: out boolean) is
   pos: tpPosicion;
 begin
   buscar(f,clave,pos,exito);
   if exito then
     put("Se ha encontrado la clave"); new_Line;
     fdircot.leerCotizacion(f.fDir,pos,cot,exito);
     f.ultimaPos:= pos;
     if not exito then put("No se ha encontrado el dato"); new_Line; end if;
   else put("No se ha encontrado la clave"); new_Line;
   end if;
 end leerCotizacion;


 procedure escribirCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                              cot: in cotizacion) is
   indice: tpIndice;
   pos: tpPosicion;
   exito: boolean;
 begin
   -- Buscamos la cotización
   buscar(f,clave,pos,exito);
   if exito then -- Clave encontrada en posición pos
     -- Actualizamos la cotización
     fdircot.escribirCotizacion(f.fdir,pos,cot);
     f.ultimaPos:= pos;
     put("Cotizacion actualizada correctamente"); new_Line;
   else
     -- Añadimos la cotización al fichero directo de datos
     fdircot.nuevaPosicion(f.fdir,pos,exito);
     fdircot.escribirCotizacion(f.fdir,pos,cot);
     if exito then
       f.ultimaPos:= pos;
       indice.clave:= clave; indice.dirDato:= pos;
       -- Actualizamos el índice
       agregarClave(f,indice);
       put("Cotizacion escrita correctamente"); new_Line;
     else put("No se ha podido escribir la cotizacion"); new_Line;
     end if;
   end if;
 end escribirCotizacion;


 procedure eliminarCotizacion(f: in out tpFIndexCotizaciones; clave: in tpClave;
                              exito: out boolean) is
   pos: tpPosicion;
 begin
   buscar(f,clave,pos,exito);
   if exito then -- Clave encontrada en posición pos
     -- Eliminamos del fichero de datos la cotización
     eliminarPosicion(f.fdir,pos,exito);
     -- Actualizamos el índice
     borrarClave(f,clave);
     f.ultimaPos:= pos;
   else -- Clave no encontrada
     put("La clave no ha sido encontrada"); new_Line;
   end if;
 end eliminarCotizacion;


 procedure primeraClave(f: in out tpFIndexCotizaciones; clave: out tpClave;
                        exito: out boolean) is
 begin
   if (f.indice.primero/=null) then
     exito:= true;
     clave:= f.indice.primero.dato.clave;
     f.ultimaPos:= f.indice.primero.dato.dirDato;
   else exito:= false;
   end if;
 end primeraClave;


 procedure siguienteClave(f: in out tpFIndexCotizaciones; clave: out tpClave;
                          exito: out boolean) is
   aux: pNodo;
 begin
   aux:= f.indice.primero; exito:= false;
   if (aux=null) then exito:= false; end if;
   while (aux/=null) and not exito loop
     exito:= (aux.dato.dirDato=f.ultimaPos);
     if not exito then aux:= aux.sig;
     else
       if (aux.sig/=null) then
          clave:= aux.sig.dato.clave;
          f.ultimaPos:= aux.sig.dato.dirDato;
       else aux:= null; exito:= false;
       end if;
     end if;
   end loop;
 end siguienteClave;


 function creaClave (fecha: tpFecha; ticker: tpTicker) return tpClave is
   clave: tpClave;
 begin
   clave.fecha:= fecha; clave.ticker:= ticker;
   return clave;
 end creaClave;


 procedure escribirClave (f: in out tpFIndexCotizaciones; clave: in tpClave;
                          pos: in tpPosicion) is
   ind: tpIndice;
 begin
   ind.clave:= clave; ind.dirDato:= pos;
   write(f.fIndex,ind);
 end escribirClave;


 procedure generarIndice(f: in out tpFIndexCotizaciones) is
   cot: cotizacion;
   aux: pNodo;
 begin
   -- Recorremos toda la lista dinamica con el indice
   -- para generar el fichero de índice
   reset(f.fIndex,out_file);
   aux:= f.indice.primero;
   if (aux/=null) then
     write(f.fIndex,aux.dato);
     aux:= aux.sig;
     while (aux/=null) loop
       write(f.fIndex,aux.dato);
       aux:= aux.sig;
     end loop;
   end if;
 end generarIndice;


 procedure reestructurar(f: in out tpFIndexCotizaciones) is
   exito: boolean;
   g: fdircot.tpFDirCotizaciones;
   nombre: tpNomFich;
   pos, posAux: tpPosicion;
   cot: cotizacion;
 begin
   -- Creamos un fichero directo de cotizaciones auxiliar
   setPos(pos); setPos(posAux); fdircot.asociar(g,nombre);
   -- Copiamos en el fichero directo auxiliar g solo
   -- aquellas cotizaciones que tengan la marca de validas,
   -- es decir, que no hubieran sido borradas.
   fdircot.leerCotizacion(f.fDir,pos,cot,exito);
   incPos(pos);
   if exito then
     -- La cotizacion no habia sido borrada
     fdircot.escribirCotizacion(g,posAux,cot);
     incPos(posAux);
   end if;
   while not fdircot.finFichero(f.fDir) loop
     fdircot.leerCotizacion(f.fDir,pos,cot,exito);
     incPos(pos);
     if exito then
       -- La cotizacion no habia sido borrada
       fdircot.escribirCotizacion(g,posAux,cot);
       incPos(posAux);
     end if;
   end loop;
   borraFichDirecto(f.fDir); borrarIndice(f);
   reset(f.fIndex,out_file);
   nombre.nom:= f.nombre.nom;
   nombre.long:= f.nombre.long+4;
   nombre.nom(nombre.long-3..nombre.long):= ".dir";
   fdircot.asociar(f.fDir,nombre);
   -- Copiamos el fichero directo auxiliar sobre el original
   -- Ademas, vamos generando el fichero con el indice
   setPos(pos);
   fdircot.leerCotizacion(g,pos,cot,exito);
   fdircot.escribirCotizacion(f.fDir,pos,cot);
   escribirClave(f, creaClave(fecha(cot), ticker(cot)), pos);
   incPos(pos);
   while not fdircot.finFichero(g) loop
     fdircot.leerCotizacion(g,pos,cot,exito);
     fdircot.escribirCotizacion(f.fDir,pos,cot);
     escribirClave(f, creaClave(fecha(cot), ticker(cot)), pos);
     incPos(pos);
   end loop;
   -- Borramos el fichero auxiliar
   borraFichDirecto(g);
   fdircot.disociar(f.fDir);
   borrarIndice(f); -- Disponemos la memoria dinamica
   cerrarFichIndice(f);
   asociar(f,f.nombre);
 end reestructurar;


 procedure disociar(f: in out tpFIndexCotizaciones) is
 begin
   reestructurar(f);
   fdircot.disociar(f.fDir);
   borrarIndice(f); -- Disponemos la memoria dinamica
   cerrarFichIndice(f);
 end disociar;


 procedure mostrarClave(clave: in tpClave) is
   i: integer:=1;
 begin
   put("Ticker de la clave: ");
   while (clave.ticker.nom(i)/= character'val(126)) loop
     put(clave.ticker.nom(i));
     i:= i+1;
   end loop;
   new_Line;
   put("Fecha de la clave: ");
   fdircot.ponerFecha(clave.fecha); new_Line;
 end mostrarClave;


 procedure leerCotizacion2(f: in out tpFIndexCotizaciones; clave: in tpClave;
                          cot: out cotizacion; exito: out boolean) is
   pos: tpPosicion;
 begin
   buscar(f,clave,pos,exito);
   if exito then
     fdircot.leerCotizacion(f.fDir,pos,cot,exito);
     f.ultimaPos:= pos;
   end if;
 end leerCotizacion2;


 procedure primerElemtoIndice (f: in out tpFIndexCotizaciones;
                               cot: out cotizacion; exito: out boolean;
                               pos: out tpPosicion) is
   aux: pNodo;
 begin
   aux:= f.indice.primero;
   if aux/= null
     then leerCotizacion2 (f, aux.dato.clave, cot, exito);
     else exito:= false;
   end if;
   setPos(pos);
 end primerElemtoIndice;


 procedure siguienteElemtoIndice (f: in out tpFIndexCotizaciones;
                                  cot: out cotizacion; exito: out boolean;
                                  pos: in out tpPosicion) is

   desde, hasta: tpPosicion;
   aux: pNodo;
 begin
   setPos(desde); hasta:= pos;
   aux:= f.indice.primero;
   while desde < hasta loop
     aux:= aux.sig;
     incPos(desde);
   end loop;
   if aux.sig /= null
     then aux:= aux.sig;
          leerCotizacion2(f, aux.dato.clave, cot, exito);
     else exito:= false;
   end if;
   incPos(pos);
 end siguienteElemtoIndice;


 function finIndice (f: tpFIndexCotizaciones) return boolean is

   desde, hasta: tpPosicion;
   aux: pNodo;
 begin
   setPos(desde); hasta:= f.ultimaPos;
   aux:= f.indice.primero;
   while desde <= hasta loop
     aux:= aux.sig;
     incPos(desde);
   end loop;
   return (aux.sig = null);
 end finIndice;



end FINDEXCOT;
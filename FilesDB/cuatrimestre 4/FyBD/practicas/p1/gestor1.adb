-- Fichero: gestor1.adb
-- Tema: Programa que ofrece un menu y operaciones de alto nivel para
--       trabajar con los ficheros de cotizaciones.
-- Fecha de la última revisión: 15-5-07
-- Autores: Marcos Mainar Lalmolda. NIP: 550710
--          José Javier Colomer Vieitez. NIP: 550372
-- Versión: 1.0
-- Comentarios: Utiliza el modulo FCOTIZACIONES.
--------------------------------------------------------------------------
with ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES;
use ada.text_IO, ada.integer_text_IO, ada.float_text_IO, FCOTIZACIONES;

procedure gestor1 is


 procedure escribirMenu is
 -- Post: escribe por pantalla el menu inicial
 begin
   new_Line;
   put("                         MENU"); new_Line(2);
   put("1. Especificar/Cambiar fichero de cotizaciones"); new_line;
   put("2. Generar Fichero para Cliente"); new_line;
   put("3. Generar Fichero para un periodo"); new_line;
   put("4. Comprobar la cotizacion de un valor en una fecha dada"); new_line;
   put("5. Actualizar cotizacion"); new_Line;
   put("6. Insertar nueva cotizacion"); new_line;
   put("7. Salir"); new_line(2);
   put("Elige una opcion... ");
 end escribirMenu;


 procedure generarFichCliente(f,g: in out tpFCotizaciones; cod: in tpTicker;
                              nombre: in tpNomFich) is
   exito: boolean;
   cot: cotizacion;
 begin
   iniciarLectura(f);
   -- Creamos el fichero para el cliente
   asociar(g,nombre,tpAccF'last,exito);
   iniciarEscritura(g);
   siguienteCotizacionTicker(f,cod,exito);
   if not exito then put_line("No se ha encontrado el ticker");
   else put("Fichero generado correctamente"); new_Line;
   end if;
   while exito loop
     cotizacionVentana(f,cot);
     if exito then
       escribirCotizacionCliente(g,cot);
     end if;
     leerCotizacion(f,cot);
     if not finFichero(f) then siguienteCotizacionTicker(f,cod,exito);
     else exito:= false;
     end if;
   end loop;
   disociar(g);
 end generarFichCliente;


 procedure generarFichPeriodo(f,g: in out tpFCotizaciones; fecha1,fecha2:
                              in tpFecha; nombre: in tpNomFich) is
   exito: boolean;
   cot: cotizacion;
 begin
   iniciarLectura(f);
   asociar(g,nombre,tpAccF'last,exito);
   if exito then
     iniciarEscritura(g); exito:= false;
     -- Buscamos la fecha de comienzo del periodo
     while not exito and not finFichero(f) loop
       siguienteCotizacionFecha(f,exito);
       cotizacionVentana(f,cot);
       exito:= exito and (fechaSes(cot)=fecha1);
       if not exito then leerCotizacion(f,cot); end if;
     end loop;
     if finFichero(f) and not exito then
       put_line("No se ha podido encontrar la fecha de inicio del periodo");
     else
       if exito then
         escribirCotizacion(g,cot); exito:= false;
         while not exito and not finFichero(f) loop
           leerCotizacion(f,cot); cotizacionVentana(f,cot);
           exito:= not(fechaSes(cot)<fecha2);
           if exito and not finFichero(f) then
             escribirCotizacion(g,cot);
             exito:= false;
           end if;
         end loop;
       end if;
       put("Fichero generado correctamente"); new_Line;
     end if;
     disociar(g);
   else put("Ha ocurrido algun problema al asociar el fichero a generar");
        new_Line; put("Por favor, intentelo de nuevo"); new_Line;
   end if;
 end generarFichPeriodo;


 procedure comprobarCotizacion(f: in out tpFCotizaciones; fecha: in tpFecha;
                               cod: in tpTicker) is
   exito: boolean:= false;
   cot: cotizacion;
 begin
   iniciarLectura(f);
    -- Buscamos la cotizacion con fecha "fecha" y ticker "codigo"
    -- Primero buscaremos la fecha de la cotizacion y dentro
    -- de esa fecha el ticker concreto
   while not exito and not finFichero(f) loop
     siguienteCotizacionFecha(f,exito);
     cotizacionVentana(f,cot);
     exito:= exito and (fechaSes(cot)=fecha);
     if not exito then leerCotizacion(f,cot); end if;
   end loop;
   if not exito and finFichero(f) then
     put_line("La fecha introducida no existe");
   else -- Hemos encontrado la fecha
     -- Buscamos el ticker dentro de esa fecha
     exito:= (tick(cot).long=cod.long) and then
              (tick(cot).nom(1..tick(cot).long)=cod.nom(1..cod.long));
     if exito then
       mostrarCotizacion(cot);
     else
       siguienteCotizacionTicker(f,cod,exito);
       if exito then
         cotizacionVentana(f,cot);
         mostrarCotizacion(cot);
       else put("La cotizacion no se ha encontrado"); new_Line;
       end if;
     end if;
   end if;
 end comprobarCotizacion;


 procedure actualizarCotizacion(f: in out tpFCotizaciones; cot: in
                                                            cotizacion) is
   exito: boolean;
   aux: cotizacion;
   g: tpFCotizaciones; -- Fichero auxiliar para la copia
   pos, actual: integer;
   fichAux: tpNomFich;
 begin
   buscarCotizacion(f,fechaSes(cot),tick(cot),exito,pos);
   if exito then
     -- Hay que actualizar la cotizacion con los nuevos datos
     -- proporcionados por el usuario.
     -- Primero copiamos los datos del fichero original anteriores
     -- a la cotizacionen a actualizar en un fichero auxiliar
     asociar(g,fichAux,tpAccF'last,exito); iniciarEscritura(g);
     iniciarLectura(f); actual:=1;
     while actual<pos loop
       leerCotizacion(f,aux);
       actual:= actual+1;
       escribirCotizacion(g,aux);
     end loop;
     if (actual/=1) then
       -- Leemos la cotizacion a actualizar y la desechamos
       leerCotizacion(f,aux);
       -- Escribimos la nueva cotizacion actualizada
       escribirCotizacion(g,cot);
     else -- actual=1
       -- Escribimos la nueva cotizacion actualizada
       escribirCotizacion(g,cot);
       -- Leemos la cotizacion a actualizar y la desechamos
       leerCotizacion(f,aux);
     end if;
     -- Escribimos el resto de las cotizaciones del fichero
     while not finFichero(f) loop
       leerCotizacion(f,aux);
       escribirCotizacion(g,aux);
     end loop;
     iniciarLectura(g); iniciarEscritura(f);
     while not finFichero(g) loop
       leerCotizacion(g,aux);
       escribirCotizacion(f,aux);
     end loop;
     disociar(g);
     put_line("Cotizacion actualizada correctamente"); skip_Line;
   else
     put_line("El fichero no contiene datos para la cotizacion introducida");
     skip_Line;
   end if;
 end actualizarCotizacion;


 procedure insertarCotizacion(f: in out tpFCotizaciones; cot: in cotizacion) is
   exito: boolean:= false;
   aux: cotizacion;
   g: tpFCotizaciones; -- Fichero auxiliar para la copia
   pos: integer;
   fichAux: tpNomFich;
 begin
   buscarCotizacion(f,fechaSes(cot),tick(cot),exito,pos);
   if exito then
     put_line("El fichero ya contiene datos para la cotizacion");
     skip_Line;
   else
     asociar(g,fichAux,tpAccF'last,exito);
     iniciarEscritura(g); iniciarLectura(f);
     cotizacionVentana(f,aux);
     while (fechaSes(aux)>fechaSes(cot)) loop
       leerCotizacion(f,aux);
       escribirCotizacion(g,aux);
       cotizacionVentana(f,aux);
     end loop;
     -- Escribimos la nueva cotizacion a insertar
     escribirCotizacion(g,cot);
     -- Escribimos el resto de las cotizaciones del fichero
     while not finFichero(f) loop
       leerCotizacion(f,aux);
       escribirCotizacion(g,aux);
     end loop;
     iniciarLectura(g); iniciarEscritura(f);
     -- Copiamos el fichero auxiliar sobre el original
     while not finFichero(g) loop
       leerCotizacion(g,aux);
       escribirCotizacion(f,aux);
     end loop;
     disociar(g);
     put_line("Cotizacion insertada correctamente"); skip_Line;
   end if;
 end insertarCotizacion;


 procedure mostrarError is
 -- Post: Informa al usuario de que se ha producido un error
 --       al no haber especificado todavía un fichero de cotizaciones
 --       con el que trabajar.
 begin
   new_Line;
   put("Antes debe elegir un fichero de cotizaciones");
   new_Line;
 end mostrarError;


 procedure realizarOperacion(opcion: in natural; f: in out tpFCotizaciones;
                             asociado: in out boolean) is
 -- Post: Gestiona las acciones a realizar en función de la opción
 --       elegida en el menú principal.
   nombre: tpNomFich;
   cot: cotizacion;
   codigo: tpTicker;
   fecha1,fecha2: tpFecha;
   exito: boolean;
   g: tpFCotizaciones;
 begin
   case opcion is
     when 1 => if asociado then disociar(f); end if;
               put("Nombre del fichero de cotizaciones: ");
               get_line(nombre.nom, nombre.long);
               asociar(f,nombre,tpAccF'first,exito);
               if exito then
                 asociado:= true;
                 put("Se ha realizado correctamente la operacion");
                 new_Line;
               else
                 asociado:= false;
                 put("Se ha producido algun error. "); new_Line;
                 put("Vuelva a intentarlo de nuevo"); new_Line;
               end if;
     when 2 => if asociado then
                 put("Ticker del valor bursatil deseado: ");
                 get_line(codigo.nom,codigo.long);
                 codigo.long:= codigo.long+1;
                 codigo.nom(codigo.long):= character'val(126);
                 put("Nombre del fichero a crear: ");
                 get_line(nombre.nom,nombre.long);
                 generarFichCliente(f,g,codigo,nombre);
               else mostrarError;
               end if;
     when 3 => if asociado then
                 pideFecha(fecha1); pideFecha(fecha2);
                 put("Nombre del fichero a crear: ");
                 get_line(nombre.nom,nombre.long);
                 if (fecha1>fecha2) then
                   generarFichPeriodo(f,g,fecha1,fecha2,nombre);
                 else generarFichPeriodo(f,g,fecha2,fecha1,nombre);
                 end if;
               else mostrarError;
               end if;
     when 4 => if asociado then
                 pideFecha(fecha1);
                 put("Ticker del valor bursatil deseado: ");
                 get_line(codigo.nom,codigo.long);
                 codigo.long:= codigo.long+1;
                 codigo.nom(codigo.long):= character'val(126);
                 comprobarCotizacion(f,fecha1,codigo);
               else mostrarError;
               end if;
     when 5 => if asociado then
                 ObtenerCotizacion(cot);
                 actualizarCotizacion(f,cot);
               else mostrarError;
               end if;
     when 6 => if asociado then
                 ObtenerCotizacion(cot);
                 insertarCotizacion(f,cot);
               else mostrarError;
               end if;
     when others => put_line("La opcion introducida no es correcta");
   end case;
 end realizarOperacion;


 opcion: natural;
 f: tpFCotizaciones;
 correcto, asociado: boolean:= false;
 car: character;
begin
 while not correcto loop
   begin
     escribirMenu; get(opcion); skip_Line;
     correcto:= true;
   exception
     when DATA_ERROR =>
       put_line("La opcion introducida no es correcta");
       skip_line;
   end;
 end loop;

 while not (opcion=7) loop
   realizarOperacion(opcion,f,asociado);
   correcto:= false;
   while not correcto loop
     begin
       put("Pulsa enter para continuar...");
       get_immediate(car); new_Line(2);
       escribirMenu; get(opcion); skip_Line;
       correcto:= true;
     exception
       when DATA_ERROR =>
         put_line("La opcion introducida no es correcta");
         skip_line;
     end;
   end loop;
 end loop;
 if asociado then disociar(f); end if;
end gestor1;
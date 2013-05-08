-- AUTORES: Ismael Saad Garc�a. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: m�dulo de declaraci�n del TAD listaexitos
--           para la pr�ctica 4 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: nacionalidades.ads
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de nacionalidades.
with ustrings, ada.text_IO;
use ustrings, ada.text_IO;
package nacionalidades is

 type nacionalidad is record
   codigo: natural;
   descripcion: ustring;
 end record;
 
 subtype texto is ada.text_io.file_type;
 
 type listaNac is limited private;
 -- permite almcenar en memoria dinamica una lista de nacionalidades


--|
--| Resumen:
--|
--| El m�dulo 'nacionalidades' exporta el tipo abstracto de
--| datos listaNac
--|
--| La especificaci�n algebraica del TAD es la siguiente:
--|
--| espec nacionalidades
--|   usa booleanos, cadenas, enteros, listaexitos
--|   g�nero listaNac
--|   operaciones
--|            VAC�A:       -> listaNac                         { operaciones constructoras generadoras:
--|            A�ADIR:      listaNac natural cadena -> listaNac          VAC�A, A�ADIR      }
--|            ESTA:        listaNac natural -> booleano        { operaci�n observadora }
--|            BORRAR:      listaNac natural -> listaNac        { operaci�n constructora modificadora }
--|            MODIFICAR:   listaNac natural cadena -> listaNac { operaci�n constructora modificadora }
--|
--|   ecuaciones  ln: listaNac; n1,n2: natural; c1,c2: cadena; l: listaexitos
--|      ESTA(VAC�A,n1)= falso
--|      ESTA(A�ADIR(ln,n1,c1),n2)= (n1=n2) OR ESTA(ln,n2) 
--|      si ESTA(ln,n1) -> A�ADIR(ln,n1,c1)=ln
--|      n1/=n2 -> A�ADIR(A�ADIR(ln,n1,c1),n2,c2) = A�ADIR(A�ADIR(ln,n2,c2),n1,c1)
--|      BORRAR(VAC�A,n1) = VAC�A
--|      n1=n2 AND �EST�NACIONALIDAD(l,n1) -> BORRAR(A�ADIR(ln,n1,c1),n2,c2) = BORRAR(ln,n2,c2)
--|      n1/=n2 AND �EST�NACIONALIDAD(l,n2) -> BORRAR(A�ADIR(ln,n1,c1),n2,c2) = A�ADIR(BORRAR(ln,n2,c2),n1,c1)
--|      MODIFICAR(VACIA,n1,c1)= VAC�A
--|      n1=n2 -> MODIFICAR(A�ADIR(ln,n1,c1),n2,c2)= A�ADIR(ln,n2,c2)
--|      n1/=n2 -> MODIFICAR(A�ADIR(ln,n1,c1),n2,c2)= MODIFICAR(ln)
--|
--| fespec
--|
--| El m�dulo nacionalidades exporta el nombre del tipo y las operaciones
--| especificadas anteriormente.

 procedure cargarNacionalidades(ln: in out listaNac);
 -- Post: Carga la lista de nacionalidades ln desde un fichero de texto externo
 --       llamado "nacionalidades.txt"
 procedure agregarNacionalidad(ln: in out listaNac; n: in nacionalidad);
 -- Pre: ln=ln0
 -- Post: ln=A�ADIR(l0,n.codigo,n.descripcion)
 procedure modificarDescripcion(ln: in out listaNac; c: in natural; d: in ustring);
 -- Pre: ln=ln0
 -- Post: ln=MODIFICAR(ln0,c,d)
 procedure borrarNacionalidad(ln: in out listaNac; c: in natural);
 -- Pre: ln=ln0
 -- Post: si EST�(ln,c) entonces ln=BORRAR(ln0,c)
 --       sino ln=ln0
 procedure guardarNacionalidades(ln: in listaNac; f: in out texto);
 -- Post: Guarda en el fichero de texto f la lista de nacionalidades
 --       ln en su estado actual.
 procedure listarNacionalidades(ln: in listaNac);
 -- Post: Muestra por pantalla la lista de nacionalidades con su c�digo
 --       y su descripci�n asociada.
 function comprobarNacionalidad(ln: listaNac; n: natural) return boolean;
 -- Post: Devuelve cierto si y solo si existe una nacionalidad en la lista
 --       de nacionalidades ln cuyo c�digo de nacionalidad es "n".

private
 type unDato;
 type ptDato is access unDato;
 type unDato is record
                dato: nacionalidad;
                sig: ptDato;
              end record;
 type listaNac is new ptDato;
end nacionalidades;
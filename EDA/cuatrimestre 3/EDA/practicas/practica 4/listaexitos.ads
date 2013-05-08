-- AUTORES: Ismael Saad Garc�a. NIP: 547942
--          Marcos Mainar Lalmolda. NIP: 550710
-- PROYECTO: m�dulo de declaraci�n del TAD listaexitos
--           para la pr�ctica 4 del 06/07 de la
--           asignatura de Estructuras de Datos y Algoritmos
-- FICHERO: listaexitos.ads
-- DESCRIPCION: Este TAD sirve para guardar y gestionar una lista
--              de �xitos formada por canciones con un t�tulo, un
--              int�rprete, una fecha de grabaci�n y un n�mero de
--              ventas.
with fecha, ustrings, ada.text_IO;
use fecha, ustrings, ada.text_IO;
package listaexitos is

 subtype texto is ada.text_IO.file_type;

 type cancion is record
  titulo, interprete: ustring;
  tiempo: tpfecha;
  ventas: natural;
  nacionalidad: natural;
 end record;

 type lista is limited private;
 -- permite almacenar en memoria din�mica una lista de �xitos


--|
--| Resumen:
--|
--| El m�dulo 'listaexitos' exporta el tipo abstracto de
--| datos lista.
--|
--| La especificaci�n algebraica del TAD es la siguiente:
--|
--| espec listaexitos
--|   usa booleanos, cadenas, enteros, canci�n, fecha, nacionalidades
--|   g�nero lista
--|   operaciones
--|            VAC�A:       -> lista                  { operaciones constructoras generadoras:
--|            A�ADIR:      lista canci�n -> lista          VAC�A, A�ADIR      }
--|            BORRAR:      lista canci�n -> lista    { operaci�n constructora modificadora }
--|            SUPERACOTA:  lista ent -> booleano     { operaci�n observadora  }
--|            ACTUALIZADA: lista fecha -> lista      { operaci�n constructora modificadora }
--|            ESVAC�A?:    lista -> booleano         { operaci�n observadora }
--|            EST�:        lista canci�n -> booleano { operaci�n auxiliar observadora para INTERSECCI�N}
--|            UNI�N:       lista lista -> lista      { operaci�n constructora modificadora}
--|            INTERSECCI�N: lista lista -> lista     { operaci�n constructora modificadora}
--|            EST�NACIONALIDAD: lista natural -> booleano { operaci�n observadora}
--|
--|   ecuaciones c,c1,c2: canci�n; l: lista; f:fecha; cot: cota; ln: listaNac; n,n1,n2: natural
--|      (c1=c2) <-> (titulo(c1)=titulo(c2)) ^ (interprete(c1)=interprete(c2))
--|                 ^ (tiempo(c1)=tiempo(c2)) ^ (nacionalidad(c1)=nacionalidad(c2))
--|      c1/=c2 AND EST�(ln,nacionalidad(c1)) AND EST�(ln,nacionalidad(n2)) -> 
--|            A�ADIR(A�ADIR(l,c1),c2) = A�ADIR(A�ADIR(l,c2),c1)
--|      c1=c2  AND ESTA(ln,nacionalidad(c1)) -> A�ADIR(A�ADIR(l,c1),c2) = A�ADIR(l,c2)
--|      EST�NACIONALIDAD(VAC�A,n) = falso
--|      EST�NACIONALIDAD(A�ADIR(l,c),n)= (nacionalidad(c)=n) OR EST�NACIONALIDAD(l,n)
--|      BORRAR(VAC�A,c1) = VAC�A
--|      c1=c2 -> BORRAR(A�ADIR(l,c1),c2) = BORRAR(l,c2)
--|      c1/=c2 -> BORRAR(A�ADIR(l,c1),c2) = A�ADIR(BORRAR(l,c2),c1)
--|      ACTUALIZADA(VAC�A,f) = VAC�A
--|      fecha(c1)>f -> ACTUALIZADA(A�ADIR(l,c1),f) = A�ADIR(actualizada(l,f),c1)
--|      fecha(c1)<=f -> ACTUALIZADA(A�ADIR(l,c1),f) = ACTUALIZADA(l,f)
--|      SUPERACOTA(VAC�A,cot) = FALSO
--|      SUPERACOTA(A�ADIR(l,c1),cot) = (ventas(c1) > cot) OR (superacota(l,cot))
--|      ESVAC�A?(VAC�A) = CIERTO
--|      ESVAC�A?(A�ADIR(l,c1)) = FALSO
--|      EST�(VAC�A,c) = FALSO
--|      EST�(A�ADIR(l,c1),c2) = (c1=c2) OR (EST�(l,c2))
--|      UNI�N(l,VAC�A) = l
--|      UNI�N(l1,A�ADIR(l2,c)) = A�ADIR(UNI�N(l1,l2),c)
--|      INTERSECCI�N(l,VAC�A) = VAC�A
--|      INTERSECCI�N(l1,A�ADIR(l2,c)) = si EST�(c,l1)
--|                                        ent A�ADIR(INTERSECCI�N(l1,l2),c)
--|                                      sino INTERSECCI�N(l1,l2)
--|
--|
--| fespec
--|
--| El m�dulo listaexitos exporta el nombre del tipo, las operaciones
--| especificadas anteriormente y:
--|
--|  * una operaci�n de asignaci�n ('asignar'),
--|  * una operaci�n de liberaci�n de memoria din�mica ocupada
--|    por una lista ('liberar').
--|
--|
 procedure vacia(l:out lista);
 -- crea una lista de exitos vac�a
 procedure anyadir(l:in out lista; c:in cancion);
 -- modifica l de la siguiente forma: si ya hab�a una canci�n
 -- en l con el mismo int�rprete y t�tulo que c actualiza el
 -- n�mero de ventas, en otro caso a�ade c
 procedure borrar(l:in out lista; c:in cancion);
 -- modifica l eliminando la canci�n c si esta estaba en l
 function superacota(l:lista; cota:integer) return boolean;
 -- devuelve cierto si existe una canci�n en l con n�mero de
 -- ventas mayor que cota
 procedure actualizada(l:in lista; lact:out lista; f:in tpfecha);
 -- calcula lact una lista con las canciones de l que tienen
 -- fecha de grabaci�n posterior a f
 function esvacia(l:lista) return boolean;
 -- devuelve cierto si l est� vac�a
 procedure loscuarenta(l:in lista; lhits: out lista);
 -- Post: si l tiene menos de 40 canciones lhits=l, si no lhits
 -- es una lista con las 40 canciones de l que tienen mayor
 -- n�mero de ventas
 procedure asignar(lin: in lista; lout: out lista);
 -- Post: lout=lin, duplicando la representaci�n en memoria
 procedure liberar(l: in out lista);
 -- Post: l=VACIA y adem�s libera la memoria previamente utilizada por l
 procedure listado(l: in lista; c: in natural);
 -- lista en pantalla las canciones almacenadas en la lista de �xitos l
 procedure union(l1,l2: in lista; lout: out lista);
 -- Post: lout es la uni�n de las listas l1 y l2
 procedure interseccion(l1,l2: in lista; lout: out lista);
 -- Post: lout es la intersecci�n de las listas l1 y l2
 procedure grabacion(f: in out texto; l: in lista);
 -- Post: almacena en el fichero de texto externo "nacionalidades.txt" 
 -- la lista de �xitos l en su estado actual
 function estaNacionalidad(l: in lista; n: natural) return boolean;
 -- Post: Devuelve cierto si y solo si en l hay alguna canci�n cuyo
 -- c�digo de nacionalidad sea igual a n y falso en caso contrario.
private
 type unDato;
 type ptDato is access unDato;
 type unDato is record
                dato: cancion;
                sig: ptDato;
              end record;
 type lista is new ptDato;
end listaexitos;
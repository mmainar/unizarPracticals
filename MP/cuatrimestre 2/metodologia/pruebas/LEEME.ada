Cadenas de caracteres
=====================

En Ada hay varios tipos de cadenas de caracteres; presentamos aqui algunas
de ellas.

Cadenas de tamaño fijo:
-----------------------

<identificador>:string(1..<longitud>); -- El valor inicial no tiene porque ser
                                       -- 1, pero en general lo usaremos asi.
                                    
Declara la variable indicada como una cadena de caracteres de la longitud 
especificada.          

Ejemplo: 

cadena: string(1..20);    
cad:    string(1..5);

OPERADORES Y FUNCIONES:

:=        Ejemplos: s:="hola                ";  -- 20 caracteres
=, /=     Ejemplo: if s="hola                " then
<, >      Comparación lexicográfica (carácter a carácter, según el código 
          ASCII. Las dos cadenas deben tener la misma longitud)
          Ejemplos:
              "adios"<"hola " se evalúa a true ("hola "<"adios" es false)
              "casa    "<"casanova" se evalúa a true
              "CASA"<"casa" se evalúa a true
              "ZAPATO"<"avion " se evalúa a true
              "00000"<"casa " se evalúa a true
              "00000"<"CASA " se evalúa a true
              "1 "<"15" se evalúa a true
              "1  "<"015" se evalúa a FALSE

PROCEDIMIENTOS:

   procedure Move (Source  : in  String; 
                   Target  : out String; 
                   Drop    : in  Truncation := Error;
                   Justify : in  Alignment  := Left;
                   Pad     : in  Character  := Space);

Drop:    que hacer si no cabe. Posibilidades: Error, Left, Right
Justify: donde la pone?.       Posibilidades: Left, Right, Center 
Pad:     con que rellena.      Posibilidades: cualquier carácter.

Ejemplos: Move("Jose Luis", cadena);    -- "Jose Luis"
          Move(cadena,cad,Drop=>Right); -- "Jose "
          Move("CPS",cad,Drop=>Right,Pad=>'+'); -- "CPS++"

cad(indice) (Indexación de cadenas)
       Permite acceder a los caracteres que componen la cadena cad 
       comenzando en la posición 1 y acabando en la posición última según
       el tamaño con que se definió.
       Ejemplo:
                     c:char;
                     s:string(1..10);
                 begin
                   s:="hola      "; 
                   put(s(3));     -- escribe el caracter 'l' 
                   c:=s(1);       -- le asigna a c el caracter 'h' 
                   writeln(s(11)); -- da error en ejecución, 11>10 
                 end;
                 
       También se puede usar para asignar valores a caracteres específicos 
		 de una cadena.
       Ejemplo:
                 s:string(1..5);
                 begin
                   s:="000000"; 
                   s(3):='1';
                   s(5):='1'; 
                   put(s);     -- escribiria "001010"
                   s(1):="12"; -- da error al compilar. Debe ser un caracter

cad(indice1..indice2) (Trozos de cadenas -rebanadas-)
       Permite acceder a grupos de caracteres que componen la cadena cad 
       comenzando en la posición indice1 y acabando en la posición indice2
       Ejemplo:
                     s:string(1..10);
                 begin
                   s:="hola      "; 
                   put(s(1..3));     -- escribe 'hol' 
                 end;
                 
       La indexación también se puede usar para asignar valores a una cadena, 
       carácter a carácter.
       Ejemplo:
                 s:string(1..5);
                 begin
                   s:="000000"; 
                   s(3..5):="111";
                   put(s);     -- escribiria "001110"
                   s(4..6):="123"; -- da error al compilar. Debe ser un rango
                                   -- admisible.
                   s(4..5):="123"; -- da error al compilar. Deben ser del mismo
                                   -- tamaño.
                end;


Cadenas de tamaño variable (acotado):
-------------------------------------

with Ada.Strings.Bounded;
...
procedure .... is

package <identificador> is new Generic_Bounded_Length(<tam>);
...

define el tipo Bounded_String capaz de albergar cadenas de caracteres de como
máximo tam caracteres.

Ejemplo:
   package pCad20 is new Generic_Bounded_Length(20);
   use pCad20;

   laCad: Bounded_String;
   ...
   laCad:= To_Bounded_String("Jose Luis");

Concatenación: &

Ejemplo: laCad:= laCad & To_Bounded_String(" Perez");
         laCad:= Append(laCad, ' ' & "Pi");

Indexación de elementos:

function Element (Source : in Bounded_String;
                  Index  : in Positive) return Character;

Ejemplo:

put(Element(laCad, 3)); -- Escribira ´s´

Selección de trozos (rebanadas):

function Slice (Source : in Bounded_String;
                Low    : in Positive;
                High   : in Natural) return String;

Ejemplo:

cad(2..4):= Slice(laCad,2,4); -- Notar que la primera era de tamaño fijo.

Otras interesantes con relación a las anteriores:

procedure Replace_Element (Source : in out Bounded_String;
                           Index  : in Positive;
                           By     : in Character);
procedure Replace_Slice (Source   : in out Bounded_String;
                         Low      : in Positive;
                         High     : in Natural;
                         By       : in String;
                         Drop     : in Truncation := Error);

Ejemplos:

Replace_Element(laCad,1,'R');     -- Rose Luis Perez Pi
Replace_Slice(laCad,1,4,"Pepe");  -- Pepe Luis Perez Pi

Operadores relacionales
=, /=, <, <=, >, >= 
La diferencia es que las longitudes de las cadenas no tienen porque
coincidir.

Longitud de la cadena (recordar que no necesariamente alcanzamos el tope)

subtype Length_Range is Natural range 0 .. Max_Length;
function Length (Source : in Bounded_String) return Length_Range;

Dado una cadena devuelve el numero de caracteres que almacena.
La longitud indicada en la declaración es el numero máximo de caracteres 
que podemos almacenar en la cadena; esta función devuelve cuántos hay realmente
ocupados.

Ejemplo:

put(Length(laCad));

Lectura y escritura de ficheros de texto
========================================

Caracteres:
-----------

Para leer y escribir caracteres de ficheros de texto los procedimientos
adecuados se encuentran en Ada.Text_IO.

    procedure Get(File : in File_Type; Item : out Character);
    procedure Get(Item : out Character); 
    procedure Put(File : in File_Type; Item : in Character);
    procedure Put(Item : in Character);

Además, es bastante útil poder leer un carácter sin necesidad de avanzar
en el fichero, para lo que Ada95 proporciona los siguientes procedimientos.
    procedure Look_Ahead (File        : in  File_Type; 
                          Item        : out Character;           
                          End_Of_Line : out Boolean);
    procedure Look_Ahead (Item        : out Character;
                         End_Of_Line : out Boolean);

Números:
--------

Para leer y escribir números (enteros y reales) en ficheros de texto, los
procedimientos adecuados son también get y put, pero para estos tipos  las
bibliotecas son Ada.Integer_Text_IO y Ada.Float_Text_IO, respectivamente 
(también existen bibliotecas genéricas, utilizadas para tipos derivados de 
éstos. Se llaman: Integer_IO y Float_IO). Los procedimientos y funciones
de interés son:

De Ada.Integer_Text_IO:

   procedure Get(File : in File_Type; Item : out Num; Width : in Field := 0); 
   procedure Get(Item : out Num; Width : in Field := 0);     
   procedure Put(File  : in File_Type;
                 Item  : in Num;
                 Width : in Field := Default_Width;            
                 Base  : in Number_Base := Default_Base);            
   procedure Put(Item  : in Num;
                 Width : in Field := Default_Width;                
                 Base  : in Number_Base := Default_Base);

Y además pueden ser de utilidad los siguientes, que en lugar de interaccionar
con un fichero de texto, lo hacen con una cadena de caracteres.

   procedure Get(From : in String; Item : out Num; Last : out Positive);
   procedure Put(To   : out String;
                 Item : in Num;
                 Base : in Number_Base := Default_Base);

De Ada.Float_Text_IO:

   procedure Get(File : in File_Type; Item : out Num; Width : in Field := 0);          
   procedure Get(Item : out Num; Width : in Field := 0);
   procedure Put(File : in File_Type;
                 Item : in Num;
                 Fore : in Field := Default_Fore;
                 Aft  : in Field := Default_Aft;               
                 Exp  : in Field := Default_Exp);
   procedure Put(Item : in Num;          
                 Fore : in Field := Default_Fore;
                 Aft  : in Field := Default_Aft;
                 Exp  : in Field := Default_Exp);

Y además pueden ser de utilidad los siguientes, que en lugar de interaccionar
con un fichero de texto, lo hacen con una cadena de caracteres.

   procedure Get(From : in String; Item : out Num; Last : out Positive);
   procedure Put(To   : out String;           
                 Item : in Num;
                 Aft  : in Field := Default_Aft;
                 Exp  : in Field := Default_Exp);


Cadenas de caracteres:
----------------------

Cuando lo que queremos es leer cadenas de caracteres, los procedimientos de
lectura y escritura están en Ada.Text_IO si se trata de cadenas de 
caracteres de tamaño fijo.

   procedure Get(File : in File_Type; Item : out String);
   procedure Get(Item : out String);
   procedure Put(File : in File_Type; Item : in String);         
   procedure Put(Item : in String);
   procedure Get_Line(File : in File_Type; 
                      Item : out String; 
                      Last : out Natural);
   procedure Get_Line(Item : out String;   Last : out Natural);
   procedure Put_Line(File : in File_Type; Item : in String);  
   procedure Put_Line(Item : in String);

pero cuando se trata de cadenas de tamaño acotado 
(Bounded_string) entonces la utilización de procedimientos  para la lectura y
escritura precisa de la utilización de una biblioteca no estándar en Ada95.
La biblioteca se llama BStrings y podéis encontrar los ficheros fuente que
contienen los procedimientos y funciones en:
/users2/PROGRAMACION/salidas/LIBS
o en:
/users2/MP/salidas/LIBS
Tambien, a través de la siguiente página web:
http://www.cps.unizar.es/~ftricas/Asignaturas/ip/practicas.html
En el fichero Strings.ads hay un ejemplo de cómo utilizarla en vuestros
programas.

   procedure Get_Line(File : in File_Type; Item : out Bounded_String);
   procedure Get_Line(Item : out Bounded_String);
   procedure Put(File : in File_Type; Item : in Bounded_String);
   procedure Put(Item : in Bounded_String);
   procedure Put_Line(File : in File_Type; Item : in Bounded_String);
   procedure Put_Line(Item : in Bounded_String);


Una posible forma de leer un fichero de texto es usar cadenas de caracteres 
para leerlo por líneas y procesarlas de la manera que sea necesaria. 
Veamos como quedaría un programa que leyera el contenido de un fichero que 
se llama "datos.txt" y lo escribiera en la pantalla:


-- Leyendo caracter a caracter.

with Ada.Text_IO;
use  Ada.Text_IO;

procedure leerLineas is
   f:File_type;
   c:character;

begin
  open(f,In_File,"datos.txt");
  while not(End_Of_File(f)) loop
     while not (End_Of_Line(f)) loop
        get(f,c);
        put(c);
     end loop;
     if (not End_Of_File(f)) then
        skip_line(f); -- Hace falta pasar a la línea siguiente
     end if;
     new_line;
  end loop;
  close(f);
end leerLineas;


-- Leyendo por lineas, utilizando cadenas de tamaño fijo.

with Ada.Text_IO;
use  Ada.Text_IO;

procedure leerLineas is
   f:File_type;
   cad:string(1..500);
   tam:integer range 0..500; -- Empieza en 0. La cadena puede estar vacía.
                             -- Es un error frecuente olvidar esto.

begin
  open(f,In_File,"datos.txt");
  while not(End_Of_File(f)) loop
      get_line(f,cad,tam);
      put(cad(1..tam));
  end loop;
  close(f);
end leerLineas;

-- Leyendo por lineas, utilizando cadenas de tamaño acotado.


with Ada.Text_IO, Ada.Strings.Bounded, BStrings;
use  Ada.Text_IO;

procedure leerLineas is
   -- Declaramos el tamaño de las cadenas que vamos a utilizar.
   package pCad500 is new Ada.Strings.Bounded.Generic_Bounded_Length(500);
   use pCad500; 
   -- Biblioteca de entrada/salida para las cadenas 
   -- que vamos a utilizar.
   package pCad500_Text_IO is new BStrings(pCad500);
   use pCad500_Text_IO;
   f:File_type;
   cad: Bounded_String;

begin
  open(f,In_File,"datos.txt");
  while not(End_Of_File(f)) loop
      get_line(f,cad); -- Notese que a cambio de escribir una seccion de 
                       -- declaraciones mas cargada, no hay que ocuparse
                       -- de la gestión del tamaño de la cadena.
      put_line(cad);
  end loop;
  close(f);
end leerLineas;

Muy importante: 1) usar get_line y no get. Con get nunca pasaría a la siguiente
                   línea. Habría que usar un skip_line para cambiar de línea.
                2) asegurarse que la longitud de la cadena es mayor que la de
                   la línea mas larga. Si no, de cada línea solo leería tantos
                   caracteres como su longitud máxima.
                3) get_line, en contra de lo que pueda parecer por su nombre
                   y comportamiento con otros tipos de datos, no salta de 
                   línea (ignorando el resto) si la cadena no es suficientemente
                   larga. En la siguiente iteración leería de la línea que
                   no ha completado el resto (o lo que fuera capaz).
                   

Tipos definidos por enumeración
-------------------------------

Para leer y escribir datos de tipos definidos por enumeración en ficheros de 
texto los procedimientos adecuados se encuentran en la biblioteca genérica 
Ada.Enumeration_IO. Esto significa que para utilizar esa biblioteca con un
tipo que hayamos definido, debermos instanciarla para dicho tipo.

with ada.text_io, Ada.Enumeration_IO;
use  ada.text_io;

procedure escribeEnumerados is

	type tpEnumerado is (...);
	
	package tpEnumerado_IO is new Ada.Text_IO.Enumeration_IO(tpEnumerado);
	use tpEnumerado_IO;
	
	(...)
	
	datoEnumerado: tpEnumerado;
	
	(...)
	
begin
	(...)
	get(datoEnumerado); -- También: tpEnumerado_IO.get(datoEnumerado);
	(...)
	put(datoEnumerado);	-- También: tpEnumerado_IO.put(datoEnumerado);
	(...)
end escribeEnumerados;

Algunos procedimientos y funciones de esta biblioteca:

Los valores se escriben en mayúsculas o en minúsculas. 
Esto se especifica con el parámetro Set que es del tipo definido por 
enumeración en la propia biblioteca Type_Set:

	type Type_Set is (Lower_Case, Upper_Case);

El formato puede especificarse con un parámetro opcional de anchura que se llama
Width. 

Los valores por defecto de estos parámetros se definen mediante las variables
	
	Default_Width   : Field := 0;
	Default_Setting : Type_Set := Upper_Case;

que están definidas en la biblioteca genérica.

Los procedimientos son:
	procedure Get(File : in File_Type; Item : out Enum);
	procedure Get(Item : out Enum);
	procedure Put(File  : in File_Type;
					Item  : in Enum;
					Width : in Field := Default_Width;
					Set   : in Type_Set := Default_Setting);
	procedure Put(Item  : in Enum;
					Width : in Field := Default_Width;
					Set   : in Type_Set := Default_Setting);

	
Matemáticas en Ada
==================

En algunos programas se utilizan con frecuencia funciones como la raíz 
cuadrada, el seno, el coseno y otras. En Ada estas funciones están disponibles
a través de la biblioteca Ada.Numerics.Elementary_Functions. Algunas de las 
funciones disponibles en esa biblioteca son:

function Sqrt    (X           : Float_Type'Base)        return Float_Type'Base
function Log     (X           : Float_Type'Base)        return Float_Type'Base;
function Log     (X, Base     : Float_Type'Base)        return Float_Type'Base;
function Exp     (X           : Float_Type'Base)        return Float_Type'Base;
function Sin     (X           : Float_Type'Base)        return Float_Type'Base;
function Cos     (X           : Float_Type'Base)        return Float_Type'Base;
function Tan     (X           : Float_Type'Base)        return Float_Type'Base;
function Cot     (X           : Float_Type'Base)        return Float_Type'Base;
function Arcsin  (X           : Float_Type'Base)        return Float_Type'Base;
function Arccos  (X           : Float_Type'Base)        return Float_Type'Base;
function Arctan  (Y           : Float_Type'Base;        
                  X           : Float_Type'Base := 1.0) return Float_Type'Base;
function Arccot  (X           : Float_Type'Base;        
                  Y           : Float_Type'Base := 1.0) return Float_Type'Base;

Ejemplo: 
(extraído y adaptado de "Ada 95. Problem Solving and Design. Feldman &
Koffman. Addison Wesley. segundo Edition.)

------------------------------------------------------------------
with Ada.Text_IO, 
     Ada.Float_Text_IO, 
     Ada.Numerics.Elementary_Functions;
use  Ada.Text_IO, 
     Ada.Float_Text_IO, 
     Ada.Numerics.Elementary_Functions;

PROCEDURE raizCuadrada IS
------------------------------------------------------------------
--| Muestra el uso de la funcion raiz cuadrada proporcionada
--| mediante el paquete de funciones matematicas de Ada.
--| Author: Michael B. Feldman, George Washington University 
--| Modificado por: Area de Lenguajes y Sistemas Informaticos.
--| Last Modified: Noviembre 1998                                     
------------------------------------------------------------------

  SUBTYPE tpRealNoNeg IS Float RANGE 0.0 .. Float'Last;

  primero :  tpRealNoNeg;
  segundo:   tpRealNoNeg;
  respuesta: tpRealNoNeg;

BEGIN  -- raizCuadrada   

  Put ("Por favor introduzca el primer numero > ");
  Get(primero);
  respuesta := Sqrt(primero);
  Put ("La raiz cuadrada del primer numero es ");
  Put (Item => respuesta, Fore => 1, Aft => 5, Exp => 0);
  New_Line;

  Put ("Por favor introduzca el segundo numero > ");
  Get(segundo);
  Put ("La raiz cuadrada del segundo numero es ");
  Put (Sqrt (segundo), Fore => 1, Aft => 5, Exp => 0);
  New_Line;

  respuesta := Sqrt(primero + segundo);
  Put ("La raiz cuadrada de la suma de los numeros es ");
  Put (Item => respuesta, Fore => 1, Aft => 5, Exp => 0);
  New_Line;

END raizCuadrada;
------------------------------------------------------------------

Números aleatorios en Ada
=========================

En algunos programas puede ser interesante disponer de números aleatorios o,
al menos, pseudoaleatorios. En Ada hay generadores de números aleatorios 
en la biblioteca Ada.Numerics. En particular, disponemos de bibliotecas 
genéricas para dar cuenta de estas necesidades. Una ellas se denomina 
Ada.Numerics.Discrete_Random y puede utilizarse con cualquier tipo o subtipo 
de los enteros o de tipos definidos por enumeración, de manera que la 
instancia resultante podrá utilizarse para generar valores pseudoaleatorios 
en el rango del tipo o subtipo.

Ejemplo 1:

subtype tpPrimerosCincuenta is integer range 1..50;
package pRandom50 is new Ada.Numerics.Discrete_Random(tpPrimerosCincuenta);
use pRandom50;

g: Generator; -- esta variable es curiosa ... se puede pasar como argumento
              -- a Random, pero no se puede modificar.
-- o tambien:
-- g: pRandom50.Generator;

...

numero := Random(g);
-- o tambien:
-- numero := pRandom50.Random(g);

Ejemplo 2:
(sacado y adaptado del mismo sitio del anterior)

------------------------------------------------------------------
with Ada.Text_IO,
     Ada.Integer_Text_IO,
     Ada.Numerics.Discrete_Random;
use  Ada.Text_IO,
     Ada.Integer_Text_IO;

PROCEDURE numerosAleatorios IS
------------------------------------------------------------------
--| Genera 120 enteros aleatorios entre 1 y 50
--| Utiliza el generador de numeros aleatorios de  Ada.Numerics
--| Author: Michael B. Feldman, The George Washington University
--| Modificado: Area de Lenguajes y Sistemas Informaticos
--| Last Modified: Noviembre 1998
------------------------------------------------------------------

  SUBTYPE tpRangoAleatorio IS Positive RANGE 1..50;

  PACKAGE Random_50 IS NEW Ada.Numerics.Discrete_Random(tpRangoAleatorio);

  g: Random_50.Generator;     -- Sigue siendo igual de curioso que antes

  fila, numero: integer;

BEGIN -- numerosAleatorios

  Random_50.Reset(g);  --  Inicializa g a partir del tiempo del reloj.

  fila:= 1; numero:= 1;

  while fila <= 10 LOOP        -- mostrara 10 filas de 12 numeros
    while numero <= 12 LOOP
      Put(Item => Random_50.Random(g), Width => 4);
      numero:= numero + 1;
    end loop;
    New_Line;
    numero:= 1; fila:= fila + 1;
  end loop;

END numerosAleatorios;
------------------------------------------------------------------


Cómo borrar la pantalla en Ada? Cómo escribir en una determinada posición?
==========================================================================

Para esto está disponible la biblioteca screen. No es estándar. Puede 
encontrarse en:
/users2/PROGRAMACION/salidas/LIBS
o a través de la página web de la asignatura:
http://www.cps.unizar.es/~ftricas/ip/Home.html

En esta biblioteca hay los siguientes procedimientos:

procedure Clear_Screen;
procedure Move_Cursor (Row, Column : in Integer);

La primera borra la pantalla, la segunda lleva el cursor a la posición 
representada por los valores de Row y Column (fila y columna, 
respectivamente)

Ejemplo: 

------------------------------------------------------------------
with Ada.Text_IO,
     screen;
use  Ada.Text_IO,
     screen;
     
procedure Smiley is
------------------------------------------------------------------
--|                                                              
--| Dibuja una "cara sonriente" en el centro de la pantalla
--|                                                              
--| Author: Michael B. Feldman, The George Washington University 
--| Modified: Area de Lenguajes y Sistemas Informaticos
--| Last Modified: Noviembre 1998                                     
--|                                                              
------------------------------------------------------------------

BEGIN -- Smiley

  Clear_Screen;
  Move_Cursor (Row => 7, Column => 34);
  Put (Item =>    "Hola!  Buen dia!");
  Move_Cursor (Row => 9, Column => 39);
  Put (Item =>     "_____");
  Move_Cursor (Row => 10, Column => 37);
  Put (Item =>   "/       \");
  Move_Cursor (Row => 11, Column => 36);
  Put (Item =>  "/         \");
  Move_Cursor (Row => 12, Column => 35);
  Put (Item => "|           |");
  Move_Cursor (Row => 13, Column => 35);
  Put (Item => "|   O   O   |");
  Move_Cursor (Row => 14, Column => 36);
  Put (Item =>  "\    o    /");
  Move_Cursor (Row => 15, Column => 37);
  Put (Item =>   "\ \___/ /");
  Move_Cursor (Row => 16, Column => 38);
  Put (Item =>    "\     /");   
  Move_Cursor (Row => 17, Column => 39);
  Put (Item =>     "-----");
  Move_Cursor (Row => 24, Column => 1);

END Smiley;
                 
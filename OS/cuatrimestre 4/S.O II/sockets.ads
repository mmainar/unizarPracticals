with gnat.Sockets;
use gnat.Sockets;

package sockets is


  --                           COMUNICACION A TRAVES DE SOCKETS
  --
  -- El proceso logico de una comunicacion a traves de sockets es el siguiente:
  -- 1º: El servidor tiene que crear una conexion mediante la funcion crearConexion.
  --     A esta funcion hay que especificarle un puerto (el cual tiene que ser mayor
  --     que 1024 y un numero maximo de clientes, el que se deseee.
  --     La funcion devolvera un identificador de conexion que nos servira para aceptar
  --     conexiones posteriormente.
  --
  -- 2º: Disposicion del servidor a aceptar una conexion.  El servidor tiene que llamar
  --     al procedimiento aceptarConexion pasandole como parametro el identificador de
  --     conexion que le ha devuelto la llamada crearConexion. Tras la llamada, el servidor
  --     se bloqueara hasta que haya algun cliente que quiera conectarse. Cuando se establece
  --     la conexion, se devuelve un enlace que sirve tanto para el envio como para la
  --     recepcion de mensajes.
  --
  -- 3º: Peticion del cliente para la conexion. El cliente tiene que llamar a la funcion
  --     conectarConServidor especificando el puerto y la direccion IP para la conexion.
  --     Esta funcion devuelve un enlace para el envio y recepcion de mensajes.
  --
  -- 4º: Comunicacion entre los procesos. Una vez se han realizado los pasos anteriores,
  --     se tiene que iniciar el envio de mensajes entre los procesos. Para ello se 
  --     proporcionan una serie de procedimientos para el envio tanto de cadenas de caracteres
  --     como para enteros. La comunicacion ha de hacerse de forma adecuada pues de lo
  --     contrario se puede dar lugar a bloqueos.
  --
  --
  --     Ejemplo de comunicacion:
  --
  -- Proceso servidor:
  --
  --
  -- with sockets, ada.Text_IO, ada.Integer_Text_IO;
  -- use sockets, ada.Text_IO, ada.Integer_Text_IO;
  --
  -- procedure servidorPrueba is
  --   con: conexion;
  --   en: enlace;
  --   buf: buffer;
  --   int: integer;
  -- begin
  --   con := crearConexion(2000,5);
  --   en := aceptarConexion(c);
  --   leerMensajeString(en,buf); -- Llamada bloqueante
  --   for i in 1..buf.long loop
  --     put(buf.t(i));
  --   end loop;
  --   new_line;
  --   leerMensajeInteger(en,int); -- Llamada bloqueante
  --   put(int,0);
  -- end servidorPrueba;
  --
  --
  -- with sockets, ada.Text_IO;
  -- use sockets, ada.Text_IO;
  --
  -- procedure clientePrueba is
  --   en: enlace;
  --   buf: buffer;
  -- begin
  --   en := conectarConServidor(2000,"10.49.85.203");  
  --   put("Mensaje a enviar: "); get_line(buf.t,buf.long);
  --   enviarMensajeString(en,buf);
  --   enviarMensajeInteger(en,23);
  --   end clientePrueba;
  --
  --
  -- Notese que cuando se ejecutan las llamadas bloqueantes, se sabe de antemano que hay o va a haber un dato.
  -- disponible ya que conocemos el proceso cliente.
  -- 
  -- Para una comunicacion local puede obtener su IP local ejecutando el comando ipconfig en el simbolo del sistema.
  --
  -- Para el envio de string debera utilizar la estructura de datos de buffer que le proporciona esta libreria.
  


type conexion is private;
type enlace is private;
type buffer is record
    t: string(1..512);
    long: integer;
end record;


  function crearConexion (puerto: integer; maxClientes: integer) return conexion;
  --
  -- Un servidor crea una conexion con el puerto especificado
  -- y con un numero maximo de clientes dado.
  --



  function aceptarConexion (con: conexion) return enlace;
  --
  -- El servidor acepta una conexion (si la hay) y devuelve el 
  -- enlace para la comunicacion. Si no hay ninguna conexion se 
  -- bloqueara
  --


  function conectarConServidor (puerto: integer; ip: string) return enlace;
  --                             
  -- Establece una conexion desde el cliente al servidor.
  -- Ip es la direccion Ip del servidor.
  -- longIp es la longitud del string Ip.
  --
  procedure enviarMensajeString (e: enlace; buf: buffer);
  --
  -- Envia una cadena de caracteres de longitud maxima 512
  --
  
  procedure leerMensajeString (e: enlace; buf: out buffer);
  --
  -- Lee una cadena de caracteres de longitud maxima 512
  --  
  
  procedure enviarMensajeInteger (e: enlace; num: integer);
  --
  -- Envia un dato de tipo entero por el enlace
  --
  
  procedure leerMensajeInteger (e: enlace; num: out integer);
  --
  -- Lee un dato de tipo entero del enlace
  --  

private
  
  type conexion is new socket_type;
  type enlace is new socket_type;

end sockets;

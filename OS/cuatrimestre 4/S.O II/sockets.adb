with ada.Text_IO, ada.Integer_Text_IO, gnat.Sockets, ada.Streams, ada.Strings;
use ada.Text_IO, ada.Integer_Text_IO, gnat.Sockets, ada.Streams, ada.Strings;

package body sockets is


  function crearConexion (puerto: integer; maxClientes: integer) return conexion is
  --
  -- Un servidor crea una conexion con el puerto especificado
  -- y con un numero maximo de clientes dado.
  --
    sock: conexion;
    datosConexion: sock_addr_type;
  begin
    initialize;
    create_socket(sock,Family_Inet,Socket_Stream);
    datosConexion.port:= port_type(puerto);
    datosConexion.addr:= any_inet_addr; -- Busca su propia direccion IP 
    set_socket_option(sock,socket_level,(reuse_address,true));
    bind_socket(sock,datosConexion);
    listen_socket(sock,maxClientes); -- numero maximo de clientes
    return sock;
  end crearConexion;


  function aceptarConexion (con: conexion) return enlace is
  --
  -- El servidor acepta una conexion (si la hay) y devuelve el 
  -- enlace para la comunicacion. Si no hay ninguna conexion se 
  -- bloqueara
  --
    datosCliente: sock_addr_type;
    sock2: enlace;
  begin
    accept_socket(socket_type(con),socket_type(sock2),datosCliente);
    new_line;
    put("Conexion establecida con: "); put_line(image(datosCliente.addr));
    put("Conexion establecida en el puerto: ");
    put(integer(datosCliente.port),0);
    new_line;
    return sock2;
  end aceptarConexion;


  function conectarConServidor (puerto: integer; ip: string) return enlace is
  --                             
  -- Establece una conexion desde el cliente al servidor.
  -- Ip es la direccion Ip del servidor.
  -- longIp es la longitud del string Ip.
  --
    datosConexion: sock_addr_type;                           
    sock: enlace;
  begin
      initialize;
      create_socket(sock,family_inet,socket_stream);  
      datosConexion.port:= port_type(puerto);
      datosConexion.addr:=inet_addr(ip);
      put("Intentando conectar con: "); put_line(image(datosConexion.addr));
      put("En el puerto: "); put(integer(datosConexion.port),0);
      set_socket_option(sock,socket_level,(reuse_address,true));
      connect_socket(sock,datosConexion);
    return sock;
  end conectarConServidor;
  

  procedure enviarMensajeString (e: enlace; buf: buffer) is
  -- 
  -- Envia una cadena de caracteres mediante un buffer
  -- de capacidad 512
  --
    canal: stream_access;
  begin
    canal := stream(e);
    natural'write(canal,buf.long);
    for i in 1..buf.long loop
      character'write(canal,buf.t(i));
    end loop;
  end enviarMensajeString;
  

  procedure leerMensajeString (e: enlace; buf: out buffer) is
  -- 
  -- Recibe una cadena de caracteres mediante un buffer
  -- de capacidad 512
    canal: stream_access;
  begin
    canal:= stream(e);
    natural'read(canal,buf.long);
    if buf.long>512 then
      put("Error, la longitud del mensaje es mayor de la permitida");
      new_line;
    else
      for i in 1..buf.long loop
        character'read(canal,buf.t(i));
      end loop;
    end if;
  end leerMensajeString;
  

  procedure enviarMensajeInteger (e: enlace; num: integer) is
  --
  -- Envia un dato de tipo entero
  --
    canal: stream_access;
  begin
    canal := stream(e);
    integer'write(canal,num);
  end enviarMensajeInteger;
   

  procedure leerMensajeInteger (e: enlace; num: out integer) is
  --
  -- Lee un dato de tipo entero
  --
    canal: stream_access;
  begin
    canal:= stream(e);
    integer'read(canal,num);
  end leerMensajeInteger;
  

end sockets;




                              
                                                                                          
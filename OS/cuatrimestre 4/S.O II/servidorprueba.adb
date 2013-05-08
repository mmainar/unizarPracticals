with sockets, ada.Text_IO, ada.Integer_Text_IO;
use sockets, ada.Text_IO, ada.Integer_Text_IO;

procedure servidorPrueba is
  con: conexion;
  en: enlace;
  buf: buffer;
  int: integer;
begin
  con := crearConexion(21,5);
  en := aceptarConexion(con);
  leerMensajeString(en,buf);
  for i in 1..buf.long loop
    put(buf.t(i));
  end loop;
  new_line;
  while(1=1) loop
    leerMensajeInteger(en,int);
    put(int,0);
  end loop;
end servidorPrueba;
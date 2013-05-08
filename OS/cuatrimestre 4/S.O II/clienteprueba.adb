with sockets, ada.Text_IO, ada.Integer_Text_IO;
use sockets, ada.Text_IO, ada.Integer_Text_IO;

procedure clientePrueba is

  en: enlace;
  buf: buffer;
  num: integer;
  cadena: constant string:= "88.23.206.209";
begin
  en := conectarConServidor(80,cadena);  new_line;
  put("Mensaje a enviar: "); get_line(buf.t,buf.long); 
  enviarMensajeString(en,buf);
  get(num);
  while not(num=0) loop
    enviarMensajeInteger(en,num);
    get(num);
  end loop;
end clientePrueba;
import java.rmi.*;
import java.net.InetAddress;

public class Servidor {
	

	public static void main (String [] args) throws Exception {		
								
		//Instanciar clase remota
		//...
		String puerto = args[0];
		String nombreObjRemoto = args[1];
		Remote objRemoto = new ClaseRemota(); // Instanciamos el objeto remoto
		InetAddress address = InetAddress.getLocalHost();
		String host = address.getHostAddress();
		String name = "//" + host + ":" + puerto + "/" + nombreObjRemoto;
		
		//Mostrar informacion del servidor (dirección, puerto y nombre
		//del objecto remoto).
		System.out.println(host + " " + puerto + " " + nombreObjRemoto);
		
		
		//Registrar el objeto en el registro de RMI
		java.rmi.Naming.rebind(name, objRemoto);

	}
}

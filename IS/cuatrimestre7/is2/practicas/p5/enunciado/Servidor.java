
import java.rmi.*;
import java.net.InetAddress;

public class Servidor {

	public static void main (String [] args) throws Exception {		
								
		//Instanciar clase remota
		//...
		String puerto = args[0];
		String nombreObjRemoto = args[1];
		Remote objRemoto = new ClaseRemota(); // Instanciamos el objeto remoto
		String host = InetAddress.class.getCanonicalName();
		String name = "//" + host + ":" + puerto + "/" + nombreObjRemoto;
		java.rmi.Naming.rebind(name, objRemoto);
		
		//Registrar el objeto en el registro de RMI
		objRemoto = ClaseRemota.exportObject(objRemoto, Integer.valueOf(puerto));
		
		//Mostrar informacion del servidor (dirección, puerto y nombre
		//del objecto remoto).
		System.out.println(host + " " + puerto + " " + nombreObjRemoto);
	}
}

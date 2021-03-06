
import java.rmi.*;
import java.rmi.server.*;
import java.util.Date;
import java.util.Vector;


@SuppressWarnings("serial")
public class ClaseRemota extends UnicastRemoteObject implements InterfazRemota {	
	// Atributos
	// ... 
	
	//Constructor de la clase remota
	public ClaseRemota () throws RemoteException {
		super();
	}
	
	//Método de ordenación de burbuja
	public Vector<Integer> OrdenaBurbujaAscendente(Vector<Integer> vect) throws RemoteException 
	{
		// ... 	
		
		Date date = new Date();
		String hostCliente = " ";
		try {
			hostCliente = ClaseRemota.getClientHost();
		} catch (ServerNotActiveException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(date + " " + hostCliente);
		
        for (int i = 0; i < vect.size(); i++)
        {
            for (int j = i; j < vect.size(); j++)
            {
                if (vect.elementAt(i) > vect.elementAt(j))
                {
                    int aux = vect.elementAt(i);
                    vect.setElementAt(vect.elementAt(j), i);
                    vect.setElementAt(aux, j);
                }
            }
        }	
        return vect;
	
	}
}

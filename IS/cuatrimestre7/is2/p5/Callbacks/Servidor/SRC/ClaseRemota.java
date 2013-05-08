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
		
        for (int i = (vect.size() -1); i >= 0; i--)
        {
            for (int j = 0; j <= (i - 1); j++)
            {
                if (vect.elementAt(j) > vect.elementAt(j+1))
                {
                    int aux = vect.elementAt(j);
                    vect.setElementAt(vect.elementAt(j+1), j);
                    vect.setElementAt(aux, j+1);
                }
            }
        }	
        return vect;
	
	}
}

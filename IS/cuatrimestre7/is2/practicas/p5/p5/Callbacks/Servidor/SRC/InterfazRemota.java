import java.rmi.*;
import java.util.Vector;

public interface InterfazRemota extends Remote {
	//Declaracion del método de ordenación de burbuja
	Vector<Integer> OrdenaBurbujaAscendente(Vector<Integer> vect) throws RemoteException;		
}

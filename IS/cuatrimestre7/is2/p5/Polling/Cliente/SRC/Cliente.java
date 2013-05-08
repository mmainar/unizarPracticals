import java.rmi.*;
import java.util.Random;
import java.util.Vector;



public class Cliente {
	
	public static void main (String [] args) throws Exception {

		//Obtener la referencia al objeto remoto
		//...
		String direccion = args[0];
		String puerto = args[1];
		String nombreObjRemoto = args[2];
		String name = "//" + direccion + ":" + puerto + "/" + nombreObjRemoto;
		
		InterfazRemota remote = InterfazRemota.class.cast(Naming.lookup(name));
		
		//Generar el vector de números enteros aleatoriamente
		//...
		
		int tam = Integer.valueOf(args[3]);
		Vector<Integer> vect = new Vector<Integer>(tam);
		Random r = new Random();
		
	    for (int i = 0; i < tam; i++)
	    {
	    	vect.addElement((int) r.nextInt()); 
	    	// Mostramos por pantalla el vector desordenado
	    	System.out.println("v[" + i + "] = " + vect.elementAt(i));
	    }


		//Llamar al método de ordenación de burbuja de la clase remota
		//...
	    vect = remote.OrdenaBurbujaAscendente(vect);
		
		//Mostrar el vector de números enteros ordenado
		//...		
	    for (int i = 0; i < tam; i++)
	    {
	    	System.out.println("v[" + i + "] = " + vect.elementAt(i));
	    }
	}
}

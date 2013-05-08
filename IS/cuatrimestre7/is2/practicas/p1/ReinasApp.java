// declarar paquetes necesarios

import java.io.IOException; // para la excepcion del metodo main
// import java.lang.System;

// Clase que modela una reina
class Reina {

	/**
	 * @param args
	 */
	// Atributos
	public int fila; // Posici�n de la reina en el tablero de ajedrez: 
	public int col; // fila y columna.
	public Reina vec; // Representa a la reina vecina para enviarle mensajes.
	
	// M�todo Constructor
	public Reina(int f, int c, Reina v)
	{
		fila = f;
		col = c;
		vec = v;
	}
	
	// Resto de m�todos de la clase Reina
	
	public boolean puedeAtacar(int f, int c)
	// Funci�n que devuelve true si puedo atacar a una Reina
	// que est� situada en la fila f y columna c y falso
	// en caso contrario
	{
		if (fila == f) // Nos mata por fila
			return true;
		if ((Math.abs(fila-f)) == (Math.abs(col-c))) // Nos mata por diagonal
			return true;
		if (vec != null) return vec.puedeAtacar(f, c); // Nos mata otra reina vecina
		
		return false;
	}
	
	private boolean pruebaOAvanza()
	// La reina consulta si puede ser atacada en la posici�n
	// en la que se encuentra.
	// Devuelve true cuando se coloca OK.
	{
		if (vec != null && vec.puedeAtacar(fila,col))
			return siguiente();
		return true;
	}
	
	public void imprimir()
	{
		if (vec != null)
		{
			vec.imprimir();
			System.out.println("Fila: " + fila + " Columna:" + col);
		}
		else 
		{	
			System.out.println("Fila: " + fila + " Columna:" + col);
		}
		
	}
	

	
	public boolean siguiente()
	// Avanza una posici�n la reina (si est� en la �ltima se coloca en
	// la primera) y consulta si puede ser atacada.
	{
		if (fila != 8)
		{
			fila++;
			return pruebaOAvanza();
		}
		else // La reina ha llegado a la �ltima fila sin encontrar
			 // una posici�n segura -> Pedimos a nuestra vecina
			 // que explore la posici�n siguiente.
		{
			fila = 1; // Me bajo abajo, a la primera posici�n
			// Hago que mi reina vecina se coloque en la posici�n 
			// siguiente a la suya y vuelvo a comprobar.
			if (vec != null && vec.siguiente())
				return pruebaOAvanza();
		        return false; // Muestra todas las soluciones

		}
	}
	
	public boolean primera()
	{
		// primera posici�n legal para Reina y su vecina
		if (vec != null && vec.primera())
			return pruebaOAvanza();
		return true;
	}
	
	
	
}



class Torre extends Reina
{

	public boolean puedeAtacar(int f, int c)
	// Funci�n que devuelve true si puedo atacar a una Reina
	// que est� situada en la fila f y columna c y falso
	// en caso contrario
	{
		if (fila == f) // Nos mata por fila
			return true;
		if (vec != null) return vec.puedeAtacar(f, c); // Nos mata otra reina vecina
		
		return false;
	}

	// M�todo Constructor
	public Torre(int f, int c, Reina v)
	{
		super(f,c,v);
	}

}

class ReinasApp {
	
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		
		int contador = 0; 
		int c;
		
		// Crear las reinas
		Reina ultimaReina = null; // la primera reina no tiene vecina

		for (int j=1; j<=8; j++)
		{
	        // Generar soluci�n
		  	System.out.print("Columna " + j + " R o T?: ");
			c = System.in.read();
			System.in.read();
			if (c == 'R')
		        {
			  ultimaReina = new Reina(1, j, ultimaReina);
			}
			else 
		        {
			  ultimaReina = new Torre(1, j, ultimaReina);
			}
		 }
		 // Escribir soluci�n por pantalla en modo texto 
		 if (ultimaReina.primera())
		 {
		   contador++;
		   System.out.println("----------------------------");
		   System.out.println("Solucion numero " + contador);
		   ultimaReina.imprimir();
		 }
		 
		 while (ultimaReina.siguiente()) 
		 {
		   contador++;
		   System.out.println("----------------------------");
		   System.out.println("Solucion numero " + contador);
		   ultimaReina.imprimir();		
		 } 

	}
}

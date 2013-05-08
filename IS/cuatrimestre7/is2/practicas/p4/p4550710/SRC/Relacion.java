/*

AUTORES: Ismael Saad Garcia y Marcos Mainar Lalmolda.
PROYECTO: Practica 4 de Ingenieria del Software II curso 2008/09.
FICHERO: Relacion.java
DESCRIPCION: Clase que modela una relación entre 2 actores de una red social.
USA: Clases Actor.java, Aplicacion.java, Red.java y Ventana.java.     

*/


package practica4;

import java.awt.Color;
import java.awt.Graphics;

public class Relacion {

	// Atributos

    private Actor actor1, actor2; // Referencias a los 2 actores que relaciona la relación
	public static int numRelaciones = 0; // Numero de instancias de la clase
	
	
	public Relacion(Actor actor1, Actor actor2)
	{
		// Constructor
		numRelaciones++;
		this.actor1 = actor1;
		this.actor2 = actor2;
	}

	
	public void draw(Graphics graphics) 
	{
	    final Color negro = Color.black; // Color de los bordes del rectangulo
		graphics.setColor(negro);
		graphics.drawLine(actor1.getX() + Actor.getW(), actor1.getY() + Actor.getH(), actor2.getX() + Actor.getW(), actor2.getY() + Actor.getH());
	}
	
	// Metodos de acceso a los atributos de la clase.
		
	public Actor actor1()
	{
		return this.actor1;
	}
	
	public Actor actor2()
	{
		return this.actor2;
	}
	
	public static int numRelaciones()
	{
		return numRelaciones;
	}
}

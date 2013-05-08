/*

AUTORES: Ismael Saad Garcia y Marcos Mainar Lalmolda.
PROYECTO: Practica 4 de Ingenieria del Software II curso 2008/09.
FICHERO: Actor.java
DESCRIPCION: Clase que modela un actor de una red social.
USA: Clases Red.java, Aplicacion.java, Relacion.java y Ventana.java.     

*/


package practica4;

import java.awt.Color;
import java.awt.Graphics;


public class Actor {

	// Atributos
	
	// Coordenadas del actor
    private int x; // Coordenada x
    private int y; // Coordenada y
    private final static int w = 60; // Anchura (constantes para todos los actores)
    private final static int h = 20; // Altura
    private Color colorFondo = Color.white;
	private static int numActores = 0; // Numero de instancias de la clase
	private static int numActoresTot = 0; // Numero de actores totales creados
	private int numActor = 0; // Numero de actor
	
	
	public Actor(int x, int y)
	{
		// Constructor
		this.numActor = numActoresTot;
		numActoresTot++;
		numActores++;
		this.x = x; 
		this.y = y;
	}
	  
	
	public void draw(Graphics graphics) 
	{
	    final Color negro = Color.black; // Color de los bordes del rectangulo
		graphics.setColor(negro);
		graphics.drawRect(x, y, w, h); // Dibujamos rectángulo
		graphics.setColor(colorFondo);
		graphics.fillRect(x, y, w, h); // Rellenamos rectángulo
		graphics.setColor(negro);
		graphics.drawString("Actor "+ String.valueOf(numActor), x + (w-50)/4, y + (h+5)/2);
	}
	
	// Métodos get y set de acceso a los atributos de la clase
	
	public int getX()
	{
		return this.x;
	}
	
	public int getY()
	{
		return this.y;
	}
	
	public static int getW()
	{
		return w;
	}
	
	public static int getH()
	{
		return h;
	}
	
	public Color getColorFondo()
	{
		return this.colorFondo;
	}
	
	public static int getNumActores()
	{
		return numActores;
	}
	
	public static void decNumActores()
	{
		numActores--;
	}
	
	public void setColorFondo(Color color)
	{
		this.colorFondo = color;
	}
	
	
	public void setX(int x)
	{
		this.x = x; 
	}
	
	public void setY(int y)
	{
		this.y = y; 
	}
	
}


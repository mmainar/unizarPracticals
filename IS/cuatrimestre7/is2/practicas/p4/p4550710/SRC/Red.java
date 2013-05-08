/*

AUTORES: Ismael Saad Garcia y Marcos Mainar Lalmolda.
PROYECTO: Practica 4 de Ingenieria del Software II curso 2008/09.
FICHERO: Red.java
DESCRIPCION: Clase que modela una red social.
USA: Clases Actor.java, Aplicacion.java, Relacion.java y Ventana.java.     

*/


package practica4;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Vector;

@SuppressWarnings("serial")
public class Red extends JPanel implements MouseListener, MouseMotionListener, KeyListener {
	
	// Ventana en la que esta la red
	private Ventana ventana;
	
	// Vectores que guardan los actores (Actor) y
	// relaciones (Relacion) de la red
	private Vector<Actor> actores = new Vector<Actor>();
	private Vector<Relacion> relaciones = new Vector<Relacion>();
	
	// Atributos privados
	
	private Actor actor = null; // Ratón sobre el que está el actor.
	private Actor actorSel = null; // Actor seleccionado (en verde).
	private boolean creandoRelacion = false;
	private int xPresionado, yPresionado;

	
	public Red(Ventana laVentana) 
	{
		// Constructor
		ventana = laVentana;
		addMouseListener(this);
		addMouseMotionListener(this);
		addKeyListener(this);
	}
		
	public void addActor() {
		// Añade un actor a la red
		
		Graphics objetoGraphics = this.getGraphics();
		// Creamos nueva instancia de la clase Actor
		// Las coordenadas del nuevo actor se generan aleatoriamente
		// dentro de los límites de la pantalla
		int x = (int) (10 + 700*Math.random());
		int y = (int) (10 + 480*Math.random());
		Actor a = new Actor(x,y);
		// Lo dibujamos
		a.draw(objetoGraphics);
		// Lo añadimos al vector de actores
		actores.add(a);
	}
	
	
	public void addRelacion(Actor actor1, Actor actor2) {
		// Añade una relacion a la red
		
		Graphics objetoGraphics = this.getGraphics();
		// Creamos nueva instancia de la clase Relacion
		Relacion r = new Relacion(actor1, actor2);
		// La dibujamos
		r.draw(objetoGraphics);
		// La añadimos al vector de relaciones
		relaciones.add(r);
	}
	
	public int getNActores() {
		// Devuelve el numero de actores
		return Actor.getNumActores();
	}
	
	public int getNRelaciones() {
		// Devuelve el numero de relaciones
		return Relacion.numRelaciones;
	}
	
	public void paint(Graphics graphics) {
		// Dibuja la red social
		
		super.paint(graphics);
		ventana.updateNActores();
		ventana.updateNRelaciones();
		for (int i=0; i< actores.size(); i++)
		{
			Actor a = actores.elementAt(i);
			a.draw(graphics);
		} 
		for (int i=0; i < relaciones.size(); i++)
		{
			Relacion r = relaciones.elementAt(i);
			r.draw(graphics);
		} 
	}
	
	
	
	/********************************************/
	/** Métodos de MouseListener               **/
	/********************************************/
	
	public void mousePressed(MouseEvent event) 
	{
		// Solo se entra aquí al presionar sin soltar la primera vez.
		
		int boton = event.getButton(); // Botón presionado
		// Nos guardamos donde hemos presionado con el ratón para luego
		// hacer el arrastre correctamente.
		xPresionado = event.getX(); 
		yPresionado = event.getY(); 
		
		// Al tener un actor seleccionado (en verde) (actorSel ! = null), pulsar con el botón 
		// izdo. del ratón (BUTTON) en él y moverlo se va creando la línea recta que 
		// representará una posible relación que podremos crear con otro actor.
		if ((boton == MouseEvent.BUTTON1) && (actorSel != null)
				&& (xPresionado >= actorSel.getX()) && (yPresionado >= actorSel.getY()) &&
				(xPresionado <= (actorSel.getX() + Actor.getW())) && (yPresionado <= (actorSel.getY() + Actor.getH())))
		{
			super.getGraphics().drawLine(actorSel.getX(), actorSel.getY(), xPresionado, yPresionado);
			creandoRelacion = true;
			repaint();		
		}
		// Si se pulsa un botón del ratón que no sea el izdo. no vamos a hacer nada,
		// ni arrastrar luego ni crear relación.
		if (boton != MouseEvent.BUTTON1) actor = null;
		event.consume(); 		
	}
	
	private boolean existeRelacion(Actor actor1, Actor actor2)
	{
		// Devuelve true si ya existe una relación entre los
		// actores actor1 y actor2 y falso en caso contrario.
		
		for (int i=0; i < relaciones.size(); i++)
		{
			Relacion r = relaciones.elementAt(i);
			if (((r.actor1() == actor1) && (r.actor2() == actor2))
				|| ((r.actor1() == actor2) && (r.actor2() == actor1)))
				return true;
		}
		return false;
	}
    	
    public void mouseReleased(MouseEvent event) 
    {    	
    	// Se entra aquí al soltar algún botón del ratón.
    	// Dibujaremos la relación si procede de forma definitiva
    	
    	// Coordenadas del ratón
    	int x1 = event.getX();
    	int y1 = event.getY();
    	
    	// Vemos si procede dibujar la relación de forma definitiva,
    	// es decir, si al soltar el botón del ratón este se encontraba
    	// sobre otro actor.
    	for (int i=0; i < actores.size(); i++)
		{
			Actor a = actores.elementAt(i);
			if ((x1 >= a.getX()) && (x1 <= (a.getX() + Actor.getW())) 
					&& (y1 >= a.getY()) && (y1 <= (a.getY() + Actor.getH())) && (actorSel != null)
					&& (creandoRelacion))
			{
				// Deseleccionamos ambos actores (el de verde seleccionado y el de rojo).
				a.setColorFondo(Color.white);
				actorSel.setColorFondo(Color.white);
				actores.setElementAt(a,i);				
				int indiceActorSel = actores.indexOf(actorSel);
				if (indiceActorSel != -1) actores.setElementAt(actorSel,indiceActorSel);
				// Añadimos la nueva relación al vector de relaciones si no existía ya.
				if (!existeRelacion(actorSel,a)) addRelacion(actorSel, a);
				// Ya no hay actor seleccionado (en verde).
				actorSel = null;
				// Repintamos la red con la nueva relación así como los
				// actores con su color de fondo blanco inicial.
		    	repaint();
		    	break;
			}			
		}
    	creandoRelacion = false; // Se ha creado la relación del todo
    	event.consume();
    }
    
    public void mouseEntered(MouseEvent event)
    {
      // Esto es solo para cuando el ratón 
      // entra en la ventana.
      // No se usa pero hay que ponerlo ya que
      // arriba declaramos que estamos implementando
      // la interfaz MouseListener.
    }
    
    public void mouseExited(MouseEvent event) 
    {
      // Esto es solo para cuando el ratón
      // sale de la ventana.
      // No se usa pero hay que ponerlo ya que
      // arriba declaramos que estamos implementando
      // la interfaz MouseListener.
    }
    
    public void mouseClicked(MouseEvent event) 
    {
		/* Para borrar un actor de la red el usuario
		 * debe hacer click sobre el con el boton
		 * derecho del raton. Si el actor tiene alguna
		 * relación, estas también se borran.
		 */
		event.consume();
		int boton = event.getButton();
		
		if (boton == MouseEvent.BUTTON3) // Boton dcho. del ratón para borrar.
		{
			int x1 = event.getX(); 
			int y1 = event.getY();
			for (int i=0; i< actores.size(); i++)
			{
				Actor a = (Actor) actores.elementAt(i);
				if ((x1 >= a.getX()) && (x1 <= (a.getX() + Actor.getW())) 
						&& (y1 >= a.getY()) && (y1 <= (a.getY() + Actor.getH())))
				{
					// Lo borramos del vector de actores solo si no está seleccionado 
					// (en verde), en cuyo caso no se puede borrar sin deseleccionarlo antes.
					if (a != actorSel) 
					{
						// Buscamos si tiene alguna relación y en caso de que tenga
						// la/s borramos.
						borrarRelacion(a);
						// Ahora borramos ya el actor propiamente dicho
						actores.removeElement(a);
						Actor.decNumActores();
						//Repintamos la red social
						repaint();
					}
					break;
				}		
			}
		}
    }
    	
    
    private void borrarRelacion(Actor a)
    {
    	// Borra todas las relaciones que tenga el actor a
    	
		for (int j=0; j < relaciones.size(); j++)
		{
			Relacion r = relaciones.elementAt(j);
			if ((r.actor1() == a) || (r.actor2() == a))
			{
				relaciones.removeElementAt(j);
				Relacion.numRelaciones--;
				// Si borramos alguna relación del actor,
				// volvemos a ver si tiene más relaciones a borrar.
				borrarRelacion(a);
			}
		}
    }
    
	/********************************************/
	/** Métodos de MouseMotionListener         **/
	/********************************************/
   

    public void mouseMoved(MouseEvent event) 
    {
    	// Cuando se mueve el ratón
    	
    	actor = null;
    	// Guardamos las coordenadas del ratón
    	int x1 = event.getX();
    	int y1 = event.getY();

    	// Para traer un actor al frente
    	for (int i=0; i < actores.size(); i++)
		{
			Actor a = actores.elementAt(i);
			if ((x1 >= a.getX()) && (x1 <= (a.getX() + Actor.getW())) 
					&& (y1 >= a.getY()) && (y1 <= (a.getY() + Actor.getH())))
			{
				// Si el actor está semioculto, debe traerse al frente, para ello..
				actores.removeElementAt(i); // Lo eliminamos temporalmente del vector de actores
				actores.add(a); // Lo volvemos a añadir pero al final del vector de actores.
				actor = a; 
				// Repintamos la red
				repaint(); 
				// Ya podemos salir del bucle ya que el primer actor del vector para el que
				// se cumpla la condición del if anterior será el que queríamos traer al 
				// frente de los que estaban superpuestos ya que es el que antes se encontraba
				// en el vector y por tanto más al fondo en la pantalla.
				break;
			}		
		} 
    	
    	// Para redibujar la línea de relación al mover el cursor
    	if ((actorSel != null) && (creandoRelacion))  {
    		super.getGraphics().drawLine(actorSel.getX(), actorSel.getY(), x1, y1);
    		repaint();   		
    	}
    	
    	// Para poder seleccionar luego un actor sobre el que estamos.
    	for (int i=0; i < actores.size(); i++)
		{
			Actor a = actores.elementAt(i);
			if ((x1 >= a.getX()) && (x1 <= (a.getX() + Actor.getW())) 
					&& (y1 >= a.getY()) && (y1 <= (a.getY() + Actor.getH())))
			{
				// Nos guardamos una referenca al actor (para seleccionarlo, etc.)
				// sobre el que tenemos el ratón.
				actor = a; 
				break;
			}		
		} 
	}
    
   	public void mouseDragged(MouseEvent event) 
   	{
   		// Cuando arrastramos un objeto entramos
   		
   		// Nos guardamos las coordenadas del ratón
   		int x1 = event.getX();
   		int y1 = event.getY();
   		Actor a;
   		
   		// Para arrastrar un actor cuya referencia
   		// está en "actor" (nos la habíamos guardado en el
   		// método anterior, mouseMoved).
   		int indice = actores.indexOf(actor);
        if (indice != -1) a = actores.elementAt(indice); 
        else a = null; 
          
        if (a != actorSel){
        	// Calculamos los límites del área de dibujo.
            Rectangle r = new Rectangle();
            r = this.getBounds();
            // Arrastramos sólo si está dentro de estos límites.
            if ((a != null) && 
            		(r.contains(a.getX() + x1 - xPresionado, a.getY() + y1 - yPresionado, Actor.getW() + 20, Actor.getH() + 35)))
            	{ a.setX(a.getX() + x1 - xPresionado) ; 
            	  a.setY(a.getY() + y1 - yPresionado);
            	  xPresionado = x1; yPresionado = y1;
            	  actores.setElementAt(a,indice); }
       		repaint(); 
        }
   		
    	// Para crear relación al soltar el ratón
    	if ((actorSel != null) && (creandoRelacion))  {
    		super.getGraphics().drawLine(actorSel.getX(), actorSel.getY(), x1, y1);
    		repaint();   		
    	} 
    	
    	for (int i=0; i<actores.size(); i++)
		{
			a = (Actor) actores.elementAt(i);
			if ((x1 >= a.getX()) && (x1 <= (a.getX() + Actor.getW())) 
					&& (y1 >= a.getY()) && (y1 <= (a.getY() + Actor.getH())) && (a != actorSel)
					&& (actorSel != null) && (creandoRelacion))
			{
				// Ponemos en rojo el actor sobre el que arrastramos el ratón
				// para señalar que se puede crear una relación con él.
				// Posible mejora: podríamos consultar aquí si ya existe una
				// relación del actor seleccionado (actorSel) con este actor (a)
				// en cuyo caso ni siquiera lo iluminaríamos en rojo.
				a.setColorFondo(Color.red);
				actores.setElementAt(a,i);
				repaint();
			}
			else if ((a.getColorFondo() == Color.red) && (actorSel != null))
			{
				a.setColorFondo(Color.white);
				actores.setElementAt(a,i);
				repaint();
			}
		}
   		event.consume();
	}   
    
    
	/********************************************/
	/** Métodos de KeyListener                 **/
	/********************************************/

    public void keyTyped(KeyEvent event) 
    {
        // No se usa pero hay que ponerlo ya que
        // arriba declaramos que estamos implementando
        // la interfaz KeyListener.   	
    }
    
    public void keyPressed(KeyEvent event) 
    {
    	int tecla = event.getKeyChar();
    	if (tecla == 's')
    	{
    		// Seleccionamos o deseleccionamos el actor
    		if ((actorSel == null) && (actor != null))
    		{
    			if (actor.getColorFondo() == Color.white) { 
    				actor.setColorFondo(Color.green);
    				actorSel = actor;
    				int indice = actores.indexOf(actor);
            		if (indice != -1) actores.setElementAt(actor,indice);
            		repaint();
    			}
    		}
    		else if ((actor != null) && (actorSel == actor))  
    		{
    			actor.setColorFondo(Color.white); 
    			int indice = actores.indexOf(actor);
				actorSel = null;
        		if (indice != -1) actores.setElementAt(actor,indice);
        		repaint();
    		}
    		else if ((actorSel != null) && (actor == null))
    			// Deseleccionar el último actor seleccionado
    		{
    			actorSel.setColorFondo(Color.white);
    			int indiceActorSel = actores.indexOf(actorSel);
    			if (indiceActorSel != -1) actores.setElementAt(actorSel,indiceActorSel);
    			actorSel = null;
        		repaint();
    		}
    	}
    	event.consume();
	}
    
    public void keyReleased(KeyEvent event) 
    {
        // No se usa pero hay que ponerlo ya que
        // arriba declaramos que estamos implementando
        // la interfaz KeyListener.   	
    }
    
    
}

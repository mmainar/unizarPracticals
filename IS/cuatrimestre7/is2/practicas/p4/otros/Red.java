import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Vector;

public class Red extends JPanel implements MouseListener, MouseMotionListener, KeyListener {
	
	// Ventana en la que esta la red
	private Ventana ventana;
	
	// Vectores que guardan los actores (Actor) y
	// relaciones (Relacion) de la red
	private Vector actores = new Vector();
	private Vector relaciones = new Vector();
	
	// ... (otros posibles atributos)

	
	public Red(Ventana laVentana) {
		// Constructor
		ventana = laVentana;
		addMouseListener(this);
		addMouseMotionListener(this);
		addKeyListener(this);
		// ...
		
	}
	
	public void addActor() {
		// Añade un actor a la red
		// ...

	}
	
	public int getNActores() {
		// Devuelve el no. de actores
		// ...

		return 0;
	}
	
	public int getNRelaciones() {
		// Devuelve el no. de relaciones
		// ...
		
		return 0;
	}

	public void paint(Graphics graphics) {
		// Dibuja la red social
		// ...

	}
	
	
	/********************************************/
	/** Métodos de MouseListener               **/
	/********************************************/
	
	public void mousePressed(MouseEvent event) {
		// ...

	}
    	
    	public void mouseReleased(MouseEvent event) {    	
    		// ...
    	
	}
    
    	public void mouseEntered(MouseEvent event) {
		// ...
    	
	}
    
    	public void mouseExited(MouseEvent event) {
		// ...
    
    	}
    
    	public void mouseClicked(MouseEvent event) {
		// ...
    	
    	}
    	
    
	/********************************************/
	/** Métodos de MouseMotionListener         **/
	/********************************************/

    	public void mouseMoved(MouseEvent event) {
    		// ...

	}
    
   	public void mouseDragged(MouseEvent event) {
    		// ...
    	
	}   
    
    
	/********************************************/
	/** Métodos de KeyListener                 **/
	/********************************************/

    	public void keyTyped(KeyEvent event) {
    		// ...
    	
    	}
    
    	public void keyPressed(KeyEvent event) {
	    	// ...

	}
    
    	public void keyReleased(KeyEvent event) {
    		// ...
    	
    	}
    
}

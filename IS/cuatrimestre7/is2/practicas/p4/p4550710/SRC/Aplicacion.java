/*

AUTORES: Ismael Saad Garcia y Marcos Mainar Lalmolda.
PROYECTO: Practica 4 de Ingenieria del Software II curso 2008/09.
FICHERO: Aplicacion.java
DESCRIPCION: Aplicación que modela una red social.
USA: Clases Actor.java, Red.java, Relacion.java y Ventana.java.     

*/


package practica4;

import javax.swing.*;
import java.awt.*;

public class Aplicacion {
	
	private static void createAndShowGUI() {
		
		JFrame.setDefaultLookAndFeelDecorated(true); 
		JFrame frame = new JFrame("Práctica 4");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		Ventana ventana = new Ventana();
		Component contents = ventana.createComponents();
		frame.getContentPane().add(contents, BorderLayout.CENTER);
		frame.pack();
		frame.setSize(800, 600);
		frame.setVisible(true);
		
	}
	
	public static void main(String[] args) {
		
		javax.swing.SwingUtilities.invokeLater(
				new Runnable() {
					public void run() { createAndShowGUI(); }
				}
		);
		
	}
	
}
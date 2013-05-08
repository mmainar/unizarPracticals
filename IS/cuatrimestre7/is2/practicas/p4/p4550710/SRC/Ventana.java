/*

AUTORES: Ismael Saad Garcia y Marcos Mainar Lalmolda.
PROYECTO: Practica 4 de Ingenieria del Software II curso 2008/09.
FICHERO: Ventana.java
DESCRIPCION: Clase que construye una ventana donde se modela
             una red social.
USA: Clases Actor.java, Aplicacion.java, Relacion.java y Red.java.     

*/


package practica4;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Ventana implements ActionListener {
	
	private JPanel  panel;
	
	private Red red;
	private JButton boton;
	private JLabel labelNActores;
	private JLabel labelNRelaciones;
	
	public Ventana() { super(); }
	
	public Component createComponents() {
		
		panel = new JPanel(new GridBagLayout());

		GridBagConstraints constraints = new GridBagConstraints();

		boton = new JButton("Añadir Actor");
		boton.setMnemonic(KeyEvent.VK_I);
		boton.addActionListener(this);
		constraints.gridx = 0;
		constraints.gridy = 0;
		constraints.gridwidth = 1;
		constraints.gridheight = 1;
        panel.add(boton, constraints);

		red = new Red(this);
		constraints.gridx = 0;
		constraints.gridy = 1;
		constraints.gridwidth = 4;
		constraints.gridheight = 3;
		constraints.fill = GridBagConstraints.BOTH;
		constraints.weightx = 1.0;
		constraints.weighty = 1.0;
        panel.add(red, constraints);
    
        labelNActores = new JLabel("Actores: " + red.getNActores());
	    constraints.gridx = 0;
        constraints.gridy = 4;
        constraints.gridwidth = 2;
        constraints.gridheight = 1;
        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.weightx = 0;
        constraints.weighty = 0;
        panel.add(labelNActores, constraints);
        
        labelNRelaciones = new JLabel("Relaciones: " + red.getNRelaciones());
        constraints.gridx = 2;
        constraints.gridy = 4;
        constraints.gridwidth = 2;
        constraints.gridheight = 1;
        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.weightx = 0;
        constraints.weighty = 0;
        panel.add(labelNRelaciones, constraints);
		
		panel.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		
		return panel;		
	}
	
	public void actionPerformed(ActionEvent event) {
		
		red.addActor();
		red.requestFocusInWindow();
		updateNActores();	
	}
	
	public void updateNActores() {
		
		labelNActores.setText("Actores: " + red.getNActores());
		
	}
	
	public void updateNRelaciones() {
		
		labelNRelaciones.setText("Relaciones: " + red.getNRelaciones());
		
	}
	
}
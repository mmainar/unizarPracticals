package gui;

import infoProyec.Proyecto;

import java.awt.Container;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;



public class VentanaVerProyecto extends JFrame {
		
	/* Cuadros de texto y botones */	
	JButton botonAceptar = new JButton("Aceptar");
	JTextField cuadroNombre = new JTextField();
	JTextField cuadroDescripcion = new JTextField();	
	JTextField cuadroDiaFechaIni = new JTextField();
	JTextField cuadroMesFechaIni = new JTextField();
	JTextField cuadroAnhoFechaIni = new JTextField();
	JTextField cuadroDiaFechaFin = new JTextField();
	JTextField cuadroMesFechaFin = new JTextField();
	JTextField cuadroAnhoFechaFin = new JTextField();	
	
	
	public VentanaVerProyecto(Proyecto proyectoAMostrar) {
		
		super("Ver proyecto");
			
		/* Etiquetas */	
		JLabel etiquetaNombre;
		JLabel etiquetaDescripcion;
		JLabel etiquetaDiaFechaIni;
		JLabel etiquetaMesFechaIni;
		JLabel etiquetaAnhoFechaIni;
		JLabel etiquetaDiaFechaFin;
		JLabel etiquetaMesFechaFin;
		JLabel etiquetaAnhoFechaFin;
		
		String cadenaNombre = "Nombre: ";
		String cadenaDescripcion = "Descripcion: ";
		String cadenaDiaFechaIni = "Fecha de inicio: ";
		String cadenaMesFechaIni = " - ";
		String cadenaAnhoFechaIni = " - ";
		String cadenaDiaFechaFin = "Fecha de fin: ";
		String cadenaMesFechaFin = " - ";
		String cadenaAnhoFechaFin = " - ";		
					
		etiquetaNombre = new JLabel(cadenaNombre);
		etiquetaDescripcion = new JLabel(cadenaDescripcion);
		etiquetaDiaFechaIni = new JLabel(cadenaDiaFechaIni);
		etiquetaMesFechaIni = new JLabel(cadenaMesFechaIni);
		etiquetaAnhoFechaIni = new JLabel(cadenaAnhoFechaIni);
		etiquetaDiaFechaFin = new JLabel(cadenaDiaFechaFin);
		etiquetaMesFechaFin = new JLabel(cadenaMesFechaFin);
		etiquetaAnhoFechaFin = new JLabel(cadenaAnhoFechaFin);			
			
		cuadroNombre.setColumns(20);
		cuadroDescripcion.setColumns(50);
		cuadroDiaFechaIni.setColumns(2);
		cuadroMesFechaIni.setColumns(2);
		cuadroAnhoFechaIni.setColumns(4);
		cuadroDiaFechaFin.setColumns(2);
		cuadroMesFechaFin.setColumns(2);
		cuadroAnhoFechaFin.setColumns(4);


		/* Añadimos los elementos al layout */				
		Container frameContainer = getContentPane();
		frameContainer.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
			
		c.fill = GridBagConstraints.HORIZONTAL;
		c.insets = new Insets(5,5,5,5);
		c.gridx = 0;
		c.gridy = 2;
		frameContainer.add(etiquetaDiaFechaIni,c);
		c.gridx++;
		c.insets = new Insets(0,5,0,0);
		frameContainer.add(cuadroDiaFechaIni,c);
		c.gridx++;
		c.insets = new Insets(0,0,0,0);
		frameContainer.add(etiquetaMesFechaIni,c);
		c.gridx++;
		frameContainer.add(cuadroMesFechaIni,c);
		c.gridx++;
		frameContainer.add(etiquetaAnhoFechaIni,c);
		c.gridx++;
		frameContainer.add(cuadroAnhoFechaIni,c);
		c.gridx = 0;
		c.gridy = 3;
		c.insets = new Insets(5,5,5,5);
		frameContainer.add(etiquetaDiaFechaFin,c);
		c.gridx++;
		c.insets = new Insets(0,5,0,0);
		frameContainer.add(cuadroDiaFechaFin,c);
		c.gridx++;
		c.insets = new Insets(0,0,0,0);
		frameContainer.add(etiquetaMesFechaFin,c);
		c.gridx++;
		frameContainer.add(cuadroMesFechaFin,c);
		c.gridx++;
		frameContainer.add(etiquetaAnhoFechaFin,c);
		c.gridx++;
		frameContainer.add(cuadroAnhoFechaFin,c);
		c.insets = new Insets(5,5,5,5);
		c.gridx = 0;
		c.gridy = 0;
		frameContainer.add(etiquetaNombre,c);
		c.gridx++;
		c.gridwidth = 6;
		frameContainer.add(cuadroNombre,c);
		c.gridy = 1;
		c.gridx = 0;
		c.gridwidth = 16;
		frameContainer.add(etiquetaDescripcion,c);
		c.gridx++;
		frameContainer.add(cuadroDescripcion,c);			
		c.gridwidth = 4;
		c.gridy = 4;
		c.gridx = 2;			
		frameContainer.add(botonAceptar,c);	


		/* Añadimos los manejadores */		
		ManejadorVentanaVerProyecto manejador = new ManejadorVentanaVerProyecto();
		
		cuadroNombre.setText(proyectoAMostrar.getTitulo());
		cuadroNombre.setEditable(false);
		cuadroDescripcion.setText(proyectoAMostrar.getDescripcion());
		cuadroDescripcion.setEditable(false);
		String cadenaFechaIni = proyectoAMostrar.getFechaInic().toString();
		cuadroDiaFechaIni.setText(cadenaFechaIni.substring(8,10));
		cuadroDiaFechaIni.setEditable(false);
		cuadroMesFechaIni.setText(cadenaFechaIni.substring(5,7));
		cuadroMesFechaIni.setEditable(false);
		cuadroAnhoFechaIni.setText(cadenaFechaIni.substring(0,4));
		cuadroAnhoFechaIni.setEditable(false);
		String cadenaFechaFin = proyectoAMostrar.getFechaFin().toString();
		cuadroDiaFechaFin.setText(cadenaFechaFin.substring(8,10));
		cuadroDiaFechaFin.setEditable(false);
		cuadroMesFechaFin.setText(cadenaFechaFin.substring(5,7));
		cuadroMesFechaFin.setEditable(false);
		cuadroAnhoFechaFin.setText(cadenaFechaFin.substring(0,4));
		cuadroAnhoFechaFin.setEditable(false);
		botonAceptar.addActionListener(manejador);	
	
		pack();
		setLocationRelativeTo(null);
		setVisible(true);		
	}
	
	
	public class ManejadorVentanaVerProyecto implements ActionListener {
		
		public void actionPerformed (ActionEvent e) {
		
			Object obj = e.getSource();
			
			if (obj == botonAceptar) {
				Interfaz.nuevaVentanaVerProyecto.dispose();
			}
		}
	}

	
	
}

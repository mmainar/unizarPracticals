package gui;

import infoProyec.Empleado;

import java.awt.Container;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

import bd.Conexion;


public class VentanaNuevoEmpleado extends JFrame {
		
	/* Cuadros de texto y botones */
	JButton botonAceptar = new JButton("Aceptar");
	JButton botonCancelar = new JButton("Cancelar");
	JTextField cuadroNombre = new JTextField();
	JTextField cuadroApellidos = new JTextField();	
	JTextField cuadroNumeroDNI = new JTextField();
	JTextField cuadroLetraDNI = new JTextField();
	JTextField cuadroAnhoFechaNac = new JTextField();	
	
	
	public VentanaNuevoEmpleado() {
		
		super("Nuevo empleado");
			
		/* Etiquetas */	
		JLabel etiquetaNombre;
		JLabel etiquetaApellidos;
		JLabel etiquetaNumeroDNI;
		JLabel etiquetaLetraDNI;
		JLabel etiquetaAnhoFechaNac;
		
		String cadenaNombre = "Nombre: ";
		String cadenaApellidos = "Apellidos: ";
		String cadenaNumeroDNI = "DNI: ";
		String cadenaLetraDNI = " - ";
		String cadenaAnhoFechaNac = "Año de fecha de nacimiento: ";
					
		etiquetaNombre = new JLabel(cadenaNombre);
		etiquetaApellidos = new JLabel(cadenaApellidos);
		etiquetaNumeroDNI = new JLabel(cadenaNumeroDNI);
		etiquetaLetraDNI = new JLabel(cadenaLetraDNI);
		etiquetaAnhoFechaNac = new JLabel(cadenaAnhoFechaNac);
		
		cuadroNombre.setColumns(20);
		cuadroApellidos.setColumns(20);
		cuadroNumeroDNI.setColumns(8);
		cuadroLetraDNI.setColumns(1);
		cuadroAnhoFechaNac.setColumns(4);
		
		/* Añadimos los elementos al layout */		
		Container frameContainer = getContentPane();
		frameContainer.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
			
		c.fill = GridBagConstraints.HORIZONTAL;
		c.insets = new Insets(5,5,5,5);
		c.gridx = 0;
		c.gridy = 0;
		
		frameContainer.add(etiquetaNombre,c);
		c.gridx++;
		c.gridwidth = 20;
		frameContainer.add(cuadroNombre,c);
		c.gridwidth = 1;
		c.gridx = 0;
		c.gridy++;
		frameContainer.add(etiquetaApellidos,c);
		c.gridx++;
		c.gridwidth = 20;
		frameContainer.add(cuadroApellidos,c);
		c.gridwidth = 1;
		c.gridx = 0;
		c.gridy++;
		frameContainer.add(etiquetaNumeroDNI,c);
		c.gridx++;
		c.gridwidth = 8;
		frameContainer.add(cuadroNumeroDNI,c);
		c.gridwidth = 1;
		c.gridx+=9;
		c.gridwidth = 3;
		frameContainer.add(etiquetaLetraDNI,c);
		c.gridwidth = 1;
		c.gridx+=3;
		frameContainer.add(cuadroLetraDNI,c);
		c.gridx = 0;
		c.gridy++;
		frameContainer.add(etiquetaAnhoFechaNac,c);
		c.gridx++;
		c.gridwidth = 4;
		frameContainer.add(cuadroAnhoFechaNac,c);
		c.gridwidth = 1;		
		c.gridx = 1;
		c.gridy+=2;
		frameContainer.add(botonAceptar,c);	
		c.gridx += 6;
		c.gridwidth = 8;
		frameContainer.add(botonCancelar,c);
		
		/* Añadimos los manejadores*/
		ManejadorVentanaNuevoEmpleado manejador = new ManejadorVentanaNuevoEmpleado();
		
		botonAceptar.addActionListener(manejador);
		botonCancelar.addActionListener(manejador);	
	
		pack();
		setLocationRelativeTo(null);
		setVisible(true);
			

		
	}
	
	public class ManejadorVentanaNuevoEmpleado implements ActionListener {
		
		public void actionPerformed (ActionEvent e) {
			
			Empleado empleadoAInsertar;
		
			Object obj = e.getSource();
			if (obj == botonAceptar) {
				empleadoAInsertar = new Empleado();
				try {
					empleadoAInsertar.setNif(cuadroNumeroDNI.getText()+cuadroLetraDNI.getText().toUpperCase().charAt(0));
					empleadoAInsertar.setNombre(cuadroNombre.getText());
					empleadoAInsertar.setApellidos(cuadroApellidos.getText());
					empleadoAInsertar.setAnyoNac(Integer.parseInt(cuadroAnhoFechaNac.getText()));
				}
				// Si alguno de los datos es incorrecto ya se encargará el método esCorrecto de
				// indicar el fallo.
				catch (Exception excepcion) {
					empleadoAInsertar.setNif("");
					empleadoAInsertar.setNombre("");
					empleadoAInsertar.setApellidos("");
					empleadoAInsertar.setAnyoNac(0);
				}
				
				if (empleadoAInsertar.esCorrecto()) {
					try {
						Conexion.insertarEmpleado(empleadoAInsertar);
						JOptionPane.showMessageDialog(new JFrame(), "Empleado insertado correctamente.");
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error al insertar el empleado.");
					}
					Interfaz.nuevaVentanaNuevoEmpleado.dispose();
				}
				else {
					JOptionPane.showMessageDialog(new JFrame(), "Error, alguno de los datos no es válido.");
				}
			}
			if (obj == botonCancelar) {
				Interfaz.nuevaVentanaNuevoEmpleado.dispose();
			}
			
		}
	}
}



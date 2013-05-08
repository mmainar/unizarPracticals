package gui;

import bd.Conexion;
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

import infoProyec.*;


public class VentanaModificarEmpleado extends JFrame{

	/* Cuadros de texto y botones */
	JButton botonAceptar = new JButton("Aceptar");
	JButton botonCancelar = new JButton("Cancelar");
	JTextField cuadroNombre = new JTextField();
	JTextField cuadroApellidos = new JTextField();	
	JTextField cuadroNumeroDNI = new JTextField();
	JTextField cuadroLetraDNI = new JTextField();
	JTextField cuadroAnhoFechaNac = new JTextField();	

	
	public VentanaModificarEmpleado(Empleado empleadoAModificar) {
	// Constructor de la ventana
		
		
			super("Modificar persona");
			
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
			String cadenaAnhoFechaNac = "A�o de fecha de nacimiento: ";
						
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
			
			/* Ubicamos los elementos sobre el layout */					
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

			/* A�adimos los manejadores */
			ManejadorVentanaModificarEmpleado manejador = new ManejadorVentanaModificarEmpleado();
			
			botonAceptar.addActionListener(manejador);
			botonCancelar.addActionListener(manejador);	
			
			cuadroNombre.setText(empleadoAModificar.getNombre());
			cuadroApellidos.setText(empleadoAModificar.getApellidos());
			cuadroNumeroDNI.setText(empleadoAModificar.getNif().substring(0,8));
			cuadroNumeroDNI.setEditable(false);
			cuadroLetraDNI.setText(empleadoAModificar.getNif().substring(8).toUpperCase());
			cuadroLetraDNI.setEditable(false);
			cuadroAnhoFechaNac.setText(Integer.toString(empleadoAModificar.getAnyoNac()));
			
			pack();
			setLocationRelativeTo(null);
			setVisible(true);

	}
	
	
	public class ManejadorVentanaModificarEmpleado implements ActionListener {
		
		public void actionPerformed (ActionEvent e) {
			
			Empleado empleadoModificado;
		
			Object obj = e.getSource();
			if (obj == botonAceptar) {
				empleadoModificado = new Empleado();
				try {
					empleadoModificado.setNombre(cuadroNombre.getText());
					empleadoModificado.setApellidos(cuadroApellidos.getText());
					empleadoModificado.setNif(cuadroNumeroDNI.getText()+cuadroLetraDNI.getText());
					empleadoModificado.setAnyoNac(Integer.parseInt(cuadroAnhoFechaNac.getText()));
				}
				// Si alguno de los datos es incorrecto ya se encargar� el m�todo esCorrecto de
				// indicar el fallo.
				catch (Exception excepcion) {
					empleadoModificado.setNif("");
					empleadoModificado.setNombre("");
					empleadoModificado.setApellidos("");
					empleadoModificado.setAnyoNac(0);
				}
				if (empleadoModificado.esCorrecto()) {
					try {
						Conexion.modificarEmpleado(empleadoModificado);
						JOptionPane.showMessageDialog(new JFrame(), "Empleado modificado correctamente.");
						Interfaz.nuevaVentanaModificarEmpleado.dispose();
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error al modificar el empleado.");
					}
				}
				else {
					JOptionPane.showMessageDialog(new JFrame(), "Error, alguno de los datos no es v�lido.");
				}
			}
			if (obj == botonCancelar) {
				Interfaz.nuevaVentanaModificarEmpleado.dispose();
			}
			
		}
	}

	
	
}


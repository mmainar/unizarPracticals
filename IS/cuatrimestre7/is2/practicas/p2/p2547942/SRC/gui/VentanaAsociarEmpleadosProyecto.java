package gui;


import infoProyec.Empleado;
import infoProyec.Proyecto;

import java.awt.Container;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Date;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.JFrame;

import bd.Conexion;

public class VentanaAsociarEmpleadosProyecto extends JFrame {

	// Botones y cuadros de texto
	JButton botonAceptar = new JButton("Aceptar");
	JButton botonCancelar = new JButton("Cancelar");
	JTextField cuadroDNI = new JTextField();
	JTextField cuadroNombreProy = new JTextField();	

	
	public VentanaAsociarEmpleadosProyecto () {
	// Constructor de la ventana
		
		JLabel etiquetaDNI;
		JLabel etiquetaNombreProy;
		
		String cadenaDNI = "DNI del empleado: ";
		String cadenaNombreProy = "Nombre del proyecto: ";
					
		etiquetaDNI= new JLabel(cadenaDNI);
		etiquetaNombreProy = new JLabel(cadenaNombreProy);			
			
		cuadroDNI.setColumns(9);
		cuadroNombreProy.setColumns(20);

		Container frameContainer = getContentPane();
		frameContainer.setLayout(new GridBagLayout());
		
		// Usamos el layout GridBagLayout, definimos unas restricciones
		// para que los widgets queden alineados como se desea 
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.HORIZONTAL;
		c.insets = new Insets(5,5,5,5);

		c.gridx = 0;
		c.gridy = 0;
		frameContainer.add(etiquetaNombreProy,c);
		
		c.gridx++;
		c.gridwidth = 2;
		frameContainer.add(cuadroNombreProy,c);
		
		c.gridwidth = 1;
		c.gridy++;
		c.gridx = 0;
		frameContainer.add(etiquetaDNI,c);
		
		c.gridx++;
		frameContainer.add(cuadroDNI,c);
		
		c.gridx = 1;
		c.gridy += 2;
		frameContainer.add(botonAceptar,c);
		
		c.gridx++;
		frameContainer.add(botonCancelar,c);
		
		ManejadorVentanaAsociarEmpleadosProyecto manejador = 
			new ManejadorVentanaAsociarEmpleadosProyecto();

		// Añadimos los manejadores
		botonAceptar.addActionListener(manejador);
		botonCancelar.addActionListener(manejador);
		cuadroDNI.addActionListener(manejador);
		cuadroNombreProy.addActionListener(manejador);

		pack();
		setLocationRelativeTo(null);
		setResizable(false);
		setVisible(true);		
	}

	
	
	public class ManejadorVentanaAsociarEmpleadosProyecto implements ActionListener {
		
		public void actionPerformed (ActionEvent e) {
			
			Proyecto proyectoAAsociar = new Proyecto();
			Empleado empleadoAAsociar = new Empleado();
		
			Object obj = e.getSource();
			
			if (obj == botonAceptar) {
				proyectoAAsociar.setTitulo(cuadroNombreProy.getText());
				empleadoAAsociar.setNif(cuadroDNI.getText().toUpperCase());
				try {
					Conexion.asociarEmpleadoProyecto(empleadoAAsociar, proyectoAAsociar);
					JOptionPane.showMessageDialog(new JFrame(), "Empleado asociado correctamente");
				}
				catch (SQLException exc) {
					JOptionPane.showMessageDialog(new JFrame(), "Error, alguno de los datos no es correcto");
				}
				int n = JOptionPane.showConfirmDialog(new JFrame(),
					    "¿Quieres seguir asociando empleados a proyectos?",
					    "¿Seguir?",
					    JOptionPane.YES_NO_OPTION);
				if (n == JOptionPane.NO_OPTION) { // Salir
					Interfaz.nuevaVentanaAsociarEmpleadosProyecto.dispose();
				}
				else {
					cuadroDNI.setText("");
				}

			}
			else if (obj == botonCancelar) {
				Interfaz.nuevaVentanaAsociarEmpleadosProyecto.dispose();
			}
		}
	}

}
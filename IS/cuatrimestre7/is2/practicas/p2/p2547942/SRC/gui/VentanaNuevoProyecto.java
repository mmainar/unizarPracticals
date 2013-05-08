package gui;

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
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

import bd.Conexion;


public class VentanaNuevoProyecto extends JFrame {
		
	/* Cuadros de texto y botones */	
	JButton botonAceptar = new JButton("Aceptar");
	JButton botonCancelar = new JButton("Cancelar");
	JTextField cuadroNombre = new JTextField();
	JTextField cuadroDescripcion = new JTextField();	
	JTextField cuadroDiaFechaIni = new JTextField("1");
	JTextField cuadroMesFechaIni = new JTextField("1");
	JTextField cuadroAnhoFechaIni = new JTextField("2000");
	JTextField cuadroDiaFechaFin = new JTextField("1");
	JTextField cuadroMesFechaFin = new JTextField("1");
	JTextField cuadroAnhoFechaFin = new JTextField("2000");	
	
	
	public VentanaNuevoProyecto() {
		
		super("Nuevo proyecto");
			
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

		/* Añadimos los elementos al layout*/				
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
		c.gridx = 7;
		frameContainer.add(botonCancelar,c);
		
		/* Añadimos los manejadores */
		ManejadorVentanaNuevoProyecto manejador = new ManejadorVentanaNuevoProyecto();
		
		botonAceptar.addActionListener(manejador);
		botonCancelar.addActionListener(manejador);	
	
		pack();
		setLocationRelativeTo(null);
		setVisible(true);
			

		
	}
	
	public class ManejadorVentanaNuevoProyecto implements ActionListener {
		
		public void actionPerformed (ActionEvent e) {
			
			Proyecto proyectoAInsertar;
		
			Object obj = e.getSource();
			if (obj == botonAceptar) {
				proyectoAInsertar = new Proyecto();
				try {
					proyectoAInsertar.setTitulo(cuadroNombre.getText());
					proyectoAInsertar.setDescripcion(cuadroDescripcion.getText());
					proyectoAInsertar.setFechaInic(Date.valueOf(cuadroAnhoFechaIni.getText()+"-"+
																cuadroMesFechaIni.getText()+"-"+
																cuadroDiaFechaIni.getText()));
					proyectoAInsertar.setFechaFin(Date.valueOf(cuadroAnhoFechaFin.getText()+"-"+
																cuadroMesFechaFin.getText()+"-"+
																cuadroDiaFechaFin.getText()));
				}
				// Si alguno de los datos es incorrecto ya se encargará el método esCorrecto de
				// indicar el fallo.
				catch (Exception excepcion) {
					proyectoAInsertar.setTitulo("");
					proyectoAInsertar.setDescripcion("");
					proyectoAInsertar.setFechaInic(Date.valueOf("0-0-0"));
					proyectoAInsertar.setFechaFin(Date.valueOf("0-0-0"));
				}
				if (proyectoAInsertar.esCorrecto()) {
					try {
						Conexion.insertarProyecto(proyectoAInsertar);
						JOptionPane.showMessageDialog(new JFrame(), "Proyecto insertado correctamente.");
						Interfaz.nuevaVentanaNuevoProyecto.dispose();
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error al insertar el proyecto.");
					}
				}
				else {
					JOptionPane.showMessageDialog(new JFrame(), "Error, alguno de los datos no es válido.");
				}
			}
			else if (obj == botonCancelar) {
				Interfaz.nuevaVentanaNuevoProyecto.dispose();
			}
		
		}

	
	}
}

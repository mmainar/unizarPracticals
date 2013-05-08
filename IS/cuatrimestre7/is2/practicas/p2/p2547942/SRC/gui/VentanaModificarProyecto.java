package gui;

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

import infoProyec.*;


public class VentanaModificarProyecto extends JFrame{

	/* Botones y cuadros de texto */
	JButton botonAceptar = new JButton("Aceptar");
	JButton botonCancelar = new JButton("Cancelar");	
	JTextField cuadroNombre = new JTextField();
	JTextField cuadroDescripcion = new JTextField();	
	JTextField cuadroDiaFechaIni = new JTextField();
	JTextField cuadroMesFechaIni = new JTextField();
	JTextField cuadroAnhoFechaIni = new JTextField();
	JTextField cuadroDiaFechaFin = new JTextField();
	JTextField cuadroMesFechaFin = new JTextField();
	JTextField cuadroAnhoFechaFin = new JTextField();	

	
	public VentanaModificarProyecto(Proyecto proyectoAModificar) {
					
			super("Modificar proyecto");
			
			/* Etiqutas */
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
			c.gridx = 7;
			frameContainer.add(botonCancelar,c);

			/* Ponemos los manejadores */
			ManejadorVentanaModificarProyecto manejador = new ManejadorVentanaModificarProyecto();

			
			cuadroNombre.setText(proyectoAModificar.getTitulo());
			cuadroNombre.setEditable(false);
			cuadroDescripcion.setText(proyectoAModificar.getDescripcion());
			String cadenaFechaIni = proyectoAModificar.getFechaInic().toString();
			cuadroDiaFechaIni.setText(cadenaFechaIni.substring(8,10));
			cuadroMesFechaIni.setText(cadenaFechaIni.substring(5,7));
			cuadroAnhoFechaIni.setText(cadenaFechaIni.substring(0,4));
			String cadenaFechaFin = proyectoAModificar.getFechaFin().toString();
			cuadroDiaFechaFin.setText(cadenaFechaFin.substring(8,10));
			cuadroMesFechaFin.setText(cadenaFechaFin.substring(5,7));
			cuadroAnhoFechaFin.setText(cadenaFechaFin.substring(0,4));
			botonAceptar.addActionListener(manejador);	
			botonCancelar.addActionListener(manejador);
		
			pack();
			setLocationRelativeTo(null);
			setVisible(true);

	}
	
	
	public class ManejadorVentanaModificarProyecto implements ActionListener {
		
		public void actionPerformed (ActionEvent e) {
			
			Proyecto proyectoModificado;
		
			Object obj = e.getSource();
			if (obj == botonAceptar) {
				proyectoModificado = new Proyecto();
				try {
					proyectoModificado.setTitulo(cuadroNombre.getText());
					proyectoModificado.setDescripcion(cuadroDescripcion.getText());
					proyectoModificado.setFechaInic(Date.valueOf(cuadroAnhoFechaIni.getText()+"-"+																cuadroDiaFechaIni.getText()));
					proyectoModificado.setFechaFin(Date.valueOf(cuadroAnhoFechaFin.getText()+"-"+
																cuadroMesFechaFin.getText()+"-"+
																cuadroDiaFechaFin.getText()));
				} /* Si hay algun error el metodo esCorrecto se encargara de decir que los datos no son validos */
				catch (Exception excepcion) {
					proyectoModificado.setTitulo("");
					proyectoModificado.setDescripcion("");
					proyectoModificado.setFechaInic(Date.valueOf("0-0-0"));
					proyectoModificado.setFechaFin(Date.valueOf("0-0-0"));
				}
				if (proyectoModificado.esCorrecto()) {
					try {
						Conexion.modificarProyecto(proyectoModificado);
						JOptionPane.showMessageDialog(new JFrame(), "Proyecto modificado correctamente.");
						Interfaz.nuevaVentanaModificarProyecto.dispose();
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error al modificar el proyecto.");
					}
				}
				else {
					JOptionPane.showMessageDialog(new JFrame(), "Error, alguno de los datos no es válido.");
				}
			}
			else if (obj == botonCancelar) {
				Interfaz.nuevaVentanaModificarProyecto.dispose();
			}
			
		}
	}

	
	
}

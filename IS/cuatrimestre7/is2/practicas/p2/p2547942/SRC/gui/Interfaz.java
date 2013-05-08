package gui;

import java.sql.*;
import java.util.Vector;
import java.awt.event.*;
import javax.swing.*;
import bd.*;
import infoProyec.*;


/*  Fichero: interfaz.java
    Descripcion: Este fichero implementa todas las funciones de interfaz y creacion de nuevas ventanas
*/

public class Interfaz {

	
	JFrame ventanaPrincipal;
	
	// Declaracion todas las pestañas de menú de la aplicación
	JMenuItem opcionNuevoProyecto = new JMenuItem("Nuevo proyecto");
	JMenuItem opcionVerProyecto = new JMenuItem("Ver proyecto");
	JMenuItem opcionModificarProyecto = new JMenuItem("Modificar proyecto");
	JMenuItem opcionAsociarEmpleadosProyecto = new JMenuItem("Asociar empleados a un proyecto");
	JMenuItem opcionVerEmpleadosProyecto = new JMenuItem("Ver los empleados asociados a un proyecto");
	JMenuItem opcionListarProyectos = new JMenuItem("Listar proyectos");
	JMenuItem opcionNuevoEmpleado = new JMenuItem("Nuevo empleado");
	JMenuItem opcionVerEmpleado = new JMenuItem("Ver empleado");
	JMenuItem opcionModificarEmpleado = new JMenuItem("Modificar empleado");
	JMenuItem opcionVerProyectosEmpleado = new JMenuItem("Ver los proyectos asociados a un empleado");
	JMenuItem opcionListarEmpleados = new JMenuItem("Listar empleados");
	JMenuItem opcionSalir = new JMenuItem("Salir");
	
	// Declaracion todas las ventanas de la aplicacion
	static VentanaNuevoProyecto nuevaVentanaNuevoProyecto;
	static VentanaVerProyecto nuevaVentanaVerProyecto;
	static VentanaNuevoEmpleado nuevaVentanaNuevoEmpleado;
	static VentanaVerEmpleado nuevaVentanaVerEmpleado;
	static VentanaModificarProyecto nuevaVentanaModificarProyecto;
	static VentanaModificarEmpleado nuevaVentanaModificarEmpleado;
	static VentanaEmpleadosProyecto nuevaVentanaVerEmpleadosProyecto;
	static VentanaAsociarEmpleadosProyecto nuevaVentanaAsociarEmpleadosProyecto;
	static VentanaProyectosEmpleado nuevaVentanaVerProyectosEmpleado; 
	static VentanaListarProyectos nuevaVentanaListarProyectos;
	static VentanaListarEmpleados nuevaVentanaListarEmpleados;

	// Declaracion todas los dos menus principles de la aplicacion
	static JMenu menuProyectos = new JMenu("Proyectos");	
	static JMenu menuEmpleados = new JMenu("Empleados");

	
	public Interfaz() {
        // Constructor del interfaz, crea la ventana principal
		
		ventanaPrincipal = new JFrame("Acceso a base de datos e interfaces gráficas de usuario en Java");
		ventanaPrincipal.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		crearMenu();
		JFrame.setDefaultLookAndFeelDecorated(true);
		ventanaPrincipal.setSize(500,500);
		ventanaPrincipal.setLocationRelativeTo(null);
		ventanaPrincipal.setVisible(true);
	}


	private void crearMenu() {
	// Método privado que añade las pestañas a la ventana
		
		JMenuBar barraMenu = new JMenuBar();
		
		menuProyectos.setEnabled(false);
		barraMenu.add(menuProyectos);
		menuProyectos.add(opcionNuevoProyecto);
		menuProyectos.add(opcionVerProyecto);
		menuProyectos.add(opcionModificarProyecto);
		menuProyectos.add(opcionAsociarEmpleadosProyecto);
		menuProyectos.add(opcionVerEmpleadosProyecto);
		menuProyectos.add(opcionListarProyectos);
		
		menuEmpleados.setEnabled(false);
		barraMenu.add(menuEmpleados);
		menuEmpleados.add(opcionNuevoEmpleado);
		menuEmpleados.add(opcionVerEmpleado);
		menuEmpleados.add(opcionModificarEmpleado);
		menuEmpleados.add(opcionVerProyectosEmpleado);
		menuEmpleados.add(opcionListarEmpleados);
		
		barraMenu.add(opcionSalir);
		
		ventanaPrincipal.setJMenuBar(barraMenu);
		
	        // Añadimos los manejadores
		
		ManejadorOpcionesMenuPrincipal miManejadorOpcionesMenuPrincipal 
			= new ManejadorOpcionesMenuPrincipal();
		
		opcionNuevoProyecto.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionVerProyecto.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionModificarProyecto.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionNuevoEmpleado.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionVerEmpleado.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionModificarEmpleado.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionSalir.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionVerEmpleadosProyecto.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionAsociarEmpleadosProyecto.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionVerProyectosEmpleado.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionListarProyectos.addActionListener(miManejadorOpcionesMenuPrincipal);
		opcionListarEmpleados.addActionListener(miManejadorOpcionesMenuPrincipal);
	}

	
	public class ManejadorOpcionesMenuPrincipal implements ActionListener {
		
		public void actionPerformed (ActionEvent e) {
			Object obj = e.getSource();
			
			if (obj == opcionNuevoProyecto) {
				nuevaVentanaNuevoProyecto = new VentanaNuevoProyecto();
			}
			
			else if (obj == opcionVerProyecto) {
				String nombreProyecto = JOptionPane.showInputDialog("Titulo del proyecto a buscar");
				if (nombreProyecto != null) {
					try {
						Proyecto proyectoABuscar = Conexion.obtenerProyecto(nombreProyecto);
						nuevaVentanaVerProyecto = new VentanaVerProyecto(proyectoABuscar);
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error, no existe el proyecto.");
					}
				}
			}
			
			else if (obj == opcionNuevoEmpleado) {
				nuevaVentanaNuevoEmpleado = new VentanaNuevoEmpleado();
			}
			
			else if (obj == opcionVerEmpleado) {
				String nifEmpleado = JOptionPane.showInputDialog("NIF del empleado a buscar");
				if (nifEmpleado != null) {
					try {
						nifEmpleado = nifEmpleado.toUpperCase();
						Empleado empleadoABuscar = Conexion.obtenerEmpleado(nifEmpleado);
						nuevaVentanaVerEmpleado = new VentanaVerEmpleado(empleadoABuscar);
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error, no existe el empleado.");
					}
				}
			}
			
			else if (obj == opcionModificarProyecto) {
				String nombreProyectoComprobacion = JOptionPane.showInputDialog("Nombre del proyecto a modificar");
				if (nombreProyectoComprobacion != null) {
					try {
						Proyecto proyectoAModificar = Conexion.obtenerProyecto(nombreProyectoComprobacion); // Para comprobar si existe
						nuevaVentanaModificarProyecto = new VentanaModificarProyecto(proyectoAModificar);
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error, no existe el empleado.");
					}
				}
			}
			
			else if (obj == opcionModificarEmpleado) {
				String nifEmpleadoComprobacion = JOptionPane.showInputDialog("NIF del empleado a modificar");
				if (nifEmpleadoComprobacion != null) {
					try {
						nifEmpleadoComprobacion = nifEmpleadoComprobacion.toUpperCase();
						Empleado empleadoAModificar = Conexion.obtenerEmpleado(nifEmpleadoComprobacion); // Para comprobar si existe
						nuevaVentanaModificarEmpleado = new VentanaModificarEmpleado(empleadoAModificar);
						
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error, no existe el empleado.");
					}
				}
			}
			
			else if (obj == opcionVerEmpleadosProyecto) {
				Proyecto proyectoABuscar = new Proyecto();
				proyectoABuscar.setTitulo(JOptionPane.showInputDialog("Titulo del proyecto a buscar: "));
				if (proyectoABuscar.getTitulo() != null) {
					try {
						Vector<Empleado> vectorBusqueda = Conexion.listarEmpleadosProyecto(proyectoABuscar);
						if (vectorBusqueda.size() != 0) {
							nuevaVentanaVerEmpleadosProyecto = new VentanaEmpleadosProyecto(vectorBusqueda,
																		proyectoABuscar.getTitulo());
						}
						else {
							JOptionPane.showMessageDialog(new JFrame(), "No existen empleados asociados al proyecto.");
						}
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error, no existe el proyecto.");
					}
				}
			}
			
			else if (obj == opcionVerProyectosEmpleado) {
				Empleado empleadoABuscar = new Empleado();
				empleadoABuscar.setNif(JOptionPane.showInputDialog("DNI del empleado: "));
				if (empleadoABuscar.getNif() != null) {
					try {
						Vector<Proyecto> vectorBusqueda = Conexion.listarProyectosEmpleado(empleadoABuscar);
						if (vectorBusqueda.size() != 0) {
							nuevaVentanaVerProyectosEmpleado = new VentanaProyectosEmpleado(vectorBusqueda,
																empleadoABuscar.getNif());
						}
						else {
							JOptionPane.showMessageDialog(new JFrame(), "No existen proyectos asociados al empleado.");	
						}
					}
					catch (SQLException excepcion) {
						JOptionPane.showMessageDialog(new JFrame(), "Error, no existe el empleado.");
					}
				}
			}
			
			else if (obj == opcionAsociarEmpleadosProyecto) {
				nuevaVentanaAsociarEmpleadosProyecto = new VentanaAsociarEmpleadosProyecto();
			}
			
			else if (obj == opcionListarProyectos) {
				try {
					Vector<Proyecto> vectorProyectos = Conexion.listarProyectos();
					nuevaVentanaListarProyectos = new VentanaListarProyectos(vectorProyectos);
				}
				catch (SQLException excepcion) {
					JOptionPane.showMessageDialog(new JFrame(), "Se ha producido un error consultando los proyectos.");
				}
			}
			
			else if (obj == opcionListarEmpleados) {
				try {
					Vector<Empleado> vectorEmpleados = Conexion.listarEmpleados();
					nuevaVentanaListarEmpleados = new VentanaListarEmpleados(vectorEmpleados);
				}
				catch (SQLException excepcion) {
					JOptionPane.showMessageDialog(new JFrame(), "Se ha producido un error consultando los empleados.");
				}	
			}
			
			else if (obj == opcionSalir) {
				ventanaPrincipal.dispose();
				System.exit(0);
			}
			
		}
	}



	static public void ventanaConectadoBien() {
		JOptionPane.showMessageDialog(new JFrame(), "Conectado correctamente a la base de datos.");
	}
	

	static public void ventanaErrorConectando() {
		JOptionPane.showMessageDialog(new JFrame(), "Error conectándose a la base de datos.");
	}


	static public void habilitarMenus () {
		menuProyectos.setEnabled(true);
		menuEmpleados.setEnabled(true);
	}



	
}




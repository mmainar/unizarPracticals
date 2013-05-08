package gui;

import infoProyec.Empleado;

import java.util.Vector;
import infoProyec.*;
import javax.swing.*;

import javax.swing.JTable;

public class VentanaProyectosEmpleado extends JFrame {

	
	public VentanaProyectosEmpleado (Vector<Proyecto> vectorProyectos, String nifEmpleado) {

		super("Proyectos asociados al empleado ");
		
		String[] campos = {"Título","Descripción","Fecha de inicio","Fecha de fin"};
		
		Object [][] matrizProyectos = new Object[vectorProyectos.size()][4];
		
		for (int i = 0; i < vectorProyectos.size(); i++) {
			matrizProyectos[i][0] = vectorProyectos.get(i).getTitulo();
			matrizProyectos[i][1] = vectorProyectos.get(i).getDescripcion();
			matrizProyectos[i][2] = vectorProyectos.get(i).getFechaInic();
			matrizProyectos[i][3] = vectorProyectos.get(i).getFechaFin();
		}
		
		
		
		final JTable tabla = new JTable(matrizProyectos,campos);
		JScrollPane scrollPane = new JScrollPane(tabla);
		tabla.setEnabled(false);
		getContentPane().add(scrollPane);
		pack();
		setResizable(false);
		setLocationRelativeTo(null);
		setVisible(true);
	}
}

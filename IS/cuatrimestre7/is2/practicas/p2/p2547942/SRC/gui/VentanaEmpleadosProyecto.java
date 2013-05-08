package gui;

import infoProyec.*;
import java.util.Vector;
import javax.swing.*;

public class VentanaEmpleadosProyecto extends JFrame {
	
	public VentanaEmpleadosProyecto (Vector<Empleado> vectorEmpleados, String nombreProy) {

		super("Empleados asociados al proyecto ");
		
		String[] campos = {"Nombre","Apellidos","NIF","Año de nacimiento"};
		
		// Volcamos los datos sobre una matriz
		Object [][] matrizEmpleados = new Object[vectorEmpleados.size()][4];
		
		for (int i = 0; i < vectorEmpleados.size(); i++) {
			matrizEmpleados[i][0] = vectorEmpleados.get(i).getNombre();
			matrizEmpleados[i][1] = vectorEmpleados.get(i).getApellidos();
			matrizEmpleados[i][2] = vectorEmpleados.get(i).getNif();
			matrizEmpleados[i][3] = vectorEmpleados.get(i).getAnyoNac();
		}
		
		final JTable tabla = new JTable(matrizEmpleados,campos);	
		JScrollPane scrollPane = new JScrollPane(tabla);
		tabla.setEnabled(false);
		getContentPane().add(scrollPane);
		pack();
		setResizable(false);
		setLocationRelativeTo(null);
		setVisible(true);
	}
}
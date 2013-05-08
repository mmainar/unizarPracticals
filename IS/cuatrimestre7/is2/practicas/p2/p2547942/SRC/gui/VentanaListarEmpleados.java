package gui;

import infoProyec.*;

import java.sql.SQLException;
import java.util.Vector;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;

public class VentanaListarEmpleados extends JFrame {

	public VentanaListarEmpleados(Vector<Empleado> vectorEmpleados) {
		super("Empleados");
		
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
		setLocationRelativeTo(null);
		setResizable(false);
		pack();
		setVisible(true);

		
	}
	
}

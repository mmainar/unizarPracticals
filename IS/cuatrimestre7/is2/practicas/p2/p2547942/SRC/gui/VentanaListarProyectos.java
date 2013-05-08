package gui;

import javax.swing.JScrollPane;
import java.util.Vector;
import infoProyec.*;
import javax.swing.JFrame;
import javax.swing.JTable;

public class VentanaListarProyectos extends JFrame{

	
		public VentanaListarProyectos(Vector<Proyecto> vectorProyectos) {
			
			super("Proyectos");
			Object[] campos = {"Título","Descripción","Fecha de inicio","Fecha de fin"};
			
			// Volcamos los datos sobre una matriz
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

			setResizable(false);
			setLocationRelativeTo(null);
			pack();
			setVisible(true);			
		}
}

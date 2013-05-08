//	 declarar paquetes necesarios
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.StringTokenizer;
import javax.swing.JPanel;
import javax.swing.table.AbstractTableModel;
import javax.swing.event.*;
import javax.swing.table.TableModel;
import javax.swing.JTree;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.event.TreeModelEvent;
import javax.swing.event.TreeModelListener;
import javax.swing.tree.TreeModel;
import javax.swing.tree.TreePath;
import java.util.Vector;
import java.util.Iterator;




//	 clase que crea el menu
	
@SuppressWarnings("serial")
public class Aplicacion extends JFrame {
	  Container frameContainer;
	  // Crear los items de menu (JMenuItem) y el separador (JSeparator).
	  JMenuItem menuItem1 = new JMenuItem("Nuevo");
	  JMenuItem menuItem2 = new JMenuItem("Abrir");
	  JMenuItem menuItem3 = new JMenuItem("Salvar");
	  JMenuItem menuItem4 = new JMenuItem("Salir");
	  JMenuItem menuItem5 = new JMenuItem("Tabla");
	  JMenuItem menuItem6 = new JMenuItem("Arbol");
	  JSeparator separator = new JSeparator();
	  // Crear el campo de texto (JTextField).
	  JTextField textField = new JTextField(6);

	  final int altura = 500;
	  final int anchura = 200;

	 

	  @SuppressWarnings("static-access")
	public Aplicacion() {
	    // 1. Crear el frame (para ello invoca al constructor de la superclase)
	    // Equivalente a: JFrame frame = new JFrame("Un programa!");
	    super("Un programa!");
	    crearGUI();
	    crearManejadoresEvts();
	    // fijar tamanyo de la ventana, modo de operacion y mostrarla.
	    setDefaultCloseOperation(super.EXIT_ON_CLOSE);
	    // Pregunta por decoraciones de ventana proporcionadas por el look & feel.
	    setDefaultLookAndFeelDecorated(true);
	    // 2. Opcional: ¿Que ocurre cuando el frame se cierra?
	    // 4. Dimensionar el frame
	    pack();
	    setSize(altura,anchura);
	    // 5. Mostrar el frame
	    setVisible(true);
	  }
	  
	  void crearGUI() {
	    crearMenu();
	    situarComponentes();
	  }

	  void crearMenu() {
	    // Crear la barra de menu (JMenuBar).
	    JMenuBar menuBar = new JMenuBar();
	    // Crear las opciones del menu principal (JMenu).
	    JMenu menu1 = new JMenu("Fichero");
	    JMenu menu2 = new JMenu("Mis Dialogos");
	    // Añadir las opciones principales a la barra de menu.
	    menuBar.add(menu1);
	    menuBar.add(menu2);
	    // Añadir los items de menu a su opcion principal.
	    menu1.add(menuItem1);
	    menu1.add(menuItem2);
	    menu1.add(menuItem3);
	    menu1.addSeparator();
	    menu1.add(menuItem4);
	    menu2.add(menuItem5);
	    menu2.add(menuItem6);
	    // Configurar la barra de menu (set JMenuBar(..)).
	    setJMenuBar(menuBar);
	  }
	  
	  void situarComponentes() {
	    frameContainer = getContentPane();
	    frameContainer.setLayout(new FlowLayout(FlowLayout.CENTER,altura/2,anchura/2));
	    // Dar tamaño al campo de texto (textField) y unirlo al frameContainer.
	    frameContainer.add(textField);
	  }
	  
	  void crearManejadoresEvts() { 
	    addWindowListener(new ManejadorVentana()); // gestiona evts. vent. ppal.
	    // AñadirManejadores a los items de menu (y al campo de texto).
	    menuItem1.addActionListener(new ManejadorItemMenu());
	    menuItem2.addActionListener(new ManejadorItemMenu());
	    menuItem3.addActionListener(new ManejadorItemMenu());
	    menuItem4.addActionListener(new ManejadorItemMenu());
	    menuItem5.addActionListener(new ManejadorItemMenu());
	    menuItem6.addActionListener(new ManejadorItemMenu());
	    textField.addActionListener(new ManejadorItemMenu());
	  }
	  
	  public class ManejadorVentana extends WindowAdapter {
	    // implementar el metodo correspondiente
	    // para que la aplicacion termine correctamente.

		  public void windowClosed(WindowEvent e)
		  {
			  System.exit(0);
		  }
	  }
	  
	  public class ManejadorItemMenu implements ActionListener {
	    // implementar el metodo correspondiente para que Fichero/Salir
	    // termine la Aplicacion y el resto de opciones escriban
	    // en el campo de texto su nombre.

	    public void actionPerformed(ActionEvent e) {
	      //...Get information from the action event...
	      //...Display it in the text area...
	      Object obj = e.getSource();
	      if (obj == menuItem1) 
	      {
		    textField.setText("Nuevo");
		  }
	      else if (obj == menuItem2)
	      {
			textField.setText("Abrir"); 
	      }
	      else if (obj == menuItem3)
	      {
	    	textField.setText("Salvar");
	      }	
	      else if (obj == menuItem4)
	      {
	    	textField.setText("Salir");
	    	System.exit(0);
	      }
	      else if (obj == menuItem5)
	      {
	    	textField.setText("Tabla");
	        extraerDatos extra = new extraerDatos();
	        Thread miThread = new Thread(extra);
	        miThread.start();
	        try {
				miThread.join();
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            // Duda, como volver al thread de manejo de eventos
			// Es decir, que al ejecutar esto se vuelva a la ventana
			// principal
	      }
	      else if (obj == menuItem6)
	      {
	    	textField.setText("Arbol");
	    	generarArbol arbol = new generarArbol();
	    	Thread miThread2 = new Thread(arbol);
	    	miThread2.start();
	        try {
				miThread2.join();
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	      }	
		
	    }
	  } 	  
	  
	  public class generarArbol implements Runnable
	  {
		  	  
		  public class FileTreeFrame extends JFrame {
			  private JTree fileTree;
			  private FileSystemModel fileSystemModel;
			  private JTextArea fileDetailsTextArea = new JTextArea();

			  public FileTreeFrame(String directory) {
			    super("JTree FileSystem Viewer");
			    fileDetailsTextArea.setEditable(false);
			    fileSystemModel = new FileSystemModel(new File(directory));
			    fileTree = new JTree(fileSystemModel);
			    fileTree.setEditable(true);
			    fileTree.addTreeSelectionListener(new TreeSelectionListener() {
			      public void valueChanged(TreeSelectionEvent event) {
			        File file = (File) fileTree.getLastSelectedPathComponent();
			        fileDetailsTextArea.setText(getFileDetails(file));
			      }
			    });
			    JSplitPane splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, true, new JScrollPane(
			        fileTree), new JScrollPane(fileDetailsTextArea));
			    getContentPane().add(splitPane);
			    setDefaultCloseOperation(EXIT_ON_CLOSE);
			    setSize(640, 480);
			    setVisible(true);
			  }

			  private String getFileDetails(File file) {
			    if (file == null)
			      return "";
			    StringBuffer buffer = new StringBuffer();
			    buffer.append("Name: " + file.getName() + "\n");
			    buffer.append("Path: " + file.getPath() + "\n");
			    buffer.append("Size: " + file.length() + "\n");
			    return buffer.toString();
			  }
		  }

			class FileSystemModel implements TreeModel {
			  private File root;
			  private Vector listeners = new Vector();

			  public FileSystemModel(File rootDirectory) {
			    root = rootDirectory;
			  }

			  public Object getRoot() {
			    return root;
			  }

			  public Object getChild(Object parent, int index) {
			    File directory = (File) parent;
			    String[] children = directory.list();
			    return new TreeFile(directory, children[index]);
			  }

			  public int getChildCount(Object parent) {
			    File file = (File) parent;
			    if (file.isDirectory()) {
			      String[] fileList = file.list();
			      if (fileList != null)
			        return file.list().length;
			    }
			    return 0;
			  }

			  public boolean isLeaf(Object node) {
			    File file = (File) node;
			    return file.isFile();
			  }

			  public int getIndexOfChild(Object parent, Object child) {
			    File directory = (File) parent;
			    File file = (File) child;
			    String[] children = directory.list();
			    for (int i = 0; i < children.length; i++) {
			      if (file.getName().equals(children[i])) {
			        return i;
			      }
			    }
			    return -1;

			  }

			  public void valueForPathChanged(TreePath path, Object value) {
			    File oldFile = (File) path.getLastPathComponent();
			    String fileParentPath = oldFile.getParent();
			    String newFileName = (String) value;
			    File targetFile = new File(fileParentPath, newFileName);
			    oldFile.renameTo(targetFile);
			    File parent = new File(fileParentPath);
			    int[] changedChildrenIndices = { getIndexOfChild(parent, targetFile) };
			    Object[] changedChildren = { targetFile };
			    fireTreeNodesChanged(path.getParentPath(), changedChildrenIndices, changedChildren);

			  }

			  private void fireTreeNodesChanged(TreePath parentPath, int[] indices, Object[] children) {
			    TreeModelEvent event = new TreeModelEvent(this, parentPath, indices, children);
			    Iterator iterator = listeners.iterator();
			    TreeModelListener listener = null;
			    while (iterator.hasNext()) {
			      listener = (TreeModelListener) iterator.next();
			      listener.treeNodesChanged(event);
			    }
			  }

			  @SuppressWarnings("unchecked")
			public void addTreeModelListener(TreeModelListener listener) {
			    listeners.add(listener);
			  }

			  public void removeTreeModelListener(TreeModelListener listener) {
			    listeners.remove(listener);
			  }

			  private class TreeFile extends File {
			    public TreeFile(File parent, String child) {
			      super(parent, child);
			    }

			    public String toString() {
			      return getName();
			    }
			  }
			}

		  
		  public void run()	  
		  {
			 new FileTreeFrame("/");
		  }
	  }
	  
	  public class extraerDatos implements Runnable
	  {
		  
	      Object[][] datos = {
	                {"Mary", "Campione",
	                 "Snowboarding", 5},
	                {"Alison", "Huml",
	                 "Rowing", 3},
	                {"Kathy", "Walrath",
	                 "Knitting", 2},
	                {"Sharon", "Zakhour",
	                 "Speed reading", 1}
	            };

		  String[] columnas = {"Nombre","Apellido","Telefono","Edad"}; 		
	      
		  public void run()	  
		  {
			  final JTable table = new JTable(datos,columnas);
			  
			  class MyTableModel extends AbstractTableModel implements TableModelListener 
			  {
				    public MyTableModel() 
				    {
				        table.getModel().addTableModelListener(this);
				    }

				    public void tableChanged(TableModelEvent e) {
				        int row = e.getFirstRow();
				        int column = e.getColumn();
				        TableModel model = (TableModel)e.getSource();
				        @SuppressWarnings("unused")
						String columnas = model.getColumnName(column);
				        @SuppressWarnings("unused")
						Object datos = model.getValueAt(row, column);
				        System.out.println("He modificado algooo");

				        // Do something with the data...
				        // Actualizar fichero
				    }
				  
				  
			        public int getColumnCount() 
			        {
			            return columnas.length;
			        }
					
			        public int getRowCount() 
			        {
			            return datos.length;
			        }

			        public String getColumnName(int col) 
			        {
			            return columnas[col];
			        }

			        public Object getValueAt(int row, int col) 
			        {
			            return datos[row][col];
			        }

			        /*
			         * JTable uses this method to determine the default renderer/
			         * editor for each cell.  If we didn't implement this method,
			         * then the last column would contain text ("true"/"false"),
			         * rather than a check box.
			         */
			        @SuppressWarnings("unchecked")
					public Class getColumnClass(int c) 
			        {
			            return getValueAt(0, c).getClass();
			        }

			        /*
			         * Don't need to implement this method unless your table's
			         * editable.
			         */
			        public boolean isCellEditable(int row, int col)
			        {
			            //Note that the data/cell address is constant,
			            //no matter where the cell appears onscreen.
			            return true;
			        }

			        /*
			         * Don't need to implement this method unless your table's
			         * data can change.
			         */
			        public void setValueAt(Object value, int row, int col) 
			        {
			            datos[row][col] = value;
			            fireTableCellUpdated(row, col);
			        }
			  }
			  				
			  BufferedReader inputStream = null;
			  
		      try 
		      {
		        	inputStream = new BufferedReader(new FileReader
		        	  ("/home/marcos/asignaturas/cuatrimestre7/is2/practicas/p1/clientes.txt"));
		  		    String l; int lin = 0; int col = 0;
				    while ((l = inputStream.readLine()) != null) {
					  StringTokenizer st = new StringTokenizer(l);
					  while (st.hasMoreTokens()) 
					  {
						  datos[lin][col] = st.nextToken();
						  System.out.println(datos[lin][col]);
						  col++;
					  }
					  lin++; col=0;
				     }
				     
		        } catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
		        finally 
		        {
		        	if (inputStream != null) 
		        	{
		        	  try {
						inputStream.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		        	}
		        }
		        
		    	JFrame frame = new JFrame("Tabla");
		    	frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                // Construimos la tabla
		    	JPanel t = new JPanel(new GridLayout(1,0));
		    	// final JTable table = new JTable(new MyTableModel());
		        // Para poder ordenar la tabla por cualquier campo (columna)
		        table.setAutoCreateRowSorter(true);
		        table.setPreferredScrollableViewportSize(new Dimension(500, 70));
		        //table.setFillsViewportHeight(true);
		        table.getModel().addTableModelListener(new MyTableModel());
		        //Create the scroll pane and add the table to it.
		        JScrollPane scrollPane = new JScrollPane(table);
		        //Add the scroll pane to this panel.
		        t.add(scrollPane);		        
		        t.setOpaque(true); //content panes must be opaque
		        frame.setContentPane(t);
			    //Display the window.
			    frame.pack();
			    frame.setVisible(true);
		  }
	  }
		 
			     
	  
	  public static void main(String[] args) {
		    javax.swing.SwingUtilities.invokeLater(new Runnable() {
		    	public void run() { @SuppressWarnings("unused")
				Aplicacion app = new Aplicacion();}
		    	});
		  }
	  
}


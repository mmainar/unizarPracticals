package bd;  // Capa de acceso a datos de la aplicaci√≥n

import java.sql.*;
import java.io.IOException; // para la excepcion del metodo main
import infoProyec.*;
import gui.*;
import java.util.Vector;


/*  Fichero: conexion.java
    Descripcion: Este fichero implementa todas las funciones del acceso a la base de datos (consultas,
                 insrciones y actualizaciones) 
*/



public class Conexion implements Runnable {

	static Connection con;
	static String username;
	static String password;


	public static void conectar() throws ClassNotFoundException, SQLException 
	/* Conexion a la base de datos, creacion de tablas e introduccion de datos */
	{
	       String url ="jdbc:oracle:thin:@den.cps.unizar.es:1521:vicious";
	       // Para probar las consultas
	       Proyecto proy = new Proyecto("GNU Hurd","lololo", Date.valueOf("1991-6-1"), Date.valueOf("1991-6-1"));
	       Empleado emp = new Empleado("74223140C", "ko", "ka", 1990);
	       Empleado emp2 = new Empleado("74773140C", "ko", "ka", 1990);
	       Proyecto proy2 = new Proyecto("GNU Hurd2","lololo", Date.valueOf("1991-6-1"), Date.valueOf("1991-6-1"));
	       Empleado emp3 = new Empleado("74773140C", "funciona", "kaaaa", 1990);
	       Proyecto proy3 = new Proyecto("GNU Hurd","funciona", Date.valueOf("1991-6-1"), Date.valueOf("1991-6-1"));

	       Class.forName("oracle.jdbc.driver.OracleDriver");
	       con = DriverManager.getConnection(url, username, password);
	       crearTablas();
	       con.setAutoCommit(true);
	       // Insertamos tuplas de ejemplo
	       introducirDatos();
        }


	private static boolean borrarTabla(String nombreTab) throws SQLException
	{
	        Statement stmtBorrar = con.createStatement();
        	stmtBorrar.executeQuery("DROP TABLE " + nombreTab + " cascade constraints");
       		stmtBorrar.close();
	       return true;
	}


	private static boolean crearTablas () throws SQLException
	{
		try {
       			borrarTabla("Empleados");
 	        	borrarTabla("Proyectos");
		        borrarTabla("Participar");
		} /* Si no existen dara excepcion */
		catch (SQLException e){;}
	        Statement stmtCrear = con.createStatement();
         	stmtCrear.executeQuery("CREATE TABLE Empleados (NIF VARCHAR(9) PRIMARY KEY "
                  + "NOT NULL, nombre VARCHAR(20) NOT NULL, apellidos VARCHAR(20) NOT "
                  + "NULL, anyo NUMBER(4) NOT NULL)");
	        stmtCrear.executeQuery("CREATE TABLE Proyectos (titulo VARCHAR(20) PRIMARY KEY "
                + "NOT NULL, descripcion VARCHAR(50), fechaIni DATE, fechaFin DATE)");
          	stmtCrear.executeQuery("CREATE TABLE Participar (titulo VARCHAR(20), NIF VARCHAR(9), "
                + "CONSTRAINT    Participar_PK        PRIMARY KEY   (titulo, NIF), "
                + " CONSTRAINT titulo_FK FOREIGN KEY (titulo) REFERENCES Proyectos(titulo) ON DELETE CASCADE, "
                + "CONSTRAINT NIF_FK FOREIGN KEY (NIF) REFERENCES Empleados(NIF) ON DELETE CASCADE)");

	        stmtCrear.close();
       		return true;
	}

	
	public static void introducirDatos() throws SQLException
	{
		introducirDatosEmpleados();
		introducirDatosProyectos();
		introducirDatosParticipar();
	}
	
	
	private static void introducirDatosEmpleados() throws SQLException
	{
		PreparedStatement insertarEmpleados;
		String cadInsercion = "INSERT into Empleados values (?,?,?,?)";
		String [] nifs = {"74223140C", "87491498A", "76989872W", "18763827M", "86254123F"};
		String [] nombres = {"Eduardo", "Julian", "Juan Luis", "Pepe", "Carlos"};
		String [] apellidos = {"Perez Greco", "Mateo Alvarez", "Aguilar", "Cristo Fuente", "Abad Rubio"};
		int [] anyos = {1975, 1950, 1960, 1955, 1980};
		int len = nifs.length;
	        insertarEmpleados = con.prepareStatement(cadInsercion);

		for (int i = 0; i < len; i++) 
		{
		  insertarEmpleados.setString(1, nifs[i]);
		  insertarEmpleados.setString(2, nombres[i]);
		  insertarEmpleados.setString(3, apellidos[i]);
		  insertarEmpleados.setInt(4, anyos[i]);
		  insertarEmpleados.executeUpdate();
		}				
	}
	
	
	private static void introducirDatosProyectos() throws SQLException
	{
		PreparedStatement insertarProyectos;
		String cadInsercion = "INSERT into Proyectos values (?,?,?,?)";
		String [] titulos = {"GNU Hurd", "GCC", "SETI", "Chrome", "Android"};
		String [] desc = {"El kernel de GNU", "Coleccion de compiladores", "Vida extraterrestre",
				"El navegador de Google", "El sistema operativo de Google para moviles"};
		Date [] fechasInic = {Date.valueOf("1991-6-1"),	Date.valueOf("1991-8-20"), Date.valueOf("2000-2-1")
				            , Date.valueOf("2006-8-20"), Date.valueOf("1991-8-20")};
		Date [] fechasFin = {Date.valueOf("2050-6-1"),	Date.valueOf("1995-8-20"), Date.valueOf("2020-2-1")
						    , Date.valueOf("2010-3-15"), Date.valueOf("2010-8-20")};
		int len = titulos.length;
	    insertarProyectos = con.prepareStatement(cadInsercion);

		for (int i = 0; i < len; i++) 
		{
		  insertarProyectos.setString(1, titulos[i]);
		  insertarProyectos.setString(2, desc[i]);
		  insertarProyectos.setDate(3, fechasInic[i]);
		  insertarProyectos.setDate(4, fechasFin[i]);
		  insertarProyectos.executeUpdate();
		}				
	}
	
	
	private static void introducirDatosParticipar() throws SQLException
	{
		PreparedStatement insertarParticipar;
		String cadInsercion = "INSERT into Participar values (?,?)";
		String [] titulos = {"GNU Hurd", "GCC", "SETI", "Chrome", "Android"};
		String [] nifs = {"74223140C", "87491498A", "76989872W", "18763827M", "86254123F"};
		int len = titulos.length;
 	        insertarParticipar = con.prepareStatement(cadInsercion);

		for (int i = 0; i < len; i++) 
		{
		  insertarParticipar.setString(1, titulos[i]);
		  insertarParticipar.setString(2, nifs[i]);
		  insertarParticipar.executeUpdate();
		}				
	}
	
	
	public static Vector<Empleado> listarEmpleados() throws SQLException
	{
		Statement listarEmpleados = con.createStatement();
		ResultSet resul;
		Vector<Empleado> emp = new Vector<Empleado>();
		int i = 0; // Numero de filas devueltas por la consulta
		String consultaListado = "SELECT * FROM EMPLEADOS";
		resul = listarEmpleados.executeQuery(consultaListado);
		while(resul.next()) 
		{
			emp.add(new Empleado(resul.getString("NIF"), resul.getString("nombre"),
					              resul.getString("apellidos"), resul.getInt("anyo")));
			i++;
		}
		
		listarEmpleados.close();
		return emp;	
	}
	
	
	public static Vector<Proyecto> listarProyectos() throws SQLException
	{
		Statement listarProyectos = con.createStatement();
		ResultSet resul;
		Vector<Proyecto> proy = new Vector<Proyecto>();
		int i = 0; // Numero de filas devueltas por la consulta
		String consultaListado = "SELECT * FROM PROYECTOS";
		resul = listarProyectos.executeQuery(consultaListado);
		while(resul.next()) 
		{
			proy.add(new Proyecto(resul.getString("titulo"), resul.getString("descripcion"),
					               resul.getDate("fechaIni"), resul.getDate("fechaFin")));
			i++;
		}
		
		listarProyectos.close();
		return proy;	
	}
	
	
	public static Vector<Proyecto> listarProyectosEmpleado(Empleado emp) throws SQLException
	{
		ResultSet resul;
		Vector<Proyecto> proy = new Vector<Proyecto>();
		int i = 0; // Numero de filas devueltas por la consulta
		String consultaListado = "SELECT Participar.titulo,Proyectos.descripcion,Proyectos.fechaIni,Proyectos.fechaFin " +
				              "FROM Participar, Proyectos where Participar.titulo=Proyectos.titulo and "+
		                              "Participar.NIF LIKE ?";
		PreparedStatement listarProyectos = con.prepareStatement(consultaListado);
		listarProyectos.setString(1, emp.getNif() + "%");
		resul = listarProyectos.executeQuery();
		while(resul.next()) 
		{
			proy.add(new Proyecto(resul.getString("titulo"), resul.getString("descripcion"),
					          resul.getDate("fechaIni"), resul.getDate("fechaFin")));
			i++;
		}
		
		listarProyectos.close();
		return proy;	
	}
	
	
	public static Vector<Empleado> listarEmpleadosProyecto(Proyecto proy) throws SQLException
	{
		PreparedStatement listarEmpleados;
		ResultSet resul;
		String consultaListado = "SELECT Participar.NIF,Empleados.nombre,Empleados.apellidos,Empleados.anyo " +
				             "FROM Participar, Empleados where Participar.NIF=Empleados.NIF and "+
		                             "Participar.titulo LIKE ?";
		listarEmpleados = con.prepareStatement(consultaListado);
		/* AÒadimos al titulo el caracter '%' con la finalidad de que busque el titulo "mas parecido" y no sea
		   necesario que el titulo introducido en la busqueda sea exactamente la cadena que esta almacenada en la base de datos
		   Por ejemplo: para buscar GNU Hurd, seria suficiente con buscar GNU. En el caso de que haya mas de un
		   posible proyecto con el nombre se devolvera cualquiera de los dos. */
		listarEmpleados.setString(1, proy.getTitulo()+"%");
		Vector<Empleado> emp = new Vector<Empleado>();
		int i = 0; // Numero de filas devueltas por la consulta
		resul = listarEmpleados.executeQuery();	
		while(resul.next()) 
		{
			emp.add(new Empleado(resul.getString("NIF"), resul.getString("nombre"),
					              resul.getString("apellidos"), resul.getInt("anyo")));
			i++;
		} 
		
		listarEmpleados.close();
		return emp;	
	}
	
	
	public static void insertarEmpleado(Empleado emp) throws SQLException
	{
		PreparedStatement insertarEmpleado;
		String cadInsercion = "INSERT INTO Empleados values(?,?,?,?)";
		insertarEmpleado = con.prepareStatement(cadInsercion);
		insertarEmpleado.setString(1, emp.getNif());
		insertarEmpleado.setString(2, emp.getNombre());
		insertarEmpleado.setString(3, emp.getApellidos());
		insertarEmpleado.setInt(4, emp.getAnyoNac());
		insertarEmpleado.executeUpdate();
		insertarEmpleado.close();
	}
	

	public static void insertarProyecto(Proyecto proy) throws SQLException
	{
		PreparedStatement insertarProyecto;
		String cadInsercion = "INSERT INTO Proyectos values(?,?,?,?)";
		insertarProyecto = con.prepareStatement(cadInsercion);
		insertarProyecto.setString(1, proy.getTitulo());
		insertarProyecto.setString(2, proy.getDescripcion());
		insertarProyecto.setDate(3, proy.getFechaInic());
		insertarProyecto.setDate(4, proy.getFechaFin());
		insertarProyecto.executeUpdate();
		insertarProyecto.close();
	}
	
	
	public static void asociarEmpleadoProyecto(Empleado emp, Proyecto proy) throws SQLException
	{
		PreparedStatement asociarEmpProy;
		String cadInsercion = "INSERT INTO Participar values(?,?)";
		/* Aqui no podemos permitir que el titulo del proyecto y el dni
		del emplado sean una aproximacion porque se podria asociar mal
		sin saberlo el usuario, por tanto, se exige que ambos datos sean
		completos */
		asociarEmpProy = con.prepareStatement(cadInsercion);
		asociarEmpProy.setString(1, proy.getTitulo());
		asociarEmpProy.setString(2, emp.getNif());
		asociarEmpProy.executeUpdate();
		asociarEmpProy.close();
	}
	
	
	public static void modificarEmpleado(Empleado empNuevo) throws SQLException
	{
		PreparedStatement modificarEmpleado;
		String cadInsercion = "UPDATE Empleados SET nombre = ?, apellidos = ?, anyo = ?" +
				         " where nif=?";
		modificarEmpleado = con.prepareStatement(cadInsercion);
		modificarEmpleado.setString(1, empNuevo.getNombre());
		modificarEmpleado.setString(2, empNuevo.getApellidos());
		modificarEmpleado.setInt(3, empNuevo.getAnyoNac());
		modificarEmpleado.setString(4, empNuevo.getNif());
		modificarEmpleado.executeUpdate();
		modificarEmpleado.close();
	}
	

	public static void modificarProyecto(Proyecto proyNuevo) throws SQLException
	{
		PreparedStatement modificarProyecto;
		String cadInsercion = "UPDATE Proyectos SET descripcion = ?, fechaIni = ?," +
		                	  " fechaFin = ? where titulo=?";
		modificarProyecto = con.prepareStatement(cadInsercion);
		modificarProyecto.setString(1, proyNuevo.getDescripcion());
		modificarProyecto.setDate(2, proyNuevo.getFechaInic());
		modificarProyecto.setDate(3, proyNuevo.getFechaFin());
		modificarProyecto.setString(4, proyNuevo.getTitulo());
		modificarProyecto.executeUpdate();
		modificarProyecto.close();
	}

	
	public static Empleado obtenerEmpleado(String nif) throws SQLException
	{
		PreparedStatement obtenerEmpleado;
		ResultSet resul;
		Empleado emp;
		String cadConsulta = "SELECT * FROM Empleados WHERE NIF LIKE ?";
		obtenerEmpleado = con.prepareStatement(cadConsulta);
 	       /* AÒadimos al nif el caracter '%' con la finalidad de que busque el empleado con el DNI "mas parecido" y no sea
		   necesario que el dni introducido en la busqueda sea exactamente la cadena que esta almacenada en la base de datos
		   Por ejemplo: no hay necesidad de especificar la letra del DNI. En el caso de que especifiquemos un
		   dni incompleto y haya dos empleados con esa cadena al principio de su dni, devolvera cualquiera de
		   los dos */
		obtenerEmpleado.setString(1, nif + "%");
		resul = obtenerEmpleado.executeQuery();	
		resul.next(); // necesario para situarnos en la fila resultado
		emp = new Empleado(resul.getString("NIF"), resul.getString("nombre"),
	              resul.getString("apellidos"), resul.getInt("anyo"));
		obtenerEmpleado.close();
		return emp;
	}

	
	public static Proyecto obtenerProyecto(String titulo) throws SQLException
	{
		PreparedStatement obtenerProyecto;
		ResultSet resul;
		Proyecto proy;
		String cadConsulta = "SELECT * FROM Proyectos WHERE Titulo LIKE ?";
		obtenerProyecto = con.prepareStatement(cadConsulta);
		/* AÒadimos al titulo el caracter '%' con la finalidad de que busque el titulo "mas parecido" y no sea
		   necesario que el titulo introducido en la busqueda sea exactamente la cadena que esta almacenada en la base de datos
		   Por ejemplo: para buscar GNU Hurd, seria suficiente con buscar GNU. En el caso de que haya mas de un
		   posible proyecto con el nombre se devolvera cualquiera de los dos. */
		obtenerProyecto.setString(1, titulo + "%");
		resul = obtenerProyecto.executeQuery();	
		resul.next(); // necesario para situarnos en la fila resultado
		proy = new Proyecto(resul.getString("titulo"), resul.getString("descripcion"),
	               resul.getDate("fechaIni"), resul.getDate("fechaFin"));
		obtenerProyecto.close();
		return proy;
	}

	
	public void run() {
	/* Hacemos que la conexion a la base de datos se haga mediante un nuevo thread para que mientras tanto
	   se vaya cargando la interfaz de forma concurrente */
		try {
			Conexion.conectar();
			Interfaz.habilitarMenus();
			Interfaz.ventanaConectadoBien();
		}
		catch (Exception e) {
	 		Interfaz.ventanaErrorConectando();
		}
	
	}
	
	
	static public void crearInterfaz () {
	/* La creacion de la interfaz ser independiente a la creacion de la base de datos */
 		Interfaz miInterfaz = new Interfaz();
	}
	
	
	public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException
	/* Programa principal */
	{
		  // Invocaci√≥n: ejecuta usuario contrase√±a	 
		  username = args[0];
		  password = args[1];
	    	  Thread miThread = new Thread(new Conexion()); 
		  miThread.start();
		  javax.swing.SwingUtilities.invokeLater(new Runnable() 
		                                    {public void run()
						    {crearInterfaz();}});
		  miThread.join();
	  
       }
}





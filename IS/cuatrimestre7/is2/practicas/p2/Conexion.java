package bd;  // Capa de acceso a datos de la aplicación

import java.sql.*;
import java.io.IOException; // para la excepción del metodo main
import infoProyec.*;

import java.util.Vector;

public class Conexion {

	static Connection con;

	public static void conectar() 
	{
       String url ="jdbc:oracle:thin:@den.cps.unizar.es:1521:vicious";
       String usernameMio ="m6921579";
       String passwordMio ="lalala";
       // Para probar las consultas
       Proyecto proy = new Proyecto("GNU Hurd","lololo", Date.valueOf("1991-6-1"), Date.valueOf("1991-6-1"));
       Empleado emp = new Empleado("74223140C", "ko", "ka", 1990);
       Empleado emp2 = new Empleado("74773140C", "ko", "ka", 1990);
       Proyecto proy2 = new Proyecto("GNU Hurd2","lololo", Date.valueOf("1991-6-1"), Date.valueOf("1991-6-1"));
       Empleado emp3 = new Empleado("74773140C", "funciona", "kaaaa", 1990);
       Proyecto proy3 = new Proyecto("GNU Hurd","funciona", Date.valueOf("1991-6-1"), Date.valueOf("1991-6-1"));


       try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         con = DriverManager.getConnection(url, usernameMio, passwordMio);
         System.out.println("Conectado a la BD");
         crearTablas();
 	     con.setAutoCommit(true);
 	     // Insertamos tuplas de ejemplo
         introducirDatosEmpleados();
         introducirDatosProyectos();
         introducirDatosParticipar();
         System.out.println("Tuplas de ejemplo introducidas correctamente");
         // Probamos consultas
         listarProyectos(); // Funciona bien
         listarEmpleados(); // Funciona bien
         listarEmpleadosProyecto(proy); // Funciona bien
         listarProyectosEmpleado(emp);  // Funciona bien
         insertarEmpleado(emp2);  // Funciona bien
         insertarProyecto(proy2); // Funciona bien
         asociarEmpleadoProyecto(emp2,proy2); // Funcionan bien
         asociarEmpleadoProyecto(emp2,proy); // Funciona bien
         modificarEmpleado(emp3);  // Funcionan bien
         modificarProyecto(proy3); // Funcionan bien
       }
       catch (ClassNotFoundException e) {
         e.printStackTrace();
       }
       catch (SQLException e) {
          //e.printStackTrace();
          System.err.println("SQLException: " + e.getMessage());
       }
	}


	private static boolean borrarTabla(String nombreTab) 
	{
       try
       {
         Statement stmtBorrar = con.createStatement();
         stmtBorrar.executeQuery("DROP TABLE " + nombreTab + " cascade constraints");
         stmtBorrar.close();
       }
       catch (SQLException e) {
         // System.out.println("La tabla " + nombreTab + " no existe para borrar");
         // e.printStackTrace();
    	 System.err.println("SQLException: " + e.getMessage());
       }
       return true;
	}


	private static boolean crearTablas () 
	{
       borrarTabla("Empleados");
       borrarTabla("Proyectos");
       borrarTabla("Participar");

       try 
       {
          Statement stmtCrear = con.createStatement();
          stmtCrear.executeQuery("CREATE TABLE Usuarios (nick VARCHAR(9) PRIMARY KEY "
                + "NOT NULL, password VARCHAR(20) NOT NULL)");
          stmtCrear.executeQuery("CREATE TABLE Proyectos (titulo VARCHAR(20) PRIMARY KEY "
                + "NOT NULL, descripcion VARCHAR(50), fechaIni DATE, fechaFin DATE)");
          stmtCrear.executeQuery("CREATE TABLE Participar (titulo VARCHAR(20), NIF VARCHAR(9), "
                + "CONSTRAINT    Participar_PK        PRIMARY KEY   (titulo, NIF), "
                + " CONSTRAINT titulo_FK FOREIGN KEY (titulo) REFERENCES Proyectos(titulo) ON DELETE CASCADE, "
                + "CONSTRAINT NIF_FK FOREIGN KEY (NIF) REFERENCES Empleados(NIF) ON DELETE CASCADE)");

          System.out.println("Las 3 tablas se han creado");
          stmtCrear.close();
       }
       catch (SQLException e) {
    	  System.err.println("SQLException: " + e.getMessage());
          System.out.println("Alguna de las tablas no se ha creado");
       }
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
			// Depuracion
			System.out.println("Empleado numero " +i);
			System.out.println("NIF: " + resul.getString("NIF") + " Nombre: " + " "
					           + resul.getString("nombre") + " " +resul.getString("apellidos")
					           + " " + resul.getInt("anyo"));
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
			// Depuracion
			System.out.println("Proyecto numero " +i);
			System.out.println("Titulo: " + resul.getString("titulo") + " Descripcion: " 
					           + " " + resul.getString("descripcion") + " " + resul.getDate("fechaIni")
					           + " " + resul.getDate("fechaFin"));
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
		                         "Participar.NIF=?";
		PreparedStatement listarProyectos = con.prepareStatement(consultaListado);
		listarProyectos.setString(1, emp.getNif());
		resul = listarProyectos.executeQuery();
		while(resul.next()) 
		{
			proy.add(new Proyecto(resul.getString("titulo"), resul.getString("descripcion"),
					               resul.getDate("fechaIni"), resul.getDate("fechaFin")));
			// Depuracion
			System.out.println("Proyecto numero " +i);
			System.out.println("Titulo: " + resul.getString("titulo") + " Descripcion: " 
					           + " " + resul.getString("descripcion") + " " + resul.getDate("fechaIni")
					           + " " + resul.getDate("fechaFin"));
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
		                         "Participar.titulo=?";
		System.out.println(proy.getTitulo());
		listarEmpleados = con.prepareStatement(consultaListado);
		listarEmpleados.setString(1, proy.getTitulo());
		Vector<Empleado> emp = new Vector<Empleado>();
		int i = 0; // Numero de filas devueltas por la consulta
		resul = listarEmpleados.executeQuery();	
		while(resul.next()) 
		{
			emp.add(new Empleado(resul.getString("NIF"), resul.getString("nombre"),
					              resul.getString("apellidos"), resul.getInt("anyo")));
			// Depuracion
			System.out.println("Empleado numero " +i);
			System.out.println("NIF: " + resul.getString("NIF") + " Nombre: " + " "
					           + resul.getString("nombre") + " " +resul.getString("apellidos")
					           + " " + resul.getInt("anyo"));
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
	
	public static void main(String[] args) throws IOException 
	{
	  // Invocación: ejecuta usuario contraseña	 
  	  Conexion.conectar();
 	}
}

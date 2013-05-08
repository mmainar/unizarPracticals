package infoProyec; // capa de logica de negocio de la aplicación

public class Empleado {

	// Atributos o variables miembro de la clase 
    private String nif;
    private String nombre;
    private String apellidos;
    private int anyoNac;
     
    // Metodos constructores de la clase
    public Empleado()
    {  ;  }

    public Empleado(String nif, String nombre, String apellidos, int anyoNac)
    {
    	this.nif = nif;
    	this.nombre = nombre;
    	this.apellidos = apellidos;
    	this.anyoNac = anyoNac;
    }
    
    
    // Metodos get y set
    
    public String getNif()
    {
    	return this.nif;
    }
    
    
    public String getNombre()
    {
    	return this.nombre;
    }
    
    
    public String getApellidos()
    {
    	return this.apellidos;
    }
    
    
    public int getAnyoNac()
    {
    	return this.anyoNac;
    }
    
    
    public void setNif(String nif)
    {
    	this.nif = nif;
    }
    
    
    public void setNombre(String nombre)
    {
    	this.nombre = nombre;
    }
    
    
    public void setApellidos(String apellidos)
    {
    	this.apellidos = apellidos;
    }
    
    
    public void setAnyoNac(int anyoNac)
    {
    	this.anyoNac = anyoNac;
    }
	
	
    public boolean esCorrecto () {
    /* Comprobacion de que los datos de un empleado son correctos */
	boolean correcto = (nif.length() == 9);
	int i = 0;
	while ((i < nif.length()-2) && correcto) {
		correcto = correcto && (nif.charAt(i) >= '0') && 
		                       (nif.charAt(i) <= '9');
		i++;
	}
	if (correcto) {
		correcto = correcto && (nif.charAt(nif.length()-1) >= 'A') && 
							   (nif.charAt(nif.length()-1) <= 'Z');
	}
	if (correcto) {
		correcto = correcto && (nombre.length() != 0);
	}
	if (correcto) {
		correcto = correcto && (apellidos.length() != 0);
	}
	if (correcto) {
		correcto = correcto && (anyoNac >= 1900);
	}
	return correcto;

    }

}

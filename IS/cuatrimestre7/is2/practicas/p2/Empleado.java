package infoProyec; // capa de logica de negocio de la aplicación

public class Empleado {

	// Atributos o variables miembro de la clase 
    private String nif;
    private String nombre;
    private String apellidos;
    private int anyoNac;
     
    // Metodo constructor de la clase
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
	
    
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}

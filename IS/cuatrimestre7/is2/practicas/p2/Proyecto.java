package infoProyec; // capa de logica de negocio de la aplicación

import java.sql.Date;

public class Proyecto {
	// Atributos o variables miembro de la clase 
    private String titulo;
    private String desc;
    private Date fechaInic;
    private Date fechaFin;
     
    // Metodo constructor de la clase
    public Proyecto(String titulo, String desc, Date fechaInic, Date fechaFin)
    {
    	this.titulo = titulo;
    	this.desc = desc;
    	this.fechaInic = fechaInic;
    	this.fechaFin = fechaFin;
    }
    
    
    // Metodos get y set
    
    public String getTitulo()
    {
    	return this.titulo;
    }
    
    
    public String getDescripcion()
    {
    	return this.desc;
    }
    
    
    public Date getFechaInic()
    {
    	return this.fechaInic;
    }
    
    
    public Date getFechaFin()
    {
    	return this.fechaFin;
    }
    
    
    public void setTitulo(String titulo)
    {
    	this.titulo = titulo;
    }
    
    
    public void setDescripcion(String desc)
    {
    	this.desc = desc;
    }
    
    
    public void setApellidos(Date fechaInic)
    {
    	this.fechaInic = fechaInic;
    }
    
    
    public void setAnyoNac(Date fechaFin)
    {
    	this.fechaFin = fechaFin;
    }
}

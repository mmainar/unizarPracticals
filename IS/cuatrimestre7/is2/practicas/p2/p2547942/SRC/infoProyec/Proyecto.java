package infoProyec; // capa de logica de negocio de la aplicación

import java.sql.Date;

public class Proyecto {
	// Atributos o variables miembro de la clase 
    private String titulo;
    private String desc;
    private Date fechaInic;
    private Date fechaFin;

     
    // Metodos constructores de la clase
    
    public Proyecto () {
    	;
    }

    
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
    
    
    public void setFechaInic (Date fechaInic)
    {
    	this.fechaInic = fechaInic;
    }
    
    
    public void setFechaFin(Date fechaFin)
    {
    	this.fechaFin = fechaFin;
    }
    
    
    private int dia (Date fecha) {
    	return Integer.parseInt(fecha.toString().substring(8,10));
    }
    
    
    private int mes (Date fecha) {
    	return Integer.parseInt(fecha.toString().substring(5,7));
    }
    
    
    private int anho (Date fecha) {
    	return Integer.parseInt(fecha.toString().substring(0,4));
    }
    
    
    public boolean esCorrecto() {
    /* Comprueba que lo dato de un proyecto sean correctos */    
    	boolean correcto = !((titulo.length() == 0) ||
    			             (desc.length() == 0) ||
    			             (mes(fechaInic) <= 0) ||
    			             (mes(fechaInic) > 12) ||
    			             (dia(fechaInic) <= 0) ||
    			             (dia(fechaInic) > 31) ||
    			             (anho(fechaInic) < 1900) ||
    			             (mes(fechaFin) <= 0) ||
    			             (mes(fechaFin) > 12) ||
    			             (dia(fechaFin) <= 0) ||
    			             (dia(fechaFin) > 31) ||
    			             (anho(fechaFin) < 1900) ||
    			             fechaInic.after(fechaFin));
    	return correcto;
    }
}

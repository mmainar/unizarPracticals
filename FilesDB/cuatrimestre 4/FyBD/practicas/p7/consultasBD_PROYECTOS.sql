/* consultasBD_PROYECTOS.sql */

SET ECHO ON

/* I. Cantidad de clientes que han encargado mas de un proyecto en Julio */
      
      SELECT DISTINCT clvCliente 
      FROM Contratar C
      WHERE 7 = (SELECT TO_NUMBER(TO_CHAR(C.fechaEncargo, 'MM'))
                FROM Contratar
		WHERE clvCliente = C.clvCliente)
      GROUP BY clvCliente
      HAVING count(clvCliente) > 1;
			  
	    

/* II. Nombre del empleado que mas equipos dirige */


     CREATE VIEW Empleado_y_num_equipos (clvEmpleado, nomEmpleado, num_equipos) AS
     SELECT D.clvEmpleado, E.nomEmpleado, count(fechaInicio) 
     FROM Dirigir D, Empleado E
     GROUP BY D.clvEmpleado, E.nomEmpleado;
     
     
     SELECT nomEmpleado
     FROM Empleado_y_num_equipos EYN
     WHERE EYN.num_equipos = (SELECT max(num_equipos)
                              FROM Empleado_y_num_equipos);
			           
     DROP VIEW Empleado_y_num_equipos;
			
		
 			
/* III. Nombre de los empleados que desarrollan tareas de programacion en alguna
	tarea */

  
     SELECT  EM.nomEmpleado
     FROM    Encargar E, Empleado EM
     WHERE   (E.papelEmpl LIKE 'Programador');


/* IV. Numero de empleados que viven en la misma calle y dirigen algun equipo y
       direccion de dichos empleados  */

  
  /* Crearemos una vista en la que almacenaremos el numero de empleados que
   * efectuan tareas de direccion y veremos cuantos viven en cada calle.
   */
   
    CREATE VIEW direcciones_y_numVecinos (direccion, num_vecinos) AS
    SELECT E.dirContacto, count(D.clvEmpleado) 
    FROM Dirigir D, Empleado E
    WHERE D.clvEmpleado = E.clvEmpleado
    GROUP BY dirContacto;
     
   /* Tomamos aquellas direcciones en que vive mas de un director, ya buscamos
    * unicamente aquellas calles en las que vive mas de un director */
      
    SELECT direccion "Direccion", num_vecinos "Num. de vecinos"
    FROM direcciones_y_numVecinos DYN
    WHERE DYN.num_vecinos > 1;
    
    DROP VIEW direcciones_y_numVecinos;

    
/* V. Identificadores de los equipos dirigidos por empleados de procedencia
       externa */

 
     SELECT E.clvEmpleado
     FROM Empleado E, Dirigir D
     WHERE E.clvEmpleado = D.clvEmpleado AND
           E.procedencia = -1;
        
  
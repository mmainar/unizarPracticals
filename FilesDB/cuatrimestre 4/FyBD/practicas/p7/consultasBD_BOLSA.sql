/* consultasBD_BOLSA.sql */

SET ECHO ON

/* I. Listado de los nombres de las empresas cuyos valores han sufrido una 
      variacion de porcentaje mayor del 4.5% en los dias impares del mes */
      
      
      SELECT E.nombEmpresa
      FROM Empresa E
      WHERE EXISTS (SELECT *
                    FROM Informar I, Valor V
		    WHERE I.ticker = V.ticker AND
		          porVariac > 4.5     AND
			  E.nombEmpresa = V.nombEmpresa AND
			  1 = (SELECT mod(TO_NUMBER(TO_CHAR(I2.fechaHora, 'DD')),2)
			       FROM Informar I2
			       WHERE I.ticker = I2.ticker));
			  
	    

/* II. Nombre de los agentes que no trabajan para nosotros */


 /* Como cada agente que trabaja para nosotros ha de operar con valores y esto
  * se hace mediante la gestion de una cartera de valores (las cuales siempre
  * contienen valores), podemos decir que aquellos agentes que no operen con
  * nuestros valores no gestionaran ninguna de nuestras carteras y por tanto no
  * trabajaran para nosotros 
  */
  
  
     SELECT  nombAgente
     FROM    Agente A
     WHERE  NOT EXISTS (SELECT * 
                        FROM Agente A2, Operar O
			WHERE A.clvAgente = A2.clvAgente AND
			      A2.clvAgente = O.clvAgente);
			
			
 			
/* III. Nombre del agente que gestiona la cartera que mas titulos contiene */

  
     CREATE VIEW Carteras_y_titulos (clvCartera, numTitulos) AS
     SELECT clvCartera, count(numTitulos) 
     FROM ContenerTit 
     GROUP BY clvCartera;
   
      
     SELECT A.nombAgente
     FROM    Carteras_y_titulos CYT, Agente A
     WHERE   CYT.clvCartera = A.clvCartera AND
             CYT.numTitulos = (SELECT max(numTitulos)
	                       FROM Carteras_y_titulos);	
  
    
     DROP VIEW Carteras_y_titulos;


/* IV. Fecha de inicio de cotizacion del valor con el que mas se opera */


  /* Crearemos primero una vista en la que almacenaremos los ticker de los 
   * valores y el numero de veces que se opera con dichos valores.
   */
    
     CREATE VIEW Valores_y_operaciones (ticker, num_op) AS
     SELECT ticker, count(fechaHora)
     FROM Operar
     GROUP BY ticker;
     
     
  /* Seleccionamos ahora el ticker del valor con el que mas se ha operado
   * y obtenemos su fecha de inicio de cotizacion.
   */
   
     SELECT fechaInicioCot
     FROM Valor V, Valores_y_operaciones VYO
     WHERE V.ticker = VYO.ticker AND
           VYO.num_op = (SELECT max(num_op)
	                 FROM Valores_y_operaciones);
	   
   	   
     DROP VIEW Valores_y_operaciones;	   
     
	   
/* V. Nombre de la entidad bancaria en la que mas titulos tenemos */

  /* Como los titulos no se almacenan directamente en los bancos sino en
   * carteras de valores, agruparemos las carteras de valores en funcion de la
   * entidad bancaria en la que esten alojadas. Despues contaremos el numero de
   * titulos que cada grupo de carteras tiene, veremos que grupo tiene mas y a que
   * entidad pertenecen las carteras de dicho grupo y con ello hallaremos la
   * respuesta a nuestro problema.
   */
   
     CREATE VIEW Bancos_y_titulos (clvBanco, num_titulos) AS
     SELECT clvBanco, count(numTitulos)
     FROM contenerTit 
     GROUP BY clvBanco;
     
         
     SELECT nombBanco
     FROM EntBancaria E, Bancos_y_titulos BYT
     WHERE E.clvBanco = BYT.clvBanco AND
           BYT.num_titulos = (SELECT max(num_titulos) 
	                      FROM Bancos_y_titulos);
        

     DROP VIEW Bancos_y_titulos;


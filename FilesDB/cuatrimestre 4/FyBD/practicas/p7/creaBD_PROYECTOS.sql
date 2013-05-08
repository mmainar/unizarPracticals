/* @creaBD_PROYECTOS.sql */
SET ECHO ON

/* Creamos las tablas y añadimos algunas restricciones */

CREATE TABLE  Cliente (							  			
  /* NIF = clvCliente */
  clvCliente     char(9)       CONSTRAINT PK_clvCliente    PRIMARY KEY,
  infoPersonal   char(500)     CONSTRAINT NN_infoPersonal  NOT NULL,
  datosContacto  char(500)     CONSTRAINT NN_datosContacto NOT NULL);
   
CREATE TABLE EquipoYProyecto (
  clvEquipo      char(10),
  PRIMARY KEY(clvEquipo),
  clvProyecto    char(50) NOT NULL,
  tipoProyecto   number(1)     CONSTRAINT NN_tipoProyecto NOT NULL,	
  horasEst       number(5)     CONSTRAINT NN_horasEst     NOT NULL,
  fec            date          CONSTRAINT NN_fec          NOT NULL,
  fef            date          CONSTRAINT NN_fef          NOT NULL,
  costeEst       number(6,2)   CONSTRAINT NN_costeEst     NOT NULL);		      

CREATE TABLE Tarea (
  clvTarea       char(10),
  clvInterna     char(10),
  clvEquipo      char(10),
  PRIMARY KEY(clvTarea),
  FOREIGN KEY (clvEquipo) REFERENCES EquipoYProyecto(clvEquipo)
                          ON DELETE CASCADE,
  comentario     char(300)     CONSTRAINT NN_comentario   NOT NULL,
  horasEmpl      number(5)     CONSTRAINT NN_horasEmpl    NOT NULL,
  tiempoEst      number(5)     CONSTRAINT NN_tiempoEst    NOT NULL,
  costeEst       number(6,2)  NOT NULL);       			  
 
CREATE TABLE  Contratar (
  clvCliente    char(9),   
  CONSTRAINT    FK_clvCliente FOREIGN KEY (clvCliente) REFERENCES Cliente(clvCliente)
                                                       ON DELETE CASCADE,
  clvEquipo     char(10),  
  FOREIGN KEY (clvEquipo) REFERENCES EquipoYProyecto(clvEquipo)
                          ON DELETE CASCADE,
  PRIMARY KEY(clvCliente,clvEquipo),							 
  fechaEncargo	date    CONSTRAINT NN_fechaEncargo NOT NULL);						       
   
CREATE TABLE  Empleado (
  clvEmpleado   char(9)      CONSTRAINT PK_clvEmpleado PRIMARY KEY,
  nomEmpleado   char(50)     CONSTRAINT UN_nomEmpleado UNIQUE
                             CONSTRAINT NN_nomEmpleado NOT NULL,
  estudios      char(100)    CONSTRAINT NN_estudios    NOT NULL,			
  dirContacto   char(100)    CONSTRAINT NN_dirContacto NOT NULL,
  email         char(20)     CONSTRAINT NN_email       NOT NULL,
  salario       number(5,2)  CONSTRAINT NN_salario     NOT NULL,
  catProf       char(100)    CONSTRAINT NN_catProf     NOT NULL,
  procedencia   number(1)    CONSTRAINT NN_procedencia NOT NULL,
  tfno          number(9)    CONSTRAINT NN_tfno        NOT NULL);
  
CREATE TABLE  Dirigir (
  clvEmpleado   char(9),
  CONSTRAINT    FK_clvEmpleado FOREIGN KEY (clvEmpleado) REFERENCES Empleado(clvEmpleado)
                                                         ON DELETE CASCADE,
  clvEquipo     char(10),
  FOREIGN KEY (clvEquipo) REFERENCES EquipoYProyecto(clvEquipo)
                                                     ON DELETE CASCADE,
  PRIMARY KEY(clvEmpleado, clvEquipo),						   
  fechaInicio   date         CONSTRAINT NN_fechaInicio NOT NULL);    
  
CREATE TABLE  Pertenecer (
  clvEmpleado   char(9),
  FOREIGN KEY (clvEmpleado) REFERENCES Empleado(clvEmpleado)     
                            ON DELETE CASCADE,    
  clvEquipo     char(10),
  FOREIGN KEY (clvEquipo) REFERENCES EquipoYProyecto(clvEquipo)
                          ON DELETE CASCADE,
  PRIMARY KEY(clvEmpleado, clvEquipo));
  
CREATE TABLE Encargar (
  clvCliente  char(9), 
  FOREIGN KEY (clvCliente) REFERENCES Cliente(clvCliente)
                           ON DELETE CASCADE,
  clvEquipo   char(10),
  FOREIGN KEY (clvEquipo) REFERENCES EquipoYProyecto(clvEquipo) 
                           ON DELETE CASCADE,
  clvTarea    char(10),
  FOREIGN KEY (clvTarea) REFERENCES Tarea(clvTarea)
                         ON DELETE CASCADE,
  clvInterna  char(10),	
  PRIMARY KEY(clvCliente,clvEquipo,clvTarea),			   
  papelEmpl   number(1)    CONSTRAINT NN_PapelEmpl NOT NULL);				       					     
  
  
SELECT * FROM cat;

DESCRIBE  Cliente;
DESCRIBE  EquipoYProyecto;
DESCRIBE  Tarea;
DESCRIBE  Contratar;
DESCRIBE  Dirigir;
DESCRIBE  Pertenecer;
DESCRIBE  Encargar;
DESCRIBE  Empleado;

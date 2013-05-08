/* @creaBD_BOLSA.sql */
SET ECHO ON

/* Creamos las tablas y añadimos algunas restricciones */

CREATE TABLE  EntBancaria (
  /* clvBanco = CIF */
  clvBanco    char(9)      CONSTRAINT PK_clvBanco    PRIMARY KEY,
  nombBanco   char(20)     CONSTRAINT NN_nombBanco  NOT NULL
                           CONSTRAINT UN_nombBanco  UNIQUE);
CREATE TABLE  CuentaValores (
  /* clvCuenta = Numero de indentificador(cuenta) */
  clvCuenta   char(20)     CONSTRAINT PK_clvCuenta   PRIMARY KEY,
  tfnoCuenta  number(9)    CONSTRAINT NN_tfnoCuenta   NOT NULL,
  clvSecreta  char(20)     CONSTRAINT NN_clvSecreta  NOT NULL,
  clvBanco    char(9),
  CONSTRAINT  FK_clvBancoCuenta FOREIGN  KEY (clvBanco) REFERENCES EntBancaria(clvBanco) 
                                                        ON DELETE CASCADE);
CREATE TABLE  CarteraValores (
  /* clvCartera = Numero de indentificador(cartera) */
  clvCartera  number(3)    CONSTRAINT PK_clvCartera   PRIMARY KEY,
  clvBanco    char(9),
  CONSTRAINT  FK_clvBancoCartera FOREIGN  KEY (clvBanco) REFERENCES EntBancaria(clvBanco) 
                                                         ON DELETE CASCADE,
  clvCuenta   char(20),
  CONSTRAINT  FK_clvCuentaCartera FOREIGN KEY (clvCuenta) REFERENCES CuentaValores(clvCuenta)
                                                   	  ON DELETE CASCADE);	
							  
CREATE TABLE  Agente (							  			
  /* NIF = clvAgente */
  clvAgente   char(9)      CONSTRAINT PK_clvAgente    PRIMARY KEY,
  nombAgente  char(50)     CONSTRAINT NN_nombAgente   NOT NULL,
  tfnoAgente  number(9)    CONSTRAINT NN_tfnoAgente   NOT NULL,
  direccion   char(100)    CONSTRAINT NN_direccion    NOT NULL,
  impresiones char(300)    CONSTRAINT NN_impresiones  NOT NULL,   
  clvCartera  number(3),
  CONSTRAINT  FK_clvCarteraAgente FOREIGN  KEY (clvCartera) REFERENCES CarteraValores(clvCartera) 
                                                            ON DELETE CASCADE,
  clvCuenta   char(20),
  CONSTRAINT  FK_clvCuentaAgente FOREIGN KEY (clvCuenta) REFERENCES CuentaValores(clvCuenta)
                                                         ON DELETE CASCADE,
  clvBanco    char(9),
  CONSTRAINT  FK_clvBancoAgente FOREIGN KEY (clvBanco) REFERENCES EntBancaria(clvBanco)
                                                       ON DELETE CASCADE);
CREATE TABLE  Empresa (
  nombEmpresa char(50)   CONSTRAINT PK_nombEmpresa PRIMARY KEY,
  infoEmpresa char(500)  CONSTRAINT NN_infoEmpresa NOT NULL);
  
CREATE TABLE  Valor (
  ticker      char(4)       CONSTRAINT PK_ticker PRIMARY KEY,
  mercado     char(20)      CONSTRAINT UN_mercado UNIQUE
                            CONSTRAINT NN_mercado NOT NULL,
  nombEmpresa char(50),
  CONSTRAINT FK_nombEmpresa FOREIGN KEY (nombEmpresa) REFERENCES Empresa(nombEmpresa)
                                                      ON DELETE CASCADE,			
  numTitulos  number(3)     CONSTRAINT NN_numTitulos NOT NULL,
  valoracionPER number(3,3) CONSTRAINT NN_valoracionPer NOT NULL,
  fechaInicioCot date       CONSTRAINT NN_fechaInicioCot NOT NULL);
  
CREATE TABLE  Informar (
  fechaHora   date         CONSTRAINT NN_fechaHora NOT NULL,
  vttn        number(4)    CONSTRAINT NN_vttn NOT NULL,
  importeTot  number(9,3)  CONSTRAINT NN_importeTot NOT NULL,
  precioMedio number(9,3)  CONSTRAINT precioMedio NOT NULL,
  precioAper  number(9,3)  CONSTRAINT precioAper NOT NULL,
  precioCier  number(9,3)  CONSTRAINT precioCier NOT NULL,
  porVariac   number(2,2)  CONSTRAINT porVariac NOT NULL,
  comentarios char(300)    CONSTRAINT comentarios NOT NULL,
  ticker      char(4), 
  FOREIGN KEY (ticker) REFERENCES Valor(ticker)
                                             ON DELETE CASCADE,
  clvAgente   char(9),
  FOREIGN KEY (clvAgente) REFERENCES Agente(clvAgente)
                                                   ON DELETE CASCADE);
  
CREATE TABLE  Operar (
  fechaHora   date         CONSTRAINT PK_fechaHora PRIMARY KEY,
  numTitulos  number(3),
  importeTot  number(9,3),
  precioUnit  number(9,3)  CONSTRAINT NN_precioUnit NOT NULL,
  tipoOperac  number(1)    CONSTRAINT NN_tipoOperac NOT NULL,
  comentarios char(300),
  ticker      char(4),
  FOREIGN KEY (ticker) REFERENCES Valor(ticker)
                                             ON DELETE CASCADE,
  clvAgente   char(9),
  FOREIGN KEY (clvAgente) REFERENCES Agente(clvAgente)
                                                   ON DELETE CASCADE);
  
CREATE TABLE ContenerTit (
  ticker      char(4), 
  FOREIGN KEY (ticker) REFERENCES Valor(ticker)
                                             ON DELETE CASCADE,
  mercado     char(20),
  CONSTRAINT  FK_mercado FOREIGN KEY (mercado) REFERENCES Valor(mercado) 
                                               ON DELETE CASCADE,
  clvCuenta   char(20),
  FOREIGN KEY (clvCuenta) REFERENCES CuentaValores(clvCuenta)
                                                   ON DELETE CASCADE,
  clvCartera  number(3),	
  FOREIGN KEY (clvCartera) REFERENCES CarteraValores(clvCartera)
                                                     ON DELETE CASCADE,				       					     
  numTitulos  number(3) CONSTRAINT NN_numTitulosCT NOT NULL,
  clvBanco    char(9),
  CONSTRAINT  FK_clvBancoCT FOREIGN KEY (clvBanco) REFERENCES EntBancaria(clvBanco)
                                                       ON DELETE CASCADE);
  
SELECT * FROM cat;

DESCRIBE  EntBancaria;
DESCRIBE  CuentaValores;
DESCRIBE  CarteraValores;
DESCRIBE  Agente;
DESCRIBE  Informar;
DESCRIBE  Empresa;
DESCRIBE  Valor;
DESCRIBE  ContenerTit;

  



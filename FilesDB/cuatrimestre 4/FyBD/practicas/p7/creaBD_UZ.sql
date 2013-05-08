/* @creaBD_UZ.sql */

/* Crear las tablas y añadir algunas restricciones, de varias maneras */

CREATE TABLE Departamento (
  clvDpto    number(3)   CONSTRAINT clvDpto_PK    PRIMARY KEY,
  codDpto    char(10)    CONSTRAINT codDpto_UN    UNIQUE,
  nombDpto   char(20)    CONSTRAINT nombDpto_NN   NOT NULL);

CREATE TABLE AreaConoc (
  clvArea    number(3)   CONSTRAINT clvArea_PK    PRIMARY KEY,
  codArea    char(10)    CONSTRAINT codArea_UN    UNIQUE,
  nombArea   char(30)    CONSTRAINT nombArea_NN   NOT NULL,
  clvDpto    number(3),
  CONSTRAINT clvDptoArea_FK FOREIGN KEY (clvDpto) REFERENCES Departamento(clvDpto) );

CREATE TABLE Profesor (
  clvProf    number(3)   CONSTRAINT clvProf_PK    PRIMARY KEY,
  codProf    char(10)    CONSTRAINT codProf_UN    UNIQUE,
  nombProf   char(30)    CONSTRAINT nombProf_NN   NOT NULL,
  clvArea    number(3)   CONSTRAINT areaProf_NN   NOT NULL,
  CONSTRAINT clvAreaProf_FK  FOREIGN KEY (clvArea) REFERENCES AreaConoc(clvArea) );

CREATE TABLE Asignatura (
  clvAsign   number(3)   CONSTRAINT clvAsign_PK   PRIMARY KEY,
  codAsign   char(10)    CONSTRAINT codAsign_UN   UNIQUE,
  nombAsign  char(30)    CONSTRAINT nombAsign_NN  NOT NULL,
  tt_HT      number(3),
  tt_HP      number(3),
  clvArea    number(3)   CONSTRAINT areaAsig_NN   NOT NULL,
  CONSTRAINT clvAreaAsig_FK  FOREIGN KEY (clvArea) REFERENCES AreaConoc(clvArea),
  CONSTRAINT A_horasNoNeg CHECK ( tt_HT >= 0 AND tt_HP >= 0 ),
  CONSTRAINT A_horasMas_0 CHECK ( tt_HT + tt_HP > 0 ));

CREATE TABLE Titulacion (
  clvTitulo  number(3)   CONSTRAINT clvTitulo_PK  PRIMARY KEY,
  codTitulo  char(10)    CONSTRAINT codTitulo_UN  UNIQUE,
  nombTitulo char(20)    CONSTRAINT nombTitulo_NN NOT NULL);

CREATE TABLE ImparteAsign (
  clvProf    number(3),
  clvAsign   number(3),
  HT         number(4),
  HP         number(4),
  CONSTRAINT imparteAsign_PK   PRIMARY KEY (clvProf, clvAsign),
  CONSTRAINT clvProfImpAsg_FK  FOREIGN KEY (clvProf)  REFERENCES Profesor(clvProf),
  CONSTRAINT clvAsigImpAsg_FK  FOREIGN KEY (clvAsign) REFERENCES Asignatura(clvAsign),
  CONSTRAINT IA_horasNoNeg CHECK ( HT >= 0 AND HP >= 0 ),
  CONSTRAINT IA_horasMas_0 CHECK ( HT + HP > 0 ));

CREATE TABLE AsignTitulo (
  clvAsign   number(3),
  clvTitulo  number(3),
  CONSTRAINT AsignTitulo_PK    PRIMARY KEY (clvAsign, clvTitulo),
  CONSTRAINT clvAsgAsigTit_FK  FOREIGN KEY (clvAsign)  REFERENCES Asignatura(clvAsign),
  CONSTRAINT clvTitAsigTit_FK  FOREIGN KEY (clvTitulo) REFERENCES Titulacion(clvTitulo) );


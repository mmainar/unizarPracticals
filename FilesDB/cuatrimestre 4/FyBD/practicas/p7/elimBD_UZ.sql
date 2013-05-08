/* @borraBD_UZ.sql */
/* Eliminar las tablas y todas las restricciones ligadas, de tal modo que
   solo se borre una tabla cuando sus atributos no son referenciados */
ALTER TABLE AreaConoc    DROP CONSTRAINT clvDptoArea_FK;
ALTER TABLE Profesor     DROP CONSTRAINT clvAreaProf_FK;
ALTER TABLE Asignatura   DROP CONSTRAINT clvAreaAsig_FK;
ALTER TABLE ImparteAsign DROP CONSTRAINT clvProfImpAsg_FK;
ALTER TABLE ImparteAsign DROP CONSTRAINT clvAsigImpAsg_FK;
ALTER TABLE AsignTitulo  DROP CONSTRAINT clvAsgAsigTit_FK;
ALTER TABLE AsignTitulo  DROP CONSTRAINT clvTitAsigTit_FK;

DROP TABLE ImparteAsign;
DROP TABLE AsignTitulo;
DROP TABLE Asignatura;
DROP TABLE Profesor;
DROP TABLE AreaConoc;
DROP TABLE Departamento;
DROP TABLE Titulacion;



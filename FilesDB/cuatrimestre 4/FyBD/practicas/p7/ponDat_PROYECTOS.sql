/* @ponDat_PROYECTOS.sql */

SET ECHO ON
DELETE FROM Cliente;
DELETE FROM EquipoYProyecto;
DELETE FROM Tarea;
DELETE FROM Contratar;
DELETE FROM Empleado;
DELETE FROM Dirigir;
DELETE FROM Pertenecer;
DELETE FROM Encargar;
INSERT INTO EquipoYProyecto VALUES
('1','284',1,400,to_date('12-5-93','DD-MM-YY'),to_date('12-5-95','DD-MM-YY'),100.51);
INSERT INTO EquipoYProyecto VALUES
('2','285',2,500,to_date('12-5-94','DD-MM-YY'),to_date('12-5-95','DD-MM-YY'),200.52);
INSERT INTO EquipoYProyecto VALUES
('3','286',3,600,to_date('12-5-95','DD-MM-YY'),to_date('12-5-95','DD-MM-YY'),500.14);
INSERT INTO Tarea VALUES ('1','1A','1','gestion',40,37,100.23);
INSERT INTO Tarea VALUES ('2','1B','2','programacion',50,40,200.30);
INSERT INTO Tarea VALUES ('3','1C','1','analisis',10,11,300.4);
INSERT INTO Tarea VALUES ('4','1D','3','pruebas',20,25,400.5);
INSERT INTO Tarea VALUES ('5','1E','1','testing',40,38,500.4);
INSERT INTO Tarea VALUES ('6','1F','3','diseñador',37,35,400.4);
INSERT INTO Tarea VALUES ('7', '1G','2','corrector',76,37,975.4);
INSERT INTO Cliente VALUES (  '111111111', 'P.CRUZ',   'TFNO: 1188880');
INSERT INTO Cliente VALUES (  '222222222', 'S.RAMOS',    'TFNO: 558190');
INSERT INTO Cliente VALUES (  '333333333', 'J.RAMON', 'TFNO: 8732');
INSERT INTO Cliente VALUES (  '444444444', 'PEPE', 'TFNO:8980');
INSERT INTO Empleado VALUES (  '1',  'PEDRO','ING.INFORMATICA',
'C/1','pepe@gmail.com',300.34,'JEFE',1,'976111111');
INSERT INTO Empleado VALUES (  '2',  'JUAN',
'ING.INFORMATICa','C/2','juan@gmail.com',300.34,'JEFE',2,'976222222');
INSERT INTO Empleado VALUES (  '3',  'LUIS',
'ING.INFORMATICA','C/3','luis@gmail.com',300.34,'EMPLEADO',3,'976333333');
INSERT INTO Empleado VALUES (  '4',  'RAMON', 'ING.INFORMATICA',
'C/4','ramon@gmail.com',300.34,'EMPLEADO',4,'976444444');
INSERT INTO Empleado VALUES (  '5',  'CARLOS',
'ING.INFORMATICA','C/5','carlos@gmail.com',300.34,'EMPLEADO',5,'976555555');
INSERT INTO Empleado VALUES ( '6',  'JAVIER', 'ING.INFORMATICA',
'C/6','javier@gmail.com',300.34,'EMPLEADO',6,'976666666');
INSERT INTO Empleado VALUES ( '7',  'ISMA',
'ING.INFORMATICA','C/7','isma@gmail.com',300.34,'EMPLEADO',7,'976777777');
INSERT INTO Empleado VALUES ( '8',  'SERGIO',
'ING.INFORMATICA','C/8','sergio@gmail.com',300.34,'EMPLEADO',8,'976888888');
INSERT INTO Dirigir   VALUES ('1', '1', to_date('12-6-94','DD-MM-YY'));
INSERT INTO Pertenecer VALUES ( '1',  '2');
INSERT INTO Encargar   VALUES ('222222222','2','6','1F',1);
INSERT INTO Contratar VALUES ('111111111','2', to_date('12-7-94','DD-MM-YY'));
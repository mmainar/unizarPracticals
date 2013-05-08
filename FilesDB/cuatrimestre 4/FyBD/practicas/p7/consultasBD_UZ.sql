/* @consultasBD_UZ.sql */

SET ECHO ON
/* I. Listado de las areas de conocimiento, junto con el total de horas 
      de teoria y practicas que imparten */

SELECT A.nombArea, sum(S.tt_HT), sum(S.tt_HP)
FROM AreaConoc A, Asignatura S
WHERE (A.clvArea = S.clvArea)
GROUP BY A.nombArea;

/* II. Listado de las asignaturas (nombre y clave) impartidas por profesores
       de mas de un departamento */

/* Vista1 = Areas de conocimiento que pertenecen a mas de un departamento */

CREATE VIEW Vista1 AS
SELECT AC.clvArea, count(AC.clvDpto) num
FROM AreaConoc AC
GROUP BY AC.clvArea
HAVING count(AC.clvDpto)>1;

SELECT A.clvAsign, A.nombAsign
FROM Asignatura A, Vista1 V1, ImparteAsign IA
WHERE (A.clvArea = V1.clvArea) AND (IA.clvAsign = A.clvAsign);


DROP VIEW Vista1;


/* III. Listado de los pares (clvDpto, clvArea) correspondientes a los departame
ntos
       que imparten docencia en al menos todas las asignaturas encargadas a dich
a
       area. No se incluyen las areas que no tienen encargada ninguna asignatura
 */

/* Vista 1 = Departamentos y asignaturas impartidas */


CREATE VIEW Vista1 (clvDpto, clvAsign) AS
SELECT AC.clvDpto, IA.clvAsign
FROM AreaConoc AC, Profesor P, ImparteAsign IA
WHERE (IA.clvProf = P.clvProf) AND (P.clvArea = AC.clvArea);

/* Vista 2 = Departamentos junto con las areas en que imparte docencia
             en alguna de las asignaturas que tiene encargadas */

CREATE VIEW Vista2 (clvDpto, clvArea) AS
SELECT clvDpto, clvArea
FROM Asignatura A, Vista1 V1
WHERE (V1.clvAsign = A.clvAsign);

/* Vista 3 = Departamentos junto con las asignaturas que no imparten */

CREATE VIEW Vista3 (clvDpto, clvAsign) AS
SELECT D.clvDpto, A.clvAsign
FROM Departamento D, Asignatura A
MINUS SELECT * FROM Vista1;

/* Vista 4 = Departamentos y areas en las que hay alguna asignatura
             encargada que no es impartida por dicho departamento */

CREATE VIEW Vista4 (clvDpto, clvArea) AS
SELECT V3.clvDpto, A.clvArea
FROM Vista3 V3, Asignatura A
WHERE (V3.clvAsign = A.clvAsign);

SELECT * FROM Vista2 MINUS SELECT * FROM Vista4;


DROP VIEW Vista1;
DROP VIEW Vista2;
DROP VIEW Vista3;
DROP VIEW Vista4;



/* IV. Listado de todos los profesores (clave y nombre) tales que hay alguna
       asignatura en la que son los unicos que imparten docencia. No deben
       aparecer los que no dan clase. */

/* Vista 1 = Claves de las asignaturas impartidas por un solo profesor */

CREATE VIEW Vista1 (clvAsign) AS
SELECT IA.clvAsign
FROM ImparteAsign IA, Profesor P, Asignatura A
WHERE (IA.clvAsign = A.clvAsign) AND (IA.clvProf = P.clvProf)
GROUP BY IA.clvAsign
HAVING count(IA.clvProf) = 1;

SELECT DISTINCT P.clvProf, P.nombProf
FROM Vista1 V1, Asignatura A, Profesor P, ImparteAsign IA
WHERE (V1.clvAsign = IA.clvAsign) AND (IA.clvProf = P.clvProf);

DROP VIEW Vista1;



/* V. Listado del area o areas que tienen encargada docencia en mas titulaciones
.
      Para ello se construye una vista, ordenada, con el numero de titulaciones
      en que tiene encargada docencia cada area */

/* Vista con el numero de titulaciones en que tiene encargada docencia cada area
 */

CREATE VIEW Vista1 (clvArea, nombArea, numTitulaciones) AS
SELECT AC.clvArea, AC.nombArea, count(distinct AT.clvTitulo) numTitulaciones
FROM AreaConoc AC, Asignatura A, AsignTitulo AT, ImparteAsign IA, Profesor P
WHERE (IA.clvAsign = AT.clvAsign) AND (A.clvAsign = IA.clvAsign)
     AND (IA.clvProf = P.clvProf) AND (AC.clvArea = P.clvArea)
GROUP BY AC.clvArea, AC.nombArea
ORDER BY numTitulaciones;


CREATE VIEW Vista2 AS
SELECT clvArea, nombArea, numTitulaciones
FROM Vista1
WHERE (numTitulaciones = (SELECT max(numTitulaciones) FROM Vista1));

SELECT * FROM Vista2;

DROP VIEW Vista1;
DROP VIEW Vista2;



/* VI. Realizar las operaciones necesarias para eliminar de ImparteAsign aquello
s
       profesores que no imparten ninguna hora en una asignatura asi como las
       necesarias para garantizar que en lo sucesivo no se produzca tal situacio
n */

/* Eliminamos de ImparteAsign a aquellos profesores que no imparten ninguna hora
   en una asignatura */

DELETE FROM ImparteAsign WHERE (HT = 0) AND (HP = 0);

/* Para garantizar que en lo sucesivo no se produzca tal situacion, al crear la
   B.D. de la universidad de zaragoza, añadimos las restricciones siguientes en
la
   tabla ImparteAsign:
     CONSTRAINT  IA_horasNoNeg CHECK ( HT >= 0 AND HP >= 0 ),
     CONSTRAINT  IA_horasMas_0 CHECK ( HT + HP > 0 )
   */

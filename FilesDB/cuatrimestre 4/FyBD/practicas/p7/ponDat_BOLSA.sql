/* @ponDat_BOLSA.sql */

INSERT INTO EntBancaria VALUES ('clvIber', 'IberCaja');

INSERT INTO CuentaValores VALUES ('clvCuentaIber', 976000001, 'clvSecCuentIber', 'clvIber');
				 
INSERT INTO EntBancaria VALUES ('clvBBV', 'BBV');

INSERT INTO CuentaValores VALUES ('clvCuentaBBV', 976000101, 'clvSecCuentaBBV', 'clvBBV');
	 
INSERT INTO CarteraValores VALUES (001, 'clvIber', 'clvCuentaIber');
INSERT INTO CarteraValores VALUES (002, 'clvIber', 'clvCuentaIber');
INSERT INTO CarteraValores VALUES (003, 'clvBBV', 'clvCuentaBBV');

INSERT INTO Agente VALUES ('clvAg01', 'Agente 01', 976123212, 'Calle 01', 
                           'Es un poco incompetente', 001, 'clvCuentaIber',
			   'clvIber');
INSERT INTO Agente VALUES ('clvAg02', 'Agente 02', 976123213, 'Calle 02', 
                           'Es muy incompetente', 002, 'clvCuentaIber',
			   'clvIber');
INSERT INTO Agente VALUES ('clvAg03', 'Agente 03', 976123214, 'Calle 03', 
                           'Es un poco incompetente', 003, 'clvCuentaBBV',
			   'clvBBV');	   
INSERT INTO Empresa VALUES ('El Corte Ingles', 'Menudo gigante');
INSERT INTO Empresa VALUES ('MediaMarkt', 'Que ofertas...');
INSERT INTO Empresa VALUES ('GranCasa', 'Tienen bolera!');
INSERT INTO Empresa VALUES ('YouTube', 'Sus videos son una pasada');

INSERT INTO Valor VALUES ('ECI', 'Dinamarca', 'El Corte Ingles', 25, 0.1, TO_DATE ('1-JAN-2001', 'DD-MM-YYYY'));
INSERT INTO Valor VALUES ('MMKT', 'Brasil', 'MediaMarkt', 23, 0.12, TO_DATE ('1-MAY-2001','DD-MM-YYYY'));
INSERT INTO Valor VALUES ('GCSA', 'Congo', 'GranCasa', 56, 0.2, TO_DATE ('11-JAN-2001', 'DD-MM-YYYY'));
INSERT INTO Valor VALUES ('YOUT', 'Zagreb', 'YouTube', 14, 0.6, TO_DATE ('6-MAR-2001', 'DD-MM-YYYY'));


INSERT INTO ContenerTit VALUES ('ECI', 'Dinamarca', 'clvCuentaIber', 001, 120, 'clvIber');			 
INSERT INTO ContenerTit VALUES ('MMKT', 'Brasil', 'clvCuentaIber', 001, 75, 'clvIber');	
INSERT INTO ContenerTit VALUES ('GCSA', 'Congo', 'clvCuentaIber', 002, 89, 'clvIber');	
INSERT INTO ContenerTit VALUES ('YOUT', 'Zagreb', 'clvCuentaBBV', 003, 200, 'clvBBV');	
			 
			 

INSERT INTO Informar VALUES (TO_DATE ('23-SEP-2007', 'DD-MM-YYYY'), 4, 65600.23, 3200.6, 1615.75, 4100.56, 0.2, 'Compra poco productiva', 'ECI', 'clvAg01');			     
INSERT INTO Informar VALUES (TO_DATE ('16-APR-2007', 'DD-MM-YYYY'), 7, 65400.23, 3000.6, 1600.75, 4100.56, 0.1, 'Compra interesante', 'MMKT', 'clvAg01');
INSERT INTO Informar VALUES (TO_DATE ('15-APR-2007', 'DD-MM-YYYY'), 7, 65400.23, 3030.6, 1640.75, 4100.56, 0.8, 'Compra interesante', 'GCSA', 'clvAg02');
INSERT INTO Informar VALUES (TO_DATE ('19-APR-2007', 'DD-MM-YYYY'), 7, 65400.23, 3040.6, 1605.75, 4100.56, 0.3, 'Compra interesante', 'YOUT', 'clvAg03');

			     
INSERT INTO Operar VALUES (TO_DATE ('23-SEP-2007', 'DD-MM-YYYY'), 5, 65400.23, 4103.56, 1, 'Compra interesante', 'ECI', 'clvAg01');
INSERT INTO Operar VALUES (TO_DATE ('16-APR-2007', 'DD-MM-YYYY'), 6, 65430.23, 4200.56, 1, 'Compra interesante', 'MMKT', 'clvAg01');
INSERT INTO Operar VALUES (TO_DATE ('15-APR-2007', 'DD-MM-YYYY'), 7, 66400.23, 4103.56, -1, 'Venta deplorable', 'GCSA', 'clvAg02');
INSERT INTO Operar VALUES (TO_DATE ('19-APR-2007', 'DD-MM-YYYY'), 8, 6400.23, 4120.56, 1, 'Vaya compra mas mala', 'YOUT', 'clvAg03');				   		     
			     


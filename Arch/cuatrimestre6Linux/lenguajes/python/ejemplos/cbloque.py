nombre = raw_input("Nombre del fichero: ");
f = open(nombre,'r');
if f.read(1) == 'h':
    genero = 1;
    print 'Hombre'
elif f.read(1) == 'm':
    genero = 2;
    print 'Mujer'
else:
    print 'Sexo incorrecto'  

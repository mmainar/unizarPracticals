def sqr(n): # Funcion sqr
  return n*n

myfile = file("prueba", "w") # Creamos un fichero prueba
i = 2;
cadena = str(i)
myfile.write(cadena)
i = 3
cadena = str(i)
myfile.write(cadena)
myfile.close()
# myfile es un fichero que contiene 2 enteros: 2 3
myfile = open('prueba', 'r')
#print int(myfile.read(1))
# myfile.read(1) lee un elemento del fichero myfile
""" Orden de evaluacion: Cuando una abstraccion
    se activa el parametro actual se evalua en el
    momento de la llamada (en orden aplicativo, 
    posibilidad a).
    Como la evaluacion es en el momento de la llamada,
    se lee un entero del fichero y se eleva al cuadrado."""
print ( sqr( int(myfile.read(1)) )) # Se lee el entero 2
print ( sqr( int(myfile.read(1)) ))  # Se lee el entero 3

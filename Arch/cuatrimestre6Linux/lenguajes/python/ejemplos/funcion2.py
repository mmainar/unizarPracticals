def parametros(a, lista):
  a += 1
  lista.append(10) # Equivalente a lista = lista + [10]

x = 1
l = [1,2,3]
parametros(x,l)
print x
print l

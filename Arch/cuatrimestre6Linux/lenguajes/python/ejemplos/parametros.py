def incrementa(p):
  p = p + 1
  return p

a = 1
b = incrementa(a)

print 'a:', a
print 'b:', b


def modifica(a, b):
  a.append(4)
  b = b + [4]
  return b

lista1 = [1, 2, 3]
lista2 = [1, 2, 3]
lista3 = modifica(lista1, lista2)

print lista1
print lista2
print lista3


def modifica(a, b):
  for elemento in b:
    a.append(elemento)
  b = b + [4]
  a[-1] = 100
  del b[0]
  return b[:]

lista1 = [1, 2, 3]
lista2 = [1, 2, 3]
lista3 = modifica(lista1, lista2)

print lista1
print lista2
print lista3


def modifica_parametros(x, y):
  x = 1
  y[0] = 1

a = 0
b = [0, 1, 2]
modifica_parametros(a, b)
print a
print b

def modifica_parametros2(x, y):
  x = 1
  y.append(3)
  y = y + [4]
  y[0] = 10

a = 0
b = [0, 1, 2]
modifica_parametros2(a, b)
print a
print b

# Same as def f(x): return x + 1
functionvar = lambda x: x + 1
print functionvar(1)
 
# an_int and a_string are optional, they have default values
# if one is not passed (2 and "A default string", respectively).
def passing_example(a_list, an_int=2, a_string="A default string"):
    a_list.append("A new item")
    an_int = 4
    return a_list, an_int, a_string
 
my_list = [1, 2, 3]
my_int = 10
print passing_example(my_list, my_int)
print my_list
print my_int

def parametros(a, lista):
  a += 1
  j = lista + [5]
  lista.append(10)
  return j


x = 1
l = [1,2,3]
j = parametros(x,l)
# x no se ha modificado
print x
# pero a l se le ha agregado el elemento 10
print l
print j

def f(x, y):
    x = x + 3
    y.append(23)
    print x, y

x = 22
y = [22]
f(x, y)
print x, y


def sumar(x, y):
    return x + y

print sumar(3, 2)

def f2(x, y):
    return x * 2, y * 2

a, b = f2(1, 2)


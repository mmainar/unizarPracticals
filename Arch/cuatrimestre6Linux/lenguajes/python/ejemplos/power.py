import math

def power(x_real, n_int): # funcion potencia
  if n_int == 1:
    return x_real
  else:
    return x_real * power(x_real, n_int - 1)
    
def power2(x_real, n_int): # funcion potencia2
  if n_int == 1:
    return x_real
  elif (n_int % 2 == 0):
    return  power2(math.pow(x_real,2), n_int/2)
  else:
    return x_real * power2(math.pow(x_real,2), n_int/2)
        
    
print power(2,5)    
print power(2,1)    
print power2(2,5)
print power2(2,1)
    
    
""" En Python, como en C, los procedimientos son simplemente
funciones que no devuelven un valor. En realidad, tecnicamente
hablando, si que devuelven un valor. Este valor se llama "None" y 
esta predefinido.

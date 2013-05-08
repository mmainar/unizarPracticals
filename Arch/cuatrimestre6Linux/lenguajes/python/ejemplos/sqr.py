def sqr(n):
  return n*n
  
p = 2
q = 5
""" Orden de evaluacion: Cuando una abstraccion
    se activa el parametro actual se evalua en el
    momento de la llamada (en orden aplicativo, 
    posibilidad a) """
print (sqr(p+q))

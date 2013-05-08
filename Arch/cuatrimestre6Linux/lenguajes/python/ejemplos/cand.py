def cand(b1, b2):  # evaluacion cortocircuitada
  if b1:
    return b2
  else:
    return false
    
n = 2
t = 0.8    
print (cand (n>0, t/n>0.5))

# Division por cero (se genera excepcion)
n = 0 
print (cand (n>0, t/n>0.5)) 

print "hola" # no se llega a ejecutar

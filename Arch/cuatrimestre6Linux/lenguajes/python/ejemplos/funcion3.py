def ejemplo(lista, entero=2, cadena="Cadena por defecto"):
    lista.append("Elemento nuevo")
    entero = 4
    return lista, entero, cadena
 
mi_lista = [1, 2, 3]
mi_entero = 10
print ejemplo(mi_lista, mi_entero)
print mi_lista
print mi_entero


print "Name: %s\nNumber: %s\nString: %s" % (myclass.name, 3, 3 * "-")
 
strString = """This is
a multiline
string."""
 
# WARNING: Watch out for the trailing s in "%(key)s".
# Lo de entre llaves es un diccionario con pares <clave,valor>
print "This %(verb)s a %(noun)s." % {"noun": "test", "verb": "is"}

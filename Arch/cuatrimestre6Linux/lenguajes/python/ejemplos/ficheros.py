# Libreria usada para convertir E.D en cadenas
import pickle
mylist = ["This", "is", 4, 13327]
# Open the file C:\binary.dat for writing. The letter r before the
# filename string is used to prevent backslash escaping.
myfile = file(r"C:\binary.dat", "w")
pickle.dump(mylist, myfile)
myfile.close()
 
myfile = file(r"C:\text.txt", "w")
myfile.write("This is a sample string")
myfile.close()
 
myfile = file(r"C:\text.txt")
print myfile.read()
myfile.close()
 
# Open the file for reading.
myfile = file(r"C:\binary.dat")
loadedlist = pickle.load(myfile)
myfile.close()
print loadedlist

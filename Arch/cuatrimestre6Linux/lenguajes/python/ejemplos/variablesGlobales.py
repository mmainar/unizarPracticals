number = 5
 
def myfunc():
    # This will print 5.
    print number
 
def anotherfunc():
    # This raises an exception because the variable has not
    # been bound before printing. Python knows that it an
    # object will be bound to it later and creates a new, local
    # object instead of accessing the global one.
    print number
    number = 3
 
def yetanotherfunc():
    global number
    # This will correctly change the global.
    number = 3

myfunc()
anotherfunc()
yetanotherfunc()

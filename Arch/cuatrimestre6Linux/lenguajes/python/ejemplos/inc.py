def inc():
    global c
    c = c + 1
    print c;

def inc2():
    global c
    c = c+1
    print c

c = 0
print c
inc(); inc2();

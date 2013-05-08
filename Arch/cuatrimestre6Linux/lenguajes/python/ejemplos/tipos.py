sample = [1, ["another", "list"], ("a", "tuple")]
mylist = ["List item 1", 2, 3.14]
mylist[0] = "List item 1 again"
mylist[-1] = 3.14
mydict = {"Key 1": "Value 1", 2: 3, "pi": 3.14}
mydict["pi"] = 3.15
mytuple = (1, 2, 3)
myfunction = len
print myfunction(mylist)
mylist = ["List item 1", 2, 3.14]
print mylist[:]
print mylist[0:2]
print mylist[-3:-1]
print mylist[1:]


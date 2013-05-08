class MyClass:
    common = 10
    def __init__(self):
        self.myvariable = 3
    def myfunction(self, arg1, arg2):
        return self.myvariable
 
    # This is the class instantiation
classinstance = MyClass()
print classinstance.myfunction(1, 2)

# This variable is shared by all classes.
classinstance2 = MyClass()
print classinstance.common
print classinstance2.common

# Note how we use the class name
# instead of the instance.
MyClass.common = 30
print classinstance.common
print classinstance2.common

# This will not update the variable on the class,
# instead it will bind a new object to the old
# variable name.
classinstance.common = 10
print classinstance.common
print classinstance2.common

MyClass.common = 50
# This has not changed, because "common" is
# now an instance variable.
print classinstance.common

print classinstance2.common
 
# This class inherits from MyClass. Multiple
# inheritance is declared as:
# class OtherClass(MyClass1, MyClass2, MyClassN)
class OtherClass(MyClass):
    def __init__(self, arg1):
        self.myvariable = 3
        print arg1
 
classinstance = OtherClass("hello")
print classinstance.myfunction(1, 2)

# This class doesn't have a .test member, but
# we can add one to the instance anyway. Note
# that this will only be a member of classinstance.
classinstance.test = 10
print classinstance.test

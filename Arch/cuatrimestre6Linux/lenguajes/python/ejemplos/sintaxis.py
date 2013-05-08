myvar = 3
myvar += 2
print myvar
myvar -= 1
print myvar
"""This is a multiline comment.
The following lines concatenate the two strings."""
mystring = "Hello"
mystring += " world."
print mystring
# This swaps the variables in one line(!).
# It doesn't violate strong typing because values aren't
# actually being assigned, but new objects are bound to
# the old names.
myvar, mystring = mystring, myvar

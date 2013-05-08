lst1 = [1, 2, 3]
lst2 = [3, 4, 5]
print [x * y for x in lst1 for y in lst2]
print [x for x in lst1 if 4 > x > 1]
# Check if an item has a specific property.
# "any" returns true if any item in the list is true.
print any(i % 3 for i in [3, 3, 4, 4, 3])

# Check how many items have this property.
print sum(1 for i in [3, 3, 4, 4, 3] if i == 3)
del lst1[0]
print lst1

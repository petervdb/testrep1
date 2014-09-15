# In python 3 raw_input has been renamed to input
print "How old are you?",
age = raw_input()
print "How tall are you?",
height = raw_input()
print "How much do you weight?",
weight = raw_input()

print "So, you're %r old, %r tall and %r heavy." % (
	age, height, weight)
 
# This is some additional stuff as requested in the Sudy Drills

print "Now I am going to try to retrieve the values of your input"
children = raw_input('How many children do you have? ')
children = int(children)
print "The integer value of this is : %s" % children


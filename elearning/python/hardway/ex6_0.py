#!/usr/bin/python
# This script has been updated with the Sudy drills

# a string inside a string
x= "There are %d types of people." % 10
binary= "binary"
do_not = "don't"

# a string inside a string
y = "Those who know %s and those who %s." % (binary, do_not)

# Now print it out.
print x
print y

# Print is again with quotes
print "I said: %r." % x
print "I also said: '%s'." % y

hilarious = True
# a string inside a string
joke_evaluation = "Isn't that joke so funny?! %r"

print joke_evaluation % hilarious

w = "This is left side of..."
e = "a string with a right side."

# Print the 2 strings together.
print w + e


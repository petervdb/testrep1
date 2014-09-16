from sys import argv

# retrieve the arguments. Need 1
script, filename = argv

# open the file 
txt = open(filename)

print "Here's your file %r:" % filename
# show the content of the file
print txt.read()

# which fiel should I open now?
print "Type the filename again:"
file_again = raw_input("> ")

txt_again = open(file_again)
# show content of the file 
print txt_again.read()

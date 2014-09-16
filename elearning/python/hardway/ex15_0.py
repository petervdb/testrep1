from sys import argv

# added some extra commands that are not found in the book. 
# retrieve the arguments. Need 1
script, filename = argv

# open the file 
txt = open(filename)

print "Here's your file %r:" % filename
# show the content of the file
print txt.read()
txt.close()

# which file should I open now?
print "Type the filename again:"
file_again = raw_input("> ")

txt_again = open(file_again)
# show content of the file 
print txt_again.read()

# will try to read only line 2 but we need to open it again to start at the beginning of the file
txt_again = open(file_again)
print "Will only read 20 characters"
print "----------------------------------------"
print txt_again.readline(20)
print txt_again.readline(20)

# will close the file now
txt_again.close()

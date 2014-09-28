from sys import argv
from os.path import exists

# short version of ex17_0.py
# The script requires 2 arguments. The original filename and the new filename
script, from_file, to_file = argv

print "Copying from %s to %s" % (from_file, to_file)

indata = open(from_file).read()

out_file = open(to_file, 'w')
out_file.write(indata)

out_file.close()

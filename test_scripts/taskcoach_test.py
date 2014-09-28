#!/usr/bin/python3

from sys import argv
from os.path import exists
import xml.etree.ElementTree as etree

# This is a test program to analyze taskcoach files

script, taskfile = argv
if exists(taskfile):
	tk_file = etree.parse(taskfile)
else:
	print("Sorry, %s does not exist." % taskfile)
	exit(1)
root = tk_file.getroot()
print("Document root: %s " % root)
print("Child elements of root: %s " % len(root))
for child in root:
	print(child)


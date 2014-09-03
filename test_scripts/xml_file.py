#!/usr/bin/python3

from urllib.request import urlopen
from xml.etree.ElementTree import parse
from xml.dom import minidom

Test_file = open('./test_file.xml','r')
xmldoc = minidom.parse(Test_file)

Test_file.close()

def printNode(node):
  print(node)
  for child in node.childNodes:
       printNode(child)

printNode(xmldoc.documentElement)

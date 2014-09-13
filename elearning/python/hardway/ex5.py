#!/usr/bin/python
# -- coding: utf-8 --
# the script has already been modified with the study drills

name = 'Zed A. Shaw'
age = 35 # not a lie
height = 74 # inches
height = height * 2.54 # convert it to cm
weight = 180.0 # lbs
weight = weight / 2.2 # convert it to kilos
eyes = 'Blue'
teeth = 'White'
hair = 'Brown'

print("Let's talk about %s." % name)
print("Let's talk about %r." % name)
print("He's %d cm tall." % height)
print("He's %f cm tall." % height)
print("He's %r cm tall." % height)
print("He's %d kg heavy." % weight)
print("Actually that's not too heavy")
print("He's got %s eyes and %s hair." % (eyes, hair))
print("His teeth are usually %s depending on the coffee." % teeth)

# this line is tricky, try to get it exactly right
print("if I add %d, %d and %d I get %d." % (age, height, weight, age + height + weight))

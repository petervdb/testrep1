#!/bin/bash
# Show  running queries 
# Requires that .my.cnf has been created with user and password information
myscript=`basename $0`
# Use this syntax or use: if [ $# -lt 3 ]
if (( $# < 1 ))
then
  printf "%b" "Error. Not enough arguments.\n" >&2
  printf "%b" "usage: $myscript server\n" >&2
  exit 1
else
  mysql -h $1 -e "SELECT * FROM information_schema.processlist WHERE command != 'Sleep' ORDER BY id;"
fi

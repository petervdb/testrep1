#!/bin/bash
# Show long running queries      
# Requires that .my.cnf has been created with user and password information
myscript=`basename $0`
# Use this syntax or use: if [ $# -lt 3 ]
if (( $# < 2 ))
then
  printf "%b" "Error. Not enough arguments.\n" >&2
  printf "%b" "usage: $myscript server seconds\n" >&2
  exit 1
else
  mysql -h $1 -e "SELECT user, time, state, info FROM information_schema.processlist WHERE command != 'Sleep' AND time >= $2 ORDER BY time DESC, id;"
fi

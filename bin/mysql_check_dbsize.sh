#!/bin/bash
# Show current data and index size. Can be very time consuming for large databases.
# Requires that .my.cnf has been created with user and password information

myscript=`basename $0`
# Use this syntax or use: if [ $# -lt 3 ]
if (( $# < 1 ))
then
  printf "%b" "Error. Not enough arguments.\n" >&2
  printf "%b" "usage: $myscript server\n" >&2
  exit 1
else
  mysql -h $1 -e "SELECT ROUND(SUM(data_length+index_length)/1024/1024) AS total_mb, \
  ROUND(SUM(data_length)/1024/1024) as data_mb, \
  ROUND(SUM(index_length)/1024/1024) as index_mb \
  FROM INFORMATION_SCHEMA.tables;"
fi

#!/bin/bash
# Show current data and index size. Can be very time consuming for large databases.
# Requires that .my.cnf has been created with user and password information

myscript=`basename $0`
# Use this syntax or use: if [ $# -eq 2 ]
if (( $# != 2 ))
then
  printf "%b" "Error. Not enough arguments.\n" >&2
  printf "%b" "usage: $myscript server database\n" >&2
  exit 1
else
  server=$1
  db=$2
  mysql -h $server -e "SELECT table_name, table_type, engine,
    ROUND((data_length+index_length)/1024/1024) AS total_mb,
    ROUND(data_length/1024/1024) as data_mb,
    ROUND(index_length/1024/1024) as index_mb
    FROM information_schema.tables
    WHERE table_schema = '$db'
    ORDER BY table_name;"
fi

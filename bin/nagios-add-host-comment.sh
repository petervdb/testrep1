#!/bin/sh
# This is a sample shell script showing how you can submit the ADD_HOST_COMMENT command
# to Nagios. Adjust variables to fit your environment as necessary.

# now=`date +%Y-%m-%d %H:%M:%S`
now=`date +%s`
commandfile='/var/lib/nagios3/rw/nagios.cmd'
host=$1
comment=$2

/usr/bin/printf "[%lu] ADD_HOST_COMMENT;$host;1;nagios;$comment\n" $now > $commandfile 

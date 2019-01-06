#!/bin/sh
# This is a sample shell script showing how you can submit the ADD_SVC_COMMENT command
# to Nagios. Adjust variables to fit your environment as necessary.

now=`date +%s`
commandfile='/var/lib/nagios3/rw/nagios.cmd'
host=$1
service=$2
comment=$3
/usr/bin/printf "[%lu] ADD_SVC_COMMENT;$1;$2;1;nagios;$comment\n" $now > $commandfile  

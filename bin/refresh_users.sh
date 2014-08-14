#!/usr/bin/bash
# I use this script to update the /etc/passwd and /etc/group file with Active Directory
#

myscript=`basename $0`

echo "Creating a backup first ..."
# Lets make a backup first
cur_date=`date '+%Y%m%d_%H%M%S'`
backup_dir=${HOME}/backup
cp /etc/passwd ${backup_dir}/passwd_${cur_date}
cp /etc/group ${backup_dir}/group_${cur_date}
echo "Backup created"
# Update passwd and group file
# This can take a while if Active Directory contains a lot of users and groups

echo "Started refreshing group file"
mkgroup -l -d > /etc/group
echo "Refresh group file completed"
echo "Started refreshing passwd file"
mkpasswd -l -d > /etc/passwd
echo "Refresh passwd file completed"

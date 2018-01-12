#!/bin/bash
# Full Backup script for Linux
# Please check the settings first
#

# Settings
##################################################
server=`hostname -s`
backup_dir="/backup/${server}"
cur_user=`whoami`
echo "INFO - Creating full backup of important folders"
if [ ! "$cur_user" == "root" ]; then
  echo "WARNING - It is recommended to execute the backup script as root"
  exit 1;
fi
if [ ! -d "$backup_dir" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo -n "INFO - Backup folder $backup_dir does not exist. Creating ...."
  mkdir $backup_dir
  echo "done."
fi
echo "INFO - Creating full backup /srv folder."
tar -czpf ${backup_dir}/srv_full_backup.tar.gz /srv

echo "INFO - Backup created."

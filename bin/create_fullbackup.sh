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
tar --listed-incremental=${backup_dir}/srv_snapshot.snar --level=0 -czpf ${backup_dir}/srv_full_backup.tar.gz /srv
# To prevent confusion we should delete created incremental backups
echo -n "INFO - Remove created incremental backups ..."
if [ -f "${backup_dir}/srv_incremental_backup.tar.gz" ]; then
  rm "${backup_dir}/srv_incremental_backup.tar.gz"
fi
echo " done."
echo "INFO - Backup created."

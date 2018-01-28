#!/bin/bash
# Incremental Backup script for Linux
# Please check the settings first
#

# Settings
##################################################
server=`hostname -s`
backup_dir="/backup/${server}"
cur_user=`whoami`
echo "INFO - Creating incremental backup of important folders"
if [ ! "$cur_user" == "root" ]; then
  echo "WARNING - It is recommended to execute the backup script as root"
  exit 1;
fi
if [ ! -d "$backup_dir" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "WARNING - Backup folder $backup_dir does not exist."
  echo "WARNING - You will need to create a full backup first."
  exit 1;
fi
if [ ! -f "${backup_dir}/srv_full_backup.tar.gz" ]; then
  echo "WARNING - No backup file found. You need to create a full backup first."
  exit 1;
fi
echo "INFO - Creating incremental backups"
# /etc folder
echo "INFO - Creating incremental backup /etc folder."
tar --listed-incremental=${backup_dir}/etc_snapshot.snar --level=1 -czpf ${backup_dir}/etc_incremental_backup.tar.gz /etc
# /home folder
echo "INFO - Creating incremental backup /home folder."
tar --listed-incremental=${backup_dir}/home_snapshot.snar --level=0 -czpf ${backup_dir}/home_incremental_backup.tar.gz /home
# /srv folder
echo "INFO - Creating incremental backup /srv folder."
tar --listed-incremental="${backup_dir}/srv_snapshot.snar" --level=1 -czpf "${backup_dir}/srv_incremental_backup.tar.gz" /srv
# /var/lib folder
echo "INFO - Creating incremental backup /var/lib folder."
tar --listed-incremental=${backup_dir}/var_lib_snapshot.snar --level=0 -czpf ${backup_dir}/var_lib_incremental_backup.tar.gz /var/lib

echo "INFO - Incremental backups created."


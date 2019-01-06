#!/bin/bash
# Full Backup script for Linux
# Please check the settings first
# Only a backup is made of some specific folders. 
# Backup folders are: /home /etc /srv /var/lib
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

# /etc folder
echo "INFO - Creating full backup /etc folder."
tar --listed-incremental=${backup_dir}/etc_snapshot.snar --level=0 -czpf ${backup_dir}/etc_full_backup.tar.gz /etc
# /home folder
echo "INFO - Creating full backup /home folder."
tar --listed-incremental=${backup_dir}/home_snapshot.snar --level=0 -czpf ${backup_dir}/home_full_backup.tar.gz /home
# /srv folder
echo "INFO - Creating full backup /srv folder."
tar --listed-incremental=${backup_dir}/srv_snapshot.snar --level=0 -czpf ${backup_dir}/srv_full_backup.tar.gz /srv
# /var/lib folder
echo "INFO - Creating full backup /var/lib folder."
tar --listed-incremental=${backup_dir}/var_lib_snapshot.snar --level=0 -czpf ${backup_dir}/var_lib_full_backup.tar.gz /var/lib
# /usr/lib/nagios/plugins
echo "INFO - Creating full backup /usr/lib/nagios/plugins folder."
tar --listed-incremental=${backup_dir}/nagios_plugins_snapshot.snar --level=0 -czpf ${backup_dir}/nagios_plugins_backup.tar.gz /usr/lib/nagios/plugins

# To prevent confusion we should delete created incremental backups
echo -n "INFO - Remove created incremental backups ..."
# /etc folder
if [ -f "${backup_dir}/etc_incremental_backup.tar.gz" ]; then
  rm "${backup_dir}/etc_incremental_backup.tar.gz"
fi
# /home folder
if [ -f "${backup_dir}/home_incremental_backup.tar.gz" ]; then
  rm "${backup_dir}/home_incremental_backup.tar.gz"
fi
# /srv folder
if [ -f "${backup_dir}/srv_incremental_backup.tar.gz" ]; then
  rm "${backup_dir}/srv_incremental_backup.tar.gz"
fi
# /var/lib folder
if [ -f "${backup_dir}/var_lib_incremental_backup.tar.gz" ]; then
  rm "${backup_dir}/var_lib_incremental_backup.tar.gz"
fi
# /usr/lib/nagios/plugins folder
if [ -f "${backup_dir}/nagios_plugins_incremental_backup.tar.gz" ]; then
  rm "${backup_dir}/nagios_plugins_incremental_backup.tar.gz"
fi
echo " done."
echo "INFO - Backup created."

#!/bin/bash
# MySQL/MariaDB Database Backup script.
# Created By: Peter Vandenberghe
# Created   : 20180119
# Updated   : 20180119
# Version   : 1.0.0
#
# This is still a backup backup scripts and needs some tuning
# Todo: check if all folders exists
# Test on specific storage engines
#
# Database credentials
# The login and password needs to be stored in the .my.cnf file 
# Your .my.cnf file also needs a mysqladmin and mysqldump section with user and password 
# 

# Settings
SERVER=`hostname -s`
BKUP_ROOT="/backup/mysql/${SERVER}/dumps"
# Get list of Databases except the pid file
DBS_LIST=$(echo "show databases;"|mysql -N)
# Log file
BKUP_LOG=/backup/mysql/${SERVER}/mysql-backup.log
# Backup Base directory
BASE_BKUP_DIR="/backup/mysql/${SERVER}/dumps"
# Backup rotation period.
BACKUP_HISTORY="+30"

# From here, only edit if you know what you are doing.
index=0
PING=$(mysqladmin ping 2> /dev/null)
if [ "$PING" != "mysqld is alive" ]; then
        echo "Error:: Unable to connected to MySQL Server, exiting !!"
        exit 101
fi
# Backup process starts here.
# Flush logs prior to the backup.
mysql -e "FLUSH LOGS"
# Loop through the DB list and create table level backup,
# applying appropriate option for MyISAM and InnoDB tables.
for DB in $DBS_LIST; do
    DB_BKP_FLDR=$BASE_BKUP_DIR/$(date +%Y%m%d)/$DB
    [ ! -d $DB_BKP_FLDR ]  && mkdir -p $DB_BKP_FLDR
    # Get the schema of database with the stored procedures.
    # This will be the first file in the database backup folder
    mysqldump -R -d --single-transaction $DB | gzip -c > $DB_BKP_FLDR/000-DB_SCHEMA.sql.gz
    index=0
    #Get the tables and its type. Store it in an array.
    table_types=($(mysql -e "show table status from $DB" | \
            awk '{ if ($2 == "MyISAM" || $2 == "InnoDB") print $1,$2}'))
    table_type_count=${#table_types[@]}
    # Loop through the tables and apply the mysqldump option according to the table type
    # The table specific SQL files will not contain any create info for the table schema.
    # It will be available in SCHEMA file
    while [ "$index" -lt "$table_type_count" ]; do
        START=$(date +%s)
        TYPE=${table_types[$index + 1]}
        table=${table_types[$index]}
        echo -en "$(date) : backup $DB : $table : $TYPE "
        if [ "$TYPE" = "MyISAM" ]; then
            DUMP_OPT="$DB --no-create-info --tables "
        else
            DUMP_OPT="$DB --no-create-info --single-transaction --tables"
        fi
        mysqldump  $DUMP_OPT $table |gzip -c > $DB_BKP_FLDR/$table.sql.gz
        index=$(($index + 2))
        echo -e " - Total time : $(($(date +%s) - $START))\n"
    done
done
# Rotating old backup. according to the 'BACKUP_HISTORY'
if [ ! -z "$BACKUP_HISTORY" ]; then
    echo -en "$(date) : removing folder : "
    find $BASE_BKUP_DIR/ -maxdepth 1 -mtime $BACKUP_HISTORY -type d -exec rm -rf {} \;
    echo
fi


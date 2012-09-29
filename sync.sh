#!/bin/bash
# Copyright 2011 Red Beacon, Inc. - All Rights Reserved
#
# This code, and all derivative work, is the exclusive property of
# Red Beacon, Inc. and may not be used without Red Beacon, Inc.'s
# authorization.
#
# Author: Serkan Yersen


#################
# This script will sync your local copy to remove development server
# First setup the script parameters to match your computer
# make sure you have a passwordless connection to the remote server othervise
# it will constantly pop-up passwords and will not work.
# ----
# cat .ssh/id_rsa.pub | ssh serkan@***.***.***.*** 'cat >> .ssh/authorized_keys'
# above code will let you connect without password
# ----
# make sure you give executable permissions to this script
# chmod +x sync.sh
# -----
# Later you can use this script as a build script on your favorite editor for example on Sublime Text 2
#################

LOCK_FILE="/tmp/rsync_backup.lock"
LOG_FILE="/tmp/rsync_backup.log"
RSYNC="/usr/bin/rsync"
LOCAL="~/example"
USER="serkan"
HOST="example.com"
REMOTE="~/"

# Prevent multiple syncs to run
if [ -e $LOCK_FILE ]; then
    TIMESTAMP=$(date)
    echo "$TIMESTAMP: sync already running, exiting" >> $LOG_FILE
    exit
fi
cat /dev/null > $LOG_FILE
touch $LOCK_FILE

echo "Syncing Files. Please wait.";
$RSYNC -avzC --include='core' --exclude='.git' $LOCAL $USER@$HOST:$REMOTE | grep -v \/$

rm $LOCK_FILE

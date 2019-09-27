#!/bin/sh
# Server Farmer sf-backup-collector backups

oldhost=$1
newhost=$4

remote="/srv/mounts/backup/remote"

if [ -d $remote/$oldhost ]; then
	mv $remote/$oldhost $remote/$newhost
fi

if [ -d $remote/CUSTOM-$oldhost ]; then
	mv $remote/CUSTOM-$oldhost $remote/CUSTOM-$newhost
fi

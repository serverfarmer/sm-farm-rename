#!/bin/sh
# base Server Farmer configuration file

oldhost=$1
newhost=$4

oldip=$3
newip=$6

if grep -q $oldhost /etc/farmconfig; then
	sed -i -e "s/$oldhost/$newhost/" /etc/farmconfig
fi

if [ "$oldip" != "$newip" ] && [ "$oldip" != "" ] && [ "$newip" != "" ] && grep -q $oldip /etc/farmconfig; then
	sed -i -e "s/$oldip/$newip/" /etc/farmconfig
fi

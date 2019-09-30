#!/bin/sh
# Server Farmer firewall repository

oldhost=$1
newhost=$4

hosts="/opt/farm/ext/firewall/hosts"

if [ -s $hosts/$oldhost.sh ]; then
	mv $hosts/$oldhost.sh $hosts/$newhost.sh
	if [ -d /opt/farm/ext/firewall/links ]; then
		rm /opt/farm/ext/firewall/links/$oldhost.sh
		cd /opt/farm/ext/firewall/links && ln -s ../hosts/$newhost.sh
	fi
fi

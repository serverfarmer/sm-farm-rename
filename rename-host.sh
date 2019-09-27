#!/bin/bash
. /opt/farm/ext/net-utils/functions
# This script provides easy renaming functionality for Amazon EC2 instances
# after public hostname change (due to eg. instance temporary shutdown, AWS
# zone failure, or migrating to Elastic IP).
#
# Tomasz Klim, Jun 2016, rewritten Sep 2019
#

if [ "$2" = "" ]; then
	echo "usage: $0 <old-hostname> <new-hostname>"
	exit 1
elif ! [[ $1 =~ ^[a-z0-9.-]+[.][a-z0-9]+$ ]]; then
	echo "error: parameter $1 not conforming hostname format"
	exit 1
elif ! [[ $2 =~ ^[a-z0-9.-]+[.][a-z0-9]+$ ]]; then
	echo "error: parameter $2 not conforming hostname format"
	exit 1
elif [ "`getent hosts $1`" = "" ] && [ "`getent hosts $2`" = "" ]; then
	echo "error: both hostnames not found"
	exit 1
elif ! grep -q "^$1:" /etc/local/.farm/*.hosts && ! grep -q "^$1$" /etc/local/.farm/*.hosts; then
	echo "error: host $1 not in farm"
	exit 1
fi

oldhost=$1
newhost=$2

oldshort=`echo $oldhost |cut -d'.' -f1`
newshort=`echo $newhost |cut -d'.' -f1`

oldip=`resolve_host $oldhost`
newip=`resolve_host $newhost`

echo "renaming $oldhost locally"
/opt/farm/ext/farm-rename/internal/all.sh $oldhost $oldshort $oldip $newhost $newshort $newip

if [ -s /etc/local/.farm/collector.hosts ]; then
	for collector in `cat /etc/local/.farm/collector.hosts |grep -v ^#`; do

		if [ -z "${collector##*:*}" ]; then
			host="${collector%:*}"
			port="${collector##*:}"
		else
			host=$collector
			port=22
		fi

		echo "renaming $oldhost on remote collector $host"
		colkey=`/opt/farm/ext/keys/get-ssh-dedicated-key.sh $host root`
		ssh -i $colkey -p $port -o StrictHostKeyChecking=no root@$host "/opt/farm/ext/farm-rename/internal/all.sh $oldhost $oldshort $oldip $newhost $newshort $newip"
	done
fi

echo "done"
echo "don't forget to rename this host in systems outside Server Farmer control:"
echo "1. $oldhost -> $newhost"
echo "2. $oldshort -> $newshort"
echo "3. $oldip -> $newip"

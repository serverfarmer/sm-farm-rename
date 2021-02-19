#!/bin/sh
# Server Farmer farm (inventory) and ssh keys

oldhost=$1
newhost=$4

for dbfile in `grep -l $oldhost /etc/local/.farm/*.hosts`; do
	sed -i -e "s/$oldhost/$newhost/" $dbfile
done

for oldkey in `ls ~/.ssh/key-*@$oldhost 2>/dev/null`; do
	newkey=`echo $oldkey |sed s/$oldhost/$newhost/g`
	mv $oldkey $newkey
	if [ -f $oldkey.pub ]; then
		mv $oldkey.pub $newkey.pub
	fi
done

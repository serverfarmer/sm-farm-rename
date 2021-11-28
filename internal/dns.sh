#!/bin/sh
# Zone Manager master DNS database

oldhost=$1
newhost=$4

oldshort=$2
newshort=$5

oldip=$3
newip=$6

if [ -s ~/.zonemanager/dns/zone.all ]; then

	for file in `grep -l $oldhost ~/.zonemanager/dns/zone.* |grep -v -- -dynamic`; do
		sed -i -e "s/$oldhost/$newhost/" $file
	done

	for file in `grep -l $oldshort ~/.zonemanager/dns/zone.* |grep -v -- -dynamic`; do
		sed -i -e "s/$oldshort/$newshort/" $file
	done

	if [ "$oldip" != "$newip" ] && [ "$oldip" != "" ] && [ "$newip" != "" ]; then
		for file in `grep -l $oldip ~/.zonemanager/dns/zone.* |grep -v -- -dynamic`; do
			sed -i -e "s/$oldip/$newip/" $file
		done
	fi
fi

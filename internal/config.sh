#!/bin/sh
# Server Farmer configuration related to current host

oldhost=$1
newhost=$4

oldshort=$2
newshort=$5

oldip=$3
newip=$6

for file in `grep -l $oldhost /etc/local/.config/*`; do
	sed -i -e "s/$oldhost/$newhost/" $file
done

for file in `grep -l $oldshort /etc/local/.config/*`; do
	sed -i -e "s/$oldshort/$newshort/" $file
done

if [ "$oldip" != "$newip" ] && [ "$oldip" != "" ] && [ "$newip" != "" ]; then
	for file in `grep -l $oldip /etc/local/.config/*`; do
		sed -i -e "s/$oldip/$newip/" $file
	done
fi

#!/bin/sh
# initiated backup (part of Server Farmer not released as open source)

oldhost=$1
newhost=$4

path="/srv/initiated"

if [ -d $path/$oldhost ]; then
	mv $path/$oldhost $path/$newhost
	mv $path/_exclude/$oldhost.list $path/_exclude/$newhost.list
fi

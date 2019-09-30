#!/bin/sh

oldhost=$1
newhost=$4

oldshort=$2
newshort=$5

oldip=$3
newip=$6

scripts="farmconfig inventory config dns firewall known backup-remote backup-initiated"

for script in $scripts; do
	/opt/farm/ext/farm-rename/internal/$script.sh \
		$oldhost $oldshort $oldip \
		$newhost $newshort $newip
done

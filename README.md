# Overview

`sm-farm-rename` is a Server Farmer management extension responsible for renaming hosts already registered in the farm, including renaming all associated resources (ssh keys, backups, firewall scripts, DNS entries etc.).

Rename operation can be needed eg. after Amazon EC2 public hostname change (due to instance temporary shutdown, AWS whole-zone failure, or simply migrating to Elastic IP).

# Scripts

`rename-host.sh` - performs the host rename operation (both locally, and on all registered remote backup collector hosts)

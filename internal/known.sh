#!/bin/sh
# add new hostname to local ~/.ssh/known_hosts file

newhost=$4

ssh -i ~/.serverfarmer/ssh/key-root@$newhost -o StrictHostKeyChecking=no -o PasswordAuthentication=no root@$newhost uptime >/dev/null 2>/dev/null

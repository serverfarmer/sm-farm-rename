#!/bin/sh
# add new hostname to local /root/.ssh/known_hosts file

newhost=$4

ssh -i /etc/local/.ssh/key-root@$newhost -o StrictHostKeyChecking=no -o PasswordAuthentication=no root@$newhost uptime >/dev/null 2>/dev/null

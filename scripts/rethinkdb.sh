#!/bin/bash

DISTRIB_CODENAME=$(lsb_release --codename | cut -f2)
SIP=$(ip -4 addr show eth1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -

apt-get update

apt-get install -y build-essential rethinkdb

cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf

sed -ri "s/# bind=127.0.0.1/bind=0.0.0.0/g" /etc/rethinkdb/instances.d/instance1.conf
sed -ri "s|# log-file=/var/log/rethinkdb|log-file=/var/log/rethinkdb.log|g" /etc/rethinkdb/instances.d/instance1.conf
sed -ri "s/# server-name=server1/server-name=$(hostname)/g" /etc/rethinkdb/instances.d/instance1.conf
sed -ri "s/# canonical-address=/canonical-address=$SIP/g" /etc/rethinkdb/instances.d/instance1.conf

cat << EOF >> /etc/rethinkdb/instances.d/instance1.conf
join=192.168.175.100:29015
join=192.168.175.2:29015
join=192.168.175.3:29015
join=192.168.175.4:29015
EOF

touch /var/log/rethinkdb.log
chown root:rethinkdb /var/log/rethinkdb.log
chmod 664 /var/log/rethinkdb.log

/etc/init.d/rethinkdb restart

#!/bin/sh

apt-get update
apt-get install xrdp -yq
sh $1/install.sh
cat $1/startwm.sh > /etc/xrdp/startwm.sh
service xrdp restart
#!/bin/sh

ARCH=$(uname -m)
if [ ($ARCH != "x86_64") -a ($ARCH != "amd64") ]; then
  echo "Google Chrome is only supported on 64bit machines" 1>&2
  exit -1
fi

add-apt-repository universe
apt-get update
sudo apt-get install libgconf2-4 libnss3-1d libxss1

if [ $(which apt) ]; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
  apt-get install -f
elif [ $(which yum) ]; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
  yum install google-chrome-stable_current_x86_64.rpm
else
  echo "Could not discover package manager" 1>&2
  exit -1
fi

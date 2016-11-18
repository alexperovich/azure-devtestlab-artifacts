#!/bin/sh

ARCH=$(uname -m)
if [ $(which apt) ]; then
  PACKAGEMANAGER=apt
elif [ $(which yum) ]; then
  PACKAGEMANAGER=yum
else
  echo "Could not discover package manager" 1>&2
  exit -1
fi

case $(uname -m) in
"x86_64" | "amd64")
  ARCH=x64
  ;;
"x86" | "i386")
  ARCH=x86
  ;;
*)
  echo "Could not detect architecture" 1>&2
  exit -1
  ;;
esac

case "$PACKAGEMANAGER:$ARCH" in
"apt:x64")
  wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868
  ;;
"apt:x86")
  wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760680
  ;;
"yum:x64")
  wget -O code.rpm https://go.microsoft.com/fwlink/?LinkID=760867
  ;;
"yum:x86")
  wget -O code.rpm https://go.microsoft.com/fwlink/?LinkID=760681
  ;;
esac

case "$PACKAGEMANAGER" in
"apt")
  if [ ! -f code.deb ]; then
    echo "Failed to download package" 1>&2
    exit -1
  fi
  apt-get update
  apt-get install -y -qq gvfs-bin
  dpkg -i code.deb
  apt-get install -f -y -qq

  # Workarround https://github.com/Microsoft/vscode/issues/3451
  cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 /usr/share/code/
  sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1

  ;;
"yum")
  if [ ! -f code.rpm ]; then
    echo "Failed to download package" 1>&2
    exit -1
  fi
  yum -y update
  yum -y install code.rpm
  ;;
esac

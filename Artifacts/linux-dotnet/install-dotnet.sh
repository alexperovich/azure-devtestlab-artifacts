#!/bin/sh

case $(uname -m) in
"x86_64" | "amd64")
  ;;
*)
  echo "This only works on amd64" 1>&2
  exit -1
  ;;
esac

if [ -f /etc/os-release ]; then
  . /etc/os-release
  case "$ID:$VERSION_ID" in
  "ubuntu:14.04")
    echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
    apt-get update
    apt-get install dotnet-dev-1.0.0-preview2.1-003177 -y -qq
    ;;
  "ubuntu:16.04")
    echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
    apt-get update
    apt-get install dotnet-dev-1.0.0-preview2.1-003177 -y -qq
    ;;
  "ubuntu:16.10")
    echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ yakkety main" > /etc/apt/sources.list.d/dotnetdev.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
    apt-get update
    apt-get install dotnet-dev-1.0.0-preview2.1-003177 -y -qq
    ;;
  "rhel:7"*)
    subscription-manager repos --enable=rhel-7-server-dotnet-rpms
    yum -y install scl-utils
    yum -y install rh-dotnetcore11
    scl enable rh-dotnetcore11 bash
    ;;
  "debian:8")
    apt-get install curl libunwind8 gettext -y -qq
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=835021
    mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet
    ln -s /opt/dotnet/dotnet /usr/local/bin
    ;;
  "fedora:23")
    dnf -y install libunwind libicu
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=835025
    mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet
    ln -s /opt/dotnet/dotnet /usr/local/bin
    ;;
  "fedora:24")
    dnf -y install libunwind libicu
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=835025
    mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet
    ln -s /opt/dotnet/dotnet /usr/local/bin
    ;;
  "centos:7")
    yum -y install libunwind libicu
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=835019
    mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet
    ln -s /opt/dotnet/dotnet /usr/local/bin
    ;;
  "opensuse:13.2")
    zypper install libunwind libicu
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=835027
    mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet
    ln -s /opt/dotnet/dotnet /usr/local/bin
    ;;
  "opensuse:42.1")
    zypper --non-interactive install libunwind libicu
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=835029
    mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet
    ln -s /opt/dotnet/dotnet /usr/local/bin
    ;;
  *)
    echo "Could not discover distro" 1>&2
    exit -1
    ;;
  esac
else
  echo "Could not discover distro" 1>&2
  exit -1
fi

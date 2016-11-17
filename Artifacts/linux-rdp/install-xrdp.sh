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
  "ubuntu:14.04" | "ubuntu:16.04" | "ubuntu:16.10")
    apt-get update
    apt-get install xrdp -y -qq
    apt-get install mate-core mate-desktop-environment mate-notification-daemon mate-tweak mate-dock-applet -y -qq
(
cat <<'EOF'
#!/bin/sh

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

mate-session
EOF
) > /etc/xrdp/startwm.sh
    shutdown -r +1
    ;;
  "rhel:7.0" | "centos:7")
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    wget http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
    yum update
    yum -y install epel-release-latest-7.noarch.rpm
    yum -y install nux-dextop-release-0-5.el7.nux.noarch.rpm
    yum -y install mate-desktop
    yum -y install xrdp tigervnc-server
    systemctl enable xrdp.service
    firewall-cmd --permanent --zone=public --add-port=3389/tcp
    firewall-cmd --reload
    chcon --type=bin_t /usr/sbin/xrdp
    chcon --type=bin_t /usr/sbin/xrdp-sesman
    shutdown -r +1
    ;;
  *)
    echo "Unknown or not supported distro" 1>&2
    exit -1
    ;;
  esac
else
  echo "Could not discover distro" 1>&2
  exit -1
fi

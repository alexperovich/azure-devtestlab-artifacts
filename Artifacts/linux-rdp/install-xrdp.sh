#!/bin/sh

xfce()
{
  apt-get install xrdp -y -qq
  apt-get install xfce4 -y -qq
(
cat <<'EOF'
#!/bin/sh

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

startxfce4
EOF
) > /etc/xrdp/startwm.sh
}

unity()
{
  if [ $(lsb_release -si) != "Ubuntu" ]; then
    (>&2 echo "This GUI shell only works on ubuntu")
    exit -1
  fi
  apt-get install ubuntu-desktop -y -qq
  if [ $(uname -m) = "x86_64" ]; then
    ARCH=amd64
  else
    ARCH=i386
  fi
  TIGERVNCPATH=https://dl.bintray.com/tigervnc/stable/ubuntu-$(lsb_release -sr)LTS/$ARCH/tigervncserver_1.7.0-1ubuntu1_$ARCH.deb
  curl -L $TIGERVNCPATH -o tigervncserver.deb
  dpkg -i tigervncserver.deb
  apt-get install -fy -qq
  apt-get install xrdp -y -qq
(
cat <<'EOF'
#!/bin/sh

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

unity
EOF
) > /etc/xrdp/startwm.sh
}

mate()
{
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
}

apt-get update
eval $1
service xrdp restart
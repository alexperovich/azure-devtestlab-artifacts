#!/bin/sh

xfce()
{
  apt-get install xfce4 -yq
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
  apt-get install ubuntu-desktop -yq
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
  apt-get install mate-desktop-environment -yq
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
apt-get install xrdp -yq
eval $1
service xrdp restart
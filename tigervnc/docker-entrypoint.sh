#!/bin/bash
set -e

if [ -n "$TZ" ]; then
sudo ln -fs /usr/share/zoneinfo/$TZ /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata
fi

if [ -n "$LANG" ]; then
sudo locale-gen $LANG
sudo dpkg-reconfigure -f noninteractive locales
fi

/home/${USER}/.vnc/vnc.sh >> /var/log/vncserver.log 2>&1
tail -f /var/log/vncserver.log
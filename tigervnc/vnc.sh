#!/bin/bash

export DISPLAY=:1

rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

VNC_CONTAINER_IP=`hostname -i`
VNC_CONTAINER_NAME=`hostname`

echo "Generating self-signed tls certificates"
if [ -z "$VNC_CONTAINER_HOST_IP" ] && [ -z "$VNC_CONTAINER_HOST_NAME" ]; then
  echo "VNC_CONTAINER_HOST_IP and VNC_CONTAINER_HOST_NAME are not set"
  openssl req -x509 -newkey rsa -days 365 -nodes -config /usr/lib/ssl/openssl.cnf \
 -keyout $HOME/.vnc/vnc.key -out $HOME/.vnc/vnc.pem -subj '/CN=vncserver' \
 -addext "subjectAltName=DNS.1:localhost, DNS.2:$VNC_CONTAINER_NAME, IP.1:127.0.0.1, IP.2:$VNC_CONTAINER_IP"
else
  openssl req -x509 -newkey rsa -days 365 -nodes -config /usr/lib/ssl/openssl.cnf \
 -keyout $HOME/.vnc/vnc.key -out $HOME/.vnc/vnc.pem -subj '/CN=vncserver' \
 -addext "subjectAltName=DNS.1:localhost, DNS.2:$VNC_CONTAINER_NAME, DNS.3:$VNC_CONTAINER_HOST_NAME, \
  IP.1:127.0.0.1, IP.2:$VNC_CONTAINER_IP, IP.2:$VNC_CONTAINER_HOST_IP"
fi
echo "Self-signed tls certificates generated"

echo "Starting vncserver"
/usr/bin/vncserver :1 -SecurityTypes x509Vnc,TLSVnc -xstartup /usr/bin/startxfce4 -localhost no \
 -X509Key $HOME/.vnc/vnc.key -X509Cert $HOME/.vnc/vnc.pem

echo "Starting ssh server"
sudo service ssh start
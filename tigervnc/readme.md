# VNC Server based on TigerVNC
This container image provides a Linux desktop environment to run a browser and other gui based applications.    
[TigerVNC](https://github.com/TigerVNC/tigervnc) is configured to provide TLS encryption with X509 certificates, use TigerVNC client for best results.  
Repo: https://github.com/yggnas/vncserver/tree/main/tigervnc

## Components
- OS:              Ubuntu 24.04
- Desktop:         Xfce4
- VNC Server:      TigerVNC
- Web Browsers:    Mozilla Firefox (default), Microsoft Edge and Google Chrome

## Credentials
- OS User:      `ubuntu`
- OS Password:  ***Not set***
- VNC Password: `vncpassword`

## Getting started!
### Native VNC with TLS enabled
```
docker run -d --hostname vncserver \
 --name vncserver \
 --restart always \
 -p 5901:5901 \
 -v /dev/shm:/dev/shm \
 yggnas/vncserver
```

### With Timezone
```
docker run -d --hostname vncserver \
 --name vncserver \
 --restart always \
 -p 5901:5901 \
 -v /dev/shm:/dev/shm \
 -e TZ=America/New_York  \
 yggnas/vncserver
```

### With Timezone and Locale
```
docker run -d --hostname vncserver \
 --name vncserver \
 --restart always \
 -p 5901:5901 \
 -v /dev/shm:/dev/shm \
 -e TZ=America/New_York \
 -e LANG=en_US.UTF-8 \
 -e LANGUAGE=en_US:en \
 -e LC_ALL=en_US.UTF-8 \
 yggnas/vncserver
```

### SSH tunnelling for encryption
**1. Create container**
```
docker run -d --hostname vncserver \
 --name vncserver \
 --restart always \
 -p 1022:22 \
 -v /dev/shm:/dev/shm \
 yggnas/vncserver
```

**2. On Linux/Mac terminal**
```
ssh -L 5901:localhost:5901 ubuntu@[container host] -p 1022
```

**Note:** To use ssh tunneling you have to set the OS password for the default user or configure passwordless ssh. See **Security** section on how to set OS password


**3. On VNC client, connect to**
```
localhost:5901
```

## Security
Please change the vncpassword after deploying the container. Run the following commands and follow the prompt
```
docker exec -it vncserver vncpasswd
```
To set the OS password for the default user. Run the following commands and follow the prompt
```
docker exec -it vncserver bash
sudo passwd ubuntu
```
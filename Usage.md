# How it works #

1. download the source and make:

```
# untar openvpn-1.0.3.tgz
# cd openvpn-1.0.3
```

```
# make build
# make deb
# make ideb
```

or

```
# make build
# make rpm
# make irpm
```


2. configure your openvpn.conf for device (tap0.conf in the /etc/openvpn/tap0.conf for example)

add "up / down lines"

```
proto tcp-server
mode server
tls-server

dev tap0

plugin /usr/lib/openvpn/openvpn-auth-pam.so login
client-cert-not-required
username-as-common-name

ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/mini.crt
key /etc/openvpn/keys/mini.key  # This file should be kept secret
dh /etc/openvpn/keys/dh1024.pem

client-to-client
duplicate-cn
keepalive 10 120
comp-lzo
persist-key
persist-tun
status /etc/openvpn/openvpn-status-tap0.log
verb 3

up /usr/bin/openvpn-upnp-up.sh
down /usr/bin/openvpn-upnp-down.sh
```
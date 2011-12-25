#!/bin/bash

openvpn-upnp.py --start > /dev/null 2>&1 & 
echo $! > /var/run/openvpn-upnp.pid

#!/bin/bash

PID=$(cat /var/run/openvpn-upnp.pid)
kill $PID

openvpn-upnp.py --stop

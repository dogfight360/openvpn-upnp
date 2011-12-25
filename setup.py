#!/usr/bin/env python

from distutils.core import setup

setup(name='openvpn-upnp',
      version='1.0.3',
      scripts=['src/openvpn-upnp.py',
               'src/openvpn-upnp-up.sh',
               'src/openvpn-upnp-down.sh',
               ],
      )

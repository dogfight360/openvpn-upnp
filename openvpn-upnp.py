#! /usr/bin/python

import miniupnpc
import sys

from time import sleep

def usage():
  print '''
Usage: %s [start] [stop]

Exiting...
''' % (sys.argv[0])

def args():
    if len(sys.argv[1:]):
        try:
            (opts, args) = getopt.getopt(sys.argv[1:], '', ['start','stop'])
            if (len(args)): raise getopt.GetoptError('bad parameter')

        except getopt.GetoptError:
            usage()
            sys.exit(0)

        for (opt, arg) in opts:
            if opt in ('-k', '--key'):
                key = arg
            elif opt in ('-s', '--secret'):
                secret = arg

def show(u):
  port = 0
  proto = 'UDP'
  # list the redirections :
  i = 0
  while True:
    p = u.getgenericportmapping(i)
    if p==None:
      break
    print i, p
    (port, proto, (ihost,iport), desc, c, d, e) = p
    #print port, desc
    i = i + 1

  print u.getspecificportmapping(port, proto)

def start(u):
  print u.addportmapping(1194, 'TCP', u.lanaddr, 1194, 'OpenVPN-UPNP plugin', '')

def stop(u):
  print u.deleteportmapping(1194, 'TCP')

def main():
  u = miniupnpc.UPnP()
  u.discoverdelay = 200;
  print u.discover()
  try:
    u.selectigd()
  except Exception, e:
    print 'Exception :', e
    sys.exit(1)

  print 'local ip address :', u.lanaddr
  print 'external ip address :', u.externalipaddress()
  print u.statusinfo(), u.connectiontype()

  while True:
    start(u)
    sleep(60 * 60) # each hour

if __name__ == "__main__":
    main()

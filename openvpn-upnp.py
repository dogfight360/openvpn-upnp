#! /usr/bin/env python

import miniupnpc
import sys
import getopt

from time import sleep

def usage():
  print '''
Usage: %s [--start] [--stop] [--show]

Exiting...
''' % (sys.argv[0])

def args():
  action = ''

  if len(sys.argv[1:]):
    try:
      (opts, args) = getopt.getopt(sys.argv[1:], '', ['start','stop','show'])
      if (len(args)): raise getopt.GetoptError('bad parameter')

    except getopt.GetoptError:
      usage()
      sys.exit(0)

    for (opt, arg) in opts:
      if opt in ('--start'):
        action = 'START'
      elif opt in ('--stop'):
        action = 'STOP'
      elif opt in ('--show'):
        action = 'SHOW'
  else:
    usage()
    sys.exit(0)

  return action

def show():
  u = init()
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

def run():
  while True:
    start()
    sleep(60 * 60) # each hour

def start():
  u = init()
  print u.addportmapping(1194, 'TCP', u.lanaddr, 1194, 'OpenVPN-UPNP plugin', '')

def stop():
  u = init()
  print u.deleteportmapping(1194, 'TCP')

def main():
  action = args()

  {
    'START' : run,
    'STOP' : stop,
    'SHOW' : show,
  }[action]()

def init():
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

  return u

if __name__ == "__main__":
    main()

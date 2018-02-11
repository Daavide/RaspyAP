#!/usr/bin/python

import sys
import os

#check args

print "Number of arguments: ", len(sys.argv)
print "The arguments are: " , str(sys.argv)

arg = sys.argv[1]

if len(sys.argv) > 2:
  print "Too much arguments."
  arg = "help"

if arg == "help":
  print """
  Raspy CLI Utility. Available commands:
    raspy connected_clients: see info about hosts connected to WiFi.
    raspy performance: see real time CPU and RAM info. Powered by htop.
    raspy traffic_usage: see traffic amount on each interface since activation Powered by vnstat.
    raspy monitor: see who is using bandwidth. Powered by tcptrack.
    raspy deauth: disconnect a client from WiFi.
  """
elif arg == "connected_clients":
  print "Connected Clients:"
  macs = os.popen("hostapd_cli all_sta | grep : | grep -v dot").read().split()
  for mac in macs:
    print os.popen("arp -a | grep " + mac).read().split()[0]
    mac_split = mac.split(":")
    print os.popen("grep -i " mac_split[0] + mac_split[1] + mac_split[2] " /usr/share/nmap/nmap-mac-prefixes").read()
    print ""



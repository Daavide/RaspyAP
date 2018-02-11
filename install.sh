#Raspy install script

echo "Checking if root..."
if [[ $(id -u) -ne 0 ]] ; then echo "Not root. Please fix." ; exit 1 ; fi

echo "Installing packages.."

apt-get update
apt-get -y upgrade
apt-get -y install hostapd tcptrack htop nbtscan vnstat

echo "Enabling routing..."

echo 1 > /proc/sys/net/ipv4/ip_forward

echo "Enabling NAT..."

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
iptables-save > /etc/iptables.ipv4.nat

apt-get -y install iptables-persistent

echo "Installing Pi-Hole..."

curl -sSL https://install.pi-hole.net | bash

echo "Insert SSID: "
read -sr SSID

echo "Insert password: "
read -sr PASSWORD

echo "Insert Pi-Hole WEB-GUI password (http://raspberry-ip/admin): "

pihole -a -p 

"Finishing up..."

service hostapd enable
service iptables-persistent enable

"Done!"



#Hostapd conf file:

interface=wlan0
driver=nl80211
ssid=$SSID
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$PASSWORD
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0



#Commands

raspy connected_clients
  hostapd_cli all_sta | grep : | grep -v dot
  arp -a | grep -station-
  grep -first_mac_address_half- /usr/share/nmap/nmap-mac-prefixes

raspy performance

raspy traffic_usage

raspy monitor

raspy deauth

#script
#<>




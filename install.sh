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



#missing sed part to customize conf files

#missing copying files to proper location

echo "Insert Pi-Hole WEB-GUI password (http://raspberry-ip/admin): "

pihole -a -p 

"Finishing up..."

service hostapd enable
service iptables-persistent enable

"Done!"



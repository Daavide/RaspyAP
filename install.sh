#Raspy install script


echo "Installing packages.."

apt-get update
apt-get -y upgrade
apt-get -y install hostapd tcptrack htop nbtscan vnstat
curl -sSL https://install.pi-hole.net | bash

echo "Insert SSID: "
read -sr SSID

echo "Insert password: "
read -sr PASSWORD

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





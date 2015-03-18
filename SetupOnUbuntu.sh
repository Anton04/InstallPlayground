
#!/bin/bash

if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

echo "Installing git"
apt-get update > /dev/null
apt-get install git

echo "Creating IoT user"

adduser iot --disabled-password --gecos "Internet of things services and applications" 

#sudo su iot

#cd ~

sudo -H -u iot bash -c 'mkdir repos'
#sudo -H -u iot bash -c 'cd repos && git clone https://github.com/Anton04/InstallPlayground.git'

#Install mqtt
echo "Installing mosquitto"
apt-get install mosquitto

#Install ipython
echo "Installing iPython"
apt-get install ipython-notebook

echo "Installing node.js"
sudo -H -u iot bash -c 'https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/node_install.sh'

#Install nodered
echo "Installing NodeRED"
sudo -H -u iot bash -c 'wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/install_node_red.sh | bash'

#Install startup script for nodered
wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/install-node-red-start-script | bash

# Install influxdb 
echo "Installing influxDB"
wget https://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb
dpkg -i influxdb_latest_amd64.deb

echo "DONE!"



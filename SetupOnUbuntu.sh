
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
echo " "
echo " "
echo " "
echo "Installing mosquitto"
apt-get install mosquitto
apt-get install mosquitto-clients
apt-get install python-pip
pip install mosquitto 

#Install ipython
echo " "
echo " "
echo " "
echo "Installing iPython"
apt-get install ipython-notebook

echo " "
echo " "
echo " "
echo "Installing node.js"
sudo -H -u iot bash -c 'cd /home/iot && wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/node_install.sh | bash'

#Install nodered
echo " "
echo " "
echo " "
echo "Installing NodeRED"
sudo -H -u iot bash -c 'cd /home/iot && wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/install_node_red.sh | bash'

#Install startup script for nodered
wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/install-node-red-start-script | bash

# Install influxdb 
echo " "
echo " "
echo " "
echo "Installing influxDB"
wget https://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb
dpkg -i influxdb_latest_amd64.deb

echo " "
echo " "
echo " "
echo "DONE!"



#!/bin/bash

if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

echo "#########################################################################################"
echo "This script will install tools used in the Open Energy Playground into your Ubuntu OS"
echo "The tools are:"
echo "	NodeRED a graphical probraming language to route realtime data."
echo "  Influxdb a timeseries database."
echo "  iPython nodebook a webbased python development tool"
echo "  Mosquitto an MQTT broaker and client tools"
echo " "
echo "The script will also install some tools to needed by the above installations such as:"
echo "	Screen, pip, git nodejs"
echo " "
echo "A user called iot will be created for the nodered installation."
echo "#########################################################################################"
echo " "
read -n1 -r -p "Press space to continue..." key

if [ "$key" = ' ' ]; then
    echo "Starting installation..."
    echo " "
fi



echo "Creating IoT user"

adduser iot --disabled-password --gecos "Internet of things services and applications" > /dev/null

#sudo su iot

#cd ~
#echo "Installing git"
apt-get update > /dev/null < /dev/null
apt-get install -y git python-software-properties python g++ make > /dev/null < /dev/null

#sudo -H -u iot bash -c 'mkdir repos' > /dev/null
#sudo -H -u iot bash -c 'cd repos && git clone https://github.com/Anton04/InstallPlayground.git'


#Install screen
#echo "Installing screen"
apt-get -y install screen > /dev/null < /dev/null

#Install mqtt
echo "Installing mosquitto"
apt-get -y install mosquitto > /dev/null < /dev/null
apt-get -y install mosquitto-clients > /dev/null < /dev/null
apt-get -y install python-pip > /dev/null < /dev/null	
pip install mosquitto > /dev/null < /dev/null


#echo "Installing node.js"
#sudo -H -u iot bash -c 'cd /home/iot && wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/node_install.sh | bash'

#Install nodered

echo "Installing NodeRED"
sudo -H -u iot bash -c 'cd /home/iot && wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/install_node_red.sh | bash'

#Install startup script for nodered
wget -qO- https://raw.githubusercontent.com/Anton04/InstallPlayground/master/nodered/install-node-red-start-script | bash

# Install influxdb 
echo "Installing influxDB"
wget https://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb > /dev/null
dpkg -i influxdb_latest_amd64.deb > /dev/null


echo "Installing grafana"
wget https://grafanarel.s3.amazonaws.com/builds/grafana_2.1.3_amd64.deb
apt-get install -y adduser libfontconfig > /dev/null < /dev/null
dpkg -i grafana_2.1.3_amd64.deb > /dev/null < /dev/null

#Install ipython

echo "Installing iPython"
apt-get -y install ipython-notebook > /dev/null < /dev/null

echo " "
echo " "
echo " "

echo "DONE! Starting new services..."

service influxdb start
service grafana-server start
service nodered start

firefox http://localhost:1880
firefox http://localhost:3000
firefox http://localhost:8083





#!/bin/bash

node_version='0.10.37'
red_version='0.10.6'


#wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

#. ~/.nvm/nvm.sh

#nvm install $node_version
#nvm use $node_version



wget https://github.com/node-red/node-red/archive/$red_version.zip
unzip $red_version.zip
rm $red_version.zip

ln -s node-red-$red_version node-red

cd node-red 

. ~/.nvm/nvm.sh

nvm use $node_version

cd /home/iot/node-red && npm install --production

cd /home/iot/node-red && npm install node-red-node-xmpp
cd /home/iot/node-red && npm install node-red-node-web-nodes
cd /home/iot/node-red && npm install node-red-contrib-googlechart
cd /home/iot/node-red && npm install node-red-contrib-slack
cd /home/iot/node-red && npm install node-red-node-suncalc
cd /home/iot/node-red && npm install node-red-contrib-freeboard




#Set up directory for saving flows 
mkdir /home/iot/flows
cp /home/iot/repos/InstallPlayground/nodered/lib/ /home/iot/flows/lib/ -r




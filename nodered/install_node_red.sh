#!/bin/bash

node_version='0.12.27'
#red_version='0.10.6'


#Install node 
wget -qO- https://raw.githubusercontent.com/Anton04/OpenEnergyPlayground/nodered/node_install.sh | bash

. ~/.nvm/nvm.sh

#Install the version of node to be used 
nvm install $node_version
nvm use $node_version

echo "Installing node-red through nodes packet manager (npm)"
#Install node red
npm install node-red

NODE_RED_PATH=$HOME/node_modules/node-red

#ln -s $NODE_RED_PATH node-red

cd $NODE_RED_PATH

echo "Installing additional node-red nodes through npm"

cd $NODE_RED_PATH && npm install node-red-node-xmpp
cd $NODE_RED_PATH && npm install node-red-node-web-nodes
cd $NODE_RED_PATH && npm install node-red-contrib-googlechart
cd $NODE_RED_PATH && npm install node-red-contrib-slack
cd $NODE_RED_PATH && npm install node-red-node-suncalc
cd $NODE_RED_PATH && npm install node-red-contrib-freeboard



#Set up flows 
echo "Copying open playground flow library"
wget -qO- http://op-en.se/lib/flow_lib.tar.gz | tar xvz -C $HOME/.node-red/lib


#Just to make tings easier
#ln -s $HOME/.node-red/ $HOME/flows



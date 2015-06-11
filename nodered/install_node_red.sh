#!/bin/bash

node_version='0.10.37'
#red_version='0.10.6'


#Install node version manager
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

. ~/.nvm/nvm.sh

#Install the version of node to be used 
nvm install $node_version
nvm use $node_version


#Install node red
npm install node-red

NODE_RED_PATH = $HOME/node_modules/node-red

ln -s $NODE_RED_PATH node-red

cd $NODE_RED_PATH

cd $NODE_RED_PATH && npm install node-red-node-xmpp
cd $NODE_RED_PATH && npm install node-red-node-web-nodes
cd $NODE_RED_PATH && npm install node-red-contrib-googlechart
cd $NODE_RED_PATH && npm install node-red-contrib-slack
cd $NODE_RED_PATH && npm install node-red-node-suncalc
cd $NODE_RED_PATH && npm install node-red-contrib-freeboard



#Set up directory for saving flows 
#mkdir /home/iot/flows
cp /home/iot/repos/InstallPlayground/nodered/lib/ $HOME/.node-red/ -r

#Just to make tings easier
ln -s $HOME/.node-red/ $HOME/flows



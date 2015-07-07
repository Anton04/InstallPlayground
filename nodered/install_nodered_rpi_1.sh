#!/usr/bin/sh

wget http://node-arm.herokuapp.com/node_0.10.36_armhf.deb
sudo dpkg -i node_0.10.36_armhf.deb
sudo apt-get install build-essential python-dev python-rpi.gpio

sudo npm install -g --unsafe-perm  node-red

NODE_RED_PATH=$HOME/node_modules/node-red

ln -s $NODE_RED_PATH node-red

cd $NODE_RED_PATH

cd $NODE_RED_PATH && npm install node-red-node-xmpp
cd $NODE_RED_PATH && npm install node-red-node-web-nodes
cd $NODE_RED_PATH && npm install node-red-contrib-googlechart
cd $NODE_RED_PATH && npm install node-red-contrib-slack
cd $NODE_RED_PATH && npm install node-red-node-suncalc
cd $NODE_RED_PATH && npm install node-red-contrib-freeboard


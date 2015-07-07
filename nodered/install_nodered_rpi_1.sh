#!/usr/bin/sh

wget http://node-arm.herokuapp.com/node_0.10.36_armhf.deb
sudo dpkg -i node_0.10.36_armhf.deb
sudo apt-get install build-essential python-dev python-rpi.gpio

sudo npm install -g --unsafe-perm  node-red


#!/bin/bash

node_version='0.8.22'
red_version='0.10.1'


#wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

#. ~/.nvm/nvm.sh

#nvm install $node_version
#nvm use $node_version



wget https://github.com/node-red/node-red/archive/0.9.1.zip
unzip $red_version.zip
rm $red_version.zip

ln -s node-red-$red_version node-red

cd node-red 

npm install --production


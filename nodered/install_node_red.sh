#!/bin/bash

node_version='0.10.9'
red_version='0.10.4'


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

npm install --production

npm install node-red-node-xmpp
npm install node-red-node-web-nodes



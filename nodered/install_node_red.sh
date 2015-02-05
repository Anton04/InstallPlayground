#!/bin/bash

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

. ~/.nvm/nvm.sh

nvm install 0.8.22
nvm use 0.8.22

wget https://github.com/node-red/node-red/archive/0.9.1.zip
unzip 0.9.1.zip
rm 0.9.1.zip

ln -s node-red* node-red

cd node-red 

npm install --production


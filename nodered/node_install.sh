#!/bin/bash
node_version='0.8.22'

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash


. ~/.nvm/nvm.sh

nvm install $node_version
nvm use $node_version

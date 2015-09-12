#!/bin/bash
node_version='0.12.7'

#Check if node version manager is installed.
if  [  ! -f ~/.nvm/nvm.sh ] ; then
  echo "Installing node version manager - to let you easilly switch between different versions of node"
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash
fi

. $HOME/.nvm/nvm.sh
echo "Installing node version" $node_version
nvm install $node_version > /dev/null 
nvm use $node_version > /dev/null 


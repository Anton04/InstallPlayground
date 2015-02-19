#!/bin/bash

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

. ~/.nvm/nvm.sh

nvm install 0.8.22
nvm use 0.8.22

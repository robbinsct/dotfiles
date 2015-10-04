#!/bin/bash

echo "Installing dotfiles"

#echo "Initializing submodule(s)"
#git submodule update --init --recursive

source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"

    echo "Brewing all the things"
    source install/brew.sh

    echo "Updating OSX settings"
    source installosx.sh

    echo "Installing node (from nvm)"
    source install/nvm.sh
fi

echo "Installing NPM modules"
sudo npm install -g eslint
sudo npm install -g babel-eslint
sudo npm install -g eslint-plugin-react

echo "Configuring zsh as default shell"
chsh -s $(which zsh)

echo "Done."
